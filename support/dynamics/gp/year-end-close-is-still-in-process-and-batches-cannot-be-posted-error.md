---
title: Year End Close is still in process and batches cannot be posted error when posting a transaction after the year is closed
description: When you try to post a transaction in General Ledger in Microsoft Dynamics GP after the year is closed, you receive the error message that states Year End Close is still in process and batches cannot be posted. Provides a resolution.
ms.reviewer: theley, ryanklev
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Year End Close is still in process and batches cannot be posted" error when posting a transaction in General Ledger after the year is closed

This article provides a resolution for the issue that you can't post a transaction in General Ledger in Microsoft Dynamics GP after the year is closed.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856550

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you try to post a transaction in General Ledger in Microsoft Dynamics GP after the year is closed, you receive the following error message:

> Year End Close is still in process and batches cannot be posted.

## Cause

This problem occurs because of invalid records that exist in the SY00800 table.

## Resolution

To resolve this problem, delete the invalid records in the SY00800 table. To do this, follow these steps:

1. Have all users exit Microsoft Dynamics GP.

2. Open SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 20XX (XX=your version)**, and then select **SQL Server Management Studio**.

3. Run the following statement against the DYNAMICS database.

   ```sql
   DELETE SY00800
   ```
