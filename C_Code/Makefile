all: getD centriAbs fpwm resetEnc toggle all_low colorRead rotateCBy rotateTo_column raise_lower_column

getD: functions.c pins.h FPGAtesting/Get_data.c
	gcc FPGAtesting/Get_data.c functions.c -lwiringPi -o ../Executables/getD
centriAbs: functions.c pins.h FPGAtesting/centriAbs.c
	gcc FPGAtesting/centriAbs.c functions.c -lwiringPi -o ../Executables/centriAbs
fpwm: functions.c pins.h FPGAtesting/Fpwm.c
	gcc FPGAtesting/Fpwm.c functions.c -lwiringPi -o ../Executables/fpwm
resetEnc: functions.c pins.h SystemsTesting/resetEnc.c
	gcc SystemsTesting/resetEnc.c functions.c -lwiringPi -o ../Executables/resetEnc
toggle: functions.c pins.h SystemsTesting/toggle.c
	gcc SystemsTesting/toggle.c functions.c -lwiringPi -o ../Executables/toggle
all_low: functions.c pins.h SystemsTesting/all_low.c
	gcc SystemsTesting/all_low.c functions.c -lwiringPi -o ../Executables/all_low
colorRead: functions.c pins.h SystemsTesting/colorRead.c
	gcc SystemsTesting/colorRead.c functions.c -lwiringPi -o ../Executables/colorRead
rotateCBy: functions.c pins.h SystemsTesting/Centrifuge/rotateCBy.c
	gcc SystemsTesting/Centrifuge/rotateCBy.c functions.c -lwiringPi -o ../Executables/rotateCBy
rotateTo_column: functions.c pins.h SystemsTesting/rotateTo_column.c
	gcc SystemsTesting/rotateTo_column.c functions.c -lwiringPi -o ../Executables/rotateTo_column
raise_lower_column: functions.c pins.h SystemsTesting/Column/raise_lower_column.c
	gcc SystemsTesting/Column/raise_lower_column.c functions.c -lwiringPi -o ../Executables/raise_lower_column
raise_lower_pump: functions.c pins.h SystemsTesting/Pump/raiseLower_Pump.c
	gcc SystemsTesting/Pump/raiseLower_Pump.c functions.c -lwiringPi -o ../Executables/raise_lower_pump
