---
title: Troubleshoot issues with online store transaction creation in Headquarters
description: Provides solutions to failures that occur during online store transaction creation in Dynamic 365 Commerce.
author: bstorie
ms.author: brstor
ms.date: 07/27/2023
ms.custom: sap:Order management\Issues with order creation in e-commerce storefront
---
# Troubleshoot issues with the online store transaction creation process

A transaction that's created in the e-Commerce site is pulled back to Commerce Headquarters through the P-job. Then, you run the "Synchronize Orders" process to make the transaction a sales order in Commerce Headquarters. However, the "Synchronize Orders" process fails. This article lists the most common causes and provides resolutions, respectively. 
 
## Prerequisites

1. Go to **Retail and Commerce** > **Inquiries and reports** > **Commerce data Exchange** > **Upload Sessions**, and check if the information about upload sessions is shown as expected.
2. Go to **Retail and Commerce** > **Retail and Commerce IT** > **Synchronize Orders**, and make sure that you have synchronized the orders recently.

## Troubleshooting checklist

### Method 1: Check the order synchronization status

Go to **Retail and Commerce** > **Inquiries and reports** > **Order synchronization status**:

- If the order is shown as "failed" with an error message, see the [Error messages](#error-messages) section in the article.
- If the order is shown as "not synchronized," synchronize the order as described in step 2 of the **Prerequisites** section in this article, and schedule the "Synchronize orders" job to run periodically. 
- If the order isn't shown in this report, it indicates an issue with the Commerce Data Exchange (CDX) upload process. To solve this issue, go to **Retail and Commerce IT** > **Distribution Schedule**, select and run the P-0001 job.

### Method 2: Use the transaction or order confirmation number

1. Go to **Retail and Commerce** > **Inquiries and reports** > **Online store transactions**.
2. Search for the transaction. You can filter by date, or add a channel reference ID to the filter using the order confirmation number.
If the order isn't shown in this report, it indicates an issue with the CDX upload process. To solve this issue, go to **Retail and Commerce IT** > **Distribution Schedule**, select and run the P-0001 job.

## Error messages

### Error 1: Number sequence \<number sequence name> has been exceeded

When you create sales orders, Headquarters generates new transactions, some of which use number sequences to generate IDs. When a number sequence runs out of numbers, you must fix it, or create a new number sequence to use.

#### Solution

To fix this issue, you need to find the failing number sequence and replace it with a new number sequence. Here are the steps:

1. Most number sequences can be found in **Organization administration** > **Number sequences** > **Number sequences**.
2. Depending on the error, you may also need to check these specific locations:

     - **Accounts Receivable** > **Setup** > **Accounts receivable parameters -  Number Sequences tab**
     - **Retail and Commerce** > **Headquarters setup** > **Parameters** > **Commerce Parameters  - Number Sequences tab**

3. Once the number sequence is corrected, run the "Synchronize Orders" job again.

### Error 2: Account structure \<Account structure>, for the combination \<combination number>, is not valid for ledger Corporate Main Account Shared

You may receive an error that resembles the following one:

```output
Posting results for journal batch number 0009656328 Voucher ARP-000959899 1.00 for voucher ARP-000959899 in company usrt will be posted as an overpayment or underpayment
Posting results for journal batch number 0009656328 Voucher ARP-000959899 Voucher ARP-000959901 Account structure Account structure, for the combination 618160, is not valid for ledger Corporate Main Account Shared.
Posting results for journal batch number 0009656328 Voucher ARP-000959899 Voucher ARP-000959901 Reported from company accounts usrt
Posting results for journal batch number 0009656328 Voucher ARP-000959899 Posting has been canceled.
```

#### Solution

To fix this issue, you must check the account structure. For more information, see [Configure account structures]( /dynamics365/finance/general-ledger/configure-account-structures).

After you fix the account structure, run the "Synchronize Orders" job again.

### Error 3: Fiscal Period does not exist

To fix this issue, you must check the existing fiscal periods and create new ones if needed. For more information, see [Fiscal calendars, fiscal years, and periods]( /dynamics365/finance/budgeting/fiscal-calendars-fiscal-years-periods).

## More information

You can use the [Edit and Audit](/dynamics365/commerce/edit-order-trans) functionality to mark a transaction as void. This will prevent the "Synchronize order" flow from processing the transaction.
