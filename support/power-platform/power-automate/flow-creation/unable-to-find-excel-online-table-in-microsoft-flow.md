---
title: Cannot find Excel Online table in Microsoft Flow
description: Provides a resolution for finding the Excel Online table in Microsoft Flow.
ms.reviewer: mehgupta
ms.date: 03/31/2021
ms.subservice: power-automate-flow-creation
---
# Unable to find Excel Online table in Microsoft Flow

This article provides a resolution for the issue that you can't find Excel Online table in Microsoft Flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4527553

## Symptoms

When trying to access information in an Excel spreadsheet that is not formatted as a table, you may not be able to see a table present in the drop-down menu.

:::image type="content" source="media/unable-to-find-excel-online-table-in-microsoft-flow/no-table-in-dropdown.png" alt-text="Screenshot shows that the Excel table drop-down menu has no table." border="false":::

Entering a custom value that does not exist or leaving the table input blank will produce an error that begins with **Error executing the api**.

## Cause

This error occurs because the data in the Excel spreadsheet is not formatted as a table.

:::image type="content" source="media/unable-to-find-excel-online-table-in-microsoft-flow/data-not-formatted-as-table.png" alt-text="Screenshot shows that the Excel data is not formatted as a table.":::

## Resolution

To fix this issue, format the data in the Excel spreadsheet as a table.

To create a table from scratch, follow these steps:

1. Select the cells you want to include in the table.
2. Select **Insert** > **Table** > **Ok**.

To convert existing data into a table, follow these steps:

1. Select the cells containing the data you want to convert into a table.
2. Select **Home** > **Format as Table**.
3. Select the type of table you want and select **Ok**.

Headers will automatically be included in the table, which will default to Column1, Column2, and so on. They can be renamed by double-clicking and typing a new header name.

:::image type="content" source="media/unable-to-find-excel-online-table-in-microsoft-flow/data-formatted-as-table.png" alt-text="Screenshot shows the Excel data is formatted as a table.":::

For more information, see [Create and format tables](https://support.microsoft.com/office/create-and-format-tables-e81aa349-b006-4f8a-9806-5af9df0ac664?ui=en-us&rs=en-us&ad=us).
