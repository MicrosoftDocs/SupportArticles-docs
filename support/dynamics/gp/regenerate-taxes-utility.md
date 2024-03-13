---
title: Regenerate Taxes Utility in Dynamics GP
description: Regenerate Taxes Utility in Microsoft Dynamics GP.
ms.reviewer:
ms.date: 03/13/2024
---
# Regenerate Taxes Utility in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4025306

## Question

What does the **Regenerate Taxes** Utility do in Microsoft Dynamics GP?

(**Microsoft Dynamics GP** menu > **Tools** > **Utilities** > **Company** > **Regenerate Taxes**)

## Answer

The purpose of this tool is to update transactions in work status if the **Tax Detail ID** has been changed since the transactions were keyed. This utility will apply the changes to the Tax Detail ID to the transactions in work status so you don't have to delete and rekey them.

You can use this feature on the following modules:

- Sales Order Processing (SOP)
- Receivables Management (RM)
- Purchase Order Processing (POP) - **Invoicing**

    > [!NOTE]
    > Taxes are not regenerated for purchase orders in the Purchase Order Processing module.
- Payables Management (PM)

## Steps to regenerate taxes

> [!NOTE]
> Ensure that you have a current **backup** of your Company database before regenerating taxes.

1. Make your change to the **Tax Detail ID** and save it.
2. Open the **Regenerate Taxes** window. (**Microsoft Dynamics GP** menu > **Tools** > **Utilities** > **Company** > **Regenerate Taxes**)
3. Select the **Module** for which to regenerate taxes.
4. Select the range of **Batches** for which to regenerate taxes using the **FROM** and **TO** drop-down lists.
5. Click **Insert** to insert the selected range of batches in the Restrictions list.
    > [!NOTE]
    > Click **Remove** to remove range of batches from the Restrictions list as needed.
6. Click **Process** to regenerate taxes with the tax percentage or amounts for transactions that are saved in the selected batches.
7. You are prompted with "You may want to backup your database before regenerating taxes. Do you want to continue?" Click **Yes** to continue, or **No** to cancel the process.
8. Print the Tax Correction Report and Tax Correction Exception Report to the screen, printer or file as desired, or click **Cancel** to not print the reports.
9. Exit out of the **Regenerate Taxes** window, or click **Cancel** to close the window.
10. Print an Edit List of the Batch(s) to verify the changes, before posting the batch.  

## More information

Click [HERE](https://community.dynamics.com/blogs/) to view the Microsoft Dynamics GP blog article containing the information above, as well as a Word Document with a SOP example.
