---
title: The specified database is not a valid VAMT database error message
description: Describes an issue in which you cannot create a database by using VAMT 3.0. Additionally, you receive an error message, and events are logged in the VAMT log. This issue occurs on a computer that is running Windows 8 or Windows Server 2012.
ms.date: 09/04/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca, luche
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# The specified database is not a valid VAMT database error message when you try to create a database by using VAMT 3.0 on a Windows 8 or Windows Server 2012-based computer

This article describes an issue in which you cannot create a database by using VAMT 3.0.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2755159

## Symptoms

When you try to create a database by using Volume Activation Management Tool (VAMT) 3.0 on a computer that is running Windows 8 or Windows Server 2012, you receive the following error message:
> The specified database is not a valid VAMT database.

## Cause

The issue occurs because the account that you use to log on to the computer does not have permissions to create the database.

## Resolution

To resolve the issue, log on to the computer as the local administrator, and then try to create the database. If the issue still occurs, install Microsoft SQL Server 2008 R2 Management Studio Express (SSMSE), and then grant yourself the relevant permissions.

For more information about downloading SSMS, see [Download SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms).

For more information about SQL Server permissions, see [Security and Protection (Database Engine)](/sql/relational-databases/security/security-center-for-sql-server-database-engine-and-azure-sql-database).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
