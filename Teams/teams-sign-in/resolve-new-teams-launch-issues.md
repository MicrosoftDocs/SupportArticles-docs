---
title: Fix issues when starting the new Teams app
description: Provides troubleshooting steps to resolve issues when you try to start the new Teams app on Windows.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Teams Identity and Auth\Client Sign-in (window, mac, linux, web)
  - CI 191453
  - CSSTroubleshoot
ms.reviewer: guptaashish; meerak
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 06/04/2024
---
# Resolve issues when starting the new Teams app

## Symptoms

When you turn on the **Try the new Teams** toggle in classic Microsoft Teams, the new Teams app doesn't start. Instead, a banner appears with the following error message:

> Something went wrong.

If you check the log file for classic Teams, the following error is logged:

```output
message: Launch api returns false, code: 11, apiCode: undefined, extendedErrorCode: 0, launchStatus: failed, status: failure, scenario: <scenarioGUID>, scenarioName: launch_pear_app, name: launch_pear_app
```

## Cause

This issue can be caused by one of the following reasons:

- The **Cookies** and **Cache** shell folders point to a reparse point.
- The **TEMP** or **TMP** environment variables point to a reparse point.
- Some directories in the **AppData** folder are changed to function as reparse points.
- The **AppData** folder contains invalid files that have the same name as the required system folders.
- The **AllowAllTrustedApps** policy setting prevents new Teams from starting.

## Resolution

Before you can fix the issue, you need to perform multiple checks to determine the cause of the issue so that you can apply the appropriate resolution. There are two options to run all the checks that are needed to diagnose the issue. Use the option that you prefer.

### Option 1: Run a script

The *TeamsLaunchCheck.ps1* PowerShell script automates all the checks that you need to perform.  
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
        if(IsReparsePoint($temp.Value))
        {
            Write-Warning "$($temp.Name): $($temp.Value) is a reparse point"
        }
        else
        {
            Write-Host "$($temp.Name): $($temp.Value) is not a reparse point" -ForegroundColor Green
        }
    }
}

function ValidatePaths($list)
{
    Foreach ($path in $list)
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
echo "# Checking for reparse points in appdata"
foreach ($path in $list)
{
    $result = PathContainsReparsePoint $path $true
}
echo ""
echo "# Checking for unexpected files in appdata"
ValidatePaths($list)
echo ""
echo "# Checking if AllowAllTrustedApps is valid"
ValidateAppXPolicies

Pause

```

</details>

### Option 2: Perform the checks manually

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, [back up the registry](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) before you modify it. Then, you can restore the registry if a problem occurs.

1. Check whether the **Cookies** and **Cache** shell folders point to a location that is a reparse point.

   1. Run the following PowerShell commands:

      ```powershell
      (gp ([environment]::getfolderpath("Cookies"))).Attributes -match 'ReparsePoint'
      (gp ([environment]::getfolderpath("InternetCache"))).Attributes -match 'ReparsePoint'
      ```

   1. If both commands return **False**, go to step 2. Otherwise, open the Registry Editor and locate the following subkey:

      `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
   1. For the shell folder that's returned **True** in the PowerShell command, update the value of its associated registry entry to a location that isn't a reparse point. For example, you can set the value to the default path:

     | Registry entry | Value |
     | --- | --- |
     |Cookies|`%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies`|
     |Cache|`%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache`|
1. Check whether the values of the **TEMP** or **TMP** environment variables are set to a reparse point.

   1. Run the following PowerShell command:

      ```powershell
      gci env:* | ?{@("TEMP", "TMP").Contains($_.Name)} | %{$_.Value+" - "+((gp $_.Value).Attributes -match 'ReparsePoint')}
      ```

   1. If the command returns **False**, go to step 3. Otherwise, [set](/windows-server/administration/windows-commands/set_1) the value of the environment variables to a location that isn't a reparse point.
1. Check whether any of the following directories in the **AppData** folder are changed to function as reparse points:

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

   If any of the directories are reparse points, contact [Microsoft Support](https://support.microsoft.com/contactus).

   Also check for files with the same name as a required system folder in the **AppData** folder. For example, a file named *Libraries* in the path *%AppData%\Microsoft\Windows\Libraries*, has the same name as a directory with the same path. For each directory that's listed earlier in this step, run the following PowerShell command:

   ```powershell
   Test-Path -Path <directory name, such as $env:USERPROFILE\AppData\Local\Temp>  -PathType Leaf
   ```

   If the command returns **True**, remove the file and create a folder by using the same name with the complete path for the system folder.
1. Check the **AllowAllTrustedApps** policy setting.

   1. Open a Command Prompt window and run the `winver` command.
   1. Compare your Windows version and build number in the result to the following versions of Windows 10 and Windows 11:

      - Windows 10 version 21H2 OS build 19044.4046
      - Windows 10 version 22H2 OS build 19045.3636
      - Windows 11 version 21H2 OS build 22000.2777
      - Windows 11 version 22H2 OS build 22621.2506
      - Windows 11 version 23H2 OS build 22631.2428
   1. If your Windows version and build number are earlier than the ones in the list, open the Registry Editor and locate the **AllowAllTrustedApps** registry entry under one of the following subkeys:

      - `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock`
      - `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx`
   1. Check the value of **AllowAllTrustedApps**. If the value is **0**, the policy is disabled. Change it to **1** to enable the policy and then start new Teams again.

      **Note:** To start new Teams without enabling the **AllowAllTrustedApps** policy, you must run one of the versions of Windows listed in step 4b.
1. If the issue still persists, update to Windows 11 version 22H2 OS build 22621.2506 or later.
