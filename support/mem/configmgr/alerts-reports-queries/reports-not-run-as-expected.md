---
title: Reports don't run as expected
description: Fixes a problem that blocks reports from running in System Center 2012 R2 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, brianhun, midi, jchornbe, delhan
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Reports and subscriptions
---
# Reports don't run in System Center 2012 R2 Configuration Manager

This article fixes a problem that blocks reports from running in System Center 2012 R2 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3060813

## Symptoms

Reports that are started from the Administrator Console in System Center 2012 R2 Configuration Manager or from the Reporting Services website may not run as expected. Additionally, you may receive error messages that resemble the following:

> The DefaultValue expression for the report parameter 'UserTokenSIDs' contains an error: The specified directory service attribute or value does not exist.Details:System.Web.Services.Protocols.SoapException: The DefaultValue expression for the report parameter 'UserTokenSIDs' contains an error: The specified directory service attribute or value does not exist.

## Cause

This problem may occur when the following conditions are true:

- You have Cumulative Update 4 or a later version for System Center 2012 R2 Configuration Manager installed.
- The Report Server Service Account doesn't have **Read** permissions to the OU in which the user running the report resides, or to Users or Computers container in Active Directory Domain Services (AD DS).

## Resolution

To resolve this problem, grant the Report Server Service Account **Read** permissions to the OU in which the user running the report resides, and to both the Users and Computers containers in AD DS.
