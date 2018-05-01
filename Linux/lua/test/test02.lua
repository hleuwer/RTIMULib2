local pretty = require "pl.pretty"
local socket = require "socket"
local function pt(t) return pretty.write(t) end
local function printf(fmt, ...)
   print(string.format(fmt, ...))
end

local function getMethods(obj)
   local t = {}
   local meta = getmetatable(obj)
   local funcs = meta[".fn"]
   for k,v in pairs(funcs) do
      table.insert(t, k)
   end
   return table.concat(t, " ")
end

local function getMembers(obj)
   local t = {}
   local meta = getmetatable(obj)
   local funcs = meta[".get"]
   for k,v in pairs(funcs) do
      table.insert(t, k)
   end
   return table.concat(t, " ")
end

rtimu = require "rtimu"

local settings = rtimu.RTIMUSettings()
printf("** setting methods:\n   %s", getMethods(settings))

local imu = rtimu.RTIMU_createIMU(settings)
printf("** imu methods:\n   %s", getMethods(imu))

local data = rtimu.RTIMU_DATA()
printf("** data members:\n%s", getMembers(data))

local humidity = rtimu.RTHumidity_createHumidity(settings)
printf("** humidity methods:\n   %s", getMethods(humidity))

local pressure = rtimu.RTPressure_createPressure(settings)
printf("** pressure  methods:\n   %s", getMethods(pressure))


printf("imu     : name=%q type=%s", imu:IMUName(), imu:IMUType())
printf("humidity: name=%q type=%s", humidity:humidityName(), humidity:humidityType())
printf("pressure: name=%q type=%s", pressure:pressureName(), pressure:pressureType())

printf("Init humidity sensor ...")
assert(humidity:humidityInit() == true, "Humidity init failed")
assert(humidity:humidityRead(data) == true, "Humidity read failed")
printf("   data.humidity: valid=%s value=%.3f", data.humidityValid, data.humidity) 

printf("Init pressure sensor ...")
assert(pressure:pressureInit() == true, "Pressure init failed!")
assert(pressure:pressureRead(data) == true, "Pressure read failed")
printf("   data.pressure: valid=%s value=%.3f", data.pressureValid, data.pressure)

printf("Init imu sensor ...")
assert(imu:IMUInit() == true, "IMU init failed")
printf("   poll interval: %d", imu:IMUGetPollInterval())

printf("Reading imu sensor ...")
local val = imu:IMURead()
printf("   imu read: %s", val)

local val = imu:getCompass()
printf("   compass: x=%.3f y=%.3f z=%.3f", val:x(), val:y(), val:z())

local val = imu:getAccel()
printf("   accel: x=%.3f y=%.3f z=%.3f", val:x(), val:y(), val:z())

local val = imu:getGyro()
printf("   gyro: x=%.3f y=%.3f z=%.3f", val:x(), val:y(), val:z())

imu:setCompassEnable(true)
imu:setGyroEnable(true)
imu:setAccelEnable(true)
for i = 1, 1 do
   local val = imu:getIMUData()
   if i == 1 then
      local mt = getmetatable(val) printf("%s", pt(mt))
   end
   local raw = val["fusionPose"]
   printf("   raw.length=%d", raw:length())
   printf("   raw.x=%.3f raw.y=%.3f raw.z=%.3f", raw:x(), raw:y(), raw:z())
   printf("   FusionPose: valid=%s data=%s", val.fusionPoseValid, val.fusionPose)
   printf("   accel: v=%s x=%.1f y=%.1f z=%1.f", val.accelValid, val.accel:x(), val.accel:y(), val.accel:z())
   socket.sleep(0.003)
end


