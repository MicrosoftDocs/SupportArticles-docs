---
title: Error 832 when installing DPM 2016 or later
description: Fixes an issue in which you receive error ID 832 when you try to install System Center 2016 Data Protection Manager. 
ms.date: 04/08/2024
ms.reviewer: Mjacquet, jarrettr, jarrettr, delhan
---
# Error ID 832 when you try to install System Center 2016 Data Protection Manager or later

This article helps you fix an issue in which you receive error ID 832 when you try to install System Center 2016 Data Protection Manager (DPM) or later.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager or later  
_Original KB number:_ &nbsp; 4020052

## Symptoms

When you try to install Microsoft System Center 2016 Data Protection Manager or later, Setup fails, and you receive the following error message:

> Error: Setup cannot grant the \<account name> account access to the DPM database.  
> Verify that SQL Server is properly installed and that it is running.  
> ID: 832

## Cause

This issue can occur if you use a fully qualified domain name (FQDN) as the name of the instance of Microsoft SQL Server. For example, the issue occurs if you enter *sqlservername.contoso.com\dpminstance* instead of *sqlservername\dpminstance*.

## Resolution

To fix this issue, uninstall and reinstall the DPM software. During the new installation, enter the `SqlServername` value by using the NETBIOS name instead of the *SqlServername.contoso.com* FQDN format.
