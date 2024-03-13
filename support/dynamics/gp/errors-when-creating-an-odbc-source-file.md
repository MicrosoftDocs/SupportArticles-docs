---
title: Errors when creating an ODBC source file
description: Provides a solution to errors that occur when you create an Open Database Connectivity (ODBC) integration source file to connect to a SQL Server 2005 database in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error messages when you create an ODBC integration source file to connect to a SQL Server 2005 database in Microsoft Dynamics GP

This article provides a solution to errors that occur when you create an Open Database Connectivity (ODBC) integration source file to connect to a SQL Server 2005 database in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918079

## Symptoms

You receive the following Integration Manager error messages when you try to connect to a Microsoft SQL Server 2005 database in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0:

> This key is already associated with an element of this collection.

> User **XX** is not valid.

> [!NOTE]
> **XX** is a User ID.

This behavior occurs when you set up a simple or an advanced Open Database Connectivity (ODBC) integration source file.

## Resolution

- Microsoft Dynamics GP 9.0

    To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Dynamics GP 9.0.

- Microsoft Business Solutions - Great Plains 8.0

    To resolve this problem, obtain Service Pack 5 for Integration Manager.

## Status

- Integration manager for Microsoft Dynamics GP 9.0

    Microsoft has confirmed that it's a bug in the Microsoft products that are listed in the Applies to section. This bug was corrected in Service Pack 1 for Integration Manager for Microsoft Dynamics GP 9.0.  

- Integration manager for Microsoft Business Solutions - Great Plains 8.0

    Microsoft has confirmed that it's a bug in the Microsoft products that are listed in the Applies to section. This problem was first corrected in Integration Manager for Microsoft Business Solutions - Great Plains 8.0 Service Pack 5.

    The issue that is described in the [Symptoms](#symptoms) section doesn't apply to Dynamics GP 10.0.
