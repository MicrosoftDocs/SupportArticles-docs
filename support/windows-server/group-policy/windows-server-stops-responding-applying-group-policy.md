---
title: Windows Server with Sysmon installed stops responding on startup when applying Group Policy 
description: Helps resolve an issue in which Windows Server that has Sysmon installed stops responding on startup when applying Group Policy. 
ms.date: 11/23/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, dennhu, teterenc, v-lianna
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot, ikb2lmc
ms.technology: windows-server-group-policy
---
# Windows Server stops responding on startup when applying Group Policy

This article helps resolve an issue in which Windows Server stops responding on startup when applying Group Policy if [System Monitor (Sysmon)](/sysinternals/downloads/sysmon) is installed.

Sysmon driver (*SysmonDrv.sys*) intercepts the transition from user mode to kernel and then sends work to its user mode process *Sysmon64.exe*. Most *Sysmon64.exe* threads are stuck waiting on a critical section. The critical section owner is waiting on a Local Security Authority Subsystem Service (LSASS) thread. However, the LSASS owner thread is trying to acquire a different critical section. Many other LSASS threads are blocked waiting on this critical section.

The critical section owning thread is blocked in SysmonDrv's kernel to the user mode communication to process *Sysmon64.exe*, which is observed to be stuck waiting on the LSASS thread. This results in a deadlock.

You can resolve this issue by upgrading [Sysmon](/sysinternals/downloads/sysmon) to the latest version, or work around this issue by disabling `FileBlockShredding`.

## Disable FileBlockShredding

To work around this issue, follow these steps:

1. Find the XML config file by running the following cmdlet:

    ```powershell
    PS C:\Sysmon> .\Sysmon64.exe -c
    
    Sysmon (internal) v15.00 - Monitors system events
    By Mark Russinovich and Thomas Garnier
    Copyright (C) 2014-2023 Microsoft Corporation
    Using libxml2. libxml2 is Copyright (C) 1998-2012 Daniel Veillard. All Rights Reserved.
    Sysinternals - www.sysinternals.com (http://www.sysinternals.com/)
    
    Current configuration:
    - Service name:                  Sysmon64
    - Driver name:                   SysmonDrv
    - Config file:                   .\file-delete.xml
    ```

2. Eliminate the following condition:

    ```xml
    <FileBlockShredding onmatch="...">
     ...
    </FileBlockShredding>
    ```
