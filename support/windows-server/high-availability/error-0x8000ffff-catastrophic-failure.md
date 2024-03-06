---
title: Fail to change drive's Shadow Copy settings
description: Describes a catastrophic failure error that occurs in Windows Server 2008 when you try to change a drive's Shadow Copy settings. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# "Error 0x8000ffff: Catastrophic failure" when you try to change Shadow Copy settings for a drive in Windows Server 2008

This article provides a solution to an error (Error 0x8000ffff: Catastrophic failure) that occurs when you change Shadow Copy settings for a drive.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2973100

## Symptoms

Consider the following scenario:

- In Windows Server 2008, you open Windows Explorer, you right-click a drive, and then you click **Properties**.
- On the **Shadow Copies** tab, you select a drive letter and then click the **Settings** button.

In this scenario, you receive the following error message:

Failed to initialize the Settings dialog for volume O:\

Error 0x8000ffff: Catastrophic failure

Additionally, the following event is logged in the Application log:

Log Name: Application
Source: VSS
Event ID: 12311
Task Category: None
Level: Error
Description:
Volume Shadow Copy Service error: Unexpected error pResource->get_Disk(&pDisk): hr = 0x80070490.

## Cause

This problem occurs if there are disk resources in the failover cluster that don't have a physical disk resource associated with them. This behavior may occur if you take a disk resource offline and remove the associated disk from the server, but you don't delete the disk resource in the failover cluster.

## Resolution

In the failover cluster, delete the disk resource that no longer has a physical disk associated with it.
