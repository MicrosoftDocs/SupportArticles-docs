---
title: This record has been created since your attempt to create it error
description: You may receive an error message that states the record has been created since your attempt to create it when adding an Account Group ID in Fixed Assets. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Fixed Assets
---
# "This record has been created since your attempt to create it" error when adding an Account Group ID in Fixed Assets

This article provides a resolution for the issue that you can't add an Account Group ID in Fixed Assets in Microsoft Dynamics GP due to the error **This record has been created since your attempt to create it**.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2581263

## Symptoms

You receive the following error message when you add an Account Group ID in Fixed Assets in Microsoft Dynamics GP:

> This record has been created since your attempt to create it. Changes won't be saved.

## Cause

The next available value in the FAINDEX table is not correct.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Open SQL Server Management Studio using the appropriate method below:

    - If you are using Microsoft SQL Server 2005, select **Start**, point to **All Programs**, point to**Microsoft SQL Server 2005** and then select **SQL Server Management Studio**. To open a query window, select the **New Query** button at the top.
    - If you are using Microsoft SQL Server 2008 or Microsoft SQL Server 2008 R2, select Start, point to **All Programs**, point to **Microsoft SQL Server 2008** or **Microsoft SQL Server 2008 R2** and then select **SQL Server Management Studio**. To open a query window, select the **New Query** button at the top.

2. Select the company database using the drop-down list.

3. Run the following script to delete the FAINDEX table. (This table will automatically rebuild itself.)

    ```console
    DELETE FAINDEX
    ```

4. Test again.
5. If this does not resolve the problem, then have all users exit Microsoft Dynamics GP. Make a current backup, and then run these scripts against the company database:

    ```console
    Delete Dynamics..ACTIVITY --all users should be out of GP before running 
    Delete Dynamics..SY00800
    Delete Dynamics..SY00801
    Delete TEMPDB..Dex_Session
    Delete TEMPDB..Dex_Lock
    Delete FAINDEX
    Delete FA01500
    ```
