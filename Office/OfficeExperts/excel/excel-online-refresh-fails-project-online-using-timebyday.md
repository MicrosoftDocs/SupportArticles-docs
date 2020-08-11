---
title: External Data Refresh Failed when refresh Project Online data in Excel Online
description: You can't refresh Project Online data in Excel Online with an "External Data Refresh Failed" error message. 
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: thempel
appliesto:
- Excel Online
---

# "External Data Refresh Failed" when refreshing Project Online data in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you try to refresh Project Online data in Excel Online, the refresh fails. Additionally, you receive the following error message:

**External Data Refresh Failed**

![External Data Refresh Failed error message](./media/excel-online-refresh-fails-project-online-using-timebyday/error.png)

## Cause

This issue occurs if you select the **TimeByDay (Month)** option in **PivotTable Fields**.

![TimeByDay (Month) option selected in in PivotTable Fields](./media/excel-online-refresh-fails-project-online-using-timebyday/timebyday-option.png)

## Resolution

If you clear the **TimeByDay (Month)** option, the error will not occur when you refresh Excel Online. However, your workbook may not look the way that you want it to look. To fix this, follows these steps:

1. In Excel, select **File** > **Options** > **Data**.
1. Select the **Disable automatic grouping of Date/Time columns in PivotTables** check box, and then select **OK**.

   ![Selecting Disable automatic grouping of Date/Time columns in PivotTable option](./media/excel-online-refresh-fails-project-online-using-timebyday/check-box.png)

1. Remove the existing "TimeByDay" columns in Power Pivot. To do this, select the **Power Pivot** tab, and then select **Manage**. In the Power Pivot for Excel window, you see two columns on the **Home** tab that are named **TimeByDay (Month Index)** and **TimeByDay (Month)**. Select both columns, right-click both columns, and then select **Delete Columns**.
1. After you remove the auto-generated time columns, select **Add Column**, name it as **Month**, and then add the following formula to this column:

   **=FORMAT([TimeByDay],"MMM YYYY")**

   ![Adding formula to the Month column](./media/excel-online-refresh-fails-project-online-using-timebyday/formula-to-month-column.png)

1. Select **Add Column** again, name it as **MonthNumber**, and then add the following formula to this column:

   **=FORMAT([TimeByDay],"YYYY MM")**

   ![Adding formula to the MonthNumber column](./media/excel-online-refresh-fails-project-online-using-timebyday/formula-to-monthnumber-column.png)

1. Sort the **Month** column by **MonthNumber**. To do this, select the **Month** column, select **Sort by Column**, and then select **MonthNumber** in the **Sort by Column** window.

   ![Sort Month column by MonthNumber](./media/excel-online-refresh-fails-project-online-using-timebyday/sort-by-column.png)

1. On the **Month** column, select **Sort A to Z**. This sorts the months in the correct chronological and alphabetical order.

   ![Selecting Sort A to Z](./media/excel-online-refresh-fails-project-online-using-timebyday/sort-a-to-z.png)

1. Go back to your Pivot table, select one cell of the **TimeByDay** column, and then select **Group**.

   ![Selecting Group for the TimeByDay column](./media/excel-online-refresh-fails-project-online-using-timebyday/group.png)

1. Select **Months** > **OK**.

   ![Group by months](./media/excel-online-refresh-fails-project-online-using-timebyday/group-by-months.png)

You now have the appearance of using the **TimeByDay (Month)** field.