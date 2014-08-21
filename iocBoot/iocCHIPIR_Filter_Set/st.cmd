#!../../bin/windows-x64/CHIPIR_Filter_Set

## You may have to change CHIPIR_Filter_Set to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/CHIPIR_Filter_Set.dbd"
CHIPIR_Filter_Set_registerRecordDeviceDriver pdbbase

##ISIS## Run IOC initialisation 
< $(IOCSTARTUP)/init.cmd

## Load record instances

##ISIS## Load common DB records 
< $(IOCSTARTUP)/dbload.cmd

# Turn on asynTraceFlow and asynTraceError for global trace, i.e. no connected asynUser.
#asynSetTraceMask("", 0, 17)

## main args are:  portName, configSection, configFile, host, options (see lvDCOMConfigure() documentation in lvDCOMDriver.cpp)
##
## there are additional optional args to specify a DCOM ProgID for a compiled LabVIEW application 
## and a different username + password for remote host if that is required 
##
## the "options" argument is a combination of the following flags (as per the #lvDCOMOptions enum in lvDCOMInterface.h)
##    viWarnIfIdle=1, viStartIfIdle=2, viStopOnExitIfStarted=4, viAlwaysStopOnExit=8
#lvDCOMConfigure("frontpanel", "frontpanel", "$(TOP)/CHIPIR_Filter_SetApp/protocol/CHIPIR_Filter_Set.xml", "ndxchipir", 6, "", "spudulike", "reliablebeam")
lvDCOMConfigure("frontpanel", "frontpanel", "$(TOP)/CHIPIR_Filter_SetApp/protocol/CHIPIR_Filter_Set.xml", "$(LVDCOMHOST=localhost)", 6, "", "", "")
dbLoadRecords("$(TOP)/db/CHIPIR_Filter_Set.db","P=$(MYPVPREFIX)CHIPIR_FILTER_SET:")

##ISIS## Stuff that needs to be done after all records are loaded but before iocInit is called 
< $(IOCSTARTUP)/preiocinit.cmd

cd ${TOP}/iocBoot/${IOC}
iocInit


##ISIS## Stuff that needs to be done after iocInit is called e.g. sequence programs 
< $(IOCSTARTUP)/postiocinit.cmd
