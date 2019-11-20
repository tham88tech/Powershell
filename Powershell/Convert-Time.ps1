$sDate = "21/11/2019"
$eDate = "21/11/2019"
$sTime = "2:00"
$eTime = "6:00"
$tz= 240
$tz = -($tz/60)

$start = $sDate +" "+ $sTime
$end = $eDate +" "+ $eTime

$CEToffset = (Get-TimeZone -Name "Central European*").baseutcoffset.hours

### Find CET Start Date and Time ###

$UTCStart = (Get-Date $start).AddHours($tz)
$CETStart = (Get-Date $UTCStart).AddHours($CEToffset)
$CETsDate = Get-Date $CETStart -Format "dd-MM-yyyy"
$CETsTime = Get-Date $CETStart -Format "HH:mm"

### Find CET Start time and End Time ###

$UTCEnd = (Get-Date $end).AddHours($tz)
$CETEnd = (Get-Date $UTCEnd).AddHours($CEToffset)
$CETeDate = Get-Date $CETEnd -Format "dd-MM-yyyy"
$CETeTime = Get-Date $CETEnd -Format "HH:mm"

Write-Host "CET Start Time : "$CETsDate" "$CETsTime
Write-Host "CET End Time : " $CETeDate" "$CETeTime