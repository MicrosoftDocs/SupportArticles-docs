---
title: Asset Record Changed by Another User error when saving Asset Book record in Fixed Assets
description: You cannot save an Asset Book record in the Fixed Assets module of Microsoft Dynamics GP due to the Asset Record Changed by Another User error.
ms.reviewer: theley, Cwaswick, Ryanklev
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Asset Record Changed by Another User" error when saving an Asset Book record in the Fixed Assets module of Microsoft Dynamics GP

This article provides a resolution for the issue that you can't save an Asset Book record in the Fixed Assets module of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2023182

## Symptoms

When you try to save an Asset Book record that already exists in the Fixed Assets module of Microsoft Dynamics GP, you receive the following error message:

> Asset Record Changed by Another User.

## Cause

The cause is that the **LASTMNTDTIME** value in the **FA00200** table for the Asset Book record has microseconds populated. Consider the following example:

Correct LASTMNTDTIME value:       1900-01-01 14:07:24.000  
Incorrect LASTMNTDTIME value:     1900-01-01 14:07:24.223

In this case, the 1900-01-01 14:07:24.223 is incorrect because the .223 is representing microseconds.

## Resolution

Use update statements through SQL Server Management Studio to remove the microseconds from the `LASTMNTDTIME` value in the **FA00200** table. To do this, follow these steps:

1. Open SQL Server Management Studio using the appropriate method below for the program you are using:

    For SQL Server 2000

    If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    For SQL Server 2005

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    For SQL Server 2008

    If you are using SQL Server 2008, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

2. Run the following statement against the company database to find the **ASSETINDEX** for the Asset ID:

    ```sql
    select ASSETINDEX,* from FA00100 where ASSETID = 'XXXXX' and ASSETIDSUF = 'Y'
    ```

    > [!NOTE]
    > Replace *XXXXX* with the Asset ID that has the problem and replace Y with the Asset ID Suffix for the Asset ID that has the problem.

3. Run the following statement against the company database to verify that the `LASTMNTDTIME` value in the FA00200 table for this ASSETINDEX has microseconds incorrectly populated:

   ```sql
   select LASTMNTDTIME,* from FA00200 where ASSETINDEX = 'ZZZZZ'
   ```

    > [!NOTE]
    > Replace *ZZZZZ* with the ASSETINDEX that you found from Step #1 that repesents the problem Asset ID.

4. Once you have verified that the LASTMNTDTIME record in the FA00200 table incorrectly has the microseconds populated, run the following statement against the company database to remove the microseconds:

    ```sql
    update FA00200 SET LASTMNTDTIME = '1900-01-01 14:07:24.000' where DEX_ROW_ID = 'UUUUU'
    ```

    > [!NOTE]
    > There are two placeholders in the above statement that will need to be modified:

    - Replace *UUUUU* with the `DEX_ROW_ID` value for the FA00200 record that you need to update.
    - Modify the `LASTMNTDTIME` value in the update statement to be appropriate to your situation from your findings in Step #2. In the example outlined above, the `LASTMNTDTIME` was changed to 1900-01-01 14:07:24.000 instead of 1900-01-01 14:07:24.223, but you need to edit this to be specific to your situation.

5. After following these steps, the microseconds should be removed from the `LASTMNTDTIME` value in the **FA00200** table. You should then be able to save the Asset Book record without error.
