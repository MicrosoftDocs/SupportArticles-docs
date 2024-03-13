---
title: Return Code 10 error when running Depreciation in Fixed Assets
description: When you run Depreciation in Fixed Assets in Microsoft Dynamics GP, you receive the Return Code 10 error. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Return Code 10" error when you run Depreciation in Fixed Assets

This article contains the information to resolve **Return Code 10** errors in Fixed Assets in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852559

## Cause

If the depreciation process was interrupted, a record may get locked in a table. So when you try to run depreciation again, this error message may happen due to the locked record. The steps below will help to clear the stuck record, but the user will have to investigate further why the depreciation process hung or was interrupted in the first place.

## Resolution

These steps require you to run update scripts through the Microsoft SQL Server query tool. We recommend that you create a backup of your data before you follow these steps.

1. Have all users exit Microsoft Dynamics GP.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    **Method 1: For SQL Server Desktop Engine**:

    If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2: For SQL Server 2000**:

    If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3: For SQL Server 2005**:

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    **Method 4: For SQL Server 2008**:

    If you are using SQL Server 2008, start SQL Management Studio. to do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

3. Run the following scripts against the company database when no users are in Microsoft Dynamics GP:

   ```sql
   DELETE DYNAMICS..SY00800
   DELETE DYNAMICS..SY00801
   DELETE DYNAMICS..ACTIVITY
   
   DELETE TEMPDB..DEX_LOCK
   DELETE TEMPDB..DEX_SESSION
   ```

   These tables should be empty when all users are logged off. The **delete** statement is just to make sure that there are no stuck records in these tables.

   Run the following against the company database when no users are in Microsoft Dynamics GP:

   ```sql
   Delete FAINDEX
   Delete FA40203
   Delete FA01500
   ```

   > [!NOTE]
   > The `FAINDEX` is re-created automatically when you use Fixed Assets.

4. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate**. Verify that you can run depreciation without receiving an error message.
