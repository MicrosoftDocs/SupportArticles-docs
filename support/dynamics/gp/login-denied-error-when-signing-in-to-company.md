---
title: Login denied error when signing in to a company
description: Describes a problem that occurs when you try to sign in to a company in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, ryanklev
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Login denied. An installation task of Analytical Accounting is running" error when signing to a company

This article provides a resolution for the **Login denied** error that occurs when you try to sign in to a company in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912965

## Symptoms

When you try to sign in to a company in Microsoft Dynamics GP, you receive the following error message:

> Login denied. An installation task of Analytical Accounting is running. Please try again later.

## Cause

This problem occurs because a record is locked in the Batch Activity (SY00800) table. The record is locked if an installation or an upgrade of Analytical Accounting for Microsoft Dynamics GP fails.

## Resolution

To resolve this problem, follow these steps:

1. Start the Support Administrator Console, SQL Query Analyzer, or SQL Server Management Studio. To do this, use the appropriate method:

   - If you use SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.
   - If you use Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you use Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

2. Run the following script against the Dynamics database to remove the locked record.

    ```sql
    delete SY00800 where BCHSOURC = 'aaWizardInstall'
    ```
