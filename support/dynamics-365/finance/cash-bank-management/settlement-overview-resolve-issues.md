---
# required metadata

title: Troubleshoot issues with transactions that can't be settled
description: Describes how to resolve issues with transactions that can't be settled in Microsoft Dynamics 365 Finance.
author: twheeloc 
ms.date: 11/30/2023
ms.prod: 
ms.technology: 

# optional metadata

ms.search.form: CustOpenTrans, LedgerJournalTransCustPaym, LedgerJournalTransVendPaym, VendOpenTrans
# ROBOTS: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
ms.collection: get-started
ms.assetid: 0968fa71-5984-415b-8689-759a0136d5d1
ms.search.region: Global
# ms.search.industry: 
ms.author: twheeloc
ms.search.validFrom: 2018-10-31
ms.dyn365.ops.version: 8.1
---
# Troubleshoot issues with transactions that can't be settled

This article provides a resolution for an issue where you can't settle transactions in Microsoft Dynamics 365 Finance.

## Symptoms

Sometimes, you can't settle transactions because another activity is currently processing the document. If you try to settle the transactions, an error occurs because those transactions are being used.

## Cause

Transactions are marked for settlement either when vendor invoices are being paid or when customers pay their open invoices. Occasionally, these invoices might already be marked for settlement. Therefore, users can't select them for payment. The invoices might be marked by another customer payment journal, sales order, vendor payment journal, or purchase order in the current legal entity or another legal entity.

## Resolution

To fix this issue, you can use the **Marked transaction details** page to find transactions that are marked for settlement and identify any other processes that are accessing them.

> [!NOTE]
> Before you can use this feature, it must be turned on in your system. Administrators can use the **Feature management** workspace to check the status of the feature and turn it on if it's required. There, the feature is listed in the following way:
>
> - **Module**: Cash and bank management
> - **Feature name**: Marked transaction detail form

- If a transaction is blocked for settlement when you enter a customer payment, go to **Accounts receivable** > **Periodic tasks** > **Customer marked transaction details** to open the **Customer marked transaction details** page.

  To quickly identify where a transaction is blocked, you can set any of these selection parameters: **Customer account**, **Voucher**, **Date**, or **Invoice**. If you don't set any selection parameters, the system shows all blocked documents from the current company or another company that you select. After the transaction that has been blocked for settlement is identified, you can select it and then select **Unmark selected transactions**. The selected transaction is then removed from any journal that includes it. However, the document isn't removed from the other location. Only the marking information is removed from that journal.

- If a transaction is blocked for settlement when you enter a vendor payment, go to **Accounts payable** > **Periodic tasks** > **Vendor marked transaction details** to open the **Vendor marked transaction details** page.

  To quickly identify where a transaction is blocked, you can set any of these selection parameters: **Vendor account**, **Voucher**, **Date**, or **Invoice**. If you don't set any selection parameters, the system shows all blocked documents from the current company or another company that you select. After the transaction is identified, you can select it and then select **Unmark selected transactions** to fix the blocking issue. The selected transaction is then removed from any other journal where it's selected. However, the document isn't removed from the other location. Only the marking information is removed from that journal.

- To identify all blocked documents, go to **Accounts receivable** > **Periodic tasks** > **All marked transaction details** or **Accounts payable** > **Periodic tasks** > **All marked transaction details** to open the **All marked transaction details** page.

  To quickly identify where a transaction is blocked, you can set any of these selection parameters: **Customer account**, **Vendor account**, **Voucher**, **Date**, or **Invoice**. If you don't set any selection parameters, the system shows all blocked documents from the current company or another company that you select. After the transaction is identified, you can select it and then select **Unmark selected transactions** to fix the blocking issue. The selected transaction is then removed from any other journal where it's selected. However, the document isn't removed from the other location. Only the marking information is removed from that journal.
