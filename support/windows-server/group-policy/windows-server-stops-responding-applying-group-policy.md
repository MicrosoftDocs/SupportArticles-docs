---
title: Windows Server with Sysmon installed stops responding on startup when applying Group Policy 
description: Helps resolve the issue in which Windows Server that has Sysmon installed stops responding on startup when applying Group Policy. 
ms.date: 11/02/2023
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

This article helps resolve the issue in which Windows Server stops responding on startup when applying Group Policy if System Monitor (Sysmon) is installed.

Sysmon driver (SysmonDrv.sys) intercepts the transition from user mode to kernel mode and then to its user mode process *Sysmon64.exe*. Most *Sysmon64.exe* threads are stuck waiting for a critical section. The critical section owner is called LsaLookuprOpenPolicy2 and is waiting on the Local Security Authority Subsystem Service (LSASS) thread. However, the LSASS thread tries to acquire a critical section (LsapDbLock). And many other LSASS threads are blocked waiting on the same critical section. The thread owned by the critical section is blocked in SysmonDrv's communication from kernel mode to user mode process *Sysmon64.exe*, which is observed to be stuck waiting on the LSASS thread. This result in a deadlock.

## Disable FileBlockShredding

To work around this issue, follow these steps:

1. Find the config xml file by running the following cmdlet:

    ```powershell
    PS C:\remote\Sysmon> .\Sysmon64.exe -c
    
    Sysmon (internal) v15.01 - Monitors system events
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
