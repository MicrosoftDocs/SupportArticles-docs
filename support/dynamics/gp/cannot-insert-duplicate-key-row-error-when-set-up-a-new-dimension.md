---
title: Cannot insert duplicate key row in object dbo AAG00600 error when setting up new dimension
description: Describes a problem where you receive the following error message when you set up a new dimension in Analytical Accounting in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Analytical Accounting
---
# "Cannot insert duplicate key row in object 'dbo.AAG00600'" error when setting up a new dimension in Analytical Accounting

This article provides a resolution to solve the Cannot insert duplicate key row in object 'dbo.AAG00600' error that occurs when you try to set up a new dimension in Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2687215

## Symptoms

When you set up a new dimension in Analytical Accounting (AA) in Microsoft Dynamics GP, you receive the following error message when you select **Save** in the **Transaction Dimension Maintenance** window:

> Cannot insert duplicate key row in object 'dbo.AAG00600' with unique index 'AK2AAG00600'.
>
> The stored procedure aagCreateTree returned the following results: DBMS: 2601, Microsoft Dynamics GP: 0.

## Cause

By default, there are six main trees that are already established in AA. Additionally, a main tree for any new Dimension will also be created. Therefore, you are not allowed to name any new Dimension to be the same name as one of the existing default main trees.

## Resolution

You will not be able to enter a Transaction Dimension name to be the same name as one of the main default trees:

- Account
- Customer
- Employee
- Item
- Site
- Vendor

> [!NOTE]
> For example, you could use a variation of the above name to make it unique such as Acct or Account1 instead of using Account.
