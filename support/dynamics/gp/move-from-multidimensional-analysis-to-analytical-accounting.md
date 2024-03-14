---
title: How to move from Multidimensional Analysis to Analytical Accounting
description: Describes how to move from Multidimensional Analysis to Analytical Accounting.
ms.topic: how-to
ms.reviewer: theley, ryanklev
ms.date: 03/13/2024
---
# How to move from Multidimensional Analysis to Analytical Accounting

This article describes how to move from Multidimensional Analysis to Analytical Accounting in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 897742

1. Print the Multidimensional Analysis Account Analysis report. To do this, click **Reports**, click **Financial**, click **Multidimensional Analysis**, and then select the **Account Analysis** report.

    This report lists the transactions, the accounts, and the distributed amounts that have analysis codes. You must have this information so that you can assign dimension codes to the transactions when you create adjustment entries.

2. Install Analytical Accounting.

    > [!NOTE]
    >
    > - To obtain the installation file, visit [this Microsoft Web site](https://mbs2.microsoft.com/customersource).
    >
    >    After you log on to the Web site, click **Downloads and Updates**, click **Service Packs/Product Releases**, and then click **Great Plains**. Then, click **Analytical Accounting 8.0 Extensions Release**.
    > - Analytical Accounting is a separate purchase. Registration keys are required.

3. Create transaction dimensions and transaction dimension codes in Analytical Accounting that correspond to the analysis groups and to the analysis codes in Multidimensional Analysis.

    The following list describes the correspondence between Multidimensional Analysis fields and Analytical Accounting fields:

    - The **Multidimensional Analysis** field corresponds to the **Analytical Accounting** field.
    - The **Analysis Groups** field corresponds to the **Transaction Dimensions** field.
    - The **Analysis Codes** field corresponds to the **Transaction Dimension Codes** field.
    - The **Analysis Type** field corresponds to the **Analysis Type**  
    field.

    In Multidimensional Analysis, the **Analysis Type** field can contain a value of **None**, **Required**, **Optional**, or **Fixed**. In Analytical Accounting, the field can contain a value of **Not Allowed**, **Required**, **Optional**, or **Fixed**.

    > [!NOTE]
    >
    > - In Multidimensional Analysis, the analysis groups are assigned one at a time to the general ledger accounts in the Account Maintenance window. In Analytical Accounting, the transaction dimensions are assigned to a group of general ledger accounts in the **Account Class** window.
    > - For more information, see the Analytical Accounting 8.0 Extensions Release document (AnalyticalAccounting.pdf) in the Great Plains\Documentation folder after you install Analytical Accounting. Or, visit [this Microsoft Web site](https://mbs2.microsoft.com/customersource). After you log on to the Web site, click **Documentation**, click **User Guides**, and then click **Great Plains 8.0 User Guides**.

4. To adjust journal entries to add transaction dimension information, take one of the following actions:

   - Click **Transactions**, point to **Financial**, point to Analytical Accounting, and then click **Edit Analysis** to open the **Analytical Adjustment Entry** dialog box. Use this dialog box to adjust journal entries to include transaction dimension information. You can adjust only journal entries that are posted to accounts that have a transaction dimension code.

   - Follow these steps:

    1. Click **Transactions**, point to **Financial**, and then click **General Entry**.
    2. Enter a general journal entry that will update the accounts and transaction dimension codes with the correct amounts for transaction dimension code beginning balances, and then post this transaction. At this point, the accounts have been updated, although they should not be updated. To remove the accounts that were updated, follow these steps:

        1. Click **Tools**, point to **Customize**, and then click **Customization Status**.
        2. Click **Analytical Accounting**, and then click **Disable**. You are now ready to reverse the journal entry. This entry will not affect Analytical Accounting, because Analytical Accounting is now disabled. To reverse the journal entry, follow these steps:

            1. Click **Transactions**, point to **Financial**, and then click **General Entry**.
            2. Click **Correct** to open the **Correct Journal Entry** dialog box.
            3. Click the journal entry number that you entered previously, and then click **OK**.
            4. Post the journal entry.
            5. Close Microsoft Great Plains, and then restart Microsoft Great Plains. These actions will enable Analytical Accounting. You now have beginning balances entered for the Analytical Accounting transaction dimension codes. For more information about how to adjust journal entries to add transaction dimension information, see the AnalyticalAccounting.pdf file.

For more information, see the MultidimensionalAnalysis.pdf file in the Great Plains\\Documentation folder on the computer where Microsoft Great Plains is installed.
