#!../../bin/windows-x64/agilent3631Atest

## You may have to change agilent3631Atest to something else
## everywhere it appears in this file

< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

epicsEnvSet "IOCNAME" "$(P=$(MYPVPREFIX))A3631:PSU"
epicsEnvSet "IOCSTATS_DB" "$(DEVIOCSTATS)/db/iocAdminSoft.db"

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/agilent3631A.dbd"
agilent3631A_registerRecordDeviceDriver pdbbase

#Set up the GPIB access
GpibBoardDriverConfig("GPIB0","1","0","3","0")
asynOctetSetInputEos("GPIB0", 1, "\n")
asynOctetSetOutputEos("GPIB0", 1, "\n")

## Load record instances
dbLoadRecords("db/devagilent3631A.db","P=$(IOCNAME),R=:,PORT=GPIB0,A=1")
dbLoadRecords("$(IOCSTATS_DB)","IOC=$(IOCNAME)")

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=kvlb23Host"
