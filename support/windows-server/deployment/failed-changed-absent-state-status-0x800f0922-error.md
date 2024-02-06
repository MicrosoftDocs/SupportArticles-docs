---
title: Failed to be changed to the Absent state with status 0x800f0922
description: Helps fix the Failed to be changed to the Absent state error with status 0x800f0922 when installing updates in Windows Server 2019.
author: Deland-Han
ms.author: delhan
ms.date: 11/23/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, luioan, v-lianna
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot, ikb2lmc
---
# "Failed to be changed to the Absent state. Status: 0x800f0922" when installing updates in Windows Server 2019 

This article helps fix the "Failed to be changed to the Absent state. Status: 0x800f0922" error when installing updates in Windows Server 2019.

You receive the error code 0x800f0922 when you try to install an update in Windows Server 2019. For example:

> Package KB5027222 failed to be changed to the Absent state. Status: 0x800f0922

In the *CBS.log* file, you see the following entries with a failed status by searching `completion status`, and the package fails to be changed to the **Absent** state:

```output
<DateTime>, Info                  CSI    00000e61 Begin executing advanced installer phase 38 index 825 (sequence 864)
    Old component: [l:157 ml:158]'Microsoft-Windows-DLNA-MDEServer, Culture=neutral, Version=10.0.17763.1697, PublicKeyToken=<PublicKeyToken> , ProcessorArchitecture=amd64, versionScope=NonSxS'
    New component: [l:154 ml:155]'Microsoft-Windows-DLNA-MDEServer, Culture=neutral, Version=10.0.17763.1, PublicKeyToken=<PublicKeyToken>, ProcessorArchitecture=amd64, versionScope=NonSxS'
    Install mode: install
    Smart installer: false
    Installer ID: {<Installer ID>}
    Installer name: 'HTTP Installer'
 <DateTime>, Error      [0x01803e] CSI    00000e64 (F) Failed execution of queue item Installer: HTTP Installer ({<Installer ID>}) with HRESULT HRESULT_FROM_WIN32(1058).  Failure will not be ignored: A rollback will be initiated after all the operations in the installer queue are completed; installer is reliable[gle=0x80004005]
...........
CSIPERF:AIDONE;{<Installer ID>};Microsoft-Windows-DLNA-MDEServer, version 10.0.17763.1, arch amd64, nonSxS, pkt {l:8 b:<PublicKeyToken>};8529us
 <DateTime>, Info                  CSI    00000e6e End executing advanced installer (sequence 864)
    Completion status: HRESULT_FROM_WIN32(ERROR_ADVANCED_INSTALLER_FAILED)
…
<DateTime>, Info                  CBS    WER: Generating failure report for package: Package_for_RollupFix~<PublicKeyToken>~amd64~~17763.4499.1.5, status: 0x80070422, failure source: CSI Other, start state: Installed, target state: Absent, client id: Software Explorer
```

In the log file, the error code 1058 indicates that the HTTP service can't be started because it's disabled or there's no enabled device associated with it.

## Enable the HTTP service

To fix this issue, follow these steps:

1. In Registry Editor, go to the following registry key:
	`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HTTP`
2. Change the **Start** registry value to **3**.
3. Close Registry Editor and install the update again.
