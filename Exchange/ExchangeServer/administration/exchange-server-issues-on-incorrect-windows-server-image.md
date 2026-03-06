---
title: Resolve issues in Exchange Server installed on a nongeneralized Windows Server 2025 image
description: Describes an issue that impacts the Exchange Server installation in a Windows Server environment that didn't follow the recommended deployment procedure.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrative Tasks\DAG Communication Issues
  - Exchange Server
  - CI 10047
  - CSSTroubleshoot
ms.reviewer: batre, svajda, nasira
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019 
  - Exchange Server 2016 
ms.date: 03/05/2026
---
# Resolve issues in Exchange Server installed on a nongeneralized Windows Server 2025 image

## Summary

This article discusses an issue that affects Microsoft Exchange Server functionality if the program is used on a computer on which Windows Server 2025 was installed from an image that wasn’t prepared by using SysPrep. The article explains the cause of the issue and provides steps to resolve it.

## Symptoms

A Windows Server 2025 image is deployed to a computer on which you install and run Exchange Server. After you install Windows update [KB5065426](https://support.microsoft.com/topic/september-9-2025-kb5065426-os-build-26100-6584-77a41d9b-1b7c-4198-b9a5-3c4b6706dea9), you might experience the following issues in Exchange Server:

- Mail flow failures such as messages stuck in a queue.
- Database replication errors in a Database Availability Group (DAG).
- Databases that can’t mount.

Also, the system logs of the affected Windows Server computer list multiple entries for Event ID 6167 that are similar to the following example:  
  
`Log Name: System`  
`Source: LsaSrv`  
`Event ID: 6167`  
`Level: Error`  
`Description: There is a partial mismatch in the machine ID. This indicates that the ticket has either been manipulated or it belongs to a different boot session. Failing authentication.`

## Cause

These issues occur if the security identifier (SID) of the affected computer is the same as the SID of another computer in the organization. Duplicate computer SIDs can occur if you:

- Install Windows Server from an image that was created without running Sysprep.
- Clone an existing instance of Windows Server.
- Incorrectly reuse a virtual machine (VM) snapshot or image.

The duplicate SIDs might be unnoticed for a time. However, update KB5065426 introduces strict checks for duplicate SIDs. Therefore, you unexpectedly encounter issues that affect Exchange Server functionality after you install the update.

To verify whether the cause of the issue is the presence of duplicate computer SIDs, use the [PsGetSid](/sysinternals/downloads/psgetsid) command to get the SID for each Windows Server instance in your organization.  
  
- To check the SID for the local computer, run the `psgetsid` command without parameters.  
- To query the SID of a remote computer, run the `psgetsid \\<computer_name\>` command.

If the SIDs of two or more computers match, then the issue is caused by a duplicate SID.

## Resolution

To resolve the issues, follow these steps:

1. Rebuild the operating system (OS). If you deploy the OS from an image, make sure that the image was correctly generalized by using [SysPrep](/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation?view=windows-11&preserve-view=true).

2. Restore the Exchange Server instance by using the [/Mode:RecoverServer](/exchange/high-availability/disaster-recovery/recover-exchange-servers) method.
