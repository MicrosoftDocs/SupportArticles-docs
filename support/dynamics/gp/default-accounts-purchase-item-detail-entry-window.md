---
title: The default accounts in the Purchase Item Detail Entry window
description: This article describes information about the default accounts in the Purchase Item Detail Entry window in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# Information about the default accounts in the Purchase Item Detail Entry window in Microsoft Dynamics GP

This article describes information about the default accounts in the Purchase Item Detail Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857766

## Introduction

This article describes how the accounts default in the Purchasing Item Detail Entry window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

## The item in the Purchasing Item Detail Entry window is an inventoried item

- The value in the **Inventory Account** field in the Purchasing Item Detail Entry window defaults from the **Inventory** field in the Item Account Maintenance window. To open this window, point to **Inventory** on the **Cards** menu, click **Item**, and then click **Accounts**.

- If the **Inventory** field in the Item Account Maintenance window contains no account number, the inventory account number defaults from the **Inventory Control** field in the Posting Account Setup window. To open this window:

  In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Posting**, and then click Po **s** ting **Accounts**.  In the Display List, click **Inventory**.

- If no inventory account number exists in either the Item Account Maintenance window or the Posting Account Setup window, the **Inventory Account** field in the Purchasing Item Detail Entry window is empty.

## The item in the Purchasing Item Detail Entry window is a noninventoried item

- The value in the **Purchases Account** field in the Purchasing Item Detail Entry window defaults from the **Purchases** field in the Vendor Account Maintenance window. To open this window, point to **Purchasing** on the **Cards** menu, click **Vendor**, and then click **Accounts**.

- If the **Purchases** field in the Vendor Account Maintenance window contains no account number, the purchases account number defaults from the **Purchases** field in the Posting Account Setup window. To open this window:

   In Microsoft Dynamics GP 10.0, point to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Posting**, and then click Po **s** ting **Accounts**.  In the Display List, click **Inventory**.

- If no purchases account number exists in either the Vendor Account Maintenance window or the Posting Account Setup window, the **Purchases Account** field in the Purchasing Item Detail Entry window is empty.

## The item in the Purchasing Item Detail Entry window is a drop-ship item

- The value in the **Drop-Ship Account** field in the Purchasing Item Detail Entry window defaults from the **Drop Ship Items** field in the Item Account Maintenance window. To open this window, point to **Inventory** on the **Cards** menu, click **Item**, and then click **Accounts**.

- If the **Drop Ship Items** field in the Item Account Maintenance window contains no account number, the drop-ship account defaults from the **Drop Ship Items** field in the Posting Account Setup window. To open this window:

  In Microsoft Dynamics GP 10.0, point to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Posting**, and then click Po **s** ting **Accounts**.  In the Display List, click **Inventory**.

- If no drop-ship account number exists in either the Item Account Maintenance window or the Posting Account Setup window, the Drop Ship Account in the Purchasing Item Detail Entry window is empty.

> [!NOTE]
> When you enter a drop-ship order for a noninventoried item, the **Drop Ship Account** field in the Purchasing Item Detail Entry window defaults from the **Drop Ship Items** field in the Posting Account Setup window. In the **Display** list, click **Purchasing**.

## Project Accounting information

- In versions that are earlier than Microsoft Dynamics GP 10.0 Service Pack 3

  If Project Accounting is registered and if a value exists in the **Project Number** field and in the **Cost Cat. ID** field in the Purchasing Item Detail Entry window, the account information defaults as mentioned in the previous sections. Because a value exists in the **Project Number** field and in the **Cost Cat. ID** field in the Purchasing Item Detail Entry window, noninventoried items are not posted to the account that is displayed in the **Purchasing Account** field for the later receiving transaction.

- In Microsoft Dynamics GP 10.0 Service Pack 3 and in later versions

  Starting with Microsoft Dynamics GP 10.0 Service Pack 3, changes were made to the account that defaults in the Purchasing Item Detail Entry window to show a truer picture of what account is used in the receiving process. Consider the following scenarios for noninventoried items:

- A **Cost Plus** project type or a **Fixed Price** project type displays the **Work in Process (WIP)** account from the source window.

- A **Time and Materials** project type that has a **When Billed** value in the **Accounting Method** field displays the **Work in Process (WIP)** account from the source window.

- A **Time and Materials** project type that has a **When Performed** value in the **Accounting Method** field displays the **Cost of Goods Sold** account from the source window.

- A **Time and Materials** project type that has the budget set up with a **Bill Type** of **Non-billable** or **No Charge** displays the **Cost of Goods Sold** account from the source window.

- A **Time and Materials** project type that has a **When Billed** value in the **Accounting Method** field and where the **WIP** account is sourced to **None** displays the **Cost of Goods Sold** account from the source window.

> [!NOTE]
> To determine the source window, follow these steps:

1. On the **Cards** menu, point to **Project**, and then click **Project**.
2. In the Project Maintenance window, click **Budget**.
3. Click the cost category from the transaction, and then click the **Cost Category** expansion window.
4. In the Budget Detail Entry window, click **Accounts** to review the source that is selected. If no account exists in the source window, the account defaults from the Posting Account Setup window.
5. In the **Display** list, click **Project**.
