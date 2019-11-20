<#
Prepared by Thameem J
Function can be used to convet the date and time to CET time zone based on the given time zone.
Example : Convert-ToCET -StartDate "25/11/2019" -EndDate "25/11/2019" -StartTime "2:00" -EndTime "6:00" -TimeZoneOffcet 300
#>
Function Convert-ToCET
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)]
        [string]
        $StartDate,
        [Parameter(Mandatory=$True)]
        [string]
        $EndDate,
        [Parameter(Mandatory=$True)]
        [string]
        $StartTime,
        [Parameter(Mandatory=$True)]
        [string]
        $EndTime,
        [Parameter(Mandatory=$True,HelpMessage=
        "Enter from which timeZone, it needs to be converted to CET (Minutes).")]
        [int]
        $TimeZoneOffcet
    )

    ### Converting time zone offset to hours ###
    $tz = -($TimeZoneOffcet/60)

    ### Concatenate date and time for further CET convertion ####
    $start = $StartDate +" "+ $StartTime
    $end = $EndDate +" "+ $EndTime

    ### Get CET Offset value from system ###

    $CEToffset = (Get-TimeZone -Name "Central European*").baseutcoffset.hours

    ### Build New Object for Output ###

    $CETData = New-Object -TypeName psobject

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

    ### Add member to the object ###

    Add-Member -InputObject $CETData -MemberType NoteProperty -Name CETStartDate -Value $CETsDate
    Add-Member -InputObject $CETData -MemberType NoteProperty -Name CETStartTime -Value $CETsTime
    Add-Member -InputObject $CETData -MemberType NoteProperty -Name CETEndDate -Value $CETeDate
    Add-Member -InputObject $CETData -MemberType NoteProperty -Name CETEndTime -Value $CETeTime

    Return $CETData
}