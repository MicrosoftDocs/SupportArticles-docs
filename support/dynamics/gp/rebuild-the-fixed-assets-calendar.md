---
title: Rebuild the Fixed Assets calendar
description: Describes how to rebuild the Fixed Assets calendar in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Fixed Assets
---
# How to rebuild the Fixed Assets calendar in Microsoft Dynamics GP

This article describes how to rebuild the Fixed Assets calendar in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874133

## Introduction

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

Steps to rebuild the Fixed Assets calendar can be used as part of the troubleshooting steps for several problems in Fixed Assets. If the Fixed Assets calendar becomes damaged or the Fiscal Period calendar is rebuilt in General Ledger, the FA calendar has to be rebuilt.

> [!NOTE]
> Users can use a different fiscal calendar for Fixed Assets than is used for the Microsoft Dynamics GP calendar.

In Dynamics GP 2013 RTM, you can set up the FA calendar based on the Company fiscal period setup, a calendar year or an existing FA calendar setup, and also build short/long years. The FA calendar doesn't need to match the Company fiscal period calendar. You can set up an unlimited number of FA Calendar IDs, but only one can be assigned to a Book and is locked down once it has been used. If you need to change the FA calendar from a calendar year to fiscal year or vice versa, it's recommended to edit the existing calendar ID for periods going forward only. You can't change the periods for historical years or a 'reset life' will cause damaged data. Therefore, only change the periods going forward, as outlined in the example in this blog:

[Guidelines for fiscal period/year changes with Fixed Assets in Microsoft Dynamics GP 10 and 2010](https://community.dynamics.com/blogs/post/?postid=06009afe-d4fc-42c2-9cdd-bfedacbc273f)

## Microsoft Dynamics GP 2013 and later versions

The calendar doesn't need to match the Company Fiscal period calendar. To rebuild the FA calendar, perform the following steps:

1. Make a current backup first, for reference if needed.

2. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **Fixed Assets** > **Calendar**.

3. Pull up the **Calendar ID** being used.

4. Mark the **Build Calendar** checkbox.

5. If you normally build from the Fiscal Year Setup, make sure that option is marked, or choose the appropriate option. (Current company fiscal period setup, a calendar year, or an existing FA calendar setup)

6. Ensure the Years are set as **1901** to **2199**.

    > [!NOTE]
    > You must rebuild all years.

7. Select **Build Calendar**.

8. Once complete, select **Save**.

## Microsoft Dynamics GP 2010 and prior versions

To rebuild the Fixed Assets calendar when it differs from the Microsoft Dynamics GP calendar, follow these steps.

> [!NOTE]
> If the Fixed Assets calendar and the Microsoft Dynamics GP calendar are the same, complete only step 7 and step 8 in this section.

1. Make a complete backup copy of the database.

    > [!NOTE]
    > It's important to back up the database because the Fiscal Period Setup table (SY40100) and the Fiscal Period Header table (SY40101) in this backup can be restored by using the Import and Export Utility in Microsoft SQL Server.
2. Make sure that all users sign out of Microsoft Dynamics GP.
3. Delete the SY40100 table and the SY40101 table. It will remove the current fiscal periods that are set up for Microsoft Dynamics GP. To do it, follow these steps:
   1. Follow the appropriate step:
      - If you're using Microsoft SQL Server 2008, start SQL Server Management Studio. To do it, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
      - If you're using Microsoft SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
      - If you're using Microsoft SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

   2. Run the following statement against the company database.

      ```sql
      DELETE SY40100
      DELETE SY40101
      ```

4. Set up at least one fiscal year. To do it, follow the appropriate step:
   - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
   - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Setup** on the **Tools** menu, point to **Company**, and then select **Fiscal Periods**.

        > [!NOTE]
        > If each year in Fixed Assets is the same, you have to set up only one year because the other years are modeled after this same year. If you want a stub year or a year that has a different period setup, you must set up those years in the Microsoft Dynamics GP calendar.
5. For the appropriate year, enter the **First Day**, enter the **Last Day**, enter the **Number of Periods**, and then select **Calculate**.
6. When you set up all the fiscal periods, select **OK**.
7. Build the Fixed Assets calendar. To do it, follow the appropriate step:
   - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**. Select the **Build Fixed Assets Fiscal Calendar** check box and the **Replace** check box.
   - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Setup** on the **Tools** menu, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**. Select the **Build Fixed Assets Fiscal Calendar** check box and the **Replace** check box.

    > [!NOTE]
    > We recommended that you leave the default **To** and **From** year fields as 1901-2199. This will make sure that the years are set up so that there are no issues with projections or depreciation calculations.
8. Verify that the Fixed Assets calendar is built correctly. To do it, open the Build Fixed Assets Fiscal Calendar window, select **Inquire**, and then select **Verify**. Select **OK** when you're prompted to continue.
9. Print the FA Verify Fiscal Calendar report.

    > [!NOTE]
    > Make sure that no periods have a status of **missing**.
10. Restore the SY40100 table and the SY40101 table from a backup.

    For more information, see [How to transfer setup information between company databases by using Microsoft SQL Server](https://support.microsoft.com/help/874208).

## More information

The Fixed Asset Management Fiscal calendar can supply all the calendar information instead of the Microsoft Dynamics GP calendar. It allows for differences that may exist between the two calendars. Users can use a different fiscal calendar for Fixed Assets.
