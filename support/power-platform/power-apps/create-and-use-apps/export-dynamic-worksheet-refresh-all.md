---
title: Refresh All doesn't work after exporting app data to a dynamic worksheet
description: Describes an issue where Refresh All doesn't work after exporting app data to a dynamic worksheet in Power Apps.
author: sriharibs-msft
ms.reviewer: aartigoyle
ms.date: 10/18/2023
ms.author: srihas
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - sriharibs-msft
  - aartig13
  - tapanm-msft
---
# Refresh All doesn't work after exporting app data to a dynamic worksheet

## Symptoms

After you use the [Export to Excel](/power-apps/user/export-excel-dynamic-worksheet) command to export app data to a dynamic worksheet and open the file by selecting **Data** > **Refresh All**, the data disappears and workbook appears blank.

## Cause

This issue occurs when the data that you're accessing is password-protected and the Excel file can't submit passwords to external data sources. To resolve this issue, you must edit and save the web query.

## Resolution

1. In the Excel file, select **Data** > **Queries & Connections**.

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/queries-and-connections.png" alt-text="Screenshot that shows the Queries and Connections option in the Data tab." border="false":::

2. The **Queries & Connections** pane opens on the right of the window. On the **Connections** tab, right-click to select the query and then select **Properties**.

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/query-properties.png" alt-text="Screenshot that shows the Properties settings of a query on the Queries and Connections pane." border="false":::

3. The **Connection Properties** window opens. On **Definition** tab, select **Edit Query**

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/edit-query.png" alt-text="Screenshot that shows the Edit Query button in the Connection Properties window." border="false":::

4. If prompted, enter username and password. Enter the same user and password that you use to sign in to your app.

5. On the **Edit Web Query** window, select **Go**. An error message occurs:

   > Can't complete this action

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/go-button-in-edit-web-query.png" alt-text="Screenshot that shows the Go button in the Edit Web Query window." border="false"  lightbox="media/export-dynamic-worksheet-refresh-all/go-button-in-edit-web-query.png":::

6. Close the **Edit Web Query** window.

7. This should fix the issue. Refresh the data in the worksheet again by selecting **Data** > **Refresh All**.

    :::image type="content" source="media/export-dynamic-worksheet-refresh-all/refresh-data.png" alt-text="Screenshot that shows how to refresh your app data in Excel." border="false":::

### See also

[Export data to an Excel dynamic worksheet](/power-apps/user/export-excel-dynamic-worksheet)
