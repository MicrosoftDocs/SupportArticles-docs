---
title: Reduce a customer's outstanding credit balance when you have Receivables Management and Payables Management registered in Microsoft Dynamics GP
description: Describes steps to reduce a customer's outstanding credit balance when you have Receivables Management and Payables Management registered in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to reduce a customer's outstanding credit balance when you have Receivables Management and Payables Management registered in Microsoft Dynamics GP

This article describes how to reduce a customer's outstanding credit balance when you have the following modules registered:

- Receivables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains
- Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952377

## Introduction

If you have Receivables Management and Payables Management registered, you can have a customer who is also a vendor. If you owe a vendor and if the vendor also owes you as a customer, you can reduce the customer's outstanding credit balance.

For example, customer A buys item B from you. Customer A is also vendor A. You buy item C from vendor A. Customer A owes you 100 dollars for item B. Additionally, you owe vendor A 90 dollars for item C.

Instead of paying the vendor and accepting a payment from the customer, you can reduce the customer's outstanding credit balance by following these steps:

## Steps to reduce the customer's outstanding credit balance

1. Create a credit memo for the Receivables Management invoice of the customer who is also a vendor by following these steps:
    1. Click **Transactions**, point to **Sales**, and then click **Transaction Entry**.
    1. In the **Document Type** list, click **Credit Memo**.
    1. In the **Number** field, keep the default document number.
    1. In the **Customer ID** field, enter the customer identifier (ID).
    1. In the **Credit Amount** field, enter the credit amount.
        > [!NOTE]
        > The credit amount is the amount that you want to reduce from the amount that you owe the vendor.
    1. Note the CRMEMO account number that you use.
    1. Click **Post**.
1. Create a credit memo for the Payables Management invoice of the vendor who is also a customer by following these steps:
    1. Click **Transactions**, point to **Purchasing**, and then click **Transaction Entry**.
    1. In the **Document Type** list, click **Credit Memo**.
    1. In the **Vendor ID** field, enter the vendor ID.
    1. In the **Document Number** field, enter the document number.
    1. In the **Credit Memos** field, enter the credit memo amount.
        > [!NOTE]
        > The credit memo amount is the credit amount that you posted in step 1.
    1. Click **Distributions**.
    1. Change the PURCH account number to the CRMEMO account number that you noted in step 1f.
        > [!NOTE]
        > When the PURCH account number is updated, Microsoft Dynamics GP backs out the CRMEMO account number that is posted in Receivables Management.
    1. Click **OK**.
    1. Click **Post**.

> [!NOTE]
> If you have Customer/Vendor Consolidations in Microsoft Dynamics GP registered, Microsoft Dynamics GP can process these steps automatically. Using Customer/Vendor Consolidations, you can consolidate balances in Payables and Receivables for a single company when you work with that company as both a Customer and a Vendor. You can assign relationships between existing Customers and Vendors and then apply open debit and credit documents against each other to consolidate the current balances.
