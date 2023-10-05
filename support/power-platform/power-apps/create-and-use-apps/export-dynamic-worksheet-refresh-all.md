---
title: Refresh All doesn't work after exporting app data to a dynamic worksheet
description: Describes an issue where refresh All doesn't work after exporting app data to a dynamic worksheet.
author: sriharibs-msft
ms.reviewer: aartigoyle
ms.date: 10/05/2023
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

After you use the [Export to Excel](/power-apps/user/export-excel-dynamic-worksheet) command to export a file to your local computer and open the file by selecting **Data** > **Refresh All**. The data disappears and workbook appears blank.

## Cause

This issue occurs when the data that you're accessing is password-protected and the Excel file can't submit passwords to external data sources. To resolve this issue, you must edit and save the web query.

## Resolution

1. In the Excel file, select the **Data** tab > **Queries and Connections**.

   > [!div class="mx-imgBorder"] 
   > ![Go to Queries and Connections.](media/export-dynamic-worksheet-refresh-all/excel-dynamic-ts-1.png "Go to Queries and Connections") 
   
3. The **Queries & Connections** pane opens on the right of the window. On the **Connections** tab, right-click to select the query and then select **Properties**.

   > [!div class="mx-imgBorder"] 
   > ![Go connections properties.](media/export-dynamic-worksheet-refresh-all/excel-dynamic-ts-2.png "Go connections properties")
   
5. The **Connection Properties** window opens. On **Definition** tab, select **Edit Query**

   > [!div class="mx-imgBorder"] 
   > ![Edit query.](media/export-dynamic-worksheet-refresh-all/excel-dynamic-ts-3.png "Edit Query")

6. If prompted, enter username and password. Enter the same user and password that you use to sign in to your app.

7. On the **Edit Web Query** window, select **GO**. An error message will show: **Can't complete this action** 

   > [!div class="mx-imgBorder"] 
   > ![Select Go.](media/export-dynamic-worksheet-refresh-all/excel-dynamic-ts-4.png "Select GO")

8. Close the **Edit Web Query** window.

   > [!div class="mx-imgBorder"] 
   > ![Close the window.](media/export-dynamic-worksheet-refresh-all/excel-dynamic-ts-5.png "Close the window")

9. This should fix the issue. Refresh the data in the worksheet again by going to, **Data** > **Refresh All**. 

   > [!div class="mx-imgBorder"] 
   > ![Refresh your app data in Excel.](media/export-dynamic-worksheet-refresh-all/refresh-data.png "Refresh your app data in Excel") 

### See also

[Export data to an Excel dynamic worksheet](/power-apps/user/export-excel-dynamic-worksheet)
