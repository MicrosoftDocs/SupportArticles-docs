---
title: How payments that have zero are treated
description: Describes that remittances are printed for payments that have amounts of zero in Payables Management.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# How payments that have amounts of zero are treated in Payables Management in Microsoft Dynamics GP

This article describes how payments that have an amount of zero are treated in Payables Management when you print a batch of check in Microsoft Dynamics GP 9.0 and Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861276

## Introduction

This article contains step-by-step information about how to remove zero amount payments.

## Reasons about why remittance will be printed for payments that have an amount of zero

When you open invoices for the vendor before you create the check for payment, Microsoft Dynamics GP will automatically apply remaining unapplied payments, credit memos.
After the documents are automatically applied, some vendors may have a net amount of zero. Microsoft Dynamics GP will not use a check number, but instead each document will be assigned a document number that begins as "REMITxxxxxxx" and print a remittance to show the vendor what documents are applied.

> [!NOTE]
>
> - You can't print a check for a non-EFT payment that has a zero amount.
> - Although the **Print Previously Applied Documents on Remittance** check box is clear in the Payables Management Setup window, the zero amount REMIT documents will still be created. Previously applied information includes documents that are applied to each other before you create the check and after you issue the last check for the vendor.

When you print a batch of checks, remittance forms will be printed for any payments in the batch that have an amount of zero.

On the first remittance for a payment that has an amount of zero, the **Check Number** field is set to **REMIT000000000000001**. This number automatically increments for each successive remittance.

### Example

Consider the following scenario. You have the following transactions for the following vendors:

- Vendor1:
  - Invoice1: 100.00
  - Invoice4: 130.00

- Vendor2:
  - Invoice2: 23.00
  - Vendor Return1: 23.00
- Vendor3:
  - Invoice3: 55.00
  - Credit Memo1: 10.00

When you create a check batch and print an edit list, the following amounts appear for the vendors:

- Vendor1: 230.00
- Vendor2: 0.00
- Vendor3: 45.00

When you print the check batch, no check is printed for Vendor2. When the checks for vendor1 and Vendor3 are printed, the Process window opens automatically to have you printed the remittance report before you post the check batch.

After you print the checks, the program prints a remittance for Vendor2. You can send a remittance to a vendor to explain why you won't send a payment to the vendor. In this example, you can send a remittance to Vendor2 to explain that Invoice2 and Vendor Return1 cancel one another out.

> [!NOTE]
> A remittance isn't a check. A remittance doesn't use a check number. After you print the remittance, you can post checks. The next check batch won't include Vendor2 unless new documents are entered for Vendor2.

## How to prevent a remittance from printing

To do it, use one of the following options.

### Option 1: Use the Edit Check window to exclude the applied documents in this check batch

> [!NOTE]
> These applied documents will be displayed again in your next check batch.

1. Open the Edit Checks window.

2. Select the batch ID and the vendor to who you want to send the remittance.

3. Select **Apply**.

4. Select to clear the check boxes for the documents that are applied to the vendor to whom you're sending the remittance.

### Option 2: Follow steps 3 and step 4 from the Knowledge Base (KB) article 855957

> [!NOTE]
> This option would remove all zero dollar checks in the table so that they aren't included in this check batch or any future check batch.

For more information, see [How to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP](https://support.microsoft.com/help/855957).

## Reasons that remittances aren't posted to Bank Reconciliation

- Remittances for payments that have a number of zero use REMIT numbers and don't use the check number sequence defined in the checkbook. These REMIT numbers have a prefix that differs from the prefix of check numbers for other remittances.

- Remittances for payments that have an amount of zero don't use check stubs.
