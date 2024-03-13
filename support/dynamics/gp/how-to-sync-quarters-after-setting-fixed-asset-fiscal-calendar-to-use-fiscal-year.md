---
title: Sync calendar quarters after setting Fixed Assets fiscal calendar to use a fiscal year
description: How to synchronize calendar quarters after you configure the Fixed Assets fiscal calendar to use a fiscal year in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to synchronize calendar quarters after you configure the Fixed Assets fiscal calendar to use a fiscal year

This article describes how to synchronize calendar quarters after you configure the Fixed Assets fiscal calendar to use a fiscal year instead of a calendar year in Fixed Asset Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935621

To synchronize calendar quarters after you configure the Fixed Assets fiscal calendar to use a fiscal year, follow these steps.

> [!NOTE]
> The Fixed Assets fiscal calendar does not have to cover the same time as the Fiscal Period calendar. However, it is easier to maintain Microsoft Dynamics GP if both calendars cover the same time. Make sure that you configure the Fixed Assets fiscal calendar based on your reporting needs.
>
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Microsoft Dynamics GP 10.0

1. Rebuild the Fixed Assets fiscal calendar. To do this, follow these steps:

    1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**.
    2. Select the **Build Fixed Assets Fiscal Calendar** check box and the **Replace** check box.
    3. Select **Build**.
    4. When you receive the following message, select **OK**:

       > Build of Fixed Assets Calendar will now be performed. Continue?

2. Verify that the Fixed Assets fiscal calendar is built correctly. To do this, select **Inquire**, and then select **Verify**. Select **OK** when you are prompted to continue.

3. Clear the data in the table that holds the calendar quarters. To do this, follow these steps:

    1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Utilities**, point to **Fixed Assets**, and then select **Clear Data**.
    2. In the Fixed Assets Clear Data window, select **Display**, and then select **Physical**. The **Files** list is re-populated.
    3. In the **Files** list, select **Quarter Setup**, and then select **Insert**.
    4. Select **OK** to clear the data in the Quarter Setup tables. Select **Yes** when you are prompted to clear the data from the tables.
    5. In the Report Destination window, select to select the **Screen** check box, and then select **OK** to print the report to the screen.

4. Synchronize the new calendar. To do this, follow these steps:

    1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**.
    2. In the Build Fixed Assets Fiscal Calendar window, select to select the **Synchronize Quarters to Fiscal Years** check box, and then select **Build**.
    3. When you are prompted to build, select **OK**.

5. If you are prompted, print the quarter report.

### For Microsoft Dynamics GP 9.0 and earlier versions

1. Rebuild the Fixed Assets Fiscal calendar. To do this, follow these steps:

    1. On the **Tools** menu, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**.
    2. Select the **Build Fixed Assets Fiscal Calendar** check box and the **Replace** check box.
    3. Select **Build**.
    4. When you receive the following message, select **OK**:

       > Build of Fixed Assets Calendar will now be performed. Continue?

2. Verify that the Fixed Assets fiscal calendar is built correctly. To do this, select **Inquire**, and then select **Verify**. When you are prompted to continue, select **OK**.

3. Clear the data in the table that holds the calendar quarters. To do this, follow these steps:

    1. On the **Tools** menu, point to **Utilities**, point to **Fixed Assets**, and then select **Clear Data**.
    2. In the Fixed Assets Clear Data window, select **Display**, and then select **Physical**. The **Files** list is repopulated.
    3. In the **Files** list, select **Quarter Setup**, and then select **Insert**.
    4. Select **OK** to clear the data in the Quarter Setup tables. When you are prompted to clear the data from the tables, select **Yes**.
    5. In the Report Destination window, select to select the **Screen** check box, and then select **OK** to print the report to the screen.

4. Synchronize the new calendar. To do this, follow these steps:

    1. On the **Tools** menu, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**.
    2. In the Build Fixed Assets Fiscal Calendar window, select to select the **Synchronize Quarters to Fiscal Years** check box, and then select **Build**.
    3. When you are prompted to build, select **OK**.

5. If you are prompted, print the quarter report.
