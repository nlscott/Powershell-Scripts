#======================================================================================
# Remove these pre-installed Apps
#======================================================================================

Get-AppxPackage *3DBuilder* | Remove-AppxPackage #3D Builder
Get-AppxPackage *BingWeather* | Remove-AppxPackage #Weather App
Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage #Alarms & Clocks
Get-AppxPackage *WindowsCalculator* | Remove-AppxPackage #Calculator
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage #Feedback Hub
Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage #Get Office
Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage #groove Music
Get-AppxPackage *WindowsMaps* | Remove-AppxPackage #built in maps
Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage #built in messaging app
Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage #sticky notes
Get-AppxPackage *OneNote* | Remove-AppxPackage #pre-installed onenote
Get-AppxPackage *Microsoft.People* | Remove-AppxPackage #built in contacts
Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage #built in skpye
Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage #built in photos
Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage #voice recorder
Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage #Xbox
Get-AppxPackage *OneConnect* | Remove-AppxPackage #Paid Wifi
Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage #Calendar
Get-AppxPackage *zunevideo* | Remove-AppxPackage #Movies & TV
Get-AppxPackage *getstarted* | Remove-AppxPackage #Tips
Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage #store app
