---
title: An error was encountered while exporting data when exporting store
description: Provides a resolution for the issue where an error was encountered while exporting data when exporting a new or existing Microsoft Dynamics Store Operations database store in Microsoft Dynamics Headquarters Administrator.
ms.reviewer: randyh
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Error 0: An error was encountered while exporting data" on DatabaseMetaData when exporting a new or existing store in Headquarters Administrator

This article provides a resolution for the **An error was encountered while exporting data** error that may occur on the DatabaseMetaData table when exporting a new or existing Microsoft Dynamics Store Operations database store in Microsoft Dynamics Headquarters Administrator.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2601889

## Symptoms

When you try to export an existing store from HQ Administrator, you receive the following error message during the export of the DataBaseMetaData table:

> An error was encountered while exporting data. Your store operations database is not complete and may not work correctly. Error 0

> [!NOTE]
> This specific error message is a default message that may appear during other processes and table exports of this function. This article relates only to the error message when it appears during the export of the DataBaseMetaData table.

## Cause

The **DatabaseMetaData** table holds encryption key information for the store database only and is not a table in Headquarters.

There may have been scripts/procedure/events ran against your headquarters database, which caused the Headquarters database to have the DatabaseMetaData table.

## Resolution

This issue can be resolved by taking the following steps to clear out the DataBaseMetaData table in Headquarters.

1. Make a backup of your database.
2. Sign in to Headquarters Administrator and connect to the headquarters database.
3. Select **Query** and then select **New** to display the New Query window.
4. In the New Query window, type in the statement below and press the F5 key to execute the query:

    ```sql
    DELETE DataBaseMetaData
    ```

5. Export the store again.
