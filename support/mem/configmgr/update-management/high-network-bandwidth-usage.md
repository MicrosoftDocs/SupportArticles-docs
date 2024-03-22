---
title: High network bandwidth usage
description: Unexpectedly high network bandwidth consumption occurs when clients scan for updates from the local Windows Server Update Services server.
ms.date: 12/05/2023
ms.reviewer: kaushika, rshastri, wesk, lamosley, v-jeffbo, jarrettr, yvetteo, brianhun
ms.custom: sap:Software Update Management (SUM)\Software Update Scanning
---
# Unexpected high network bandwidth consumption when clients scan for updates from local WSUS server

This article helps you fix an issue in which unexpectedly high network bandwidth consumption occurs when clients scan for updates from the local Windows Server Update Services (WSUS) server.

_Original product version:_ &nbsp; Windows 8.1, Windows 10  
_Original KB number:_ &nbsp; 4163525

## Symptoms

Microsoft System Center Configuration Manager customers report high network bandwidth usage for environments that employ WSUS. Some instances of the behavior started on February 13, 2018, and some started on March 13, 2018.

Affected operating systems are Windows 10 (all builds), and Windows 8.1. Customers report remarkably high-bandwidth usage on the WSUS TCP port.

## Cause

The Microsoft Compatibility Appraiser, which is used for Windows Analytics, is querying Windows Update agent in such a way that the Appraiser causes the Update Agent to discard part of its cache of update metadata. When a scan is next run for updates by Configuration Manager or Automatic Updates, or when the user selects **Check for Updates**, the metadata for these updates is downloaded from WSUS again.

## Resolution

To fix the issue, install the following updates, as applicable.

|Windows version| Windows update |
|---|---|
|Windows 10, version 1803| [September 20, 2018-KB4458469 (OS Build 17134.319)](https://support.microsoft.com/help/4458469) |
|Windows 10, version 1709| [September 20, 2018-KB4457136 (OS Build 16299.697)](https://support.microsoft.com/help/4457136) |
|Windows 10, version 1703| [October 18, 2018-KB4462939 (OS Build 15063.1418)](https://support.microsoft.com/help/4462939) |
|Windows 10, version 1607| [September 20, 2018-KB4457127 (OS Build 14393.2517)](https://support.microsoft.com/help/4457127) |
|Windows 8.1| [October 18, 2018-KB4462921 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4462921) |
  
## Mitigation

Determine whether clients are using an affected version of the Microsoft Compatibility Appraiser. Check the modified date for the following binaries that are located in `C:\Windows\System32`, and verify that they are from February 2018 or a later date:

- CompatTelRunner.exe
- Appraiser.dll

The Windows Appraiser is run through the scheduled task in **Task Schedulers** > **Task Scheduler Library** > **Microsoft** > **Windows** > **Application Experience** > **Microsoft Compatibility Appraiser**.

We have issued an update that limits how often the Appraiser runs the Windows Update query that causes this problem. This should help reduce bandwidth usage, although it may not fully eliminate higher-than-normal usage.

To receive the change, your clients must be able to access both of the following addresses:

- settings-win.data.microsoft.com
- adl.windows.com

You can determine whether clients received this update by checking the value for the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser: LastAttemptedRunDataVersion`

The following values indicate that the client has received the update.

|Operating system version|Client update value|
|---|---|
|Windows 10, version 1709|1704 or 1752|
|Windows 10, version 1703|1799|
|Windows 10, version 1607|1799|
|Windows 10, version 1511|1799|
|Windows 10, version 1507|1799|
|Windows 8.1|1799|
  
`LastAttemptedRunDataVersion` is updated when CompatTelRunner.exe is executed. This generally runs daily as part of the Microsoft Compatibility Appraiser scheduled task. However, it can be run manually without arguments:

```console
C:\Windows\System32>CompatTelRunner.exe
```

> [!NOTE]
> This value varies between operating systems.

If clients are blocked from reaching these addresses, you have to unblock them.

## Newer versions of CompatTelRunner.exe and Appraiser.dll

The following Windows updates use newer versions of CompatTelRunner.exe and Appraiser.dll that implement less frequent scanning. This avoids the need to unblock the URLs to obtain this update.

**July 11, 2018**

| Windows version| Windows update |
|---|---|
|Windows 10, version 1709| [June 21, 2018-KB4284822 (OS Build 16299.522)](https://support.microsoft.com/help/4284822) |
|Windows 10, version 1703| [June 21, 2018-KB4284830 (OS Build 15063.1182)](https://support.microsoft.com/help/4284830) |
|Windows 10, version 1607| [June 21, 2018-KB4284833 (OS Build 14393.2339)](https://support.microsoft.com/help/4284833) |
|Windows 8.1| [Compatibility update for keeping Windows up-to-date in Windows 8.1](https://support.microsoft.com/help/2976978) |
  
