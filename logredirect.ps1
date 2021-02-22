$Folder = Get-Date -UFormat "%Y-%m-%d"
$Source = "D:\collections\umbrella\proxylogs\$Folder"
$Dest = "D:\LogRhythmHA\LogRhythm System Monitor\Umbrella"
$FilesToRemove = "D:\LogRhythmHA\LogRhythm System Monitor\Umbrella\$Folder"
$YesterdaysFolder = (get-date (get-date).addDays(-1) -UFormat "%Y-%m-%d")
$OriginalSource = "D:\collections\umbrella"
$LastWeeksOriginalFolder = (get-date (get-date).addDays(-7) -UFormat "%Y-%m-%d")

# Copy only the current day's directory of logs to the new directory

Copy-Item $Source -Destination $Dest -Force -Recurse

# Delete log files older than 2 hours

Get-ChildItem -path $FilesToRemove -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddHours(-2))} | Remove-Item -Force

# Delete yesterday's log file (so historic logs dont build up)

Get-ChildItem -path $Dest | Where-Object {$_.name -like $YesterdaysFolder} | Remove-Item -Force -Recurse

# Limit to 7 days of log data in the original folders (so historic logs dont build up)

Get-ChildItem -path $OriginalSource -Recurse | Where-Object {$_.name -like $LastWeeksOriginalFolder} | Remove-Item -Force -Recurse
