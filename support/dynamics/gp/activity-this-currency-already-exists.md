---
title: Activity for this currency already exists
description: Provides a solution to an error that occurs when you try to assign or change a currency on the Multicurrency Setup page in Microsoft Dynamics GP.
ms.reviewer: theley, kriszree
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# "Activity for this currency already exists. The functional currency can't be changed." Error message when you try to assign or change a currency on the Multicurrency Setup page in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to assign or change a currency on the Multicurrency Setup page in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864342

## Symptoms

When you enter transactions, and then try to assign or change a currency on the Multicurrency Setup page in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:
> Activity for this currency already exists. The functional currency can't be changed.

## Cause

This issue occurs when you try to assign a Functional Currency for the first time after you enter or post transactions or when you change a Functional Currency that is already assigned.

## Resolution

To resolve this issue, follow these steps:

1. Create a backup of the company database.

    > [!NOTE]
    > If you want to, you can try the steps in a test company database, and then implement them in the company database. For more information, see [KB - Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/help/871973).

2. Run **Check Links** on the Multicurrency tables. To do it in Microsoft Dynamics 10.0, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, select **File**, point to **Maintenance**, and then select **Check Links**.
    1. In the **Series** list, select **Financials**.
    1. In the **Logical Tables** list, select **Multicurrency Setup**, and then select **Insert**.
    1. Select **OK**.

    To do it in Microsoft Dynamics 9.0 and earlier versions, follow these steps:

    1. Select **File**, point to **Maintenance**, and then select **Check Links**.
    1. In the **Series** list, select **Financials**.
    1. In the **Logical Tables** list, select **Multicurrency Setup**, and then select **Insert**.
    1. Select **OK**.

3. Print the File Maintenance error report, and then verify that the functional currency is updated by viewing the following entry:  
    Multicurrency Setup: Functional currency has been updated.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
