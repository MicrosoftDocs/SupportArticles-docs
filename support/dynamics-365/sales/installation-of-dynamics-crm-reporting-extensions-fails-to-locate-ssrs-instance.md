---
title: Installing Reporting Extensions cannot locate SSRS instance
description: Installation of Microsoft Dynamics CRM Reporting Extensions fails to locate SSRS instance Name and the drop-down is blank. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-reports
---
# Installation of Microsoft Dynamics CRM Reporting Extensions fails to locate SSRS instance

This article provides a resolution to make sure you can successfully install the Microsoft Dynamics CRM Reporting Extensions on SQL Reporting Services Server.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2628017

## Symptoms

When installing the Microsoft Dynamics CRM Reporting Extensions on SQL Reporting Services Server, the installation wizard fails to locate the SSRS Instance Name and the drop-down is blank.

Reviewing the Reporting Extensions install log file, a warning is logged:

> Could not find a local RS instance corresponding to the reporting url `https:///reportserver` for organization \<orgname>

> [!NOTE]
> By default, the Reporting Extensions install log file can be found at `%appdata%\Microsoft\MSCRM\Logs\SrsDataConnectorSetup.log`.

## Cause

The reason this happens is because SSRS is not on a supported version of SQL for Microsoft Dynamics CRM.

## Resolution

Ensure the minimum version of SSRS is installed.

Microsoft Dynamics CRM 2011:

- Microsoft SQL Server 2008 x64 SP1
- Microsoft SQL Server 2008 R2
- Microsoft SQL Server 2012 x64

Microsoft Dynamics CRM 2013:

- Microsoft SQL Server 2008 x64 SP3
- Microsoft SQL Server 2008 x64 R2 SP2
- Microsoft SQL Server 2012 x64 SP1
