---
title: How to troubleshoot Online store transaction creation failures in HQ
description: Providies guidance on how to troubleshooting D365 Commerce Online store transaction creation failures. 
author: bstorie
ms.author: brstor
ms.topic: troubleshooting-general 
ms.date: 07/21/2023
---
# The following provides guidance on how to troubleshoot the Online store transaction creation process

After a transaction is created on an Ecommerce website it is pulled back to Commerce HQ via the P-job.  However for that transaction to become a Sales Order inside Commerce HQ the Synchronize Orders process also needs to be executed. The Synchronize Order process can fail for a number of reasons, the following articles lists some of the most common causes.   


## Prerequisites
1) Confirm the Upload sessions are showing as applied in (Retail and Commerce > Inquiries and reports > Commerce data Exchange > Upload Sessions)
2) Make sure you recently ran the Synchronize Orders (Retail and Commerce > Retail and Commerce IT > Synchronize Orders) 

## Troubleshooting check list

### Method 1: Check the order(s) synchronization status
Go to **Retail** and **Commerce** > **Inquiries** and **reports** > **Order synchronization status**

  - If the order is showing as failed, check the error message and proceed to the cause/solution section in the article. 
  - If the order is showing as not synchronized, make sure you ran Synchronize Orders in step 2 of the pre-requisites, and schedule the job to run periodically. 
  - If the order is not showing on this report, it indicates an issues with the CDX upload process.  Go to **Retail** and **Commerce IT** > **Distribution Schedule** > **Select** and **execute** the **P-0001 job**

### Method 2: If you know the missing transaction/order confirmation number
  1. Go to **Retail** and **Commerce** > **Inquiries** and **reports** > **Online store transactions** 
  1. **Search** the **transaction**. You may filter by "Date" or if you have the order confirmation number, add "Channel reference ID" to the filter.

     - If the order is not showing on this report, it indicates an issues with the CDX upload process.  Go to **Retail** and **Commerce IT** > **Distribution Schedule** > **Select** and **execute** the **P-0001 job**

------------------------------------------------------------------------

## Error 1: Number sequence <number sequence name> has been exceeded.
When creating sales orders, HQ generates new transactions and some of them use number sequences to generate ids.
When a number sequence runs out of numbers we must fix it, or create a new number sequence to be used.
To fix it, you need to find the number sequence that is failing and replace it with a new number sequence.

### Solution: Update Numbersequence to use a new value
1. Most number sequences can be found in the following path > Modules > **Organization administration > Number sequences > Number sequences**
2. Depending on the error you may need to also look in these specific locations:
    - Modules > **Accounts Receivable > Setup > Accounts receivable parameters -  Number Sequences tab**
    - Modules > **Retail and Commerce > Headquarters setup > Parameters > Commerce Parameters  - Number Sequences tab**
3. Once the number sequence has been corrected run the Synchronize Orders job again 


## Error 2: Account structure Account structure, for the combination <combination number>, is not valid for ledger Corporate Main Account Shared.
This usually comes in a format like this:
```
Posting results for journal batch number 0009656328 Voucher ARP-000959899 1.00 for voucher ARP-000959899 in company usrt will be posted as an overpayment or underpayment
Posting results for journal batch number 0009656328 Voucher ARP-000959899 Voucher ARP-000959901 Account structure Account structure, for the combination 618160, is not valid for ledger Corporate Main Account Shared.
Posting results for journal batch number 0009656328 Voucher ARP-000959899 Voucher ARP-000959901 Reported from company accounts usrt
Posting results for journal batch number 0009656328 Voucher ARP-000959899 Posting has been canceled.
```

### Solution:  
To fix this you must review the account structures. For guidance review our official documentation [here](https://docs.microsoft.com/en-us/dynamics365/finance/general-ledger/configure-account-structures).  
After fixing the account structures, run the Synchronize Orders job again. 

## Error 3: Fiscal Period does not exist
You must check the existing fiscal periods and create new ones if needed. For guidance review our official documentation [here](https://learn.microsoft.com/en-us/dynamics365/finance/budgeting/fiscal-calendars-fiscal-years-periods)



## Advanced troubleshooting and data collection
You can use the "Edit and Audit" functionality to mark the transactions as voided.  This will stop the Synchronize order flow from processing the transaction. For more information about using Edit and Audit review our official documentation [here](https://learn.microsoft.com/en-us/dynamics365/commerce/edit-order-trans)
