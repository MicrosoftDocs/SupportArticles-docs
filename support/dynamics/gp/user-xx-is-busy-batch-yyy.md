---
title: User XX is busy with batch YYY
description: Provides a solution to an error that occurs when trying to delete a Cashbook Bank Management batch using Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "User XX is busy with batch YYY" Error message displays  when trying to delete a Cashbook Bank Management batch using Microsoft Dynamics GP

This article provides a solution to an error that occurs when trying to delete a Cashbook Bank Management batch using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2252006

## Symptoms

You receive the following error message when you try to delete a Cashbook Bank Management batch:

> User XX is busy with batch YYY

## Cause

The message can be caused by stuck records in the Cashbook Bank Management activity tables.

## Resolution

To clear the stuck records, follow the steps below:

> [!NOTE]
> Before using the steps below, make sure to have a current backup of the company database in case you would need to restore for any reason.

1. Clear the activity tables by using the Clear Activity routine.  To do it, point to **Tools** on the **Microsoft Dynamics GP menu**, point **Routines**, point **Financial**, point **Bank Management**, and then select **Clear Activity**.

2. Select the **Clear Activity** button.

3. Open SQL Server Management Studio using the appropriate method:

    - For **SQL Server 2008**  
        Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
    - For **SQL Server 2005**  
        Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
    - For **SQL Server 2000**  
        Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

4. When all users are signed out of the company database, verify that there are no records in the CE Activity (CBEU1020) table by executing the statement below against the company database:

    ```sql
    SELECT * FROM CBEU1020
    ```

5. If there are any stuck records in the CE Activity (CBEU1020) table, remove them by executing the statement below against the company database:

    ```sql
    DELETE CBEU1020
    ```
