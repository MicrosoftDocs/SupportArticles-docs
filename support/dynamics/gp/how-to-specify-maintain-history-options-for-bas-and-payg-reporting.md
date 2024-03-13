---
title: How to set Maintain History options for BAS and PAYG reporting
description: Explains how to specify Maintain History options in Microsoft Dynamics GP 9.0. And also contains steps to report the correct information for Business Activity Statement (BAS) and Pay As You Go (PAYG) reporting.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to specify Maintain History options for Business Activity Statement and Pay As You Go reporting

This article introduces the Business Activity Statement (BAS) and Pay As You Go (PAYG) reporting that is used in Australia. The article also contains detailed steps about how to maintain detailed history data in the Australian version of Microsoft Dynamics GP 9.0 to report the correct information for BAS and PAYG reporting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929214

The BAS is the form that is used in Australia to report Goods and Services Tax (GST) figures to the Australian Taxation Office (ATO). To file the BAS electronically through the Internet, you can use the Electronic Commerce Interface (ECI) software that is provided by the ATO. You must report amounts that are withheld from vendor payments as PAYG withholding annually, in the prescribed format as PAYG Vendor Summaries. The BAS and PAYG reporting dictionary lets you generate all the required ATO reports and communicate with the ECI software.

For BAS and PAYG reporting, detailed history data must be maintained to report the correct information. This data includes tax records. The data must be maintained because BAS and PAYG reporting obtains tax information from the originating transactions that may have already been moved to history. If the history isn't maintained, the removed transactions are included, and incorrect figures are reported.

To maintain detailed history data in the Australian version of Microsoft Dynamics GP 9.0, we recommend that you specify the following Maintain History options:

1. In the Debtor Maintenance Options window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Cards** menu, point to **Sales**, select **Debtor**, and then select **Options**.
   2. Select the following check boxes:
      - **Calendar Year**
      - **Financial Year**
      - **Transaction**
      - **Distribution**

2. In the Debtor Class Setup window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **Sales**, and then select **Debtor Class**.
   2. Select the following check boxes:
      - **Calendar Year**
      - **Financial Year**
      - **Transaction**
      - **Distribution**
3. In the Creditor Maintenance Options window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Cards** menu, point to **Purchasing**, select **Creditor**, and then select **Options**.
   2. Select the following check boxes:
      - **Calendar Year**
      - **Financial Year**
      - **Transaction**
      - **Distribution**
4. In the Creditor Class Setup window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **Purchasing**, and then select **Creditor Class**.
   2. Select the following check boxes:
      - **Calendar Year**
      - **Financial Year**
      - **Transaction**
      - **Distribution**
5. In the General Ledger Setup window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **Financial**, and then select **General Ledger**.
   2. Select the following check box:
      - **Transactions**
6. In the Sales Order Processing Setup window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **Sales**, and then select **Sales Order Processing**.
   2. Select the following check box:
      - **Invoice/Return**
7. In the Invoicing Setup window, specify the **Maintain History** options. To do this, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **Sales**, and then select **Invoicing**.
   2. Select the following check box:
      - **Transaction Detail**
8. In the Purchase Order Processing Setup window, specify the **Maintain History** options. To do this, follow these steps:
   1. On the **Tools** menu, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.
   2. Select the following check box:
      - **Receipt**
