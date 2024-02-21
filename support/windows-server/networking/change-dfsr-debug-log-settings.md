---
title: How to configure DFSR logging
description: Describes the way to change these DFSR debug log settings via the WMI Command-line interface WMIC.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# How to configure DFSR logging

This article describes the way to change these DFSR debug log settings is via the WMI Command-line interface WMIC.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 958893

## Symptoms

By default DFSR debug logging is already turned on in a quite verbose setting to log up to 100 files with 200000 lines in the %windir%\debug folder, as a compressed Winzip compatible file: DFSRxxxxx.log.gz and DFSRxxxxx.log (currently used). This will consume about 75-100 MB disk space and represents a kind of history of DFSR activity. In certain troubleshooting conditions, it may be necessary to extend this history, since older information will be overwritten.

The recommended way to change these debug log settings is via the WMI Command-line interface WMIC.

The changes will be immediately realized by the DFSR service without the need to restart DFSR.

SETTING: Debug Log Severity

Default: 4

Range: 1-5

WMIC syntax: wmic /namespace:\\\root\microsoftdfs path dfsrmachineconfig set debuglogseverity=5

NOTE: For the most issues, the default severity 4 is sufficient.

SETTING: Debug Log Messages

Default: 200000

Range: 1000 to 4294967295 (FFFFFFFF)

WMIC syntax: wmic /namespace:\\\root\microsoftdfs path dfsrmachineconfig set maxdebuglogmessages=400000

SETTING: Debug Log Files

Default: 1000

Range: 1 to 100000

WMIC syntax: wmic /namespace:\\\root\microsoftdfs path dfsrmachineconfig set maxdebuglogfiles=200

SETTING: Debug Log File Path

Default: %windir%\debug

WMIC syntax: wmic /namespace:\\\root\microsoftdfs path dfsrmachineconfig set debuglogfilepath="d:\dfsrlogs"

> [!NOTE]
> The path must be created manually before, if not available the default value %windir%\debug will be used.

SETTING: Enable Debug Logging

Default: TRUE

Range: TRUE or FALSE

WMIC syntax: wmic /namespace:\\\root\microsoftdfs path dfsrmachineconfig set enabledebuglog=true

NOTE:  Debug logging is enabled by default

You can check your configuration with the tool DFSRDIAG:

dfsrdiag DumpMachineCfg /Mem: DFSRMember1

Machine Configuration Parameters:

ConflictHighWatermarkPercent: 90

ConflictLowWatermarkPercent: 60

DebugLogFilePath: C:\WINDOWS\debug

DebugLogSeverity: 4

Description:

DsPollingIntervalInMin: 60

EnableDebugLog: TRUE

EnableLightDsPolling: TRUE

LastChangeNumber: 1

LastChangeSource:

LastChangeTime: 20050830140044.000000-000

MaxDebugLogFiles: 200

MaxDebugLogMessages: 400000

RpcPortAssignment: 0

StagingHighWatermarkPercent: 90

StagingLowWatermarkPercent: 60

You can also realize the debug log settings in the header of every log file:

- FRS Log Sequence: 3 Index: 6 Computer:DFSRMember1 TimeZone:W. Europe Daylight Time (GMT+-2:00) Build:[Nov 23 2005 00:36:45 built by: dnsrv_r2] Enterprise=1
- Configuration logLevel: 4 maxEntryCount: 400000 maxFileCount:200 LogPath:\\\\.\C: \WINDOWS\debug\

## More information

DFSR Registry setting for more verbose event logging

SETTING: Event Log Verbosity

Output: DFS Replication event log

Value Path: HKLM\SYSTEM\CurrentControlSet\Services\Dfsr\Parameters

Value Name: Enable Verbose Event Logging

Value Type: REG_DWORD

Value Data: 1

> [!NOTE]
> Although the registry value doesn't exist by default, the following events are suppressed by default unless verbose event logging is enabled:

2002 EVENT_DFSR_VOLUME_INITIALIZED

3002 EVENT_DFSR_RG_INITIALIZED

3004 EVENT_DFSR_RG_STOPPED

4002 EVENT_DFSR_CS_INITIALIZED

5006 EVENT_DFSR_CONNECTION_OUTCONNECTION_ESTABLISHED

5004 EVENT_DFSR_CONNECTION_INCONNECTION_ESTABLISHED

MaxDebugLogFiles Note

The maximum is 10,000 on Windows Server 2003 R2 and 100,000 on all later operating systems. The default is 100 logs in Windows Server 2003 R2 and Windows Server 2008, and 1000 logs in Windows Server 2008 R2 and later operating systems.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
