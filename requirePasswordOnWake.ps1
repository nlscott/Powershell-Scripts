

# requirePasswordOnWake ----------------------------------------------------------------
# created 2017.12.23 by Nic Scott
# tested on Windows 10 1709

# SUMMARY ------------------------------------------------------------------------------
# This script sets require sign-in 'When PC wakes up from sleep'
# found at Settings > Accounts > Sign-In options > Require sign-in
# this script only sets defaults, users can change this setting
# to enforce use GPO at:
#    Computer Configuration > Administrative Templates > System > Power Management > Sleep Settings > Require a password when a computer wakes (plugged in)
#    Computer Configuration > Administrative Templates > System > Power Management > Sleep Settings > Require a password when a computer wakes (on battery)



# on battery --------------------------------------------------------------------------
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1

# plugged in --------------------------------------------------------------------------
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1
