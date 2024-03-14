---
title: How to handle EFT/ACH files with Bank Reconciliation
description: How to handle EFT/ACH files with Bank Reconciliation in Microsoft Dynamics GP. This includes EFT/ACH files from EFT for Payables Management, EFT for Receivables Management, and ACH for Payroll Direct Deposit.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Bank Reconciliation
---
# How to handle EFT/ACH files with Bank Reconciliation in Microsoft Dynamics GP

This article includes information on how to handle EFT/ACH files with Electronic Reconcile for Bank Reconciliation in Microsoft Dynamics GP. This includes EFT/ACH files from EFT for Payables Management, EFT for Receivables Management, and ACH for Payroll Direct Deposit.

_Applies to:_ &nbsp; Microsoft Dynamics SL Bank Reconciliation, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2867547

## Cause

By design. Check' types will automatically match in the Electronic Reconcile process using the check number, check date and check amount. However, the PM EFT file and Payroll DD file don't include the check number as a standard field to send to the bank.

## More information

Below are the options for handling EFT/ACH transactions with Bank Reconciliation:

- EFT FOR PAYABLES MANAGEMENT (EFT Payments)

  EFT transactions are posted and assigned a check number in Microsoft Dynamics GP and this check number appears in bank Reconciliation. However, this check number isn't submitted to the bank on a standard EFT file format, and so, in turn, isn't included on the bank statement. So, when doing an Electronic Reconcile, there's no check number on the imported bank transactions to match to Bank Rec, and so these EFT payments remain unreconciled. They must be manually marked as cleared in the Select Bank Transactions window in Bank Reconciliation.

  If you use unique check number for EFT payments such as a check number with a prefix of *EFT*, instead of regular check numbers, these payments will stand out from regular checks in the Select Bank Transactions window in Bank Reconciliation and can be easily cleared.

- ACH FOR PAYROLL DIRECT DEPOSIT (Payroll DD/ACH)

  Payroll Direct Deposit transactions are posted and assigned a check number in Microsoft Dynamics GP and this check number appears in bank Reconciliation. However, this check number isn't submitted to the bank on a standard ACH file format, and so, in turn, isn't included on the bank statement. So, when doing an Electronic Reconcile, there's no check number on the imported bank transactions to match to Bank Rec, and so these individual DD payments remain unreconciled. They must be manually marked as cleared in the Select Bank Transactions window in Bank Reconciliation. Since the check number in Bank Rec begins with the prefix *DD*, they stand out and can be easily cleared.

  We recommend going to the Direct Deposit Setup and mark the option for Update Bank Reconciliation with **One Total Amount for all Employee Earnings Statements**. You may also want to see if the bank will put the Direct Deposit file total as one lump sum amount on the bank statement. Then you can simply clear this amount in lump sum in the Select Bank Transactions window in Bank Reconciliation.

- EFT FOR RECEIVABLES MANAGMENT (EFT Deposits)

  Usually the total for the RM EFT file is included in one lump sum deposit in Bank Rec, and so can be cleared with the lump sum Deposit amount from the bank statement. (Deposits clear by date and amount, and so should automatically be matched using Electronic Reconcile.)
