---
title: Can't install SharePoint portal in Service Manager
description: Fixes an issue in which you can't install the SharePoint portal in System Center 2012 Service Manager.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# An error occurred while executing a custom action when installing the SharePoint portal in Service Manager

This article helps you fix an issue in which you can't install the SharePoint portal in System Center 2012 Service Manager.

_Original product version:_ &nbsp; System Center 2012 Service Manager  
_Original KB number:_ &nbsp; 2834776

## Symptoms

You get the following error message when trying to install the SharePoint portal in System Center 2012 Service Manager:

> Configure portal SharePoint Web site  
> An error occurred while executing a custom action:_CreateSharePointWebSite  
> This upgrade attempt has failed before permanent modifications were made

## Cause

This can occur if the SQL Server database being used is the 32-bit edition. SharePoint 2010 Foundation server requires a 64-bit version of SQL Server.

## Resolution

To resolve this issue, use the 64-bit version of SQL Server.
