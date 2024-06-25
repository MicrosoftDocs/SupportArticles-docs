---
title: Scripts to list all running WMI providers
description: Provides a script to list all running WMI providers.
ms.date: 06/24/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gbrag, v-lianna
ms.custom: sap:System Management Components\WMI management and troubleshooting, csstroubleshoot
---
# Scripts: List all running WMI providers

This article provides a script to list all running Windows Management Instrumentation (WMI) providers.

When a WMI query is executed, the results are returned by the code running as a "WMI provider." A WMI provider can be a DLL or an executable file that runs in a separate process, which might be a WMIPrvSE process or another process that is usually associated with a service.

We usually have several WMIPrvSE processes running at the same time, each with its own security settings and having one or more WMI provider DLLs loaded.

Providers running inside a WMIPrvSE process are called "coupled providers" because they run under the control of the WMI service. In other words, the WMI service decides when to load and unload those providers.

"Decoupled providers" are separate executable files that are registered with the WMI service.

You can know which provider is loaded in which process by running the following script.

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```PowerShell
Function ExecQuery {
  param(
    [string] $NameSpace,
    [string] $Query
  )
  if ($PSVersionTable.psversion.ToString() -ge "3.0") {
    $ret = Get-CimInstance -Namespace $NameSpace -Query $Query -ErrorAction Continue
  } else {
    $ret = Get-WmiObject -Namespace $NameSpace -Query $Query -ErrorAction Continue
  }
  return $ret
}

Function Get-ProcBitness {
  param ([int] $id)
  $proc = Get-Process -Id $id -ErrorAction SilentlyContinue
  if ($proc) {
    Return ("(" + $proc.StartInfo.EnvironmentVariables["PROCESSOR_ARCHITECTURE"] + ")")
  } else {
    Return "Unknown"
  }
}

$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
if (-not $myWindowsPrincipal.IsInRole($adminRole)) {
  Write-Output "This script needs to be run as Administrator"
  exit
}

New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR -ErrorAction SilentlyContinue | Out-Null
$prov = ExecQuery -NameSpace "root\cimv2" -Query "select HostProcessIdentifier, Provider, Namespace, User from MSFT_Providers"
if (!$prov) {
  Write-host "WMI is not functional"
  exit
}

Write-host "Coupled providers (WMIPrvSE.exe processes)"
Write-host ""

$totMem = 0

$proc = ExecQuery -NameSpace "root\cimv2" -Query "select ProcessId, HandleCount, ThreadCount, PrivatePageCount, CreationDate, KernelModeTime, UserModeTime from Win32_Process where name = 'wmiprvse.exe'"
foreach ($prv in $proc) {
  $provhost = $prov | Where-Object {$_.HostProcessIdentifier -eq $prv.ProcessId}
  if ($PSVersionTable.psversion.ToString() -ge "3.0") {
    $ut= New-TimeSpan -Start $prv.CreationDate
  } else {
    $ut= New-TimeSpan -Start $prv.ConvertToDateTime($prv.CreationDate)
  }
  
  $uptime = ($ut.Days.ToString() + "d " + $ut.Hours.ToString("00") + ":" + $ut.Minutes.ToString("00") + ":" + $ut.Seconds.ToString("00"))

  $ks = $prv.KernelModeTime / 10000000
  $kt = [timespan]::fromseconds($ks)
  $kh = $kt.Hours.ToString("00") + ":" + $kt.Minutes.ToString("00") + ":" + $kt.Seconds.ToString("00")

  $us = $prv.UserModeTime / 10000000
  $ut = [timespan]::fromseconds($us)
  $uh = $ut.Hours.ToString("00") + ":" + $ut.Minutes.ToString("00") + ":" + $ut.Seconds.ToString("00")
    
  Write-Host "PID"$prv.ProcessId "Handles:"$prv.HandleCount "Threads:"$prv.ThreadCount "Private KB:"($prv.PrivatePageCount/1kb) "KernelTime:"$kh "UserTime:"$uh "Uptime:"$uptime (Get-ProcBitness($prv.ProcessId))
  $totMem = $totMem + $prv.PrivatePageCount
  foreach ($provname in $provhost) {
    $provdet = ExecQuery -NameSpace $provname.Namespace -Query ("select * from __Win32Provider where Name = """ + $provname.Provider + """")
    $hm = $provdet.hostingmodel
    $clsid = $provdet.CLSID
    $dll = (get-itemproperty -ErrorAction SilentlyContinue -literalpath ("HKCR:\CLSID\" + $clsid + "\InprocServer32")).'(default)'
    $dll = $dll.Replace("""","")
    $file = Get-Item ($dll)
    $dtDLL = $file.CreationTime
    $verDLL = $file.VersionInfo.FileVersion

    Write-Host $provname.Namespace $provname.Provider $dll $hm $provname.user $dtDLL $verDLL
  }
  Write-Host
}
Write-Host "Total memory used by coupled providers:" ($totMem/1kb) "KB"
Write-Host

$hdr = $false
$list = Get-Process
foreach ($proc in $list) {
  $prov = Get-Process -id $proc.id -Module -ErrorAction SilentlyContinue | Where-Object {$_.ModuleName -eq "wmidcprv.dll"} 
  if (($prov | measure).count -gt 0) {
    if (-not $hdr) {
      Write-host "Decoupled providers"
      Write-host ""
      $hdr = $true
    }

    $prc = ExecQuery -Namespace "root\cimv2" -Query ("select ProcessId, CreationDate, HandleCount, ThreadCount, PrivatePageCount, ExecutablePath, KernelModeTime, UserModeTime from Win32_Process where ProcessId = " +  $proc.id)
    if ($PSVersionTable.psversion.ToString() -ge "3.0") {
      $ut= New-TimeSpan -Start $prc.CreationDate
    } else {
      $ut= New-TimeSpan -Start $prc.ConvertToDateTime($prc.CreationDate)
    }

    $uptime = ($ut.Days.ToString() + "d " + $ut.Hours.ToString("00") + ":" + $ut.Minutes.ToString("00") + ":" + $ut.Seconds.ToString("00"))

    $ks = $prc.KernelModeTime / 10000000
    $kt = [timespan]::fromseconds($ks)
    $kh = $kt.Hours.ToString("00") + ":" + $kt.Minutes.ToString("00") + ":" + $kt.Seconds.ToString("00")

    $us = $prc.UserModeTime / 10000000
    $ut = [timespan]::fromseconds($us)
    $uh = $ut.Hours.ToString("00") + ":" + $ut.Minutes.ToString("00") + ":" + $ut.Seconds.ToString("00")

    $svc = ExecQuery -Namespace "root\cimv2" -Query ("select Name from Win32_Service where ProcessId = " +  $prc.ProcessId)
    $svclist = ""
    if ($svc) {
      foreach ($item in $svc) {
        $svclist = $svclist + $item.name + " "
      }
      $svc = " Service: " + $svclist
    } else {
      $svc = ""
    }

    Write-Host ($prc.ExecutablePath + $svc)
    Write-Host "PID"$prc.ProcessId "Handles:"$prc.HandleCount "Threads:"$prc.ThreadCount "Private KB:"($prc.PrivatePageCount/1kb) "KernelTime:"$kh "UserTime:"$uh "Uptime:"$uptime (Get-ProcBitness($prv.ProcessId))

    $Keys = Get-ChildItem HKLM:\SOFTWARE\Microsoft\Wbem\Transports\Decoupled\Client
    $Items = $Keys | Foreach-Object {Get-ItemProperty $_.PsPath }
    ForEach ($key in $Items) {
      if ($key.ProcessIdentifier -eq $prc.ProcessId) {
        Write-Host ($key.Scope + " " + $key.Provider)
      }
    }
    Write-Host ""
  }
}
```

Here's a sample output:

```output
PS C:\tools> .\ListHosts.ps1
Coupled providers (WMIPrvSE.exe processes)

PID 8468 Handles: 670 Threads: 8 Private KB: 27016 KernelTime: 00:00:23 UserTime: 00:00:05 Uptime: 0d 00:56:07 (AMD64)
root\CIMV2 WmiPerfClass C:\Windows\System32\wbem\WmiPerfClass.dll LocalSystemHost  <DateTime> 10.0.22621.1 (WinBuild.160101.0800)
root\wmi WMIProv C:\WINDOWS\system32\wbem\wmiprov.dll LocalSystemHost NT AUTHORITY\SYSTEM <DateTime> 10.0.22621.3672 (WinBuild.160101.0800)

PID 8476 Handles: 426 Threads: 11 Private KB: 18884 KernelTime: 00:00:52 UserTime: 00:00:36 Uptime: 0d 00:56:07 (AMD64)
root\CIMV2 CIMWin32 C:\WINDOWS\system32\wbem\cimwin32.dll NetworkServiceHost  <DateTime> 10.0.22621.1 (WinBuild.160101.0800)
root\CIMV2 Win32_WIN32_TERMINALSERVICE_Prov C:\WINDOWS\system32\tscfgwmi.dll NetworkServiceHost  <DateTime> 10.0.22621.1 (WinBuild.160101.0800)

PID 13412 Handles: 199 Threads: 6 Private KB: 5008 KernelTime: 00:00:01 UserTime: 00:00:01 Uptime: 0d 00:55:54 (AMD64)
root\ccm\Policy\Machine PolicyAgentInstanceProvider C:\Windows\CCM\PolicyAgentProvider.dll LocalSystemHost:CCM  <DateTime> 5.00.9128.1007
root\ccm\Policy\S_1_12_1_3130925673_1190315153_575550367_292298971 PolicyAgentInstanceProvider C:\Windows\CCM\PolicyAgentProvider.dll LocalSystemHost:CCM  <DateTime> 5.00.9128.1007

PID 21652 Handles: 181 Threads: 8 Private KB: 3964 KernelTime: 00:00:00 UserTime: 00:00:00 Uptime: 0d 00:55:21 (AMD64)
root\ccm\Policy\Machine RegistryEventProvider C:\WINDOWS\system32\wbem\stdprov.dll LocalServiceHost:SMS  <DateTime> 10.0.22621.1 (WinBuild.160101.0800)

PID 23204 Handles: 354 Threads: 10 Private KB: 34552 KernelTime: 00:00:03 UserTime: 00:00:01 Uptime: 0d 00:55:11 (AMD64)root\ccm SensorWmiProvider C:\Windows\CCM\SensorWmiProvider.dll LocalSystemHost:CCMSensor  <DateTime> 5.00.9128.1007

PID 4832 Handles: 276 Threads: 7 Private KB: 4688 KernelTime: 00:00:00 UserTime: 00:00:00 Uptime: 0d 00:55:07 (AMD64)
root\ccm\ClientSDK CCMSDKProvider C:\Windows\CCM\ccmsdkprovider.dll LocalSystemHost:CCMSDK  <DateTime> 5.00.9128.1007

Total memory used by coupled providers: 94112 KB

Decoupled providers

C:\Windows\CCM\CcmExec.exe Service: CcmExec
PID 12856 Handles: 1591 Threads: 16 Private KB: 49764 KernelTime: 00:00:23 UserTime: 00:00:16 Uptime: 0d 00:55:55 (AMD64)
root\ccm\Events StatusAgentProvider

C:\Windows\System32\DriverStore\FileRepository\nvlt.inf_amd64_31d5e07e54090d6b\NVWMI\nvWmi64.exe
PID 11000 Handles: 216 Threads: 5 Private KB: 6516 KernelTime: 00:00:01 UserTime: 00:00:00 Uptime: 0d 00:56:07 (AMD64)
root\cimv2\NV NVIDIA|NVWMI|2.0
root\cimv2\NV\Events NVIDIA|NVWMI|EVENTS|2.0

C:\WINDOWS\system32\vmms.exe Service: vmms
PID 3932 Handles: 913 Threads: 16 Private KB: 27724 KernelTime: 00:00:08 UserTime: 00:00:06 Uptime: 0d 00:56:31 (AMD64)
root\virtualization\v2 VmmsWmiEventProvider
root\virtualization\v2 VmmsWmiInstanceAndMethodProvider
```
