---
title: VSS writers report as failed on a virtual machine
description: Provides some information about VSS writers report as failed on a virtual machine
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, taylorb
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# VSS writers report as failed on a virtual machine

This article provides some information about VSS writers report as failed on a virtual machine.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2952783

## Symptoms

Consider the following scenario:
- You have a Windows Server 2012 R2 -based computer with the Hyper-V role.
- You run a Windows Server 2003-based or a Windows Server 2008-based virtual machine.
- You try to back up the virtual machine by using a backup application from the Hyper-V Host.  

In this scenario, the Volume Shadow Copy Service (VSS) writers on Windows Server 2003 or Windows Server 2008 report as failed. The output if you run the vssadmin list writers command is as follows:

vssadmin 1.1 - Volume Shadow Copy Service administrative command-line tool  
(C) Copyright 2001 Microsoft Corp.

>Writer name: 'System Writer'  
 Writer Id: {e8132975-6f93-4464-a53e-1050253ae220}  
 Writer Instance Id: {0df8b3f5-59ee-4185-983c-f35f16488e17}  
State: [9] Failed  
 Last error: No error  

>Writer name: 'COM+ REGDB Writer'  
 Writer Id: {542da469-d3e1-473c-9f4f-7847f01fc64f}  
 Writer Instance Id: {4a28f97d-5076-4171-b9ac-a0cabd925645}  
State: [9] Failed  
 Last error: No error  

>Writer name: 'MSDEWriter'  
 Writer Id: {f8544ac1-0611-4fa5-b04b-f7ee00b03277}  
 Writer Instance Id: {ecabb5e5-6526-42b4-b008-e74a7ce9edaa}  
 State: [1] Stable  
 Last error: No error  

>Writer name: 'Registry Writer'  
 Writer Id: {afbab4a2-367d-4d15-a586-71dbb18f8485}  
 Writer Instance Id: {5ee9aebb-1d30-474d-9562-927ba40e2e4e}  
State: [9] Failed  
 Last error: No error  

>Writer name: 'WMI Writer'  
 Writer Id: {a6ad56c2-b509-4e6c-bb19-49d8f43532f0}  
 Writer Instance Id: {0fe76f97-9185-4bb8-b9da-6ce35be4bc01}  
State: [9] Failed  
 Last error: No error  

>Writer name: 'Event Log Writer'  
 Writer Id: {eee8c692-67ed-4250-8d86-390603070d00}  
 Writer Instance Id: {8a2fd6b9-c349-4d3f-9bc2-046e053bee65}  
State: [9] Failed  
 Last error: No error  

>[!NOTE]  
>- The Hyper-V writer on the Window Server 2012 R2 host reports the backup as succeeding.
>- The VSS infrastructure uses the Microsoft Hyper-V VSS requestor to create a snapshot in the virtual machine.
>- The VSS infrastructure uses the Microsoft Hyper-V VSS writer to create a snapshot on the Hyper-V host.

## Cause

This behavior is expected. This behavior exists because of limitations in Windows Server 2003 and Windows Server 2008 that restrict the ability to expose a shadow disk to the operating system as required for the VSS autorecovery phase to finish.

Because of these limitations, the Hyper-V requester that is running on Windows Server 2003 or Windows Server 2008 stops the VSS backup process following the OnThaw phase in order to skip the autorecovery portion. This results in the guest writers reporting failure. Before aborting the backup process the virtual machine's state is preserved. This is then used to provide constant backup for the application.

## More information

The VSS writers on the Windows Server 2003 or Windows Server 2008 guest report as failed as long as the Hyper-V writer on the Windows Server 2012 R2 host reports that the backup was successful.

The following will be unaffected by this status: 
- Restore operations or later backup requests of the virtual machine though the Hyper-V writer on the host 
- Back up requests from the virtual machine that use other backup techniques such as a System State Backup together with Windows Backup
