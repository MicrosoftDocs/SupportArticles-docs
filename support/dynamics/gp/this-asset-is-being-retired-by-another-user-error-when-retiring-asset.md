---
title: This asset is being retired by another user error when retiring an asset
description: When you try to retire an asset in Microsoft Dynamics GP, you receive an error message that states this asset is being retired by another user. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Fixed Assets
---
# "This asset is being retired by another user" error when retiring an asset

This article provides a resolution for the issue that you receive **This asset is being retired by another user** error when trying to retire an asset in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860373

## Symptoms

When you try to retire an asset in Microsoft Dynamics GP, you receive the following error message:

> This asset is being retired by another user. Please try later.

## Cause

This problem may occur when a record is locked in the Activity table.

## Resolution

To resolve this problem, follow these steps:

1. Make a backup of the company database in case unwanted data loss occurs.

    > [!NOTE]
    > You have the option to restore your backup to a test company database so that you can perform these steps in the test environment. If you do this, users will not have to log off of Great Plains immediately. When users are logged off, you can then process these steps against your live company database.

    For more information about how to set up a test company that has a copy of live company data, see [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211).

2. Have all users log off of Microsoft Dynamics Great Plains.
3. Delete the locked records. To do this, follow these steps:

    1. Do one of the following things:

        - If you use Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
        - If you use Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
        - If you use SQL Server Desktop Engine (also known as MSDE 2000), start Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    2. Run the following statement against the DYNAMICS database:

       ```sql
       DELETE DYNAMICS..SY00800</br>DELETE DYNAMICS..SY00801</br>DELETE DYNAMICS..ACTIVITY
       ```

    3. Run the following statement against the TEMP database:

       ```sql
       DELETE TEMPDB..DEX_LOCK</br>DELETE TEMPDB..DEX_SESSION
       ```

    4. Run the following statement against the company database:

       ```sql
       DELETE FA01500</br>DELETE FAINDEX</br>DELETE FA00701
       ```

4. Retire the asset. To do this, point to **Fixed Assets** on the **Transactions** menu, and then select **Retirement**.
