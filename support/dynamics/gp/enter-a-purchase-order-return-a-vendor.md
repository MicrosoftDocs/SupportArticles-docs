---
title: Enter a purchase order return to a vendor
description: How to enter a purchase order return to a vendor for an item that was sold in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to enter a purchase order return to a vendor for an item that was sold in Microsoft Dynamics GP

This article discusses how to enter a purchase order return to a vendor for an item that was sold in Purchase Order Processing in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862350

## Introduction

To enter a purchase order return to a vendor for an item that was sold in Purchase Order Processing in Microsoft Dynamics GP, follow these steps.

## More information

1. Use the appropriate method:

    - In Microsoft Dynamics GP, Purchase Order Returns is already installed. Go to step 2.
    - In Microsoft Business Solutions - Great Plains 8.0 and in earlier versions, make sure that Purchase Order Returns is installed.

    To do it, select **Transactions**, select **Purchasing**, and then select **Returns Transaction Entry**. If **Returns Transaction Entry** is unavailable, you must install Purchase Order Returns.

    For more information about how to install Purchase Order Returns, see [How To Install Purchase Order Returns](https://support.microsoft.com/help/857798).

2. In the **Type** list, select **Inventory w/Credit**.

    > [!NOTE]
    > The transaction is now an inventory transaction because it has been returned through Sales Order Processing.

    If you select **Return w/Credit**, you won't see the receipt.
3. In the **Vendor Doc. No.** field, type the vendor document number.
4. In the **Vendor ID** field, type the vendor ID.
5. In the **Vendor Item** field, type the number of the item that you want to return.
6. Select the **lookup** button next to the **Receipt No.** field, and then double-click the receipt that you want to return.

    The **Inventory Type** field displays **RETURN**. The **Receipt Number** field displays the Sales Order Processing return number.
7. In the **Quantity Available** field, type the quantity that you want to be returned.
8. In the **Unit Cost** field, change the cost if this procedure is required.
9. Select **Post**, and then print the posting journals.

When you complete this process, a credit voucher is created in Payables Management in Microsoft Dynamics GP. The credit voucher will have a document type of **Return**. You can apply this credit to the original vendor invoice.
