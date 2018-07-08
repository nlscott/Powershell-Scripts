REM This script sets the power settings for both desktop and laptops
REM Tested on Windows 10 BUild 1607
REM Last Edit: 6/21/2017
REM ac = desktop
REM dc = battery


REM Turn off the screen after x minutes
powercfg -x monitor-timeout-ac 10
powercfg -x monitor-timeout-dc 10

REM Turn off hard disk after x minutes
powercfg -x disk-timeout-ac 0
powercfg -x disk-timeout-dc 15

REM Put the computer to sleep time
powercfg -x standby-timeout-ac 0
powercfg -x standby-timeout-dc 10

REM Hibernate after x minutes
powercfg -x hibernate-timeout-ac 0
powercfg -x hibernate-timeout-dc 180

