---
title: How to configure Store Operations QuickBooks integration
description: Provides detailed instructions on how to configure the Microsoft Dynamics RMS Store Operations QuickBooks integration.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/31/2021
---
# How to configure the Microsoft Dynamics RMS Store Operations QuickBooks integration

This article discusses how to integrate QuickBooks with Store Operations.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 836444

## Summary

Microsoft Dynamics Retail Management System (RMS) Store Operations includes an integration that works directly with Intuit QuickBooks. The only supported edition of QuickBooks is QuickBooks Pro. Other editions of QuickBooks may work. However, they have not been tested and therefore would not be supported.

The following versions of QuickBooks Pro are supported:

- QuickBooks 2009
- QuickBooks 2010
- QuickBooks 2011
- QuickBooks 2012
- QuickBooks 2013
- QuickBooks 2014
- QuickBooks 2015
- QuickBooks 2016

Notes

- Both QuickBooks and Store Operations must be running on the same computer.
- For operating systems that have User Account Control (UAC) enabled, you will have to make a modification to the Store Operations Manifest file.

  Follow these instructions to update the Store Operations Manager Manifest file so that the integration will work with operating systems that have UAC enabled:

  1. Locate the SOManager.exe.Manifest file in the following location:
  
     C:\Program Files\Microsoft Retail Management System\Store Operations

  2. Open the file in Notepad, and then make the following change to this section:

      ```console
      <requestedExecutionLevel level="requireAdministrator"></requestedExecutionLevel>
      ```

     Change this section to the following:

        ```console
        <requestedExecutionLevel level="AsInvoker"></requestedExecutionLevel>
        ```

The Store Operations QuickBooks integration includes the following five stages:

1. Configure QuickBooks to interact with Store Operations.
2. Configure Store Operations to interact with QuickBooks.
3. Import data from QuickBooks.
4. Assign general ledger accounts in Store Operations Manager.
5. Export accounting and purchase order data directly to QuickBooks.

After you complete the installation, you can export accounting data directly in the QuickBooks general ledger. Additionally, you can export closed purchase orders as QuickBooks bills.

Microsoft Dynamics Retail Management Systems technical support cannot advise you about how to set up your general ledger account assignment tables or where and when to post the data to QuickBooks. Technical support strongly urges you to obtain advice from a qualified professional. This article only contains information to help you integrate Store Operations with QuickBooks.

## Stage 1 - Configure QuickBooks to interact with Store Operations

1. Start QuickBooks.
2. Select **Account** on the standard toolbar or select **Lists**, and then select **Chart of Accounts** to view the Chart of Accounts.

    > [!NOTE]
    > To view the accounts that you may have to add in Store Operations, start Store Operations Manager, select **Journal**, and then select **Assign general ledger Accounts**.

3. Select **Edit**, and then select **New Account** to add any accounts that you may want to track. For example, add accounts if you want to track sales, commissions, and cost of goods sold (COGS) for each department.

    > [!NOTE]
    > There are also two accounts that you must add in QuickBooks. For more information, see step 5.

4. Add the remaining information in the **New Account** screen, and then select **OK**.

    > [!IMPORTANT]
    > QuickBooks does not permit more than one Accounts Payable or Accounts Receivable account type per transaction. Therefore, you must use Other Current Assets and Other Current Liabilities instead of Accounts Receivable and Accounts Payable if you are setting up a new account that would ordinarily use these account types.

5. Select **Edit**, and then select **New Account** to create a new Sales Tax Payable account. This name must be different from the default QuickBooks account. For example, name the account Sales Tax Payables.

    > [!NOTE]
    > You cannot use the default Sales Tax account in QuickBooks when you assign any one of the Sales Tax accounts in Store Operations. You must create a new Sales Tax account in QuickBooks.

6. Select **Other Current Liabilities** for **Account Type**.
7. Add the remaining information in the **New Account** screen, and then select **OK**.
8. Select **Edit**, and then select **New Account** to create a new Accounts Receivable account. This name must be different from the default QuickBooks account. For example, name the account AR.

    > [!Caution]
    > You cannot use the default Accounts Receivable account in QuickBooks when you assign either the Store Account: Paid On or the Store Account: Paid To accounts in Store Operations. You must create a new Accounts Receivable account in QuickBooks because the standard Accounts Receivable account type in QuickBooks requires more information than Store Operations provides.

9. Select **Other Current Assets** for **Account Type**.
10. Add the remaining information in the **New Account** screen, and then select **OK**.
11. Determine the account that you want to use for the Bills account. This account offsets the Account Payable account when a QuickBooks Bill is created. You or your accountant determine this account.

    > [!Caution]
    > You cannot use the default Accounts Payable account in QuickBooks when you assign the Bills Account in Store Operations. Store Operations automatically posts to the Accounts Payable account in QuickBooks when you are posting the closed Purchase Orders. Therefore, you must select a different account.

12. If you do not want to use any one of the accounts that are listed for the Bills account, you must create one. If an account already exists, go to the Stage 2 - Set up Store Operations to interact with QuickBooks section.

13. Select **Edit**, and then select **New Account** to create a new account.
14. In the **Type** list, select the account type.

    > [!NOTE]
    > You or your accountant must determine the account type, but it cannot be Accounts Payable.
15. Add the remaining information in the **New Account** screen, and then select **OK**.

    > [!NOTE]
    > If you assign vendors or customers to this account, you may cause errors during posting.

## Stage 2 - Set up Store Operations to interact with QuickBooks

In this stage, you select QuickBooks as your accounting software and connect to the QuickBooks company file.

1. Start QuickBooks.
2. Sign in to your company as a user with administrator credentials.
3. Start Store Operations Manager.
4. Select **File**, and then select **Configuration**.
5. Select the **Accounting** tab.
6. In the **Accounting Information** pane, select **QuickBooks 2003** in the list.

    > [!NOTE]
    > Select **QuickBooks 2003** even if you are using a later version of QuickBooks.
7. To connect with QuickBooks and to retrieve information about the company file, select **Retrieve** in the **Company Information** pane.

    > [!IMPORTANT]
    > If the **Internet Security Levels Are Set Too High** dialog box appears, you must select **Make Changes** or **Cancel**. If you select **Cancel**, you must select **Yes** to confirm your selection. If you select **Cancel**, you may prevent some QuickBooks features from working correctly.

8. In the **QuickBooks - Application Certificate** window, use one of the following methods:
   - Select **Yes, Always** to grant permanent access from Store Operations to your QuickBooks company file.
   - Select **Yes, This Time** to grant access on this occasion only. You will be prompted for authorization on later attempts.

9. After you connect to QuickBooks and retrieve the company information, select **OK** two times.
10. For Store Operations to automatically sign in to QuickBooks, follow these steps.

    > [!NOTE]
    > Every time that you interact with QuickBooks in Store Operations, the QuickBooks program must be running. You can start QuickBooks manually and sign in to the company file, or your QuickBooks administrator can set up the automatic logon feature. When you use the automatic logon feature, QuickBooks does not have to be running.

    1. Start QuickBooks.
    2. Select **Edit**, and then select **Preferences**.
    3. Select **Integrated Applications** in the left pane.
    4. Select the **Company Preferences** tab.
    5. Select **Retail Management System**, and then select **Properties**.
    6. Select the **Allow this application to log on automatically** check box.
    7. Select the user's logon name, and then select **OK** two times.

        > [!NOTE]
        > The user must have the correct access permissions.

## Stage 3 - Import data from QuickBooks

The Import Data from QuickBooks Store Operations function imports the Chart of Accounts from QuickBooks. You can also import Payment Terms, Customers, Suppliers (Vendors), and Items if these terms are defined in QuickBooks.

> [!IMPORTANT]
> The integration does not allow you to import Payment Terms, Customers, Suppliers (Vendors), and Items from Store Operations to QuickBooks.

1. Start Store Operations Manager.
2. Select **Utilities**, and then select **Import QuickBooks**.

    > [!NOTE]
    > If Import QuickBooks is not listed, follow the instructions in the "Part 2: Set up Store Operations to interact with QuickBooks" section to select QuickBooks 2003 as your accounting software.

3. Select the data that you want to import. You can select Accounts, Payment Terms, Suppliers (vendors), Customers, and Items if these terms are defined in QuickBooks.

    > [!NOTE]
    > We recommend that you import information in the default order that appears in the Import QuickBooks window. If you change this order by re-sorting the columns, data may not be imported with the correct relationships. For additional information about importing, search for the Import QuickBooks Option topic in Store Operations Manager Help.

4. Select Import. The status appears as the data is imported.

    > [!IMPORTANT]
    > If a record already exists in Store Operations, you are prompted to select an import conflict resolution. You can update Store Operations with the QuickBooks record, create a new record, or not import the record.

    > [!NOTE]
    > Because the Chart of Accounts and Payment Terms is maintained in QuickBooks, Store Operations automatically replaces the Account and Term records with the QuickBooks imported records. You will not be prompted to select an import conflict resolution. If prompted, select a resolution. To do this, use one of the following methods:
    >
    > 1. To apply the resolution only to the current record, select **Apply**.
    > 2. To apply the resolution to all records of the same type, such as all Customer records, select **Apply to All**.
    > 3. To stop the import, select **Abort**.
    >
    >    If you abort the import, you can verify what records were imported before the interruption. To view the list of records, select **Items**, **Customers**, or **Suppliers** on the **Database** menu. To use the list to view the imported accounts, select **Assign General Ledger Accounts** on the **Journal** menu. You can view imported terms in the Supplier Properties window.

## Stage 4 - Assign general ledger accounts in Store Operations Manager

You must set up the account assignment table in Store Operations Manager. Microsoft strongly recommends that an accountant set up this table. QuickBooks does not accept a general journal import file if the debits and credits do not balance.

Every time that you add a new tender or tax type, you must update the general ledger account assignments to incorporate these additions. Use the following table to guide you through the types of general ledger accounts that you must enter for each account type listed. The table provides some additional information about these accounts. The table assumes that you are using accounts for Tender Received, Tender Opening, and Tender Closing.

Table: QuickBooks general ledger account setup in Store Operations

|Description| Type of debit account| Type of credit account| Additional Details |
|---|---|---|---|
|Inventory: Cost of Goods Sold|Cost of Goods Sold|Inventory|The total cost of items sold. Enter account numbers in these accounts if you want to track this value as a total for all departments. If you want to track this value per department, leave these accounts blank and enter your account numbers in the Dept **xxxx**: Cost Account.|
|Commission|Selling Expense|Other Current Liabilities|The commission payable to sales reps. Set up this account if you want to track this value for every department. If you want to track this value per department, leave these accounts blank and enter your account numbers in the Dept **xxxx**: Commission Account.|
|Customer Deposit: Made||Other Current Liabilities|The total deposits that are made from work orders on customer accounts.|
|Customer Deposit: Redeemed|Other Current Liabilities||The total deposits that are redeemed when work orders are completed.|
|Layaway: Closed|Other Current Liabilities||The layaway amount that is closed when the customer received the goods. Store Operations automatically credits the Sales and Tax accounts to balance the posting.|
|Layaway: Paid||Other Current Liabilities|The amount paid by customers on new or existing layaway items. Store Operations automatically debits the Payment Received accounts to balance the posting.|
|Sales: Total||Sales|The total sales amount not including tax. If you post this account, you must not post the Sales: Total + Tax account to avoid redundant posting. Set up this account if you want to track this value for all departments and track taxes separately. If you want to track this value per department, leave these Accounts blank and enter your account numbers in the Dept **xxxx**: Sales account.|
|Sales: Total + Tax||Sales|The total sales amount plus tax. If you post this account, do not post the Sales: Total or any Tax Collected accounts to avoid redundant posting. Only use this account if you do not track sales by department or sales taxes separately.|
|Shipping Charge: Total||Other Income|The amount that is collected for shipping charges. Expense it out through the general ledger program.|
|Store Account: Paid On|Accounts Receivable||Charges made to Customer Accounts. The offset is to Sales and Tax Collected.|
|Store Account: Paid To||Accounts Receivable|Payments from customers to reduce their customer balance. The offset is to Tender Received.|
|Surcharges: Cash Back||Other Income|The amount collected for fees that are charged to customers when they receive cash back on their debit purchases. Expense out any fees that are charged to you through the general ledger program.|
|Surcharges: Debit||Other Income|The amount collected for fees that are charged to customers when they use their debit card for purchases. Expense out any fees that are charged to you through the general ledger program.|
|Tax Collected: Total||Taxes Payable|The total amount that is collected for sales taxes for all departments. You can post Tax Collected for the individual tax types or for the total tax that is collected. If you post Tax Collected: Total Account, do not post the individual Tax Collected: **xxxx** accounts to avoid redundant posting. A Tax Collected: **xxxx** entry is created for each type of tax in Store Operations. Therefore, every time that you add a new tax type, you must update this account to make sure that the posting is correct.|
|Cash Dropped|Cash|Cash|The cash amount that is taken out of the cash drawers for deposit during the cashiers' shifts.|
|Cash Paid Out|Expenses|Cash|The cash amount that is paid out from the cash drawers (for minor miscellaneous expenses).|
|Tender Rounding Error|Cash||This is the rounding error that may occur when you accept multiple currencies. For example, U.S. and Canadian dollars. This error may also occur if pennies are not included in transactions.|
|Tender Closing Amounts: **xxxx**|Cash or Other Assets|Cash or Other Assets|The total amount that is available when you close the cash drawers for a particular tender type. A Tender Closing Amounts entry is created for each type of tender in Store Operations. Therefore, every time that you add a new tender type, you must update this account to make sure that the posting is correct. For more information, see the notes that appear after this table.|
|Tender Opening Amounts: **xxxx**|Cash or Other Assets|Cash or Other Assets|The total amount that is available when you open the cash drawers for a particular tender type. A Tender Opening Amounts entry is created for each type of tender in Store Operations. Therefore, every time that you add a new tender type, you must update this account to make sure that the posting is correct. For more information, see the notes that appear after this table.|
|Tender Over/Short: **xxxx**||Cash or Other Assets|The amount that the tender type is over or short at the end of the batch. It reflects the errors that the cashiers made during tender transactions. A Tender Over/Short entry is created for each type of tender in Store Operations. Therefore, every time that you add a new tender type, you must update this account to make sure that the posting is correct. If you are using this account, leave the Tender Over or Tender Short accounts blank to avoid redundant posting.|
|Tender Over: **xxxx**||Cash or Other Assets|The amount that the tender type is over at the end of the batch. It reflects the errors that the cashiers made during tender transactions. A Tender Over entry is created for each type of tender in Store Operations. Therefore, every time that you add a new tender type, you must update this account to make sure that the posting is correct. If you are using this account, leave the Tender Over or Tender Short accounts blank to avoid redundant posting.|
|Tender Received: **xxxx**|Cash||The total amount that is received for a particular tender type. This value is calculated by taking the Closing Amount - Opening Amount - Tender Dropped - Tender Paid. A Tender Received entry is created for each type of tender in Store Operations. Therefore, every time that you add a new tender type, you must update this account to make sure that the posting is correct. For more information, see the notes that appear after this table.|
|Tender Short: **xxxx**||Cash or Other Assets|The amount that the tender type is short at the end of the batch. It reflects the errors that the cashiers made during tender transactions. A Tender Short entry is created for each type of tender in Store Operations. Therefore, every time that you add a new tender type, you must update this account to make sure that the posting is correct. If you are using this Account, leave the Tender Over or Tender Short Accounts blank to avoid redundant posting.|
|Tax Collected: **xxxx**||Taxes Payable|The total amount that is collected for sales taxes for each department. You can post Tax Collected for the individual tax types or for the total tax collected. Enter account numbers in these accounts if you want to track value this separately for each sales tax. If you want to track taxes as a total, leave these accounts blank and enter your account numbers in the Tax Collected: Total. A Tax Collected: **xxxx** entry is created for each type of tax in Store Operations. Therefore, every time that you add a new sales tax, you must update this account to make sure that the posting is correct.|
|Dept. **xxxx**: Cost|Cost of Goods Sold|Inventory|The cost of the items that are sold per department. Enter account numbers in these accounts if you want to track this value separately for all departments. If you want to track this value as a total, leave these accounts blank and enter your account numbers in the Inventory: Cost of Goods Sold.|
|Dept. **xxxx: Commission|Selling Expense|Other Current Liabilities|The commission payable to sales reps by department. Set up this account if you want to track this value separately for every department. If you want to track this value as a total, leave these accounts blank and enter your account numbers in the Commission Account.|
|Dept. **xxxx: Sales||Sales|The sales amount not including taxes for the department. If you post this account, do not post Sales: Total + Tax or Sales: Total Account to avoid redundant posting. Set up this account if you want to track sales and taxes for each department separately. If you want to track this value as a total, leave these accounts blank and enter your account numbers in the Sales: Total + Tax or Sales: Total.|
|Department Tax Rounding||Cash|A rounding error may occur when you calculate the tax per department in a VAT system. Use this option if you use VAT.|
  
> [!TIP]
> For the tender amounts to post correctly to your accounting system, type opening and closing amounts in the point of sale for each batch.
>
> If you are using Tender Received Amount but not Tender Opening Amount or Tender Closing Amount, you must take the following actions:
>
> - Set credit and debit accounts for Tender Dropped and for Tender Paid Out.
> - Leave each Tender Opening and Tender Closing amount blank.
> - Set the debit amount for Tender Received.
>
> If you are using the Tender Opening and Tender Closing Amounts, but not the Tender Received Account, you must take the following actions:
>
> - Set debit accounts for both Tender Dropped and Tender Paid Out and leave their credit accounts blank.
> - Leave Tender Received blank.To assign general ledger Accounts, follow these steps:
>
> 1. Start Store Operations Manager.
> 2. Select **Journal**, and then select **Assign general ledger Accounts**.
> 3. Select the **Debit Account #** box or the **Credit Account #** box of the general ledger account that you want to assign.
> 4. Select the QuickBooks account from the list.
> 5. Repeat steps 3 and 4 until all the required accounts are assigned.  
>    Note: Not all general ledger accounts have an account that is assigned in the **Debit Account #** box or the **Credit Account #** box.
> 6. Select the QuickBooks account that you are using for the Bills Account from the list if you want to post your closed purchase orders to QuickBooks as bills.
> 7. Select **OK** to save your changes, and then close the **Assign general ledger Accounts** window.

## Stage 5 - Export accounting and Purchase Order data directly to QuickBooks

To export your accounting data directly in the QuickBooks general ledger and to export closed Purchase Orders as QuickBooks Bills, follow these steps:

1. Start Store Operations Manager.
2. Select **Journal**, and then select **Post Closed Batches**.

    > [!NOTE]
    > Only closed batches are available to be posted.
3. Select the batches that you want to post. Or, select **Dates** to open the **Select Batch Range** window to type a start date and an end date. When you select **OK**, all the batches that are closed and that are in this date range are selected, even if they have been previously posted.

    > [!IMPORTANT]
    > If you repost a batch that has already been posted, you may have duplicate general ledger and Bill entries in QuickBooks. Make sure that you delete duplicate records from QuickBooks.

4. If you have set up a Bills Account in QuickBooks, select the **Include Purchase Orders** check box to import closed purchase orders that are included in the selected batches.

    > [!NOTE]
    > Closed Purchase Orders are included in the closed batches. You can import Closed Purchase Orders into QuickBooks as bills when the batch is posted. Before you import Purchase Orders into QuickBooks, you must first select a Bills account in the account assignment table. The Bills account that you select will offset the Account Payables account when the bill is created in QuickBooks.

    The Store Operations Purchase Order exports the following information to the QuickBooks bill:

    |Store Operations PO Field| Quick Books Bill Field |
    |---|---|
    |Purchase Order Number|Reference Number|
    |Supplier Name|Vendor|
    |Purchase Order Creation Date|Transaction Date|
    |Total of the Purchase Order|Amount Due|
    |Terms|Payment Terms|
    ||One expense line for posting to the Account specified in the Assign Accounts Bill Posting Account|

5. Select **Post** to export the account data and the closed Purchase Orders.

    > [!NOTE]
    > If you receive an error message when you post the closed batch, you must view the QBPost.log file that the error message indicates. Compare the QBPost.log file to the error message articles list in the "References" section. By default, the log file is in the C:\Program Files\Microsoft Retail Management System\Store Operations folder.

6. Select **OK** to close the **Post Closed Batches** window that tells you how many batches were posted.
7. The information that was posted is now available in QuickBooks.

   To create a General Journal report in QuickBooks, follow these steps:

   1. Select **Reports**, select **Custom Transactions Detail Report**, and then select the **Filters** tab.
   2. Select **Transaction Type** in the **Filter** list.
   3. Select **Journal** in the **Transaction Type** list.
   4. Select to select a date range, and then select **OK**.

   To view the new QuickBooks Bills, select **Bill** on the standard toolbar or select **Vendors**, and then select **Pay Bills**.

   > [!NOTE]
   > The bills that you post may not be the last bills that are listed in QuickBooks.
