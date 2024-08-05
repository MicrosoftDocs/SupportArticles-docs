---
title: Integration performance decreases when you use a SQL source file after you upgrade to Integration Manager 8.0 or to Integration Manager 7.5
description: Describes a problem where integration performance decreases when you use an ODBC source that connects to a SQL table after you upgrade to Integration Manager 8.0 or to Integration Manager 7.5. You must obtain a service pack to resolve this problem.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Integration performance decreases when you use a SQL source file after you upgrade to Integration Manager 8.0 or to Integration Manager 7.5

This article describes a problem where integration performance decreases when you use an ODBC source that connects to a SQL table after you upgrade to Integration Manager 8.0 or to Integration Manager 7.5. You must obtain a service pack to resolve this problem.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 908694

## Symptoms

When you use a simple or an advanced ODBC source that connects to a SQL table, integration performance decreases after you upgrade to Microsoft Business Solutions - Great Plains Integration Manager 8.0 or to Integration Manager 7.5. For example, a payables transaction integration takes two hours to process on Integration Manager 7.0 or on an earlier version of Integration Manager. After you upgrade to Integration Manager 8.0 or to Integration Manager 7.5, the same integration takes five hours to process.

## Resolution

To resolve this problem, obtain the latest service pack for Integration Manager 8.0.

## Status

This problem was first corrected in Integration Manager 8.0 Service Pack 3.
