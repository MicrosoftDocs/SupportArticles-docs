---
title: Selected database exists error when installing Web Services
description: The selected database exists error occurs when you install Web Services for Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "The selected database exists, but its owner is not a valid Windows user" error when installing Web Services

This article provides a resolution for the issue that you can't install Web Services for Microsoft Dynamics GP due to the **selected database exists** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2421630

## Symptoms

When you install Web Services for Microsoft Dynamics GP, the following error may appear:

> The selected database exists, but its owner is not a valid Windows user. Please provide a different database name.

## Cause

The database entered for the Database Name field in the SQL Server Connection Information window already exists and has a database owner configured to have a SQL logon. For example, the DYNAMICS system database and company databases for Microsoft Dynamics GP will have a dbo configured as `DYNSA`. Therefore, you cannot use the DYNAMICS system database and company databases to store the security for Web Services.

## Resolution

To resolve the issue, enter a database name which is not the DYNAMICS system database and company databases for Microsoft Dynamics GP. Best practice for installing Web Services that has the SQL Server database option to store security is to select a new unique database that uses a name which represents the purpose of the database, for example WSSecurityDB.
