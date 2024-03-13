---
title: Must use SQL Server Management Studio error when connecting to store database server
description: Fixes a problem that occurs when you try to connect a store database server from a client that is running Microsoft Dynamics Retail Management System Store Operations Administrator.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "To connect to this server you must use SQL Server Management Studio..." error when connecting to a store database server

This article provides a resolution to solve the **To connect to this server you must use SQL Server Management Studio...** error that occurs when trying to connect a store database server from a client that is running Microsoft Dynamics Retail Management System Store Operations Administrator.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 971665

## Symptoms

When you try to connect to a store database server from a client that is running Microsoft Dynamics Retail Management System (RMS) Store Operations Administrator, you receive the following error message:

> To connect to this server you must use SQL Server Management Studio or SQL Server Management Objects (SMO).

## Cause

This problem occurs for one of the following reasons:

- The version of Microsoft SQL Server that is running on the client is earlier than version of Microsoft SQL Server on the server.
- Microsoft SQL Server is not installed on the client.
- Microsoft SQL Server 2005 Backward Compatibility is not installed on the client.

## Resolution

To resolve this problem, install the Microsoft SQL Server 2005 Backward Compatibility stand-alone package. To do this, follow these steps:

1. Download the Microsoft SQL Server Backward Compatibility stand-alone package.

2. Double-click the SQLServer2005_BC.msi file that you downloaded in step 1, and then follow the Microsoft SQL Server Backward Compatibility Installation Wizard to install Microsoft SQL Server Backward Compatibility.

3. Restart the client after you install Microsoft SQL Server Backward Compatibility.
