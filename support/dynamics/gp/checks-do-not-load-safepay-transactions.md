---
title: Checks don't load to SafePay-Transactions
description: Provides a solution to an issue where checks don't load to the SafePay-Transactions Upload window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Checks don't load to the SafePay-Transactions Upload window in Microsoft Dynamics GP

This article provides a solution to an issue where checks don't load to the SafePay-Transactions Upload window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2708664

## Symptoms

Checks don't populate in the SafePay-Transactions Upload window when you select the **Load/Reload Transactions** button.

## Cause

There are multiple reasons for why checks may not populate the SafePay-Transactions Upload window, including:

- The checkbook ID that the check was generated in isn't linked to the Bank Upload ID in SafePay.
- The check date doesn't fall within the Last Upload Date and Upload Cutoff Date range specified in the SafePay-Transactions Upload window.
- The check has already been uploaded to a SafePay file.
- The Transaction Codes haven't been defined in the Safepay configurator.
- The Customer isn't registered for the Bank Reconciliation module.
- The SafePay Configurator has a setting marked to omit checks beginning with alpha characters.
- The DD prefix was removed from the Next Earnings Statement Number in Payroll, so the system treats all checks as direct deposits and doesn't include them in the SafePay upload.

## Resolution

**Method 1** - The Checkbook ID isn't linked to the Bank Upload ID in SafePay.

Use these steps to ensure the checkbook ID is linked to the Bank Upload ID you're using in SafePay:

1. Select **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Purchasing**,  and then select **Payables**. Review what the default Checkbook ID is set to for payables, and then select **OK** to close the window.

    > [!NOTE]
    > If you set a default checkbook ID at the vendor level as well, you may also want to check the default Checkbook ID assigned to the vendors.

2. Select **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Financial**, point to **Safe Pay**, and then select **Upload Maintenance**.

3. Select the Bank Upload ID you're using, from the drop-down menu.

4. Review the Checkbook IDs listed. If the checkbook ID you want isn't listed, select **Add Checkbook** to select a checkbook ID to be linked to this Bank Upload ID.

5. Save your changes and test again.

**Method 2** - The check date doesn't fall within the **Last Upload Date** and **Upload Cutoff Date** range specified in the SafePay-Transactions Upload window.

Make sure there are checks issued between the Last Upload Date and the Upload Cutoff date used in the SafePay-Transactions Upload window.

1. Note the issue date for a sample check.

2. In the SafePay-Transactions Upload window, make sure this date falls between the Last Upload Date and the Upload Cutoff Date.

**Method 3** - The checks have already been uploaded to a SafePay file.

Review to see if the checks you're trying to upload have already been uploaded. Use these steps to review transaction history:

1. Select **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Financial**, point to **Safe Pay**, and then select **Transactions History**.

2. Enter the Bank Upload ID (that the Checkbook ID is linked to).

3. Use the left/right scrolling buttons to scroll through all the Bank Upload IDs. Review the transaction detail at the bottom of the window to see if the check number(s) you're trying to upload have already been uploaded.

4. Select **Upload** at the top of the Upload Transactions History window to generate the SafePay file again for the Upload ID selected in the window.

**Method 4**  - The Transaction Codes haven't been defined in the Safepay Configurator.

The Transaction Codes should be obtained from the bank and entered in the Codes Entry window in the Safepay Configurator setup. These are codes that the bank uses to distinguish checks, voids, and EFT payments from each other in the file. The system will replace the appropriate code entered in the Safe Pay file generated for the Transaction Type field mapped. To define the Transaction Codes in the configurator, follow these steps:

1. Open the configurator file. To do it, select **Tools** under the Microsoft Dynamics GP, point to **Routines**, point to **Financial**, point to **Safe Pay**, and select **Configurator**.

2. In the Safe Pay Configurator window, select the Bank Format ID you're using.

3. In the top menubar, select **Codes Entry** and then select **Transaction Codes Entry**. (You should obtain what codes you need to enter from your Bank before doing this step. Or you may be able to tell by looking at the bank import file.)

4. In the Transaction Types Entry window:

    1. Select **Check** for the Transaction Type and enter the Matching Code from the bank that means **check**.

    1. Select **Void** for the Transaction Type and enter the Matching Code from the bank that means **void**. There's also an option for Voids Zero Amount.  Mark it if you want the amount on voided transactions to be 0.00, or leave it unmarked to have the original amount listed on the voided transaction in the SafePay file.

    1. Select **EFT** for the Transaction Type and enter the Matching Code from the bank that means **EFT**. If the bank doesn't have a specific code for EFT, then enter the same code as you entered for the Check type as many banks just consider EFTs and checks to be the same type.

    1. Select **Save** and close the window. Select **Save** again in the Safe Pay Configurator window and test to see if the Safe Pay Upload window populates now.

**Method 5** - The Customer isn't registered for the Bank Reconciliation module.

SafePay pulls from the CM20200 table in Bank Reconciliation.  So the customer must be registered for Bank Reconciliation to use SafePay.

Option 1 - Contact your Partner to review what modules the Customer is registered for, or to purchase the Bank Reconciliation module.

Option 2 - If the SQL table (CM20200) is empty, then you're most likely not registered for Bank Reconciliation. You can use SQL Server Management Studio to review the SQL table.

**Method 6** - If the checks have a prefix, they may be omitted from loading the Safepay Transactions Upload window because of a checkbox marked within the configurator setup. Go to the safepay configurator, select the format ID, select **Codes Entry | Transaction Codes Entry** and select **Checks**. Verify the checkbox for **'Omit Checks with Alphas**' isn't marked. If it's marked, then any checks beginning with alpha characters won't load the Safepay Transactions Upload window.

**Method 7** - The **DD** prefix was removed from the Next Earnings Statement Number in Payroll, so the system treats all checks as direct deposits and doesn't include them in the Safepay upload.

The stored procedure used to populate the SafePay-Transactions Upload window will look at the prefix assigned to the Next Earnings Statement Number in Payroll, whether you're using US Payroll or Direct Deposit  or not. The system will compare all checks to the Next Earnings Statement Number to determine if it's a direct deposit or not. So if a user removes the default **DD** prefix, then the system will treat all checks as direct deposits that start with the same digit, and not populate them in the SafePay Transactions Upload window. For example, if the Next Earnings Statement Number for direct deposits starts with 0, then the system will also treat all checks that also start with 0 as direct deposits and not include them in SafePay. Use these steps to review:

1. Select **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Payroll**, and then select **Direct Deposit**.

2. Make sure the **DD** prefix is at the beginning of the Next Earnings Statement Number. Add the **DD** prefix to the beginning of the Next Earnings Statement Number if needed.

3. Select **OK** to close the window.

> [!NOTE]
> The stored procedure will check the Next Earnings Statement Number, whether or not you are using Payroll or Direct Deposit.
