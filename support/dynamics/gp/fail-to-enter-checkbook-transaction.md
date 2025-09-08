---
title: Error when you enter a checkbook transaction
description: You receive an error message in Microsoft Dynamics GP when you try to enter a checkbook transaction. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: theley, ryanklev
ms.date: 04/17/2025
ms.custom: sap:Financial - Bank Reconciliation
---
# You receive an error message in Microsoft Dynamics GP when you try to enter a checkbook transaction

This article provides a solution to an error that occurs when you enter a checkbook transaction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874139

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you try to enter a checkbook transaction in Microsoft Dynamics GP, you receive one of the following error messages:

- Error message 1

    > The checkbook ID must have the functional currency ID assigned to it.

- Error message 2

    > You must register Multicurrency Management before selecting this checkbook.

- Error message 3

    > The currency on the transaction must be either the functional currency or the currency assigned to the selected checkbook.

- Error message 4

    > The currency on the transaction must be the same as the currency assigned to the selected checkbook.

## Cause

This problem occurs if one of the following conditions is true:

- You recently registered Multicurrency in Microsoft Dynamics GP in your Microsoft Dynamics GP company after you set up your current checkbooks.
- You recently defined a functional currency in your Microsoft Dynamics GP company. However, you are currently not registered for Multicurrency.

## Resolution

To resolve this problem, follow these steps:

1. Verify your functional currency. To verify your functional currency, point to **Setup** on the **Tools** menu, point to **Financial**, and then click **Multicurrency**.

2. Use SQL Query Analyzer to obtain your functional currency index. To do this, follow these steps:

    1. Start SQL Query Analyzer.
    2. In the database list, click your company database.
    3. Copy the following statement into the query pane.

        ```sql
        select FUNLCURR, FUNCRIDX from MC40000
        ```

    4. On the **Query** menu, click **Execute**.

3. Verify your checkbook currency. To do this, follow these steps:

    1. On the **Cards** menu, point to **Financial**, and then click **Checkbook**.
    2. In the **Checkbook ID** box, type your checkbook ID.

4. In the **Currency ID** box, type your functional currency ID.
5. Run the Check Links procedure on the financial series so that all the current transactions are updated to contain the correct currency information. To do this, follow these steps:

    1. On the **File** menu, point to **Maintenance**, and then click **Check Links**.
    2. Click **All**.
    3. Click **OK**.
    4. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
