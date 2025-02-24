---
title: Scripts to clean profile folder and prevent TEMP user profile creation
description: Provides a script to clean up profile folder information and prevent TEMP user profiles from being created.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, gbrag, v-lianna
ms.custom:
- sap:user logon and profiles\user profiles
- pcy:WinComm Directory Services
---
# Scripts: Clean up profile folder information and prevent TEMP user profiles from being created

The sample script provided in this article can help clean up orphaned profile information from the registry and the _C:\\users_ folder.

If profiles are incompletely or improperly removed, additional user folders can be created, or users may receive TEMP profiles upon logging in. In some cases, there can be many profiles in a state where TEMP profiles are used, even though these profiles haven't been logged into yet.

_Applies to:_ &nbsp; Windows 10, Windows 11, Windows Server 2016, and later versions

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```powershell
#
# usage:
# PowerShell /file OrhanedProfile.ps1 [-clean]
#
# The clean switch enables the deletion to take place. Otherwise, it reports what it could do.
#

Param(
    [switch]$bClean = $false
)


# Check if running as an Administrator
if( -NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator") )
{
    Write-Host "Please run as a member of the Administrators group"
    break
}


# Get Profiles folder
$ProfilesListRegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
$ProfilesFolder = $null
$ProfilesFolder = Get-ItemPropertyValue -Path $ProfilesListRegPath -Name "ProfilesDirectory"
If( $ProfilesFolder -eq $null )
{
    Write-Host "Error getting the base profile folder."
    break
}
"Profile folder: $ProfilesFolder"


#######################################
# Begin to get and check ProfileList key information
"Collecting ProfileList key information..."
"=" * 40
$WellKnownProfiles = @("S-1-5-18","S-1-5-19","S-1-5-20")
$ProfileListCount = 0
$ProfileListWarnCount = 0
$ProfileListInfo = @{}
Get-ChildItem -Path $ProfilesListRegPath -Exclude $WellKnownProfiles | ForEach-Object `
{
    $ProfileSID = $_.PSChildName

    $ProfilePath = $null
    $ProfilePath = Get-ItemPropertyValue -Path $_.PSPath -Name "ProfileImagePath"
    if( $ProfilePath -eq $null )
    {
        "Unable to read ProfileImagePath from ProfileList entry: $($_.Name)"
    }
    else
    {
        $ProfileListCount++

        if( $ProfileSID -like "*.bak" )
        {
            "WARNING: .BAK ProfileList entry exists: $ProfileSID"
            $ProfileListWarnCount++
        }

        try{
            $ProfileListInfo.Add( $ProfilePath, $ProfileSID)
        }
        catch
        {
            $ProfileListInfo[ $ProfilePath ] = $ProfileListInfo[ $ProfilePath ] + ";$ProfileSID"
            "WARNING: Multiple profile entries reference '$ProfilePath': $($ProfileListInfo[$ProfilePath])"
            $ProfileListWarnCount++
        }
    }
}
"ProfileList Count...: $ProfileListCount"
"ProfileList Warnings: $ProfileListWarnCount"


#######################################
# Check for Orphaned ProfileListEntries - entries that reference deleted profile folders
""
"Looking for orphaned ProfileListEntries"
"=" * 40
$OrphanedProfileEntries = 0
$ProfileListInfo.GetEnumerator() | ForEach-Object `
    {
        $bOrphaned = $false
        if( -not (Test-Path -Path $_.Key ) )
        {
            "Entry: $($_.Value) => $($_.Name)"
            $OrphanedProfileEntries++
            $bOrphaned = $true
        }
        elseif( -not (Get-ChildItem -Path $_.Key -include ntuser.dat,ntuser.man -Name -Force -File) )
        {
            "MISSING NTUSER.DAT or NTUSER.MAN: $($_.Value) => $($_.Name)"
            $OrphanedProfileEntries++
            $bOrphaned = $true
        }

        if( $bOrphaned -and $bClean )
        {
            $_.Value.Split( ";") | ForEach-Object `
                {
                    try
                    {
                        $WMIUserProfile = gwmi -Class Win32_UserProfile -Filter "sid = '$($_)'"
                        $WMIUserProfile.Delete()
                        "Successfully deleted orphaned profile information."
                    }
                    catch
                    {
                        "Error occurred deleting profile.  It may have only been partially deleted.  [$($_.Exception.Message)]"
                    }
                }
        }
    }
"=" * 40
"Orphaned ProfileListEntries: $OrphanedProfileEntries"

#######################################
# Check for Orphaned ProfileGUID entries - having SidString that reference deleted SID keys under ProfileList
# ProfileGUID would only exist on machines that have been domain joined at some time
$ProfileGUIDPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileGUID"
if( Test-Path -Path $ProfileGUIDPath )
{
    ""
    "Looking for orphaned ProfileGUID entries"
    "=" * 40
    $OrphanedGUIDCount = 0
    Get-ChildItem -Path $ProfileGUIDPath | ForEach-Object `
        {
            $SidString = $null
            $SidString = Get-ItemPropertyValue -Path ($ProfilesListRegPath + "\" + $_.PSChildName) -Name "SidString" -ErrorAction SilentlyContinue
            if( -not $SidString -eq $null )
            {
                if( $null -eq (Get-Item ($ProfilesListRegPath + "\" + $SidString) -ErrorAction SilentlyContinue) )
                {
                    "Orphaned GUID: $($_.PSChildName)"
                    $OrphanedGUIDCount++

                    if( $bClean )
                    {
                        Remove-Item -Path $_.PSPath -Recurse -Force
                    }
                }
            }
        }
    "=" * 40
    "Orphaned ProfileGUIDS: $OrphanedGUIDCount"
}


#######################################
# Check for Orphaned user folders - folders in the profile folder that are not referenced by ProfileList\SID keys
""
"Looking for orphaned user folders"
"=" * 40
$KnownUserFolders = @("All Users", "Default", "Default User", "LocalService", "NetworkService", "Public")
$OrhanedUserFolders = 0
Get-ChildItem -Path $ProfilesFolder -Exclude $KnownUserFolders -Directory -Force | ForEach-Object `
    {
        if( -not $ProfileListInfo.Contains( $_.FullName ) )
        {
            "Folder: $($_.FullName) (Created: $($_.CreationTime) - Modified $($_.LastWriteTime))"
            $OrhanedUserFolders++

            if( $bClean )
                {
                    Remove-Item -Path ("\\?\$($_.FullName)") -Force -Recurse
                }
        }
    }
"=" * 40
"Orphaned user folders: $OrhanedUserFolders"
""
"Completed."
```
