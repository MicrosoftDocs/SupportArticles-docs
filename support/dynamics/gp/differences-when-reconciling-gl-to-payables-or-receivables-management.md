---
title: Differences when reconciling GL to Payables or Receivables
description: Discusses why the accounts payables balance or accounts receivables balance in General Ledger differs from the balance on the Historical Aged Trial Balance report.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# Information about differences when you reconcile General Ledger to Payables Management or to Receivables Management

This article discusses why the **Accounts Payable** account balance or the **Accounts Receivables** account balance in General Ledger differs from the total amount that is due on the Historical Aged Trial Balance report in Microsoft Dynamics GP. There are commonly asked questions at the end of this article.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866570

The Reconcile to GL routine was new to Microsoft Dynamics GP 10.0 (SP2). This routine generates a Microsoft Office Excel spreadsheet. You can use this spreadsheet to match transactions in Payables Management or Receivables Management that were posted to General Ledger. This process does not generate correcting transactions. However, this process can help you determine the transaction differences that are listed in this section. To open the **Reconcile to GL** window, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Financial**, and then select **Reconcile to GL**.

Below is a running list of issues that we've seen that may cause differences:

- Not all GL batches are posted. (The Reconcile to GL spreadsheet only reports on posted entries.)
- The Historical Aged Trial Balance report is printed with restrictions. Print the Historical Aged Trial Balance report again with only a date restriction.
- Not all accounts payable accounts or all accounts receivable accounts are viewed in General Ledger. Make sure that you view all accounts payable accounts or all accounts receivables accounts in General Ledger.
- Batches in Payables Management or in Receivables Management were posted to General Ledger. The batch in General Ledger was changed or edited before it was posted.
- Adjustments to the accounts payable account or to the accounts receivable account may have been entered directly in General Ledger. These transactions update the account in General Ledger. However, these transactions don't update the Historical Aged Trial Balance report.
- The date range on the Detailed Trial Balance report in General Ledger does not match the date range on the Historical Aged Trial Balance report in Payables Management or in Receivables Management. When you print the Historical Aged Trial Balance report, select the **GL Posting Date** check box in the **Select Transactions For Report Using** area.
- Transactions were posted in Payables Management or in Receivables Management. However, these transactions were not posted to General Ledger if they were for beginning balances. If the **Post To General Ledger** check box isn't selected in the Posting Setup window for the Purchasing series or for the Sales series, the transactions will be posted to Payables Management or to Receivables Management. However, these transactions won't be posted to General Ledger.
- The **Track Discounts Available in GL** check box is selected in the Payables Management Setup window or in the Receivables Management Setup window. Then, the net amount of the invoice will be posted to General Ledger. Additionally, the remaining amount is posted to a discounts available account. Only the net amount will appear on the Detailed Trial Balance report in General Ledger. However, the invoice displays the gross invoice total on the Historical Aged Trial Balance in Payables Management or in Receivables Management.
- Documents were voided in a different period than they were originally posted. The Detailed Trial Balance report in General Ledger may not match the Historical Aged Trial Balance report. For example, assume an invoice was entered on 1/1/2007. This invoice was voided on 2/1/2007. A General Ledger Detailed Trial Balance report is printed for 2/1/2007 - 2/28/2007. The voided transaction will appear on the report. If a Historical Aged Trial Balance is printed by using the same date range, the voided document won't print on the report because it has been voided.
- If you want to balance the accounts payable account balance or the accounts receivables account balance in General Ledger to the Historical Aged Trial Balance report for a certain period, the balances from the Historical Aged Trial Balance report must be reconciled to the net change on the Detailed Trial Balance in General Ledger for the same period.
- If you want to balance the accounts payable account balance or the accounts receivables account balance in General Ledger to the Historical Aged Trial Balance report for a day that isn't in a certain period, determine whether Payables Management or Receivables Management has ever been balanced. If Payables Management or Receivables Management has never been balanced, the beginning balances may be incorrect. In this situation, balance the most current period first, and then reconcile the previous months in reverse order.
- If posting interruptions have occurred, batches may not have been posted correctly to General Ledger, to Payables Management, or to Receivables Management.
- When you print the Historical Aged Trial Balance report, you didn't select the following check boxes in the Exclude area.
- Select these check boxes, and then print the Historical Aged Trial Balance report.

  > [!NOTE]
  > If you want to match the General Ledger Detailed Trial Balance report and the Historical Aged Trial Balance report by specific documents, clear the **Fully Paid Documents** check box.

  - **Unposted Applied Credit Documents**
  - **Zero Balance**
  - **Activity**

- If you use Multicurrency Management when you revalue, you selected to post to the Purchasing/Sales Offset Account.
- Credit card amounts entered in the Payables Transaction Entry window for an invoice. This may cause an imbalance on the reconcile for Payables Management to General Ledger because only the net change will post to the General Ledger module. (That is, it appears as if GL transactions are missing, but the amounts on the GL side are netted into one GL entry, whereas the PM side may show three records. But they should still match in later versions and move to the Matched Transactions section correctly.)
- If there were posting interruptions/issues with a Payables or Receivables batch and the transactions were found in both the Work and Open tables at the same time, deleting the RM or PM batch in Microsoft Dynamics GP will cause issues. In this instance, the user usually sees the records in both tables, and decides the don't need the work batch so they just delete it in Microsoft Dynamics GP. Since the Work and Open tables share a distribution table, deleting the batch in Microsoft Dynamics GP will also remove the distribution records with it. The end result is that the transaction header record exists, but there are no matching distributions on the RM or PM side, but GL was updated correctly. This issue will be considered in the next version of Microsoft Dynamics GP.
- Distributions may show up in the Potentially Matched section with different amounts if there were discounts. In order to match, the discount GL accounts should have been pulled in with the PM/RM account before running the Reconcile to GL process. Close the spreadsheet and rerun it with the discount GL accounts listed as well.
- Distributions may be missing on the PM/RM side if the type (CASH, PAY, PURCH) were altered. On the reconcile spreadsheet, the account is only used for the GL side. The account isn't used on the PM/RM side. The PM/RM side pulls using the PAY or REC type regardless of what account is used, so that is why you should be sure to list all your AP or AR accounts on the reconcile window. And simply switching the distribution type in the SQL Table doesn't make the distribution automatically show up if you regenerate the spreadsheet. (This was an issue in prior versions for credit card payments using CASH type and hitting the AP account, but these records are displaying in GP 2016 so no longer appears to be an issue.)
- Check the apply date and GL post date in the apply table for multicurrency transactions compared to the actual date it was posted in GL. For example, on Jan 22, a credit memo dated Dec 31 was applied to an invoice dated Dec 5, and the apply date and GL post date were left as Jan 22. However, when posting the GL batch, the user changed the date to Dec 31. In this case, the Reconcile to GL spreadsheet for the month of December lists the realized gain/loss amount on both sides and they appear to be reconciled. However, the HATB report doesn't recognize the realized gain/loss amount yet and will be off by this amount when compared to GL, since it wasn't applied or posted until January according to the apply record.  

## Commonly asked questions

Q1: Is the Reconcile to GL spreadsheet a true reconciliation for Payables/Receivables to GL?

A1: The reconcile to GL feature is a *troubleshooting tool* to help users identify unmatched distributions between RM/PM and GL. It was not necessarily meant to tie out to the HATB and that was not the intended purpose, although we know clients are doing it. The balances on the Reconcile to GL spreadsheet are best estimates using a simple addition/subtraction on the distributions in the table. Whereas the balances on the HATB take nearly every table into consideration and are much more complex and accurate balances and so the two often don't tie out.

The *true* reconcile should be between the RM or PM Historical Aged Trial Balance (HATB) and the GL Trial Balance reports. If these match, then you would not necessarily need to run the Reconcile to GL tool for that month. The GL tables are made up of debits and credits, and the tables that the HATB pulls from are transaction header and apply record tables. So customers asked for a way to reconcile the distributions in GL to the distribution tables in RM or PM to help find differences at that level. So this is the reason why the Reconcile to GL routine was created. It was intended to be a troubleshooting tool to compare distributions to distributions between the modules to help identify missing distributions, that may lead you back to a missing transaction from the HATB. So use the Reconcile to GL tool as an *aid* only to help you reconcile the HATB to GL Trial Balance. If the HATB and GL TB balance, then there isn't really a need to run the Reconcile to GL tool for that month.

Q2: Should the totals on the Reconcile to GL spreadsheet match the totals on the HATB?

A2: No. The totals on the Reconcile to GL spreadsheet are just a simple addition/subtraction of the distribution records in that table and doesn't take any other tables into consideration. Whereas the HATB looks at entirely different tables to calculate a balance using the transaction and apply records tables and is a much more complex calculation. Because of the different calculation methods/tables used to obtain the balances, the Reconcile to GL spreadsheet isn't expected to outright tie to the aging balances on the HATB reports and would make reconciling them difficult. It isn't necessary to tie the balances on the reconcile to GL spreadsheet to the HATB report.

We suggest ignoring the totals on the reconcile to GL spreadsheet, and just use the Unmatched and Potentially Matched sections to help you find differences to research to see if that may also explain a difference between the GL TB and HATB. The reconcile to GL spreadsheet isn't a true reconciliation, and was only intended to be an *aid* to help you identify distribution differences to research to see if this is also a difference at the transaction level. In fact, if the HATB matches the GL TB, there really wouldn't be a need to run the reconcile to GL utility for that month at all, since there are no differences to identify.

If you still wish to tie the balance on the reconcile to GL spreadsheet to the balance on the HATB, this isn't supported in a regular support case. The reasons we have identified are listed at the top of this KB and there could be more reasons not yet identified. But since this reconcile isn't necessary between the simple total balance listed on the reconcile to GL spreadsheet and the more complex calculated balance on the HATB report, and not the intended purpose of this reconcile utility, it would be considered a consulting expense to dig into your data to assist you to reconcile these to each other.

Q3: What should I do if distributions are missing on the GL side?

A3: If you find distributions on the RM or PM side that are not on the GL side, investigate the GL side for timing differences. Check to make sure that all GL batches are posted. If they are truly missing on the GL side, you'll need to key an adjusting journal entry directly into GL for the entry to create the GL distributions.

Q4: What should I do if distributions are missing on the RM or PM side?

A4: If the GL distribution is listed, but is missing on the RM or PM side, first investigate for timing differences. Also research to see if the transaction itself is listed on the HATB report and is already accounted for. It is possible that the transaction exists, but the distributions are just missing. So the question becomes *how do I get the distributions in RM or PM then, if the transaction does exist?* First, keep in mind that the distribution tables in RM or PM are not used for any other purpose or reports in GP, other than this reconcile spreadsheet. So is it really necessary to get them added back into RM or PM? Evaluate if it's worth your time to populate a table that isn't used anywhere else.

But if you so choose to fix the PM distribution table, you would have to void the document, so the applied records move back to open. Then use the Remove Transaction History Utility to remove the voided document. Make sure to set the posting to *post to* GL and don't *post through to GL*. Delete the GL batch created by the void. Then rekey the document back into Payables, so the transactions and distributions are recreated. Be sure to void the GL batch for this. Then reapply the new document to the open documents and they should move to history again.

To fix it on the RM distribution table, you'd have to remove both sides of the invoice and payment and rekey them both back in, and delete the batch in GL.

Q5: The transactions in the Potentially Matched section look like they match. Why aren't they in the Matched section?

A5: There are several fields that are matched for each distribution record. All of the fields must match to move it to the Matched section. If some but not all of the fields match, then it will put it in the Potentially Matched Section. For example, here are the fields that are matched for PM to GL:

*Payables Management -- GL*  
Voucher Number -- Originating Control Number  
TRX Source -- Originating TRX Source  
Posting Date -- Transaction Date  
On Account Amount -- Debit Amount or Credit Amount

Q6: If I key the missing distributions in GL or RM/PM and rerun the Reconcile to GL spreadsheet, will the unmatched or potentially matched items move to the Matched section?

A6: No. If the transactions are keyed separately, the will have different voucher numbers and Trx Source codes. At best the Posting Date and Amounts may match, which could put them in the Potentially Matched section of the spreadsheet.

Q7: Why does the Ending Balance on a monthly or quarterly spreadsheet not match the Beginning Balance on the next monthly or quarterly spreadsheet?

A7: If the Ending Balance of one period does not match the Beginning balance of the next period, it is often due to orphaned distribution records that don't have an associated header record in the sub-ledger table. The Ending Balance is calculated by Excel right in the spreadsheet. It just takes the beginning balance for that period at the top of the spreadsheet and adds/subtracts the distribution records that appear on the spreadsheet to arrive at the ending balance. On the other hand, in the next period, the Beginning balance is calculated by taking a simple debit/credit calculation of the distribution records in the SQL table and the stored procedure does join the header table, so it will not include any distributions that are missing a header record. The end result could be that some distributions were calculated into the ending balance on the prior spreadsheet, and omitted from the beginning balance on the next period.

Q8: The distributions on the RM/PM side do exist, but are not pulling into the spreadsheet.

A8: Review these troubleshooting tips:

- Examine the date range used on the Reconcile to spreadsheet.
- Verify that the distributions do exist in the PM10100 or PM30600 tables for PM. (or for RM: search the RM10101 or RM30301) Examine the dates on these distributions to make sure they fall within the range you entered for the spreadsheet. It is important to locate these in the RM or PM distribution tables and not to rely solely on reprinted posting journals for instance.
- If you find the distributions in the RM or PM tables, then look at these distributions on the document in the front-end. Do they have a distribution type of PAY or REC or AVAIL? These are the only types that will be pulled on to the reconcile spreadsheet on the RM or PM side in older versions. (Update: Credit card payments may produce a distribution to the AP account with a type of CASH on it, in which it IS in the table, but the reconcile to GL spreadsheet didn't display this distribution on the left side. So just a display issue with the spreadsheet and not a data issue. However, this does not appear to be an issue in Microsoft Dynamics GP 2016, as the CASH type is now displayed on the spreadsheet correctly, so was fixed along the way.)

Q9: Can you have the Reconcile to GL window display in other currencies?

A9: The Reconcile to GL window as designed to display **functional** currencies only. For more information, see [Information about the balances in the Reconcile to GL window in Microsoft Dynamics GP](https://support.microsoft.com/topic/information-about-the-balances-in-the-reconcile-to-gl-window-in-microsoft-dynamics-gp-ccc6507c-9d98-133e-adb0-fa90b8f66cd3).
