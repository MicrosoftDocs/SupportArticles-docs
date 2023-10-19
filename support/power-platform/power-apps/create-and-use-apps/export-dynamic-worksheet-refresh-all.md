---
title: Refresh All doesn't work after exporting app data to a dynamic worksheet
description: Describes an issue where Refresh All doesn't work after exporting app data to a dynamic worksheet in Power Apps.
author: sriharibs-msft
ms.reviewer: aartigoyle
ms.date: 10/19/2023
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
# "Refresh All" doesn't work after exporting app data to a dynamic worksheet

## Symptoms

After you use the [Export to Excel](/power-apps/user/export-excel-dynamic-worksheet) command to export app data to a dynamic worksheet and open the file by selecting **Data** > **Refresh All**, the data disappears, and the workbook appears blank.

## Cause

This issue occurs when the data that you access is password-protected and the Excel file can't submit passwords to external data sources.

## Resolution

To resolve this issue, you must edit and save the web query.

1. In the Excel file, select **Data** > **Queries & Connections**.

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/queries-and-connections.png" alt-text="Screenshot that shows the Queries and Connections option in the Data tab.":::

2. The **Queries & Connections** pane opens on the right of the window. On the **Connections** tab, right-click the query and then select **Properties**.

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/query-properties.png" alt-text="Screenshot that shows the Properties settings of a query on the Queries and Connections pane.":::

3. The **Connection Properties** window opens. On the **Definition** tab, select **Edit Query**.

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/edit-query.png" alt-text="Screenshot that shows the Edit Query button in the Connection Properties window.":::

4. If prompted, enter the username and password. Enter the same user and password that you use to sign in to your app.

5. On the **Edit Web Query** window, select **Go**. An error message occurs:

   > Can't complete this action

   :::image type="content" source="media/export-dynamic-worksheet-refresh-all/go-button-in-edit-web-query.png" alt-text="Screenshot that shows the Go button in the Edit Web Query window." lightbox="media/export-dynamic-worksheet-refresh-all/go-button-in-edit-web-query.png":::

6. Close the **Edit Web Query** window.

7. This should fix the issue. Refresh the data in the worksheet again by selecting **Data** > **Refresh All**.

    :::image type="content" source="media/export-dynamic-worksheet-refresh-all/refresh-data.png" alt-text="Screenshot that shows how to refresh your app data in Excel.":::

If this resolution doesn't solve the issue, follow these additional steps:

1. Enter the following link in the address bar of the **Edit Web Query** window to access the **Advanced Settings** page in Microsoft Dynamics 365 Customer Engagement. Remember to replace `OrgURL` with your organization URL.

   `https://OrgURL/main.aspx?settingsonly=true`

2. Now, sign out using the top-right profile option link and then sign back in using the right identity. Once you're signed in, close the **Edit Web Query** window, and then in the Excel file, select **Data** > **Refresh All**. The data will be refreshed as expected.

## See also

[Export data to an Excel dynamic worksheet](/power-apps/user/export-excel-dynamic-worksheet)
