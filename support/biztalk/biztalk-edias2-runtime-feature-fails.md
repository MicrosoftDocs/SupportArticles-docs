---
title: EDI/AS2 Runtime configuration fails
description: When you install and configure a BizTalk Server group, and you install BizTalk on a second server. In the Configuration Wizard, you create a new BizTalk Server group using the same SQL Server with unique database names. The BizTalk EDI/AS2 Runtime configuration fails.
ms.date: 03/18/2020
ms.prod-support-area-path: 
ms.reviewer: EnriqueP
---
# BizTalk EDI/AS2 Runtime configuration fails with error: DTS package BAM_DM_InterchangeStatusActivity already exists

This article describes the BizTalk EDI/AS2 Runtime configuration may fail with the error: DTS package BAM_DM_InterchangeStatusActivity already exists.

_Original product version:_ &nbsp; BizTalk Server 2009, 2010, 2013, 2013 R2  
_Original KB number:_ &nbsp; 2269514

## Symptoms

Consider the following scenario:

You install and configure a BizTalk Server group. You install BizTalk on a second server. In the **Configuration Wizard**, you create a new BizTalk Server group using the same SQL Server with unique database names. The BizTalk EDI/AS2 Runtime configuration fails and you may see any one of the following error messages:

> Failed to configure EDI/AS2 Status Reporting functionalities.  
> Failed to deploy BAM activity definitions. Please make sure that all BAM related Data Transformation Services (DTS) packages are removed along with the BAM databases.  
> Failed to execute process:drive :\Program Files (x86)\Microsoft BizTalk Server 2009\Tracking\bm.exe.  
> ERROR: The BAM deployment failed. DTS package BAM_DM_InterchangeStatusActivity already exists on server \<SQL Server Name>.

## Cause

The Business Activity Monitoring (BAM) Data Transformation Services (DTS) package names in SQL Server Integration Services (SSIS) do not contain BizTalk group-specific information. As a result, this creates a conflict when configuring more than one BizTalk Server group against the same SQL Server.

## Resolution

To resolve this problem, you can rename the existing packages beginning with `BAM_DM_` and then configure the BizTalk EDI/AS2 Runtime feature.

The EDI/AS2 BAM SSIS package names begin with `BAM_DM_`. You can manually rename the `BAM_DM_` SSIS packages in SQL Server Integration Services. For example, you can rename the `BAM_DM_AS2InterchangeActivity` SSIS package to `BizTalkGroup_BAM_DM_AS2InterchangeActivity`. Then configure the BizTalk EDI/AS2 Runtime feature.

> [!NOTE]
> Renaming these `BAM_DM_` SSIS packages will not affect the EDI/AS2 runtime.
