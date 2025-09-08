---
title: No account specified for distributions
description: Provides a solution to an error that occurs when posting transactions in Payables Management or Receivables Management.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# "No account has been specified for one or more distributions." Error message when posting transactions in Payables Management or Receivables Management

This article provides a solution to an error that occurs when posting transactions in Payables Management or Receivables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2478324

## Symptoms

When you try to post transactions in Payables Management or Receivables Management, you receive the following error message. The transaction won't post and contains errors. This article explains how to resolve this error message and also how to set up the General Ledger accounts to default into the transaction to prevent this error from occurring.

The following errors were found while attempting to post:

> Distributions for this transaction contain errors.

> No account has been specified for one or more distributions.

## Cause

The Payables Management or Receivables Management transaction contains a distribution line where no General Ledger (GL) account has been specified.

## Resolution

To resolve this error message, edit the transaction and make sure all the distribution lines for the transaction have a GL account specified. To do it, follow these steps:

1. Select the transaction using the appropriate method below:

    - Payables Management transaction: Select **Transactions**, point to **Purchasing**,  and then select **Transaction Entry**.
    - Receivables Management transaction: Select **Transactions**, point to **Sales**, and then select **Transaction Entry**.  

    > [!NOTE]
    > If you receive this message on manual payments or cash receipts, then select those entry windows respectively.

2. Use the **look-up** button to select the voucher number of the document to be edited.

3. Select the **Distributions** button to open the Transaction Distribution Entry window.

4. Review the distribution lines to see if any of the accounts are missing. If you find any accounts missing, you can fill in the account using one of the methods below:

    Method 1 - Manually key in the GL account number.

    Method 2 - Use the look-up button next to the Account  heading, select the appropriate Account Number, and then click **Select** to populate the distribution line.

    Method 3 - If you have default posting accounts set up, you can select the Default  button, and the original default accounts will repopulate.

    > [!NOTE]
    > See the [More information](#more-information) section below on how to specify default posting accounts.

5. Select **OK** to close the Distribution Entry window.

6. Select **Save** or **Post** and the transaction should save or post without error.

## More information

It's recommended that you set up default GL posting accounts at the module setup level to default in for all transactions created in that module. However, if you wish for a certain customer or vendor to have a different GL account default in than what is specified at the module setup level, then you can define specific default GL accounts at the customer/vendor level as well. The system will first look to the Vendor/Customer level to see if any accounts have been specified and use those accounts as the defaults. However, if the accounts are left blank at the Vendor/Customer level, then the system will next look to the module setup level for default posting accounts. Use the appropriate method below.

### Method 1 - Define default posting accounts at the module setup level (recommended)

You can set up default GL posting accounts as follows:

1. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Posting** and then select **Posting Accounts**.

2. Under **Display**, select either Purchasing or Sales as appropriate.

3. Enter/edit the appropriate default account to use for each posting account type as wanted.

4. Select **OK**.

### Method 2 - Define default posting accounts at the vendor/customer level (optional)

If you wish want any vendors or customers to have different default accounts than what was specified at the module setup level above, specify default accounts at vendor/customer level.

- Vendor Maintenance: Select **Cards**, point to **Purchasing**, and then select **Vendor**. Select the appropriate Vendor ID and then select the **Accounts** button. Select the appropriate default accounts for each type.
- Customer Maintenance: Select **Cards**, point to **Sales**, and then select **Customer**. Select the appropriate Customer ID and then select the **Accounts** button. Select the appropriate default accounts for each type.

> [!NOTE]
> If no accounts are specified at the vendor/customer level, then the system will use the accounts defined in Method 1.
