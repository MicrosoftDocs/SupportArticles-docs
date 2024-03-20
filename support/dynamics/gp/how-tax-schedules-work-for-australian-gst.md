---
title: How tax schedules work for the Australian GST in Microsoft Dynamics GP
description: Contains detailed information about how tax schedules work for the Australian Goods and Services Tax in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# How tax schedules work for the Australian GST in Microsoft Dynamics GP

This article describes how tax schedules work for the Australian Goods and Services Tax (GST) in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944222

## More information

In the Payables Transaction Entry window and in the Receivables Transaction Entry window, you can click only one tax schedule ID in the **Tax Schedule ID** field. You have to set up the tax schedule IDs that appear in the **Tax Schedule ID** field. You set up these tax schedule IDs in the Tax Schedule Maintenance window.

Also, you can click only one tax schedule ID in the following fields in the Payables Tax Schedule Entry window and in the Receivables Tax Schedule Entry window:

- The **Purchase** field in the Payables Tax Schedule Entry window
- The **Sales** field in the Receivables Tax Schedule Entry window
- The **Freight** field in either window
- The **Miscellaneous** field in either window

> [!NOTE]
> The naming conventions that are used in this article follow the naming conventions that are used in the Australian Tax Information Setup Wizard. The Australian Tax Information Setup Wizard is included with the Business Activity Statement (BAS) and with the Pay As You Go (PAYG) withholding reporting dictionary.

Here's a list of the default tax schedule IDs that exist in Microsoft Dynamics GP for the Australian GST:

- The tax schedule ID for the creditor tax schedule is **AUSGST-CRED**. This tax schedule ID contains the purchasing tax details. The creditor tax schedule is assigned to a creditor in Payables Management in Microsoft Dynamics GP.
- The tax schedule ID for the debtor tax schedule is **AUSGST-DEBT**. This tax schedule ID contains the sales tax details. The debtor tax schedule is assigned to a debtor in Receivables Management in Microsoft Dynamics GP.
- The tax schedule ID for the Purchase/Sales tax schedule, for the Freight tax schedule, and for the Miscellaneous tax schedule is **AUSGST-GST**. These tax schedules contain the following tax details:

  - **AUSGST+GST**  
  - **AUSGST-EXP**  
  - **AUSGST-GST**

## Tax schedule comparisons

When the **AUSGST-CRED** tax schedule and the **AUSGST-GST** tax schedule are compared, the only tax detail in both schedules is the **AUSGST+GST** tax detail. The **AUSGST+GST** tax detail is a 10 percent purchasing GST. It's the default taxable purchases tax detail.

When the **AUSGST-DEBT** tax schedule and the **AUSGST-GST** tax schedule are compared, the only tax detail that is in both schedules is the **AUSGST-GST** tax detail. The **AUSGST-GST** tax detail is a 10 percent sales GST. It's the default taxable sales tax detail.

## What occurs if you change the incorrect tax schedule in a Payables Management transaction

Consider the following scenario. A user changes the tax schedule ID in the Payables Transaction Entry window from **AUSGST-CRED** to **AUSGST-FRE**. The **AUSGST-FRE** tax schedule ID contains the following tax details:

- **AUSGST+FRE**  
- **AUSGST-EXP**  
- **AUSGST-FRE**
When you compare the following tax schedule IDs, purchasing tax details don't appear in either tax schedule:

- The **AUSGST-FRE** tax schedule ID from the **Tax Schedule ID** field in the Payables Transaction Entry window
- The **AUSGST-GST** tax schedule ID from the **Purchase** field in the Payables Tax Schedule Entry window

Therefore, no tax will be calculated for the transaction. It's an expected behavior. However, when you open the Payables Tax Entry window by using the expansion button next to the **Tax Amount** field, no tax details appear. This behavior occurs because the transaction doesn't appear in the report if these tax details are processed by the Business Activity Statement (BAS). However, the expected result is that the transaction in the report is free of the GST.

The tax schedules that are created by the Australian Tax Information Setup Wizard fall into the following two groups:

- Goods and services tax schedules. These tax schedules are used for items in Sales Order Processing and in Purchase Order Processing in Microsoft Dynamics GP. These tax schedules are used in the setup for Payables Management and for Receivables Management. These tax schedules are the default tax schedules for the Purchase/Sales tax schedule, for the Freight tax schedule, and for the Miscellaneous tax schedule.
    For example, the **AUSGST-GST** tax schedule and the **AUSGST-FRE** tax schedule are Goods and Services tax schedules.
- Entity tax schedules. These tax schedules are associated with people or with companies that are buying (debtors) and with companies that are selling (creditors).
    For example, the **AUSGST-DEBT** tax schedule and the **AUSGST-CRED** tax schedule are entity tax schedules.

> [!NOTE]
> The Australian Tax Information Setup Wizard is enabled when the **Enable GST for Australia** check box is selected in the Company Setup Options window. To open the Company Setup Options window, follow these steps.
>
> 1. Use the appropriate method:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **Company**, and then click **Company**.
    - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Company**, and then click**Company**.
> 2. In the Company Setup window, click **Options**.

To work as expected, every transaction should have one tax schedule from the goods and services tax schedules group and one tax schedule from the entity tax schedules group. With Australian GST, the good or the service automatically dictates the tax that is used.

## Results of changing the correct tax schedule on a Payables Management transaction

To make a transaction entry transaction from the Payables Transaction Entry window free of the GST, open the Payables Tax Schedule Entry window, and then change the tax schedule ID in the **Purchase Tax Schedule** field from **AUSGST-GST** to **AUSGST-FRE**. However, you must leave the **AUSGST-CRED** tax schedule ID in the **Purchase Tax Schedule ID** field in the Payables Transaction Entry window.

It will calculate the tax as zero. However, the **AUSGST-FRE** tax schedule will be listed in the Payables Tax Entry window. It's the expected result. The transaction will appear in the BAS report.
