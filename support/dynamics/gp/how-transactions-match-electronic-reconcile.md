---
title: Match transactions in Electronic Reconcile
description: Introduces the criteria that Electronic Reconcile uses to match transactions in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How transactions are matched in Electronic Reconcile for Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851279

Here are the steps that Electronic Reconcile goes through to match transactions from the bank's download file and Microsoft Dynamics GP:

1. Electronic Reconcile reviews the CM Transaction table (CM20200), and copies the entire table into a temp table.
2. It then sets a date range in this temp table based on the **Cutoff Date** used in the **Reconcile Bank Statements** window.
3. Once it has the range of downloaded transactions, it then sets another range in the temp table based on **Transaction Amount**, and then on **Transaction Type** (**check**, **deposit**, **adjustment**, and so on.)
4. It then reviews the RECOND column (CM20200) to see if the transaction has already been reconciled or not. If not, then Electronic Reconcile reviews what type (CMTRXTYPE - CM20200) it is and tries to match the transaction based on the following criteria for each type.

## For checks, credit cards, and EFT transactions

To match, all these criteria must be true:

- The **Amount** matches.
- The **Check Number** matches.

   > [!IMPORTANT]
   > The leading zeroes on the front of a check do not matter. Microsoft Dynamics GP strips them off and the matching process ignores any leading zeroes.

   > [!NOTE]
   > If the bank file has NUMBERS in the check number field, then the system will try to match that number to the check number in Microsoft Dynamics GP, and it must match in order to automatically get marked as cleared. However, if the bank file has LETTERS in the check number field (such as the vendor's name for EFT payments) then the Microsoft Dynamics GP code will skip over the check number and still try to match based on the other fields (date and amount) so it may still match.

- The transaction is a check type in Microsoft Dynamics GP. (that is, the record has a CMTRXYPE = '3' in the CM20200 SQL table.)
- The **CHECKBOOK ID** on the check in the CM20200 must be the checkbook ID you're working with in the **Reconcile** window.
- It hasn't already been reconciled. (RECOND = 0 in CM20200 table.)
- It hasn't been voided. (VOIDED = 0 in CM20200 table.)
- The **Transaction Code** on the bank source file is mapped in the CODES ENTRY as a Check Paid in the configurator file. (Usually checks have code 475, which should already be mapped by default in Microsoft Dynamics GP 2013, but you may have to double-check any other codes used as not all codes are mapped by default for you.) Several codes are defaulted in for you. Verify the code you need is listed and select **Save** in this window to activate/cache them.
- The **Bank Cleared Date** in the bank file must be after the **Check Issue Date** in Microsoft Dynamics GP. The system won't clear a check on date that is before it was actually issued in Microsoft Dynamics GP. (For example: If the Bank cleared date comes in as 8/20/2016, and the check date in Microsoft Dynamics GP is 8/22/2016, the system won't match this check for you. It doesn't make sense that the check was cashed on a date prior to when it was actually issued in Microsoft Dynamics GP. The check must be manually cleared in the reconciliation.)

## For deposits

To match, all these criteria must be true:

- The **Deposit Amount** matches.
- The **Deposit Date** in Microsoft Dynamics GP (TRXDATE in CM20200) must be on or before the **Bank Cleared Date** in the bank import file. (The cash receipt/deposit is expected to be posted in Microsoft Dynamics GP first before it's sent to the bank for deposit.) If the deposit date in Microsoft Dynamics GP is after the bank cleared date from the bank import file, then it will not be matched. The **Unprocessed Downloaded Transactions/exception** report says "Unable to match deposit."
- The **Deposit Date** in the bank file must be within the grace period defined (default is 8 days, or whatever number of days you define for the grace period) from the **Deposit Date** in Microsoft Dynamics GP.

  > [!NOTE]
  > If there is another deposit in the same amount within the grace period, it will fall out on the Exception report. The system is unable to determine which one to mark, so it denotes that you must clear it manually against the one you choose.
- The transaction is a deposit type in Microsoft Dynamics GP. (that is, CMTRXTYPE = '1' in the CM20200 SQL table).
- The **CHECKBOOK ID** on the deposit in the CM20200 must be the checkbook ID you're working with in the **Reconcile** window.
- The Transaction code on the source file is mapped in the CODES ENTRY as a Deposit Cleared on the configurator file in Microsoft Dynamics GP. Several codes are defaulted in for you. Verify that the code you need is listed, and select **Save** in this window to activate them.

## For a transfer debit or transfer credit

Bank Transfers will automatically match in Microsoft Dynamics GP 2013 and higher versions. To match, all these criteria must be true:

- The transfer amount must match.
- The transfer date must match.
- The transfer must have been keyed into Microsoft Dynamics GP as a Bank Transfer in Bank Reconciliation.
- The transfer must be a transfer type in Microsoft Dynamics GP. (that is, CMTRXTYPE = '7' in the CM20200 SQL table).
- The Transaction code on the source file must be mapped in the CODES ENTRY as a Transfer Debit or Transfer Credit as needed in the configurator file in Microsoft Dynamics GP. These codes aren't defaulted in for you and must be added. Typically, the bank uses codes 277 for a credit transfer and 577 for a debit transfer.

Electronic Reconcile does this for each transaction type that is included in the download file from the bank.

## More information

The following types are for adjustments in Microsoft Dynamics GP only to affect the checkbook balance and would typically not be transactions found on the bank statement. Therefore, these types of transactions keyed in Microsoft Dynamics GP are excluded from the matching process in Electronic reconcile:

- Increase Adjustments - won't be matched.
- Decrease Adjustments - won't be matched.
- Withdrawals - won't be matched.
