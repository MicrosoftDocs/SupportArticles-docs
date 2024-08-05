---
title: Scripts to compile all registered MOF files
description: Provides a script to compile all registered Managed Object Format (MOF) files.
ms.date: 06/24/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gbrag, v-lianna
ms.custom: sap:System Management Components\WMI management and troubleshooting, csstroubleshoot
---
# Scripts: Compile all registered MOF files

This article provides a script to compile all registered Managed Object Format (MOF) files.

The Windows Management Instrumentation (WMI) repository, with the registration of classes and providers, is created by compiling several MOF files. 

Most MOF files are located in the *C:\\Windows\\System32\\wbem* folder, but many others might also be located in the folder of the application registering additional classes or providers.

The list of compiled MOFs is kept in the registry value `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Wbem\CIMOM\Autorecover MOFs`.

If WMI detects that the repository is corrupted and unusable, it will create a new empty repository and automatically compile all the MOFs listed in the registry value to restore all the expected objects.

If you encounter strange behavior that might be related to some classes or providers not being registered properly, you can recompile all the MOF files with the following script.
The script exports a copy of the registry value before starting the compilation and recording a log of all executed operations and their outcomes.

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```PowerShell
Function Write-Log {
  param( [string] $msg )
  $msg = (get-date).ToString("yyyyMMdd HH:mm:ss.fff") + " " + $msg
  Write-Host $msg
  $msg | Out-File -FilePath $outfile -Append
}

$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
if (-not $myWindowsPrincipal.IsInRole($adminRole)) {
  Write-Output "This script needs to be run as Administrator"
  exit
}

$Root = Split-Path (Get-Variable MyInvocation).Value.MyCommand.Path

$resName = "CompMOF-" + $env:computername +"-" + $(get-date -f yyyyMMdd_HHmmss)
$resDir = $Root + "\" + $resName
$outfile = $resDir + "\script-output.txt"
$errfile = $resDir + "\script-errors.txt"
$RdrOut =  " >>""" + $outfile + """"
$RdrErr =  " 2>>""" + $errfile + """"

New-Item -itemtype directory -path $resDir | Out-Null

New-PSDrive -PSProvider registry -Root HKEY_LOCAL_MACHINE -Name HKLM -ErrorAction SilentlyContinue | Out-Null
$mof = (get-itemproperty -ErrorAction SilentlyContinue -literalpath ("HKLM:\SOFTWARE\Microsoft\Wbem\CIMOM")).'Autorecover MOFs'

if ($mof.length -eq 0) {
  Write-Log ("The registry key ""HKLM:\SOFTWARE\Microsoft\Wbem\CIMOM\Autorecover MOFs"" is missing or empty")
  exit
}

$mof | Out-File ($resDir + "\Autorecover MOFs.txt")

foreach ($line in $mof) {
  if ($line.ToLower().contains("uninstall")) {
    Write-Log ("Skipping " + $line) 
  } else {
    $line = $line.Replace("%windir%", $env:windir) 
    $line = $line.Replace("%ProgramFiles%", $env:ProgramFiles) 
    if ($line -gt "") {
      if (Test-path $line) {
        Write-Log ("Compiling " + $line)
        $cmd = "mofcomp """ + $line + """"+ $RdrErr
        Write-Log $cmd
        Invoke-Expression ($cmd) | Out-File -FilePath $outfile -Append
      } else {
        Write-Log ("Missing file " + $line)
      }
    }
  }
}
```
