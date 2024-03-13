---
title: Checkbook and cash account don't balance
description: Describes reasons why the checkbook balance in Bank Reconciliation may not match the general ledger cash account in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The checkbook balance and the general ledger cash account don't balance in Microsoft Dynamics GP

This article provides a solution to an issue where the checkbook balance in Bank Reconciliation may not match the general ledger cash account in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864652

## Symptom

Why the checkbook balance in Bank Reconciliation may not match the general ledger cash account in Microsoft Dynamics GP?

## Cause

Any of the following circumstances may cause a difference between the checkbook balance in Bank Reconciliation and the general ledger cash account.

> [!NOTE]
> For more information about how to correct these situations and to tie the Bank Reconciliation to the general ledger cash account, contact technical support for Microsoft Dynamics GP.

- The outstanding information (that is, checkbook balance) was incorrect when you started using Bank Reconciliation.
- A deposit was posted in Bank Reconciliation (that didn't have receipts), and didn't post to the general ledger.
- Receipts were posted to the general ledger. However, the deposit hasn't been made to Bank Reconciliation.
- A Deposit to Clear Receipts deposit was posted to Bank Reconciliation, and those receipts came from Receivables Management or from another module. In this situation, the general ledger may have been updated. However, the checkbook balance may not have been updated.
- General ledger transactions may still be sitting in a Financial batch waiting to be posted. However, the deposit was made in Bank Reconciliation.
- The same general ledger cash account is used for more than one checkbook.
- Posting interruptions occurred.
- After a posting interruption occurred, the module that had the posting interruption was restored. However, the Bank Reconciliation files weren't restored.
- Non-cash transactions were posted to the general ledger cash account.

- Posting setup wasn't set to post to the general ledger for the Bank Reconciliation origins.

- Bank Reconciliation isn't registered.

- Other modules don't post to the general ledger. However, the modules do update Bank Reconciliation.

- You entered a transaction to the cash account in the general ledger. However, you didn't enter a transaction in Bank Reconciliation.

- The cash account is coming from a customer, from a vendor, or from an employee instead of from a checkbook.

- The starting checkbook balance isn't equal to the last reconciled balance.
- A deposit is saved. However, the deposit isn't posted.
- The transaction was edited in a financial batch before it was posted to the general ledger.
- The same cash account was debited and credited. In this situation, the checkbook balance is updated. However, the general ledger cash account has $0 posted to it.
- Timing differences; the transaction in Bank Reconciliation was posted to General Ledger with a different date.

## Resolution/steps to reconcile

Use one of the two methods listed below to reconcile the GL cash account balance to the checkbook balance in Bank Reconciliation.

### Method 1: (For Microsoft Dynamics GP 2013 ~ new feature)

In Microsoft Dynamics GP 2013, *Bank Reconciliation* has been added to the Reconcile to GL routine to help automate the matching process between the GL cash account detail and the Bank Reconciliation detail. This routine will produce an Excel spreadsheet that will determine the matched, potentially matched, and unmatched transactions between Bank Reconciliation and the General Ledger for the date range and GL accounts entered. Which Reconcile to GL tool can be found at:

1. Select **Tools** under Microsoft Dynamics GP, point to **Routines**, point to **Financial** and select **Reconcile to GL**.

2. Accept the default Reconciliation number.

3. Change the Reconciliation Date if wanted. This field is informational.

4. Enter the Date Range to be reconciled.

    > [!NOTE]
    > It works best to reconcile a smaller date range such as a monthly basis.

5. Select the **Module** of Bank Reconciliation.

6. Select the **Checkbook ID** to be reconciled.

7. In the Output File, browse out to a location to save the Excel Spreadsheet* to and a default file name will be generated (consisting of the checkbook ID, sequence number, and beginning date of the date ranged entered). (The system will store this location and default it in for the next reconciliation for Bank Reconciliation, but you can override it at any time.)

    *It's recommended to make a folder for your reconciliation spreadsheets, as you're allowed to save your reconciliation history.

8. Under **Accounts**, the default cash account defined on the Checkbook ID will default in. You can add more GL accounts if needed or override it.

9. Select **Process**.

10. An Excel spreadsheet will open displaying the items from the Bank Reconciliation table on the left side, and the GL entries on the right side. The items are listed according to sections for Unmatched Transactions, Potentially Matched Transactions, and Matched Transactions. You'll need to research the Unmatched Transactions to investigate why there isn't a match. Reasons for unmatched items are listed at the top of this KB article.

    > [!NOTE]
    > It's suggested to use this spreadsheet as an aid for your regular reconciliation. Focus mainly on researching the items in the Unmatched Transactions section to help you reconcile. The balances should be taken from the Checkbook and the GL Trial balance, and not relied on in this spreadsheet.

11. Back on the *Reconcile to GL* window in GP, select **Save** to save this reconciliation, if you wish to go back and view your reconciliation history it anytime. You can select the **Excel** button to reopen the Excel spreadsheet from any saved reconciliation.

### Method 2: (Manual method for any version of Microsoft Dynamics GP)  

This method has you print a list of unreconciled transactions from Bank Rec. and a list of what hit the GL cash account to compare to each other, to see what one side has that the other side doesn't. (It assumes you've balanced in the past and haven't marked any new items as reconciled in Bank Rec. since.) Here are the steps to print the lists of each side:

1. CHECKBOOK: Print a Smartlist of the unreconciled transactions in Bank Reconciliation using the steps below:

    1. On the Microsoft Dynamics GP menu, select **Smartlist**.
    1. Expand **Financial**, and then select **Bank Transactions**.
    1. In the Smartlist window, select the **Columns** button at the top.
    1. In the Change Column Display Window, select **Add**.
    1. In the Columns window, select **Cleared Date**. Hold down the CNTL key and also select **Reconciled**. Select  **OK**. Both fields should now be added to the Change Column Display window. You can use the buttons in the right margin to move the order of the columns around. Use the **Add** button to add more columns at any time. Use the **Remove** button to remove any column names. Or select **Default** to set the columns displayed back how it originally was.
    1. Select **OK** to close the Change Column Display window.
    1. Back on the main Smartlist window, select the **Search** button at the top.
    1. In the Search Definition 1 section of the Search Bank Transactions window, select **Checkbook ID** in the Column Name box, select is equal to in the Filter box, and then type your checkbook ID in the Value Box.
    1. In the Search Definition 2 section, add another restriction. In the Column Name box, select **GL Posting Date**, select is less than in the Filter box, and then select the **date**. Either key in the date, or use the calendar icon to select it.
        > [!NOTE]
        >  The filter **is less than** doesn't include that date. So for example, if you wanted transactions less than July 31st, you would have to enter is less than Aug 1 in your restriction in order for July 31st transactions to be included.
    1. Add another restriction in the Search Definition 3  section. Select **Reconciled** in the Column Name box, select is equal to in the Filter box, and then enter **No** in the Value Box. (It will give you a list of all unreconciled transactions to date in Bank Rec. Which should be the same list as you see in the Bank Rec. window.) It assumes you haven't marked off any items for reconciling yet for the current month, or since you last reconciled.
    1. Select **OK** to close the Search Bank Transactions window.
    1. The Smartlist window should refresh and data should populate in the columns.
        - You can select the title of any column to have it resort by that column. (Select once for ascending order, or select it again for descending order.)
        - Select the Columns button to add or remove any columns from the display, or change the order of the columns.
    1. To save this modified Smartlist as a Favorite, select the **Favorites** button at the top. Key in a Name, and select where you want it to be Visible To. Select **Add**, and select **Add Favorite**. The Smartlist should refresh and you should see the name of this smartlist on the left under Bank Transactions, to be used again for the future.
    1. With results in the window, you can also select **Print**, or select the **Excel** button at the top if you would like to view the results in an Excel spreadsheet instead. (It works well to put it in Excel, so you can mark off reconciled items, or color code items as you do your matching.)

2. Cash account: Print a detail report for the cash account. In GP, select **Inquiry**, point to **Financial** and select **Detail**. Print a detail report for the cash account for the month you're reconciling. Enter the GL cash account number, and the date range from when you last reconciled. This report will list all the transactions that affected your cash account balance since the last time you reconciled.

    OR, you could print this list from Smartlist if preferred. In Smartlist, select **Financial** and **Account Transactions**. Select **Search** and (1) restrict to the Account Number **is equal to** the GL cash account number. (2) Also restrict to the Transaction Date **is between** the first and last day of the month you're reconciling. It should produce the same list as the Detail Report in GP.

3. Compare: You'll need to compare the two lists printed above, and cross off items that match, to determine what items are on one side that are missing from the other. Which will help you to locate all the differences. Research any outstanding items to see why an entry is missing from the other side and correct as needed.

    In a regular support case, we can tell you how to print the lists above, but digging through the data for you to locate the differences would be considered a consulting expense and not something we'll do in a regular support case.
