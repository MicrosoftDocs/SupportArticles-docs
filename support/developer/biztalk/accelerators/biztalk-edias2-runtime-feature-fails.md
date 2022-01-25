---
title: EDI/AS2 runtime configuration fails
description: This article describes what to do when the EDI/AS2 runtime configuration fails after you create a BizTalk Server group by using an existing SQL Server instance with unique database names.
ms.date: 03/18/2020
ms.custom: sap:Accelerators
ms.reviewer: EnriqueP
---
# BizTalk Server EDI/AS2 runtime configuration fails with the error: DTS package BAM_DM_InterchangeStatusActivity already exists

This article describes how the BizTalk Server EDI/AS2 runtime configuration can fail with the error "DTS package BAM_DM_InterchangeStatusActivity already exists."

_Original product version:_ &nbsp; BizTalk Server 2009, 2010, 2013, 2013 R2  
_Original KB number:_ &nbsp; 2269514

## Symptoms

Consider the following scenario:

You install and configure a BizTalk Server group. You install BizTalk Server on a second server. In the Configuration Wizard, you create a new BizTalk Server group by using the same SQL Server instance with unique database names. The EDI/AS2 runtime configuration fails, and you see any of the following messages:

> Failed to configure EDI/AS2 Status Reporting functionalities.  
> Failed to deploy BAM activity definitions. Please make sure that all BAM related Data Transformation Services (DTS) packages are removed along with the BAM databases.  
> Failed to execute process:drive :\Program Files (x86)\Microsoft BizTalk Server 2009\Tracking\bm.exe.  
> ERROR: The BAM deployment failed. DTS package BAM_DM_InterchangeStatusActivity already exists on server \<SQL Server Name>.

## Cause

The Business Activity Monitoring (BAM) and Data Transformation Services (DTS) package names in SQL Server Integration Services (SSIS) don't contain information specific to a BizTalk Server group. This creates a conflict when you're configuring more than one BizTalk Server group against the same SQL Server instance.

## Resolution

To resolve this problem, you can rename the existing packages that begin with `BAM_DM_` and then configure the EDI/AS2 runtime.

The SSIS package names for BAM in EDI/AS2 begin with `BAM_DM_`. You can manually rename these packages in SQL Server Integration Services. For example, you can rename the `BAM_DM_AS2InterchangeActivity` SSIS package to `BizTalkGroup_BAM_DM_AS2InterchangeActivity`. Then configure the EDI/AS2 runtime.

> [!NOTE]
> Renaming these `BAM_DM_` SSIS packages will not affect the EDI/AS2 runtime.
