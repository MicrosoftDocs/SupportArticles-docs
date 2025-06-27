---
title: Resolve issues when starting the new Teams app
description: Provides troubleshooting steps to resolve issues when you try to start the new Teams app on Windows.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Clients\Windows Desktop
  - CI 191453
  - CI 191759
  - CSSTroubleshoot
ms.reviewer: guptaashish; meerak
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 07/09/2024
---
# Resolve issues when starting the new Teams app

## Symptoms

When you turn on the **Try the new Teams** toggle in classic Microsoft Teams, the new Teams app doesn't start. Instead, a banner appears and displays the following error message:

> Something went wrong.

If you check the log file for classic Teams, the following error entry is logged:

```output
message: Launch api returns false, code: 11, apiCode: undefined, extendedErrorCode: 0, launchStatus: failed, status: failure, scenario: <scenarioGUID>, scenarioName: launch_pear_app, name: launch_pear_app
```

## Cause

This issue might occur for any of the following reasons:

- The **Cookies** and **Cache** shell folders point to a reparse point.
- The **TEMP** or **TMP** environment variables point to a reparse point.
- You don't have the **Read** permission to access certain folders in the **AppData** folder.
- Some folders in the **AppData** folder are changed to function as reparse points.
- The **AppData** folder contains invalid files that have the same name as the required system folders.
- The SYSTEM account and the Administrators group don't have the **Full control** permission to certain folders in the **AppData** folder.
- You don't have the SYSAPPID permission to the Teams installation location.
- The **AllowAllTrustedApps** policy setting prevents new Teams from starting.

## Resolution

To apply the appropriate resolution for this issue, you have to perform multiple checks to determine the cause of the issue. There are two options to run all the necessary diagnostic checks. Use the option that you prefer.

### Option 1: Run a script

The *TeamsLaunchCheck.ps1* PowerShell script automates all the checks that you have to run.  
<br/>
<details>
<summary>The TeamsLaunchCheck.ps1 script</summary>

```powershell
# $erroractionpreference="stop"

$list = @(
    "$env:APPDATA", 
    "$env:APPDATA\Microsoft", 
    "$env:APPDATA\Microsoft\Crypto", 
    "$env:APPDATA\Microsoft\Internet Explorer", 
    "$env:APPDATA\Microsoft\Internet Explorer\UserData", 
    "$env:APPDATA\Microsoft\Internet Explorer\UserData\Low",
    "$env:APPDATA\Microsoft\Spelling", 
    "$env:APPDATA\Microsoft\SystemCertificates",
    "$env:APPDATA\Microsoft\Windows", 
    "$env:APPDATA\Microsoft\Windows\Libraries",
    "$env:APPDATA\Microsoft\Windows\Recent",
    "$env:LOCALAPPDATA",
    "$env:LOCALAPPDATA\Microsoft",
    "$env:LOCALAPPDATA\Microsoft\Windows",
    "$env:LOCALAPPDATA\Microsoft\Windows\Explorer",
    "$env:LOCALAPPDATA\Microsoft\Windows\History",
    "$env:LOCALAPPDATA\Microsoft\Windows\History\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\History\Low\History.IE5",
    "$env:LOCALAPPDATA\Microsoft\Windows\IECompatCache",
    "$env:LOCALAPPDATA\Microsoft\Windows\IECompatCache\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\IECompatUaCache",
    "$env:LOCALAPPDATA\Microsoft\Windows\IECompatUaCache\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCache",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\DNTException",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\DNTException\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\PrivacIE",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\PrivacIE\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\PPBCompatCache",
    "$env:LOCALAPPDATA\Microsoft\Windows\PPBCompatCache\Low",
    "$env:LOCALAPPDATA\Microsoft\Windows\PPBCompatUaCache",
    "$env:LOCALAPPDATA\Microsoft\Windows\PPBCompatUaCache\Low",
    "$env:LOCALAPPDATA\Microsoft\WindowsApps",
    "$env:LOCALAPPDATA\Packages",
    "$env:LOCALAPPDATA\Publishers",
    "$env:LOCALAPPDATA\Publishers\8wekyb3d8bbwe",
    "$env:LOCALAPPDATA\Temp",
    "$env:USERPROFILE\AppData\LocalLow",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft\Internet Explorer",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft\Internet Explorer\DOMStore",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft\Internet Explorer\EdpDomStore",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft\Internet Explorer\EmieSiteList",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft\Internet Explorer\EmieUserList",
    "$env:USERPROFILE\AppData\LocalLow\Microsoft\Internet Explorer\IEFlipAheadCache"
)

$ver = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\'
$script:osVersion = $ver.DisplayVersion
if($script:osVersion -eq "")    {
        $script:osVersion = $ver.ReleaseId
}
$script:osBuild = (Get-WmiObject -Class Win32_OperatingSystem).Version
$script:osUBR= [int]$ver.UBR
$script:osFullBuild = [version]"$script:osBuild.$script:osUBR"
$script:osProductName = $ver.ProductName

function ValidateShellFolders
{
    $shellFolders = @(
        "Cookies",
        "Cache"
    )

    $shellPaths = @{}

    $path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"    
    $keys = Get-Item $path
    $props = Get-ItemProperty $path
    ($keys).Property | %{
        $shellPaths[$_] = $props."$_"
        $str = $props."$_"
        $str += "`t: " + $_
        echo $str
    }

    foreach($shellFolder in $shellFolders)
    {
        $shellPath = $shellPaths[$shellFolder]
        if(PathContainsReparsePoint($shellPath))
        {
            Write-Warning "$($shellFolder) User Shell Folder path $shellPath contains a reparse point."
        }
        else
        {
            Write-Host "$($shellFolder) User Shell Folder path $shellPath is not a reparse point" -ForegroundColor Green
        }
    }
}

function ValidateEnvironmentVars
{
    $temps = (gci env:* | ?{@("TEMP", "TMP").Contains($_.Name)})
    foreach($temp in $temps)
    {
        if(PathContainsReparsePoint($temp.Value))
        {
            Write-Warning "$($temp.Name): $($temp.Value) contains a reparse point."
        }
        else
        {
            Write-Host "$($temp.Name): $($temp.Value) is not a reparse point" -ForegroundColor Green
        }
    }
}

function ValidateUserAccess($list)
{
    $checked = @()
    foreach ($path in $list)
    {
        $left = $path
        for($i=0;$i -lt 10; $i++)
        {
            if ([string]::IsNullOrEmpty($left))
            {
                break;
            }
            if(-Not $checked.Contains($left))
            {
                try
                {
                    if (Test-Path -Path $left)
                    {
                        $items = Get-ChildItem $left -ErrorAction SilentlyContinue -ErrorVariable GCIErrors
                        if($GCIErrors.Count -eq 0)
                        {
                            Write-Host "User is able to access $left" -ForegroundColor Green
                        }
                        else
                        {
                            Write-Warning "$left is missing permissions for the current user."
                        }
                        $checked += $left
                    }
                    else
                    {
                        Write-Host "MISSING: $path" -ForegroundColor Green
                    }
                }
                catch
                {
                    Write-Warning "Error trying to access $left."
                }
            }
            $left=Split-Path $left
        }
    }
}

function ValidatePaths($list)
{
    foreach ($path in $list)
    {
        if (Test-Path -Path $path)
        {
            if (Test-Path -Path $path -PathType Container)
            {
                Write-Host "Folder: $path" -ForegroundColor Green
            }
            else
            {
                Write-Warning "FILE: $path"
            }
        }
        else
        {
            Write-Host "MISSING: $path" -ForegroundColor Green
        }
    }
}

function ValidateSystemPerms($list)
{
    foreach ($path in $list)
    {
        if (Test-Path -Path $path)
        {
            $systemPerms = (Get-Acl $path).Access | where {$_.IdentityReference -eq "NT AUTHORITY\SYSTEM"}
            $systemFullControl = $systemPerms | where {$_.FileSystemRights -eq "FullControl" -and $_.AccessControlType -eq "Allow"}
            if($systemFullControl.Count -ge 1)
            {
                Write-Host "$path has the correct permissions assigned for SYSTEM account" -ForegroundColor Green
            }
            else
            {
                Write-Warning "$path is missing permissions for the SYSTEM account. The current permissions:"
                $systemPerms
            }
            $adminPerms = (Get-Acl $path).Access | where {$_.IdentityReference -eq "BUILTIN\Administrators"}
            $adminFullControl = $adminPerms | where {$_.FileSystemRights -eq "FullControl" -and $_.AccessControlType -eq "Allow"}
            if($adminFullControl.Count -ge 1)
            {
                Write-Host "$path has the correct permissions assigned for Administrators group" -ForegroundColor Green
            }
            else
            {
                Write-Warning "$path is missing permissions for the Administrators group. The current permissions:"
                $adminPerms
            }
        }
        else
        {
            Write-Host "MISSING: $path" -ForegroundColor Green
        }
    }
}

function ValidateSysAppIdPerms
{
    $apps = Get-AppxPackage MSTeams 
    foreach($app in $apps)
    {
        $perms = (Get-Acl $app.InstallLocation).sddl -split "\(" | ?{$_ -match "WIN:/\/\SYSAPPID"}
        if($perms.Length -gt 0)
        {
            Write-Host "$($app.InstallLocation) has the correct SYSAPPID permissions assigned" -ForegroundColor Green
        }
        else
        {
            Write-Warning "$($app.InstallLocation) is missing SYSAPPID permissions."
        }
    }
}

function IsReparsePoint([string]$path) 
{

    $props = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue
    if($props.Attributes -match 'ReparsePoint')
    {
        return $true
    }
    return $false
}

function PathContainsReparsePoint($path, $trace = $false)
{
    $badPaths = 0
    $result = ""
    $left = $path
    for($i=0;$i -lt 10; $i++)
    {
        if ([string]::IsNullOrEmpty($left))
        {
            break;
        };
        if(IsReparsePoint($left))
        {
            $result = "Y" + $result
            $badPaths++
        }
        else{
            $result = "N" + $result
        }
        $left=Split-Path $left
    }
    if($trace)
    {
        if ($result.Contains("Y"))
        {
            Write-Warning "$result $path contains a reparse point"
        }
        else
        {
            Write-Host "$result $path" -ForegroundColor Green
        }
    }
    return $badPaths -gt 0
}

function ValidateAppXPolicies()
{
    $osPatchThresholds = @{
        "10.0.19044" = 4046 #Win 10 21H2
        "10.0.19045" = 3636 #Win 10 22H2
        "10.0.22000" = 2777 #Win 11 21H2
        "10.0.22621" = 2506 #Win 11 22H2
    }

    $minPatchVersion = [version]"10.0.19044"
    $maxPatchVersion = [version]"10.0.22621"

    if($script:osFullBuild -lt $minPatchVersion)
    {
        if(-Not (HasAllowAllTrustedAppsKeyEnabled))
        {
            Write-Warning "AllowAllTrustedApps is not enabled and OS version is too low to get the AllowAllTrustedApps patch."
        }
        else
        {
            Write-Host "The OS version is too low to get the AllowAllTrustedApps patch, but AllowAllTrustedApps is a supported value" -ForegroundColor Green
        }
    }
    elseif($script:osFullBuild -le $maxPatchVersion)
    {
        $targetUBR = $osPatchThresholds[$script:osBuild]
        if($script:osUBR -lt $targetUBR)
        {
            if(-Not (HasAllowAllTrustedAppsKeyEnabled))
            {
                $recommendedVersion = [version]"$script:osBuild.$targetUBR"
                Write-Warning "AllowAllTrustedApps is not enabled and your version of Windows does not contain a required patch to support this.`nEither update your version of Windows to be greater than $recommendedVersion, or enable AllowAllTrustedApps"
            }
            else
            {
                Write-Host "OS version is missing the AllowAllTrustedApps patch, but AllowAllTrustedApps is a supported value" -ForegroundColor Green
            }
        }
        else
        {
            Write-Host "OS version has the AllowAllTrustedApps patch" -ForegroundColor Green
        }
    }
    else
    {
        Write-Host "OS version is high enough that AllowAllTrustedApps should not be an issue" -ForegroundColor Green
    }
}

function HasAllowAllTrustedAppsKeyEnabled
{
    $hasKey = $false;
    $appXKeys = @("HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock", "HKLM:\Software\Policies\Microsoft\Windows\Appx")
    foreach ($key in $appXKeys)
    {
        try
        {
            $value = Get-ItemPropertyValue -Path $key -Name "AllowAllTrustedApps"
            echo "$key AllowAllTrustedApps = $value"
            if ($value -ne 0) 
            {
                $hasKey = $true
                break;
            }
        }
        catch
        {
            echo "Missing AllowAllTrustedApps key at $key"
        }
    }
    return $hasKey
}

echo "$script:osProductName Version $script:osVersion, Build $script:osFullBuild"
echo ""
echo "# Checking for reparse points in user shell folders"
ValidateShellFolders
echo ""
echo "# Checking for reparse points in temp/tmp environment variables"
ValidateEnvironmentVars
echo ""
echo "# Checking for user permissions in appdata"
ValidateUserAccess($list)
echo ""
echo "# Checking for reparse points in appdata"
foreach ($path in $list)
{
    $result = PathContainsReparsePoint $path $true
}
echo ""
echo "# Checking for unexpected files in appdata"
ValidatePaths($list)
echo ""
echo "# Checking SYSTEM and Administrators permissions in appdata"
ValidateSystemPerms($list)
echo ""
echo "# Checking SYSAPPID permissions"
ValidateSysAppIdPerms
echo ""
echo "# Checking if AllowAllTrustedApps is valid"
ValidateAppXPolicies

Pause

```

</details>

### Option 2: Perform the checks manually

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, [back up the registry](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) before you modify it. Then, you can restore the registry if a problem occurs.

1. Check whether the *Cookies* and *Cache* shell folders point to a location that is a reparse point:

   1. Run the following PowerShell commands:

      ```powershell
      (gp ([environment]::getfolderpath("Cookies"))).Attributes -match 'ReparsePoint'
      (gp ([environment]::getfolderpath("InternetCache"))).Attributes -match 'ReparsePoint'
      ```

   1. If both commands return **False**, go to step 2. Otherwise, open the Registry Editor and locate the following subkey:

      `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
   1. For the shell folder in the PowerShell command that's returned as **True**, update the value of its associated registry entry to a location that isn't a reparse point. For example, you can set the value to the default path:

     | Registry entry | Value |
     | --- | --- |
     |Cookies|`%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies`|
     |Cache|`%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache`|
1. Check whether the values of the **TEMP** or **TMP** environment variables are set to a reparse point:

   1. Run the following PowerShell command:

      ```powershell
      gci env:* | ?{@("TEMP", "TMP").Contains($_.Name)} | %{$_.Value+" - "+((gp $_.Value).Attributes -match 'ReparsePoint')}
      ```

   1. If the command returns **False**, go to step 3. Otherwise, [set](/windows-server/administration/windows-commands/set_1) the value of the environment variables to a location that isn't a reparse point.
1. Check whether you have the **Read** permission to access all the following directories in the **AppData** folder:

   - %USERPROFILE%\AppData\Local
   - %USERPROFILE%\AppData\Local\Microsoft
   - %USERPROFILE%\AppData\Local\Microsoft\Windows
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\History
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\History\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\History\Low\History.IE5
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\IECompatCache
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\IECompatCache\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\IECompatUaCache
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\IECompatUaCache\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\DNTException
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\DNTException\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\PrivacIE
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\PrivacIE\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\PPBCompatCache
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\PPBCompatCache\Low
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\PPBCompatUaCache
   - %USERPROFILE%\AppData\Local\Microsoft\Windows\PPBCompatUaCache\Low
   - %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
   - %USERPROFILE%\AppData\Local\Packages
   - %USERPROFILE%\AppData\Local\Packages\VirtualizationTests.Main_8wekyb3d8bbwe\LocalCache
   - %USERPROFILE%\AppData\Local\Publishers
   - %USERPROFILE%\AppData\Local\Publishers\8wekyb3d8bbwe
   - %USERPROFILE%\AppData\Local\Temp
   - %USERPROFILE%\AppData\LocalLow
   - %USERPROFILE%\AppData\LocalLow\Microsoft
   - %USERPROFILE%\AppData\LocalLow\Microsoft\Internet Explorer
   - %USERPROFILE%\AppData\LocalLow\Microsoft\Internet Explorer\DOMStore
   - %USERPROFILE%\AppData\LocalLow\Microsoft\Internet Explorer\EdpDomStore
   - %USERPROFILE%\AppData\LocalLow\Microsoft\Internet Explorer\EmieSiteList
   - %USERPROFILE%\AppData\LocalLow\Microsoft\Internet Explorer\EmieUserList
   - %USERPROFILE%\AppData\LocalLow\Microsoft\Internet Explorer\IEFlipAheadCache
   - %USERPROFILE%\AppData\Roaming
   - %USERPROFILE%\AppData\Roaming\Microsoft
   - %USERPROFILE%\AppData\Roaming\Microsoft\Crypto
   - %USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer
   - %USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\UserData
   - %USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\UserData\Low
   - %USERPROFILE%\AppData\Roaming\Microsoft\Spelling
   - %USERPROFILE%\AppData\Roaming\Microsoft\SystemCertificates
   - %USERPROFILE%\AppData\Roaming\Microsoft\Windows
   - %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Libraries
   - %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent

   You can use the [Test-Path](/powershell/module/microsoft.powershell.management/test-path) PowerShell command to perform this check. If you don't have the **Read** permission for a particular folder, ask someone who has the **Full control** permission for the folder to grant you the **Read** permission.
1. Check whether any of the folders that are listed in step 3 are changed to function as reparse points. If any of the folders are reparse points, contact [Microsoft Support](https://support.microsoft.com/contactus).
1. Check for files that have the same name as a required system folder in the **AppData** folder. For example, a file that's named *Libraries* in the path, *%AppData%\Microsoft\Windows\Libraries*, has the same name as a folder that has the same path. For each folder that's listed in step 3, run the following PowerShell command:

   ```powershell
   Test-Path -Path <directory name, such as $env:USERPROFILE\AppData\Local\Temp>  -PathType Leaf
   ```

   If the command returns **True**, remove the file, and then create a folder by using the same name as the complete path for the system folder.
1. Check whether the SYSTEM account and the Administrators group have the **Full control** permission to all directories that are listed in step 3.

   1. Run the following PowerShell commands for each folder:

      ```powershell
      ((Get-Acl (Join-Path $env:USERPROFILE "<directory name that starts with AppData, such as AppData\Local>")).Access | ?{$_.IdentityReference -eq "NT AUTHORITY\SYSTEM" -and $_.FileSystemRights -eq "FullControl"} | measure).Count -eq 1
      ((Get-Acl (Join-Path $env:USERPROFILE "<directory name that starts with AppData, such as AppData\Local>")).Access | ?{$_.IdentityReference -eq "BUILTIN\Administrators" -and $_.FileSystemRights -eq "FullControl"} | measure).Count -eq 1
      ```

    1. If either command returns **False**, ask someone who has the **Full control** permission for the folder to grant the **Full control** permission to the corresponding account.

1. Check whether you have the SYSAPPID permission to the Teams installation location. Run the following PowerShell command:

   ```powershell
   Get-AppxPackage MSTeams | %{$_.InstallLocation+" - "+(((Get-Acl $_.InstallLocation).sddl -split "\(" | ?{$_ -match "WIN:/\/\SYSAPPID"} | Measure).count -eq 1)}
   ```

   If the command returns **False**, ask a member of the local Administrators group to [delete your user profile](/troubleshoot/windows-server/user-profiles-and-logon/delete-user-profile) on the computer. Then, sign in by using your user account to re-create the user profile.
1. Check the **AllowAllTrustedApps** policy setting:

   1. In a Command Prompt window, run the `winver` command.
   1. Compare your Windows version and build number in the results to the following versions of Windows 11 and Windows 10:

      - Windows 11 version 21H2 OS build 22000.2777
      - Windows 11 version 22H2 OS build 22621.2506      
      - Windows 10 version 21H2 OS build 19044.4046
      - Windows 10 version 22H2 OS build 19045.3636

   1. If your Windows version and build number are earlier than those in the list, open Registry Editor, and then locate the **AllowAllTrustedApps** registry entry under one of the following subkeys:

      - `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock`
      - `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx`
   1. Check the value of **AllowAllTrustedApps**. If the value is **0**, the policy is disabled. Change it to **1** to enable the policy, and then try again to start new Teams.

      **Note:** To start new Teams without enabling the **AllowAllTrustedApps** policy, you must be running one of the versions of Windows that are listed in step 5b.
1. If the issue persists, update the system to Windows 11, version 22H2, OS build 22621.2506 or a later version.
