---
title: Return Code 17 error when retiring an asset
description: When a user attempts to retire an asset they receive an error Return code 17 (Duplicate record) on script FA_Retire_Asset. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Return Code 17" error when trying to retire an asset in Microsoft Dynamics GP

This article provides a resolution for the **Return Code 17** error that may occur when you try to retire an asset in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2827044

## Symptoms

When a user attempts to retire an asset in Fixed Assets Management in Microsoft Dynamics GP, they receive the error below:

> Return Code 17 (Duplicate record) on script FA_Retire_Asset

## Cause

This error can be returned if the values in the FA00700 and FA41700 are out of sync. When an asset is retired, we take the next RETIREEVENT number from the FA41700 and insert this into the FA00700; if this value is already inserted this error is returned.

## Resolution

Follow these steps to resolve the issue:

> [!NOTE]
> Always make a current restorable backup before doing maintenance in SQL.

1. Open SQL Server Management Studio. To do this, select **Start**, select **All Programs**, select Microsoft SQL Server, and then select SQL Server Management Studio.

2. Select the New Query button to open a query window and select the Company database using the drop-down list.

3. Copy in the scripts below and execute to see the highest value in each table.

    ```sql
    Select MAX(RETIREEVENT) from FA00700
    Select MAX(RETIREEVENT) from FA41700
    ```

    Normally the values should be the same. If they are different, this would case the error.

4. Usually the FA41700 is lower, so the next steps will show you how to insert in a dummy row into this table to correct this problem. The insert statement would be similar to the statement below.

    1. Here is the syntax for the dummy row needed for the FA41700 table: (Do not run this exact script, as it will need to be modified first.)

        ```sql
        Insert FA41700 values (Retirement event number,'Description','NOTEINDX,'Date 00:00:00.000','1900-01-01 TIME,'USERID')
        ```

    2. Use the Insert statement above as a base and insert in dummy values to make a valid record. Here is an example of how it should look, but you can change any of the values per your preference. After modifying it, run this script against the company database.

        ```sql
        Insert FA41700 values (XXX,'RETIREMENT RECORD','0.00000','2013-01-01 00:00:00.000','1900-01-01 09:56:28.000','sa')
        ```

        First, insert in the MAX event number you need from the FA00700 for the *XXX* placeholder.

5. Run the scripts in step 3 above again to make sure the maximum event number is now the same between the tables.
6. Sign back in to Microsoft Dynamics GP and see if the error still occurs.

7. If the error still occurs, ensure all users are out of Microsoft Dynamics GP and run these scripts to delete the system temp files: (Make sure all users exit Microsoft Dynamics GP properly through the front-end, so you don't damage any work they may be in the middle of.)

    ```sql
    DELETE DYNAMICS..SY00800
    DELETE DYNAMICS..SY00801
    DELETE DYNAMICS..ACTIVITY 
    DELETE TEMPDB..DEX_LOCK
    DELETE TEMPDB..DEX_SESSION
    ```

8. It is also recommended to delete the contents of the two Fixed Asset temporary tables. Execute these scripts:

    ```sql
    DELETE FA01500
    DELETE FAINDEX
    ```

9. Sign back in to Microsoft Dynamics GP and see if you can retire without the error now.
