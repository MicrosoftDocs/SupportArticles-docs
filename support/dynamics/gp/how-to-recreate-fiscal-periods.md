---
title: How to recreate fiscal periods
description: Describes how to re-create fiscal periods if they are damaged or if they are incorrect in Microsoft Dynamics GP on Microsoft SQL Server.
ms.reviewer: cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to recreate fiscal periods in Microsoft Dynamics GP

This article describes how to recreate fiscal periods in Microsoft Dynamics GP. You may have to recreate fiscal periods because a table is damaged or because you are prompted in an error message.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871789

> [!NOTE]
> Before you follow the instructions, make sure that you maintain transaction history and that you have maintained transaction history in the past. If you have not maintained transaction history and you run a reconcile, the summary information may be lost. During a reconcile, the summary information is reconciled to the detail transaction information. If there is no detail for the summary with which to reconcile and you continue with the reconcile, any summary information that you had will be lost. The only way to restore information is from a backup. We recommend that you have a valid backup before you recreate fiscal periods or before you continue with the reconcile.
>
> When you recreate fiscal periods, the period description is reset. For example, if you enter period descriptions, such as period 1 for January, these descriptions are reset.

## More information

To recreate fiscal periods, follow these steps.

> [!NOTE]
> You cannot change fiscal periods if they are historical.

1. Print the fiscal period report. You will need this detail later to setup the same fiscal periods again. To do this, follow these steps:

   1. Select **Reports**, point to **Company**, and then select **Setup**.
   2. In the **Reports** list, select **Fiscal Periods**.
   3. Select New to create a new report option.
   4. In the Company Setup Report Options window, enter a name (of your choice) for the report in the **Option** field.
   5. Select **Print**. Select **OK**.
   6. To determine which years are historical, go to **Tools** under Microsoft Dynamics GP, point to **Setup**, point to **Company**, and select **Fiscal Periods**. Select each Year and note if the Historical Year checkbox is marked. If the Historical Year checkbox is unmarked, the year has not been closed.

2. Run the following statement against the company database.

    ```sql
    delete SY40100
    delete SY40101
    ```

3. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
4. Set up each fiscal period to match the fiscal periods in the report that you printed in step 1. To do this, follow these steps:

    1. In the **Year** list, select a year.
    2. In the **First Day** field, type a first day for the fiscal period.
    3. In the **Last Day** field, type a last day for the fiscal period.
    4. In the **Number of Periods** field, type the number of periods for the fiscal year.
    5. Make sure that you select the **Historical Year** check box if it was a historical year in the report that you printed in step 1.
    6. Select **Calculate**.
    7. Repeat step 4a through step 4f for each year in the report.

5. After you set up all the fiscal periods, select **OK**.
6. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Financial**, and then select **Reconcile**.
7. Select the **Year** check box.

8. If you have historical years in the fiscal periods, select **History**. Start with the oldest history year first. For example, if the historical years are 2010, 2011, and 2012, start with 2010 first. If you have no historical years, start with the oldest open year.

9. Select **Reconcile**. Microsoft Dynamics GP now processes all general ledger accounts and reconciles the account summary information to the account detail.
10. Repeat step 6 through step 9 until you have processed all historical years and open years in the correct order.
