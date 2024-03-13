---
title: FAQs about Revenue/Expense Deferrals in Dynamics GP
description: Provides answers to frequently asked questions about Revenue/Expense Deferrals in Microsoft Dynamics GP.
ms.reviewer:
ms.date: 03/13/2024
---
# Frequently asked questions about Revenue/Expense Deferrals in Microsoft Dynamics GP

This article contains answers to frequently asked questions about Revenue/Expense Deferrals (RED) in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926648

## Frequently asked questions about RED

Question 1: I installed Revenue/Expense Deferrals in Microsoft Dynamics GP. However, I can't see the commands on the menus.

Answer 1: After you install this module, you must initialize Revenue/Expense Deferrals.

Question 2: My deferral has been posted. How can I correct the GL accounts or amounts used on the remaining deferral entries? Or How do I do a partial void for the remaining entries left on my deferral?

Answer 2: You aren't able to edit the GL accounts or amounts on existing deferral transactions or partially void the remaining deferral entries not yet posted. To remedy this, you can void the entire deferral transaction and reenter it correctly. Use one of the following methods:

- VOID DEFERRAL ONLY: In the Void Deferral Transactions window, you can void the deferral transactions only. To open this window, select **Financial** on the **Transactions** menu, select **Financial Deferral** > **Void Deferral Transactions**. In this window, select the module in which the original transaction was entered. Select the transaction that you want to void, and then select **Void**. Then use the Sales or Purchasing Retroactive Deferral window to set up the deferral entries again as needed.

- VOID ORIGINAL TRANSACTION AND DEFERRAL: In the Deferral Setup window, select **Void Deferrals with Original Transactions**. When you select this option, the deferral transactions are voided when you void the original transaction. To open the Deferral Setup window, select **Setup** on the **Tools** menu, select **Financials** > **Deferral**. Now you can void the original transaction in the module it was entered in, and the deferral entries will be deleted along with it. Rekey the original transaction back in and set up the deferral for it again.

- KEY OFFSETTING JE'S: Post the Deferral entry as is, and then key offsetting GL transactions to correct the accounts or offset the remaining entries not needed. To do this, select **Transactions** > **Financial**  > **General** and enter the adjusting journal entry and respective Transaction Date, accounts, etc. For audit trail purposes, be sure to write a good Reference that indicates the original JE it is offsetting. Post the offsetting entry.

Question 3: Why do the deferral transactions post to periods that are closed in the Fiscal Period Setup window?

Answer 3: The deferral transactions post to periods that are closed because the **Auto Post into Closed Previous GL Periods** setting or the **Auto Post into Closed Future GL Periods** setting is enabled in the Deferral Setup window. These settings work only when **Automatically Post Through GL** is selected in the Deferral Setup window.

To open the Deferral Setup window, select **Setup** on the **Tools** menu, select **Financials** > **Deferral**.

Question 4: How can I post transactions to future periods in Revenue/Expense Deferrals when I am registered for Multicurrency in Microsoft Dynamics GP, and the exchange rates on the future transactions aren't yet entered?

Answer 4: Revenue/Expense Deferrals don't have multicurrency functionality. You can see only the functional currency. The exchange rate isn't considered for the transactions.

Question 5: Is there a way to have Microsoft Dynamics GP prompt a user to enter a deferral on a transaction when the transaction is being entered?

Answer 5: Currently, Microsoft Dynamics GP can't automatically prompt a user to enter a deferral. The user must know to enter the deferral.

Question 6: Is the Batch Approvals process available for Revenue/Expense Deferrals batches?

Answer 6: There's no available method for using the Batch Approvals process in Revenue/Expense Deferrals. The **Require Batch Approval** check box is in the Posting Setup window for each module. Revenue/Expense Deferrals are not part of the core Microsoft Dynamics GP dictionary. Therefore, the **Require Batch Approval** check box isn't included in this window.

Question 7: I am able to post a deferral transaction even though the deferred amount doesn't match the distribution amount. Is this correct?  

Answer 7: You can defer only part of a distribution. You don't have to defer the total distribution. Microsoft Dynamics GP lets you post the transaction even if the deferral isn't equal to the distribution amount.

Question 8: What is the difference between the Balance Sheet posting method and the Profit/Loss posting method?

Answer 8: When you use the Balance Sheet posting method, you identify two posting accounts:

- A profit-and-loss recognition account that you use together with the deferral transaction of each period. You use this account for recognition of the expense or of the revenue.

- A balance-sheet deferral account that you use together with the initial transaction for the deferred revenue or for the deferred expense.

When you use the Profit/Loss posting method, you can identify up to five accounts. This allows for greater detail in financial reporting. These accounts include three profit-and-loss accounts and two balance-sheet accounts.

The profit-and-loss accounts include the following:

- An account that you use for the initial posting of the full amount of the original revenue or of the original expense.

- An account that you use to reverse the deferred revenue or the deferred expense. This account can be the same account as the original account.

- An account that you use to recognize the deferred revenue or the deferred expense. This account can be the same account as the original account. The balance-sheet accounts include the following:

- A deferral account that you use to record the full deferred balance that was transferred from the original revenue account or from the original expense account.

- A deferrals transfer account. This account can be the same account as the deferrals account.

Question 9: Is it possible to change the deferral posting method?

Answer 9: After you select a deferral posting method for a series and then post a deferral transaction, we recommend that you not change the deferral posting method. If you must change the deferral posting method, you must first post all the unposted deferral transactions. Then, you can change the method in the Deferral Setup window. This change doesn't affect the deferral transactions that you already posted.

Question 10: What is a retroactive deferral?

Answer 10: A retroactive deferral lets you create distribution deferrals that apply to previously posted transactions that were created in the Sales series or in the Purchasing series. Retroactive deferral transactions should use the Profit/Loss posting method. This posting method lets you reverse the posted amount from the profit-and-loss account to which the amount was originally posted and then transfer that amount to a deferrals account.

Question 11: Is it possible to enter a deferral on a journal entry in General Ledger in Microsoft Dynamics GP?

Answer 11: You can't enter a deferral on a journal entry in General Ledger. You must use the Deferral Document Entry window to enter a deferral in General Ledger. In this window, you specify the following information:

- The deferral account that you want to use
- The recognition account that you want to use
- The start date and the end date for the deferral
- The method that you want to use to calculate the deferred amounts

Question 12: Which modules allow for Revenue/Expense Deferrals transactions?

Answer 12:

- General Ledger
- Receivables Management
- Payables Management
- Sales Order Processing
- Purchase Order Processing
- Invoicing

Question 13: Is it possible to enter deferrals for transactions in a recurring batch?

Answer 13: Currently, Revenue/Expense Deferrals can't save transactions in a recurring batch.

Question 14: Does RED integrate with Analytical Accounting?

Answer 14: At this time, there's limited compatibility between RED and AA. To assign AA codes to RED deferral entries, your options are:

- Option 1 - Post the batch to GL and add/edit the AA dimension codes in the GL Work batch before posting.

- Option 2 - Post the batch in GL and then use the Edit Analysis window to add/edit the AA dimension codes. (To open this window, select **Transactions** > **Financial** > **Analytical Accounting** > **Edit Analysis**.)

- Option 3 - Enter default AA dimension codes on the Accounting Class in Analytical Accounting, so these default codes get assigned to the deferral entries. However, you would still need to use one of the two options above to make any changes to the AA data, if desired. (To open this window, select **Cards** > **Financial** > **Analytical Accounting** > **Accounting Class**.)

You can vote this product suggestion via [Microsoft Idea](https://experience.dynamics.com/ideas/idea/?ideaid=6002f3c6-0da9-ec11-826d-0003ff459e22).

Question 15: Does Red integrate with Intercompany functionality?

Answer 15: Red isn't fully compatible with processing intercompany transactions. The deferral allocation will be recorded in the originating company, however, only the due to/due from accounts set up for intercompany processing are used in the destination company. The deferral entries don't flow to the destination company.

You can vote this product suggestion via [Microsoft Idea](https://experience.dynamics.com/ideas/idea/?ideaid=802e1791-0ea9-ec11-826d-0003ff459e22).

Question 16: Deferral Inquiry window pulls up Customers and Prospects when trying to pull up Vendors for Purchase Order Processing module

Answer 16: This happens when we're using RED, Revenue Expense Deferral. When you go to look up Vendors in the Deferral Inquiry window (**Inquiry** > **Financial** > **Deferral**) with the Purchase Order Processing Module selected, the window pulls up the Customers and Prospects window instead of the list of available Vendors in the company. To work around this, Select the Payables Management Module from the dropdown first, then the Vendor option for the filter and then select the Vendors desired in the From and To fields. Then change the Module dropdown back to **Purchase Order Processing** and select **Redisplay**.

You can vote this product suggestion via [Microsoft Idea](https://experience.dynamics.com/ideas/idea/?ideaid=28f0062d-4ecf-e911-b083-0003ff68c5af).
