---
title: Void a scheduled payment
description: Description of the Scheduled Payments transaction and a description of how to void a scheduled payment in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.date: 03/13/2024
---
# Description of the Scheduled Payments transaction and a description of how to void a scheduled payment in Microsoft Dynamics GP

This article describes the Scheduled Payments transaction and a description of how to void a scheduled payment in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857296

## Introduction

This article describes the Scheduled Payments transaction in the following products:

- Microsoft Dynamics GP 10.0
- Microsoft Dynamics GP 9.0
- Microsoft Business Solutions-Great Plains 8.0
- Microsoft Business Solutions-Great Plains 7.5

Additionally, this article describes how to void a scheduled payment.

## More information

You can use the Scheduled Payments transaction when you create installments from an invoice and when you post amortizations. The following steps show how the Scheduled Payments transaction works.

1. You post an invoice from which installments are created.
2. You select the invoice in the Receivables Scheduled Payments Entry window to create a scheduled payment. You configure the scheduled payment, and then you post the scheduled payment. When you do it, Microsoft Dynamics GP creates the following documents:

    - A credit memo document in which the type is set to **CR**.

        > [!NOTE]
        > The credit memo amount is the same as the invoice amount.
    - A scheduled payment document in which the type is set to **SCP**.

        > [!NOTE]
        > The scheduled payment amount is the same as the credit memo amount.

3. You post the amortizations in the Post Receivables Scheduled Payments window.

    - The amortizations are related to the invoice document in which the type is **SLS**.
    - When you post an amortization, the amortization amount is subtracted from the scheduled payment.

For example, you create six installments from an invoice that has an amount of 1,200. Then, you post all amortizations. In this example, the results of the Schedule Payments transaction are as follows.

|**Accounts Receivable account**| **Sales account** |**Offset account** |**Document** |**Type**|
|---|---|---|---|---|
|1,200|-1,200|-|Invoice|SLS|
|-1,200|-1,200|Credit memo|CR|
|-|-|-|Scheduled payment|SCP|
|200|-|-200|First amortization|SLS|
|200|-|-200|Second amortization|SLS|
|200|-|-200|Third amortization|SLS|
|200|-|-200|Fourth amortization|SLS|
|200|-|-200|Fifth amortization|SLS|
|200|-|-200|Sixth amortization|SLS|
|1,200|-1,200|0|-|-|

## How to void a scheduled payment

1. Void amortizations. To do it, follow these steps.

    > [!NOTE]
    > Follow step a through step c only if remaining amortization transactions exist that must be posted. Begin with step d to void the invoices that were created by the completed schedule payment.

    1. On the **Transactions** menu, point to **Sales**, and then select **Scheduled Payments**.
    1. In the **Schedule Number** field, enter the number of the scheduled payment that you want to void, type **1** in the **Number of Payments** field, select **Calculate**, and then select **Save**.
        > [!NOTE]
        > You perform this step to make sure that all amortizations are posted.
    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then select **Post Scheduled Payments**.
        - In versions that are earlier than Microsoft Dynamics GP 10.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then select **Post Scheduled Payments**.
    1. In the **Post Receivable Scheduled Payments** window, select the check boxes for the amortizations that you want to void, and then select **Post**.
    1. On the **Transactions** menu, point to **Sales**, and then select **Posted Transactions**.
    1. In the "Receivables Posted Transaction Maintenance" window, enter the number of an amortization that you posted in step 1d in the **Number** field, and then select **Void**.
    1. Repeat step 1f for other amortizations that you posted in step 1d.

        > [!NOTE]
        > If the scheduled payment has the number **SCHPY00000000001**, the amortizations numbers resemble the following numbers:
        >
        > - SCHPY00000000001001
        > - SCHPY00000000001002
        > - SCHPY00000000001003

2. Void the credit memo. To do it, follow these steps:

    1. On the **Transactions** menu, point to **Sales**, and then select **Posted Transactions**.
    1. In the **Receivables Posted Transaction Maintenance** window, enter the number of the credit memo that you want to void in the **Number** field, and then select **Void**.

3. If you want to void the invoice that you use for the scheduled payment, follow these steps:

    1. On the **Transactions** menu, point to **Sales**, and then select **Posted Transactions**.
    1. In the **Receivables Posted Transaction Maintenance** window, enter the number of the invoice that you want to void in the **Number** field, and then select **Void**.

4. If you want to change the status of these transaction documents to **History**, follow these steps:

    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamcis GP** menu, point to **Routines**, point to **Sales**, and then select **Paid Transaction Removal**.
        - In versions that are earlier than Microsoft Dynamics GP 10.0, point to **Sales** on the **Tools** menu, and then select **Paid Transaction Removal**.
    1. Select **Process**.

5. If you want to remove these transactions from the Receivables Management module, follow these steps:

    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamcis GP** menu, point to **Utilities**, point to **Sales**, and then select **Remove Transaction History**.
        - In versions that are earlier than Microsoft Dynamics GP 10.0, point to **Utilities** on the **Tools** menu, point to **Sales**, and then select **Remove Transaction History**.
    1. Select **Process**.
        > [!NOTE]
        > To complete step 5, you first have to complete step 4.
