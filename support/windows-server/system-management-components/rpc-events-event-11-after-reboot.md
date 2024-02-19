---
title: Microsoft-Windows-RPC-Events event 11 after reboot
description: Resolves the Microsoft-Windows-RPC-Events event 11 that occurs when you run the Server Manager Snap-in (servermanager.msc) for extended periods of time or start the Resource Host Monitor (rhs.exe) hosting FileServer Resource.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wmi, csstroubleshoot
---
# Microsoft-Windows-RPC-Events Event 11 after reboot

This article provides a solution to fix the Microsoft-Windows-RPC-Events event 11 that occurs when you run the Server Manager Snap-in (servermanager.msc) for extended periods of time or start the Resource Host Monitor (rhs.exe) hosting FileServer Resource.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974814

## Symptom

When you run the servermanager.msc for extended periods of time or start the rhs.exe hosting FileServer Resource, the following Application event log warning is written:

- For DHCP Servers, you may notice the following event description:

    > Log Name: Application  
    Source: Microsoft-Windows-RPC-Events  
    Event ID: 11  
    Task Category: None  
    Level: Warning  
    Keywords:  
    User: CONTOSO\Administrator  
    Computer: contoso.com  
    Description:  
    Possible Memory Leak. Application ("C:\WINDOWS\SYSTEM32\MMC.EXE" "C:\WINDOWS\SYSTEM32\SERVERMANAGER.MSC") (PID: 584) has passed a non-NULL pointer to RPC for an [out] parameter marked [allocate(all_nodes)]. [allocate(all_nodes)] parameters are always reallocated; if the original pointer contained the address of valid memory, that memory will be leaked. The call originated on the interface with UUID ({6bffd098-a112-3610-9833-46c3f874532d}), Method number (2). User Action: Contact your application vendor for an updated version of the application.

- For FileServer resource:

    > Description:  
    Possible Memory Leak. Application (C:\Windows\Cluster\rhs.exe -key SYSTEM\CurrentControlSet\Services\ClusSvc\Parameters\Rhs\\\<GUID> -parentPid \<ParentPid> -initEvent \<initEvent> -replyEndpoint \<replyEndpoint>) (PID: \\\<PID>) has passed a non-NULL pointer to RPC for an [out] parameter marked [allocate(all_nodes)]. [allocate(all_nodes)] parameters are always reallocated; if the original pointer contained the address of valid memory, that memory will be leaked. The call originated on the interface with UUID ({4B324FC8-1670-01D3-1278-5A47BF6EE188}), Method number \<Method number>). User Action: Contact your application vendor for an updated version of the application.

## Cause

This issue occurs during the portion of the UID calling an internal structure with a parameter not initialized as NULL. This causes a false positive detection for a memory leak.

## Resolution

There is no memory leak or functional impact to this specific condition. This warning can be ignored as long as the UUID is {6bffd098-a112-3610-9833-46c3f874532d} or {4B324FC8-1670-01D3-1278-5A47BF6EE188}, and memory is not leaking.

## More information

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
