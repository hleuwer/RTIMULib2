%module rtimu
%{
extern "C" {
#include "RTIMUHal.h"
#include "RTIMULib.h"
}
%}
%ignore getRuntimeCompassCalibrationValid; 
/* %ignore RTMath; */
/* %ignore RTQuaternion; */
%ignore display;
%ignore displayDegrees;
%ignore displayRadians;
%include ../../RTIMULib/RTIMULibDefs.h
%include ../../RTIMULib/RTMath.h
%include ../../RTIMULib/RTIMUSettings.h
%include ../../RTIMULib/IMUDrivers/RTIMU.h
%include ../../RTIMULib/IMUDrivers/RTHumidity.h
%include ../../RTIMULib/IMUDrivers/RTPressure.h
