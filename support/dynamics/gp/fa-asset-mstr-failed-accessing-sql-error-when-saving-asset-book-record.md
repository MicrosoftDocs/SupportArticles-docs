---
title: A save operation on table FA_ASSET_MSTR failed error when saving Asset Book record
description: When you save an Asset Book record, an error that states save operation on table FA_ASSET_MSTR failed accessing SQL occurs. Provides a resolution.
ms.reviewer: theley, lmuelle, dbader
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# "A save operation on table 'FA_ASSET_MSTR' failed accessing SQL" error when you save an Asset Book record

This article provides a resolution for the issue that you can't save an Asset Book record due to the **FA_ASSET_MSTR failed accessing SQL data** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 928533

## Symptoms

When you save an Asset Book record in Microsoft Dynamics GP, you receive the following error message:

> A save operation on table 'FA_ASSET_MSTR' failed accessing SQL data

## Cause

This problem occurs because data in the following tables are corrupted:

- Fixed Asset Index
- Fixed Asset Activity
- Dex_lock
- Dex_session
- Activity

## Resolution

To resolve this problem, clear the tables that are listed in the Cause section. To do this, follow these steps:

1. Have all users exit Microsoft Dynamics GP.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using:

    - If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.
    - If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
    - If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

3. Run the following script against the DYNAMICS database.

    `Delete ACTIVITY`
4. Run the following scripts against the TEMPDB database.

   `Delete DEX_LOCK Delete DEX_SESSION`
5. Run the following scripts against the company database.

   `Delete FAINDEX Delete FA01500`

6. Sign in to Microsoft Dynamics GP as the sa user, and then access Fixed Assets. To do this, point to **Fixed Assets** on the **Cards** menu, and then select **General**.

   > [!NOTE]
   > When you access Fixed Assets as the sa user, the FAINDEX table will be reinitialized.

7. Verify that you do not receive the error message that is mentioned in the Symptoms section. To do this, follow these steps:

    1. On the **Cards** menu, point to **Fixed Assets**, and then select **Book**.
    2. Display an Asset Book record, and then select **Save**.
