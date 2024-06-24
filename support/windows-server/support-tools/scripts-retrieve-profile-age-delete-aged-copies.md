---
title: Scripts to retrieve profile age and optionally delete aged copies
description: Provides a script to retrieve profile age and optionally delete aged copies.
ms.date: 06/24/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:User Logon and Profiles\User profiles, csstroubleshoot
---
# Scripts: Retrieve profile age and optionally delete aged copies

This article provides a script to retrieve profile age and optionally delete aged copies.

_Applies to:_ &nbsp; Windows Server 2016 and later versions, Windows 11, Windows 10

There's a Group Policy "[Delete user profiles older than a specified number of days on system restart](https://gpsearch.azurewebsites.net/#2583)" to delete aged copies of user profiles.

A timestamp stored in the registry has been used since Windows 10, Windows Server 2019, and later versions. This is more reliable than the approach in older operating system (OS) versions using the New Technology File System (NTFS) timestamp of the profile *NTUSER.DAT* file, as this file may be updated by any software loading the user registry.

This script allows you to test-drive what the policy will do or run it with different parameters. For example, you can clean up the profiles with a lower unused interval. The script will only clean up profiles that aren't loaded when the script runs.

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```PowerShell
###############################################################################
#
# Usage:
#	Powershell -file ADDelProf.ps1 [-Days #] [-UserDomain <domainname>] [-UserName <username>] [-RoamingOnly] [-UseNtfs] [-Delete] [-Quiet] [-ComputerName]
#
#	-Days = Number of days a profile has not been used to consider for deletion (default 0)
#	-UserDomain = Domain pattern to match to consider for deletion (default "*")
#	-UserName = Username pattern to match to consider for deletion (default "*")
#	-RoamingOnly = Determines if only profiles that would be roaming should be deleted. Default is to do all unloaded profiles.
#	-UseNtfs = Determines if using reg-entries or NTFS timestamp on ntuser.dat. Default is registry.
#	-Delete = Determines if profiles will be deleted or reported. Default is to just report.
#	-Quiet = Prompts or not, default is to prompt.
#	-ComputerName = Computer to delete profiles against. Default is the local machine. Needs WinRM to work so we can invoke registry read remotely.
#
#	Example:
#	To delete profiles that haven't been used in 60 or more days on the local machine
#   Powershell -file ADDelProf.ps1 -Days 60 -Delete True
#

# Parameters definition
Param(
    $Days = 0,
    [string]$UserDomain = "*",
    [string]$UserName = "*",
    [switch]$RoamingOnly = $false,
    [switch]$UseNtfs = $false,
    [switch]$Delete = $false,
    [switch]$Quiet = $false,
    [string]$ComputerName = "."
)

[void][System.Reflection.Assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][System.Reflection.Assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')

Function ConvertToDate
{
    param(
        [uint32]$lowpart,
        [uint32]$highpart
    )

    $ft64 = ( [UInt64]$highpart -shl 32) -bor $lowpart
    [datetime]::FromFileTime( $ft64 )
}

Write-Host "Parameters for deletion:"
Write-Host "Target Computer.:" $ComputerName
Write-Host "Days Not used...:" $Days
Write-Host "Domain..........:" $UserDomain
Write-Host "UserName........:" $UserName
Write-Host "Roaming Only....:" $RoamingOnly
Write-Host "UseNtfs.........:" $UseNtfs
Write-Host "Delete..........:" $Delete
Write-Host "Quiet Mode......:" $Quiet
Write-Host ""
Write-Host "To change parameters, provide command line switches."
Write-Host "E.g. to delete roaming profile copies older than 30 days: ADDelProf.ps1 -Days 30 -Roaming True -Delete $True"

#Setup Prompt Parameters
$title = "Delete Profile"
$message = "Delete user profile?"
$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Deletes the profile."
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Does not delete the profile."
$all = New-Object System.Management.Automation.Host.ChoiceDescription "&All", "Switches to 'quiet mode' and deletes remaining matching profiles."
$cancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel", "Exits the script."
$options = [System.Management.Automation.Host.ChoiceDescription[]]($no, $yes, $all, $cancel)

#Get Unloaded profiles and maybe ones that are only roaming
$Filter = "Loaded = 'False' and Special = 'False'"
if( $RoamingOnly ) { $Filter = "$Filter and RoamingPreference = 'True'" }
$UnloadedProfiles = gwmi win32_userprofile -filter $Filter -computername $ComputerName -ErrorAction stop

if( -not ($UnloadedProfiles -eq $null) ){

    #Match Profiles to delete
    Write-Host "Matching Profiles....."
    $UnloadedProfiles | ForEach-Object {
        $CurUserSid = $_.sid
        $CurUserObj = [wmi]"\\$ComputerName\root\cimv2:Win32_SID.SID='$CurUserSid'"
        $CurUserDomain = $CurUserObj.ReferencedDomainName
        if( $CurUserDomain -eq "" ) { $CurUserDomain = "<Unresolved>" }
        $CurUserName = $CurUserObj.AccountName
        if( $CurUserName -eq "" ) { $CurUserName = "<Unresolved>" }
        $CurUser = "$CurUserDomain\$CurUserName"

        if( $UseNtfs ) {
            if( $_.lastusetime ) {
                $CurUserDaysOld = (((Get-Date) - [System.Management.ManagementDateTimeConverter]::ToDateTime($_.lastusetime)).days)
            } else {
                $CurUserDaysOld = 99999
            }

        }
		else {
		    #Use registry keys
		    $profilelistsidkey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$CurUserSid"
			$SaveErrorActionPreference = $ErrorActionPreference
			$ErrorActionPreference = "SilentlyContinue"

			$localprofileunloadtimelow = 0
			$localprofileunloadtimehigh = 0		

			if( $ComputerName -eq ".") {
				$localprofileunloadtimelow = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileUnLoadTimeLow
				$localprofileunloadtimehigh = Get-ItemPropertyValue -Path $profilelistsidkey -Name LocalProfileUnLoadTimeHigh
			}
			else {
				$RemSession = New-PSSession -ComputerName $ComputerName
				$result = Invoke-Command -Session  $RemSession {
					Get-ItemProperty $Using:profilelistsidkey -Name LocalProfileLoadTimeLow, LocalProfileLoadTimeHigh
				}
				$localprofileunloadtimelow = $result.LocalProfileLoadTimeLow
				$localprofileunloadtimehigh = $result.LocalProfileLoadTimeHigh
			}
	
		    $lastusetime = ConvertToDate $localprofileunloadtimelow $localprofileunloadtimehigh
			$ErrorActionPreference = $SaveErrorActionPreference

            if( $lastusetime ) {
                $CurUserDaysOld = ((Get-Date) - $lastusetime).days
            }
			else {
                $CurUserDaysOld = 99999
            }
        }
        
        if (
            ($CurUserDaysOld -ge $Days) -and
            ($CurUserDomain -like $UserDomain) -and
            ($CurUserName -like $UserName)
        ){
            Write-Host "Age:" $CurUserDaysOld "-" $CurUser "-" $_.Sid "- Path:" $_.localpath
            if( $Delete ){
                $bDelete = $false
                if( $Quiet ){
                    $bDelete = $true
                } else {

                    $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

                    if( $result -eq 3 ) {
                        "Exiting Script"
                        Exit
                    } elseif( $result -eq 0 ) {
                        "     Skipping profile."
                    } else {
                        $bDelete = $true
                        if( $result -eq 2 ) { $Quiet = $true }
                    }
                }
                
                if( $bDelete ) {
                    Write-Host "     Deleting profile - " -NoNewline
                    try {
                        $_.Delete()
                        write-host "Successfully deleted profile." -ForegroundColor green
                    }
                    catch {
                        write-host "Error occured deleting profile.  It may have been only partially deleted." -ForegroundColor red
                    }
                }
            }
        }
    }
}
"Completed!"
```
