#!../../bin/windows-x64/agilent3631Atest

## You may have to change agilent3631Atest to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet "IOCNAME" "$(P=$(MYPVPREFIX))A3631:PSU"
epicsEnvSet "IOCSTATS_DB" "$(DEVIOCSTATS)/db/iocAdminSoft.db"

epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"
epicsEnvSet "TTY" "$(TTY=\\\\\\\\.\\\\COM20)"

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/agilent3631A.dbd"
agilent3631A_registerRecordDeviceDriver pdbbase

# Set up ASYN ports
drvAsynSerialPortConfigure("L0", "$(TTY)", 0, 0, 0, 0)
asynSetOption("L0", -1, "baud", "9600")
asynSetOption("L0", -1, "bits", "8")
asynSetOption("L0", -1, "parity", "none")
asynSetOption("L0", -1, "stop", "1")
asynOctetSetInputEos("L0", -1, "\r\n")
asynOctetSetOutputEos("L0", -1, "\r\n")

## Load record instances
dbLoadRecords("db/devagilent3631A.db","P=$(IOCNAME),R=:,PORT=L0,A=0")
dbLoadRecords("$(IOCSTATS_DB)","IOC=$(IOCNAME)")

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=kvlb23Host"
