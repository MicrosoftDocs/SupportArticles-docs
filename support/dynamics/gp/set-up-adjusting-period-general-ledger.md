---
title: Set up adjusting period in General Ledger
description: Describes how to set up an adjusting period to record adjustments that are posted to the general ledger after the year-end close process has been performed.
ms.reviewer: theley, dbader
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# How to set up an adjusting period in General Ledger in Microsoft Dynamics GP

This article describes how to set up an adjusting period to record adjustments that are posted to the general ledger after the year-end close process has been performed.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871679

## Introduction

This article describes how to do it in General Ledger in Microsoft Dynamics GP.

The adjusting period that you set up should meet the following conditions:

- The adjusting period should start on the last day of the fiscal year.

- The adjusting period shouldn't overlap any other period dates.

## More Information

To set up an adjusting period in General Ledger in Microsoft Dynamics GP, follow these steps.

> [!NOTE]
> Historical periods cannot be changed.

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
2. Set up each fiscal period. To do it, see the steps in the following example.

    > [!NOTE]
    > This example assumes that the fiscal year starts on January 1 and ends on December 31 and that the fiscal year has a 13th adjusting period.

    1. In the **Year** list, select a year. For example, select **2013**.
    2. In the **First Day** field, type a first day for the fiscal period. For example, type **01/01/2013**.
    3. In the **Last Day** field, type a last day for the fiscal period. For example, type **12/31/2013**.
    4. In the **Number of Periods** field, type the number of periods for the fiscal year. For example, type **13**.
    5. Select **Calculate**.
    6. If it's necessary, adjust the start dates of the periods. In this example, type dates in the **Date** column beside the corresponding entry in the **Period Name** column as indicated in the following list:
        - Period 1: 01/01/2013
        - Period 2: 02/01/2013
        - Period 3: 03/01/2013
        - Period 4: 04/01/2013
        - Period 5: 05/01/2013
        - Period 6: 06/01/2013
        - Period 7: 07/01/2013
        - Period 8: 08/01/2013
        - Period 9: 09/01/2013
        - Period 10: 10/01/2013
        - Period 11: 11/01/2013
        - Period 12: 12/01/2013
        - Period 13: 12/31/2013

3. Select **OK**.
4. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Financial**, and then select **Reconcile**.
5. Select the **Year** check box.
6. Select **Reconcile**. Microsoft Dynamics GP reconciles the account summary data to the account detail data for all general ledger accounts.
