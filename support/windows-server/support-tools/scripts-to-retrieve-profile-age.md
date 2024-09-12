---
title: Scripts to retrieve profile age
description: Introduces a script to retrieve profile age.
ms.date: 09/12/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.localizationpriority: medium
ms.reviewer: garymu, herbertm
ms.custom: sap:User Logon and Profiles\User profiles, csstroubleshoot
---
# Scripts: Retrieve profile age

Assume that you have set the "[Delete user profiles older than a specified number of days on system restart](https://gpsearch.azurewebsites.net/#2583)" group policy to delete aged profiles on system startup. The article provides a sample script that can help determine when profiles are considered for deletion because of applying the group policy.

> [!NOTE]
> A Windows Management Instrumentation (WMI) provider can also be used to configure profile handling and can override the group policy setting. Microsoft System Center Configuration Manager (SCCM) is an example of software that can do this.

_Applies to:_ &nbsp; Windows 10, version 1809, Windows 11, Windows Server 2019, and later versions of Windows

## Details

Windows 10, version 1809, Windows Server 2019 (version 1809), and later versions change how the profile age is determined and remove the reliance on the modified timestamp of the *ntuser.dat* file. Windows now uses timestamped registry values to represent the load time, unload time, and possible cleanup time. The *ntuser.dat* timestamp is now used as a fallback decision.

The following registry values track the last load of the profile by the profile service and are used to validate the **Unload** and **Cleanup** values:

- **LocalProfileLoadTimeLow**
- **LocalProfileLoadTimeHigh**

The following registry values track the last unload of the profile by the profile service:

- **LocalProfileUnLoadTimeLow**
- **LocalProfileUnLoadTimeHigh**

The following registry values track the cleanup time. If either of the other values is invalid or doesn't exist and the *ntuser.dat* timestamp isn't old enough for deletion during startup with the policy configured, the age is then calculated from this timestamp. If a user signs in when the registry values are set, the registry values are removed, and tracking reverts to the other values.

- **LocalProfileCleanupCheckTimeLow**
- **LocalProfileCleanupCheckTimeHigh**

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

## Script

```powershell
Function TranslateSID2Name
{
    param(
        [string]$sid
    )

    try
    {
        $osid = New-Object System.Security.Principal.SecurityIdentifier( $sid )
        $osid.Translate([System.Security.Principal.NTAccount])
    }
    catch
    {
        "<Unresolved>"
    }
}

Function ConvertToDate
{
    param(
        [uint32]$lowpart,
        [uint32]$highpart
    )

    $ft64 = ( [UInt64]$highpart -shl 32) -bor $lowpart
    [datetime]::FromFileTime( $ft64 )
}

Function Get-ProfileLoadUnloadDate
{
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)][String] $Name
    )

    BEGIN {}

    PROCESS{
        $SaveErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "SilentlyContinue"

        $profilelistsidkey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$Name"
        $localprofileloadtimelow = 0
        $localprofileloadtimelow = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileLoadTimeLow
        $localprofileloadtimehigh = 0
        $localprofileloadtimehigh = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileLoadTimeHigh

        $localprofileunloadtimelow = 0
        $localprofileunloadtimelow = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileUnLoadTimeLow
        $localprofileunloadtimehigh = 0
        $localprofileunloadtimehigh = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileUnLoadTimeHigh

        $localprofilecleanupchecktimelow = 0
        $localprofilecleanupchecktimelow = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileCleanupCheckTimeLow
        $localprofilecleanupchecktimehigh = 0
        $localprofilecleanupchecktimehigh = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileCleanupCheckTimeHigh

        $profilepath = "-"
        $profilepath = Get-ItemPropertyValue -Path $profilelistsidkey -Name ProfileImagePath
        $manprofilepath = $profilepath + "\NTUSER.MAN"
        $datprofilepath = $profilepath + "\NTUSER.DAT"
        $ntusermodified = [datetime]::FromFileTime(0)
        if( Test-Path $manprofilepath ){
            $ntusermodified = Get-ItemPropertyValue $manprofilepath -Name LastWriteTime
        }
        elseif( Test-Path $datprofilepath ){
            $ntusermodified = Get-ItemPropertyValue $datprofilepath -Name LastWriteTime
        }

        $ErrorActionPreference = $SaveErrorActionPreference

        [PSCustomObject] @{
            Sid = $Name
            ProfilePath = $profilepath
            LoadDate = ConvertToDate $localprofileloadtimelow $localprofileloadtimehigh
            UnLoadDate = ConvertToDate $localprofileunloadtimelow $localprofileunloadtimehigh
            CleanupCheckDate = ConvertToDate $localprofilecleanupchecktimelow $localprofilecleanupchecktimehigh
            NTUserDate = $ntusermodified
        }
    }

    END{}
}

# Get unloaded profiles' information on the machine
$profinfo = (gwmi win32_userprofile -Filter "Loaded = 'False' and Special = 'False'").sid | Get-ProfileLoadUnloadDate

$SaveErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = "SilentlyContinue"

# Begin: Check GPO or WMI controlled and get CleanupProfiles value
$WMIcontrolled = $false
$cleanupvalue = 0
$UserStateRoaming = 0
$UserStateRoaming = Get-ItemPropertyValue -Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\UserState\UserStateTechnologies\ConfigurationControls" -Name RoamingUserProfile
if( ($UserStateRoaming -eq $null) -or ($UserStateRoaming -eq 0) )
{
    # Profiles controlled by GPO, get GPO configured setting if available
    $cleanupvalue = Get-ItemPropertyValue -Path "HKLM:Software\Policies\Microsoft\Windows\System" -Name CleanupProfiles
}
else
{
    # Profiles controlled by WMI, get setting if configured
    $cleanupvalue = Get-ItemPropertyValue -Path "HKLM:Software\Microsoft\Windows\CurrentVersion\UserState\RoamingUserProfile" -Name CleanupProfiles
    $WMIcontrolled = $true
}
if( $cleanupvalue -eq $null )
{
    $cleanupvalue = 0
}
$cleanupwarning = ""
if( $cleanupvalue -eq 0)
{
    $cleanupwarning = " - Value needs to be 1 or larger for profiles to age and be deleted.  Check setting and GP application."
}
# End: Check GPO or  WMI controlled and get CleanupProfiles value

$ErrorActionPreference = $SaveErrorActionPreference

$cleanupdays = New-TimeSpan -Days $cleanupvalue

$curdate = Get-Date
$Date0 = [datetime]::FromFileTime(0)

"Current Date........: $($curdate.ToString())"
"Run As..............: $($env:USERDOMAIN)\$($env:USERNAME)"
$OSInfo = Get-ComputerInfo CsName,OsName,WindowsVersion,OsVersion,OsLastBootUpTime,OsUptime
"Machine Name........: " + $OSInfo.CsName
"Operating System....: " + $OSInfo.OsName
"Windows Version.....: " + $OSInfo.WindowsVersion + " (" + $OSInfo.OsVersion + ")"
$ProfsvcdllVersionInfo = (Get-Item $env:windir\system32\profsvc.dll).VersionInfo
"Profsvc.dll Version.: $($ProfsvcdllVersionInfo.FileMajorPart).$($ProfsvcdllVersionInfo.FileMinorPart).$($ProfsvcdllVersionInfo.FileBuildPart).$($ProfsvcdllVersionInfo.FilePrivatePart)" 
"Last boot time......: " + $OSInfo.OsLastBootUpTime.ToString() + " (Up time: " + $OSInfo.OsUptime + ")"
"-" * 21
"Profile Cleanup Days: $cleanupvalue$cleanupwarning"
"Controlled by WMI...: $WMIcontrolled"
"Profile count.......: $($profinfo.count)"

$profoutput = $profinfo | Select-Object `
    Sid, `
    @{L="User"; E={TranslateSID2Name $_.Sid }}, `
    ProfilePath, `
    @{L="LoadDate"; E={if($_.LoadDate -gt $Date0){ $_.LoadDate } else {"-"}}}, `
    @{L="UnLoadDate"; E={if( $_.UnLoadDate -gt $Date0 ){ $_.UnLoadDate } else {"-"}}}, `
    @{L="CleanupCheckDate"; E={if( $_.CleanupCheckDate -gt $Date0 ){ $_.CleanupCheckDate } else {"-"}}}, `
    @{L="NtUserDate"; E={if( $_.NtUserDate -gt $Date0 ) { $_.NtUserDate } else { "-" }}}, `
    @{L="DeterminedFrom"; E={
        if( $_.CleanupCheckDate -gt $Date0 ){ "CleanupCheckDate" } 
        elseif( $_.UnLoadDate -gt $Date0 ){ "UnloadDate" } 
        elseif( $_.NtUserDate -gt $Date0 ){ "NtUserDate" }  
        else { "-" } }}, `
    @{L="ProfileAgeDays"; E={ 
        if( $_.CleanupCheckDate -gt $Date0 ){ [Math]::Truncate( ($curdate - $_.CleanupCheckDate).TotalDays ) } 
        elseif( $_.UnLoadDate -gt $Date0 ){ [Math]::Truncate( ($curdate - $_.UnLoadDate).TotalDays ) } 
        elseif( $_.NtUserDate -gt $Date0 ){ [Math]::Truncate( ($curdate - $_.NtUserDate).TotalDays ) } 
        else { "-" } }}, `
    @{L="CleanupDate"; E={ 
        if( $cleanupdays -eq 0 ){ "-" }
        elseif( $_.CleanupCheckDate -gt $Date0 ){ $_.CleanupCheckDate + $cleanupdays } 
        elseif( $_.UnLoadDate -gt $Date0 ){ $_.UnloadDate + $cleanupdays } 
        elseif( $_.NtUserDate -gt $Date0 ){ $_.NtUserDate + $cleanupdays } 
        else { "-" } }} `
    | Sort-Object -Property @{E="CleanupDate"; Descending = $false}, @{E="ProfileAgeDays"; Descending = $true}

# Different output options
#$profoutput | fl *
$profoutput | ft *       # NOTE: may not give all columns depending on the window width.
#$profoutput | Out-GridView
#$profoutput | Export-Csv -Path ProfileAge.csv -NoTypeInformation
```

## Sample output

Here's a sample output of the script. The tabular output can be truncated depending on the width of the window, so the format of the information can be changed to other available ones as needed:

```output
Current Date........: 8/21/2024
Run As..............: DOMAIN\username
Machine Name........: COMPUTERNAME
Operating System....: Microsoft Windows 10
Windows Version.....: <version>
Profsvc.dll Version.: <version of profsvc.dll>
Last boot time......: <uptime of the machine>
---------------------
Profile Cleanup Days: 30
Controlled by WMI...: False
Profile count.......: 

Sid                                          User            ProfilePath       LoadDate              UnLoadDate            CleanupCheckDate NtUserDate            DeterminedFrom ProfileAgeDays CleanupDate
---                                          ----            -----------       --------              ----------            ---------------- ----------            -------------- -------------- -----------
S-1-5-21-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxx DOMAIN\username C:\Users\username 8/21/2024 10:23:52 AM 8/21/2024 11:23:52 AM        -         8/21/2024 10:23:52 AM UnLoadDate                  0 9/20/2024 11:23:52 AM  
```
