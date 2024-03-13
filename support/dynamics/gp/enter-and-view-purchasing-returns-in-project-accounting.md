---
title: Enter and view purchasing returns in Project Accounting in Microsoft Dynamics GP
description: Describes how to enter and view purchasing returns in Project Accounting in Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: ppeterso
ms.date: 03/13/2024
---
# How to enter and view purchasing returns in Project Accounting in Microsoft Dynamics GP

This article describes how to enter and view purchasing returns in Microsoft Dynamics GP when you use Project Accounting. The article lists the inquiry windows that you can use to view the posted purchasing return transactions.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961567

## Introduction

Purchasing returns can be entered for both inventory items and non-inventory items. You can enter the following kinds of purchasing returns:

- **Return**  
- **Return w/Credit**  
- **Return from Project**

**Return w/Credit** transactions and **Return from Project** transactions update the Payables Management module. A **Return** transaction does not update the Payables Management module.

## How to enter purchasing returns for inventory items

- Enter a purchasing return for a Shipment transaction in the Returns Transaction Entry window. To open this window, point to **Purchasing** on the **Transactions** menu, and then click **Returns Transaction Entry**. In the **Type** list, click **Return**.

- Enter a purchasing return for a Shipment/Invoice transaction in the Returns Transaction Entry window. To open this window, point to **Purchasing** on the **Transactions** menu, and then click **Returns Transaction Entry**. In the **Type** list, click **Return w/ Credit**.

- Enter a purchasing return for an Inventory Transfer transaction in the Inventory Transfer Entry window. To open this window, point to **Project** on the **Transactions** menu, and then click **Inventory Transfer**. In the **Type** list, click **Return**.

- If you have already posted the Inventory Transfer transaction, enter a purchasing return for a Shipment/Invoice transaction in the Returns from Project Entry window. To open this window, point to **Project** on the **Transactions** menu, and then click **Returns from Project Entry**.

- Enter a purchasing return for an **Invoice** transaction on a drop ship purchase order in the Returns from Project Entry window. To open this window, point to **Project** on the **Transactions** menu, and then click **Returns from Project Entry**. Enter a Returns from Project transaction when you want to return the item directly to the vendor.

- Enter a purchasing return for an Invoice transaction on a drop ship purchase order in the Inventory Transfer Entry window. To open this window, point to **Project** on the **Transactions** menu, and then click **Inventory Transfer**. Enter a Return transaction when you want to keep the inventory item in your inventory stock so that the inventory item can be used again later.

## How to enter purchasing returns for non-inventory items

- Enter a purchasing return for a Shipment transaction in the Returns Transaction Entry window. To open this window, point to **Purchasing** on the **Transactions** menu, and then click **Returns Transaction Entry**. In the **Type** list, click **Return**.

- Enter a purchasing return for a Shipment/Invoice transaction in the Returns Transaction Entry window. To open this window, point to **Purchasing** on the **Transactions** menu, and then click **Returns Transaction Entry**. In the **Type** list, click **Return w/ Credit**.

- Enter a purchasing return for an Invoice transaction on a drop ship purchase order in the Returns from Project Entry window. To open this window, point to **Project** on the **Transactions** menu, and then click **Returns from Project Entry**.

## How to view the purchasing return transactions for inventory and non-inventory items

Use the Purchases Materials Inquiry window to view the following transactions:

- Return transactions that are entered in the Returns Transaction Entry window. The **Type** field for the document displays **RET**.

- Return w/Credit transactions that are entered in the Returns Transaction Entry window. The **Type** field for the document displays **RET/CR**.

    To open the Purchases Materials Inquiry window, point to **Project** on the **Inquiry** menu, point to **PA Transaction Documents**, and then click **Purchases Materials.**

Use the Inventory Transfer Inquiry window or the Inventory Transfer - Detail Inquiry window to view the following transactions:

- Return transactions that are entered in the Inventory Transfer Entry window. The **Type** field for the document displays **Return**.

- Return from Project transactions that are entered in the Returns from Project Entry window. The **Type** field for the documents displays **Return From Project**.

    To open the Inventory Transfer Inquiry window, point to **Project** on the **Inquiry** menu, point to **PA Transaction Documents**, and then click **Inventory Transfer.**

    To open the Inventory Transfer - Detail Inquiry window, point to **Project** on the **Inquiry** menu, point to **PA Transaction Documents**, and then click **Inventory Transfer - Detail**.
