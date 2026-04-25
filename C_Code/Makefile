all: getD centriAbs fpwm resetEnc toggle all_low colorRead rotateCBy90 rotateCByTeeth rotateTo_column

getD: functions.c pins.h FPGAtesting/Get_data.c
	gcc FPGAtesting/Get_data.c functions.c -lwiringPi -o ../Executables/getD
centriAbs: functions.c pins.h FPGAtesting/centriAbs.c
	gcc FPGAtesting/centriAbs.c functions.c -lwiringPi -o ../Executables/centriAbs
fpwm: functions.c pins.h FPGAtesting/Fpwm.c
	gcc FPGAtesting/Fpwm.c functions.c -lwiringPi -o ../Executables/fpwm
# rotateTo: functions.c pins.h SystemsTesting/rotateTo.c
# 	gcc SystemsTesting/rotateTo.c functions.c -lwiringPi -o ../Executables/rotateTo
resetEnc: functions.c pins.h SystemsTesting/resetEnc.c
	gcc SystemsTesting/resetEnc.c functions.c -lwiringPi -o ../Executables/resetEnc
toggle: functions.c pins.h SystemsTesting/toggle.c
	gcc SystemsTesting/toggle.c functions.c -lwiringPi -o ../Executables/toggle
all_low: functions.c pins.h SystemsTesting/all_low.c
	gcc SystemsTesting/all_low.c functions.c -lwiringPi -o ../Executables/all_low
colorRead: functions.c pins.h SystemsTesting/colorRead.c
	gcc SystemsTesting/colorRead.c functions.c -lwiringPi -o ../Executables/colorRead
rotateCBy90: functions.c pins.h SystemsTesting/Centrifuge/rotateCBy90.c
	gcc SystemsTesting/Centrifuge/rotateCBy90.c functions.c -lwiringPi -o ../Executables/rotateCBy90
rotateCByTeeth: functions.c pins.h SystemsTesting/Centrifuge/rotateCByTeeth.c
	gcc SystemsTesting/Centrifuge/rotateCByTeeth.c functions.c -lwiringPi -o ../Executables/rotateCByTeeth
rotateTo_column: functions.c pins.h SystemsTesting/rotateTo_column.c
	gcc SystemsTesting/rotateTo_column.c functions.c -lwiringPi -o ../Executables/rotateTo_column