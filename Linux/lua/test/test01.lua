local pretty = require "pl.pretty"
local function pt(t) return pretty.write(t) end

local function printf(fmt, ...)
   print(string.format(fmt, ...))
end

rt = {
--   settings = require "rtsettings",
   imu = require "rtimu",
--   pressure = require "rtpressure",
--   humidity = require "rthumidity"
}
rt.settings = rt.imu
rt.pressure = rt.imu
rt.humidity = rt.imu

local settings = rt.settings.RTIMUSettings()
printf("setting:\n\t%s", pt(settings))
local meta = getmetatable(settings)
printf("   meta settings:\n\t%s", pt(meta))

-- This is not working - why ???
--local _imu = rt.RTIMU()
--printf("_imu:\n\t%s", pt(_imu))

local imu = rt.imu.RTIMU_createIMU(settings)
printf("imu:\n\t%s", pt(imu))
local meta = getmetatable(imu)
printf("   meta imu:\n\t%s", pt(meta))

local data = rt.imu.RTIMU_DATA()
printf("  data=%s", data)

local humidity = rt.humidity.RTHumidity_createHumidity(settings)
local pressure  = rt.pressure.RTPressure_createPressure(settings)
printf("humidty:\n\t%s", pt(humidity))
local meta = getmetatable(humidity)
printf("   meta humidity:\n\t%s", pt(meta))

printf("humidty:\n\t%s", pt(pressure))
local meta = getmetatable(pressure)
printf("   meta pressure:\n\t%s", pt(meta))

printf("humidity.humidityName = %s", humidity.humidityName)
printf("  value=%s", humidity:humidityName())
printf("humidity.humidityType = %s", humidity.humidityType)
printf("  value=%s", humidity:humidityType())

printf("pressure.pressureName = %s", pressure.pressureName)
printf("  value=%s", pressure:pressureName())
printf("pressure.pressureType = %s", pressure.pressureType)
printf("  value=%s", pressure:pressureType())


printf("humidity.humidityInit = %s", humidity.humidityInit)
printf("  value=%s", humidity:humidityInit())

assert(humidity:humidityInit() == true, "Humidity init failed")
assert(humidity:humidityRead(data) == true, "Humidity read failed")
printf("data.humidity: valid=%s value=%.3f", data.humidityValid, data.humidity) 


assert(pressure:pressureInit() == true, "Pressure init failed!")
assert(pressure:pressureRead(data) == true, "Pressure read failed")
printf("data.pressure: valid=%s value=%.3f", data.pressureValid, data.pressure) 

