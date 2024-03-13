---
title: The RNI report shows shipment receipts
description: Describes an issue in which the Received/Not Invoiced report is incorrect for a partially received item or a partially returned item.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Received/Not Invoiced report shows shipment receipts in Microsoft Great Plains even though some of the items on the report have been returned

This article provides a solution to an issue where the Received/Not Invoiced report is incorrect for a partially received item or a partially returned item.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 897270

## Symptoms

In Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains, the Received/Not Invoiced report shows shipment receipts even though some of the items on the report have been returned. This behavior affects only shipments that were entered without a purchase order number.

## Workaround

To work around this issue, follow these steps:

1. Make sure that you have a restorable backup of the company database, and then test the backup in a TEST database.
2. In Microsoft SQL Query Analyzer, run the following statement against the company database to remove the shipment receipt document number from the Received/Not Invoiced report.

    ```sql
    update POP10500 set QTYMATCH = QTYSHPPD where POPRCTNM = '<DocNumber>'
    ```

    > [!NOTE]
    > \<DocNumber> is the shipment receipt document number that you want to remove from the Received/Not Invoiced report.

## Steps to reproduce the problem

1. Select **Transactions**, select **Purchasing**, and then select **Receiving Transaction Entry**.
2. Enter a shipment receipt without a purchase order number for Item 100XLG, and then enter 10 in the **Quantity Shipped** field. Use a unit cost of $1.00. Write down the shipment receipt document number that is listed in the **Receipt No.** field and the date, and then select **Post**.
3. Select **Transactions**, select **Purchasing**, and then select **Enter/Match Invoices**.
4. Enter an invoice receipt without a purchase order number for Item 100XLG, and then enter 7 in the **Quantity Invoiced** field. Use a unit cost of $1.00.

    > [!NOTE]
    > The shipment receipt document number is what you wrote down in step 2. Write down the invoice receipt number, and then select **Post**.
5. Select **Transactions**, select **Purchasing**, and then select **Returns Transaction Entry**.
6. Enter a return receipt by using the **Return** type without a purchase order for Item 100XLG, and then enter 3 in the **Quantity Returned** field. Use a unit cost of $1.00. Select the shipment receipt document number that you wrote down in step 2 for **Receipt No.**, and then select **Post**.
7. Select **Reports**, select **Purchasing**, and then select **Analysis**.
8. Select the **Received/Not Invoiced** report, and then select **New**.
9. Enter a name for the report option. In the **Ranges** list, select **Receipt Date**, enter the date from step 2, and then select **Insert**.
10. Select **Destination**, select a print destination for the report, and then select **OK**.
11. In the Purchasing Analysis Report Options window, select **Print**.

After you follow these steps, the shipment receipt document number that you wrote down in step 2 may appears on a report that has a **Qty Shipped** value of 10, a **Qty Invoiced** value of 7, and a **Qty Returned** value of 3. You don't expect the shipment receipt document number that you wrote down in step 2 to appear on the report.
