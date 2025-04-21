---
title: The year-end closing procedures
description: Describes the year-end closing routine in Fixed Asset Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# The year-end closing procedures for the Fixed Asset Management module in Microsoft Dynamics GP

This document outlines the recommended year-end closing procedures for Fixed Asset Management in Microsoft Dynamics.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865653

## Summary

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

This article includes a checklist of the steps that you must follow to complete these procedures. The following section contains detailed information about each step. A series of frequently asked questions (FAQ) follows the description of the procedures.

## Introduction

Read this document before you do any of the following procedures. If you have any questions, contact Technical Support for Microsoft Dynamics.

## Year-end checklist

To do it, follow the steps:

### Step 1: Do all the year-end closing procedures for Payables Management in Microsoft Dynamics GP

Close Payables Management first. This action guarantees that all the outstanding fixed asset transactions are capitalized. For more information about closing Payables Management, see [KB -Year-end closing procedures for the Payables Management module in Microsoft Dynamics GP](https://support.microsoft.com/help/875169).

### Step 2: Enter all the fixed asset transactions for the current fiscal year

Post all the additions, the changes, the transfers, and the retirements for the current fiscal year.

> [!NOTE]
> Transfers and undo retirement transactions should never be done in a historical year.

### Step 3: Depreciate all assets through the last day of the current fiscal year

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate**.
2. In the **Depreciation Target Date** box, type the last date of the current fiscal year.
3. To insert all the fixed asset books, select **All**.
4. Select **Depreciate**.

    > [!NOTE]
    > It's very important to depreciate all assets through the last day of the current FA Fiscal Year. If all assets aren't depreciated through the last day of the current FA Fiscal Year prior to processing the year-end-close, depreciation amounts will be incorrect. For more information, see Q3 and A3 in the FAQ section below.

### Step 4: Do the GL Posting (GL Interface) process (This step is optional.)

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Fixed Assets**, and then select **GL Posting**.
2. In the **Beginning Period** box, type *2024-012*.

    > [!NOTE]
    > The *2024-012* placeholder represents period 12 of the fiscal year 2024. If you are not running on a calendar fiscal year, or if you have more than 12 periods, the period that you type would be different.

3. In the **Ending Period** box, type *2024-012*.
4. In the **Transaction Date** box, type the last date of the current fiscal year, or type the date when you need the posting to affect the general ledger.
5. Select **Continue**.
6. When you receive a message that the batch number is being created, select **Continue**.
7. In the **Report Destination** window, select the **Printer** check box, and then select **OK**.

### Step 5: Run any year-end reports that you want to keep as part of the year-end financial records

The year-to-date depreciation amounts for previous fiscal years aren't kept in Fixed Asset Management. So you must print any reports that contain this information before you close the year.

There are several reports available for fixed assets. We recommend that you print the following reports:

- Annual Activity

    To print the Annual Activity report, point to **Fixed Assets** on the **Reports** menu, and then select **Activity**.

- Additions

    To print the Additions report, point to **Fixed Assets** on the **Reports** menu, and then select **Transaction**.

- Retirements

    To print the Retirements report, point to **Fixed Assets** on the **Reports** menu, select **Transaction**, and then select **Retirements** in the **Reports** list.

- Transfers

    To print the Transfers report, point to **Fixed Assets** on the **Reports** menu, select **Transaction**, and then select **Transfers** in the **Reports** list.

- Depreciation Ledger

    To print the Depreciation Ledger report, point to **Fixed Assets** on the **Reports** menu, select **Depreciation**, and then select **Depreciation Ledger** in the **Reports** list.

- Property Ledger

    To print the Property Ledger report, point to **Fixed Assets** on the **Reports** menu, select **Inventory**, and then select **Property Ledger** in the **Reports** list.

- Fixed Assets to General Ledger Reconciliation

    To print the Fixed Assets to General Ledger Reconciliation report, point to **Fixed Assets** on the **Reports** menu, select **Activity**, and then select **Fixed Assets to General Ledger Reconciliation** in the **Reports** list.

If you've more than one fixed asset book, we recommend that you also print the following reports:

- Book to Book Reconciliation

    To print the Book to Book Reconciliation report, point to **Fixed Assets** on the **Reports** menu, and then select **Comparison**.

- Book to Book YTD Depreciation Comparison

    To print the Book to Book YTD Comparison report, point to **Fixed Assets** on the **Reports** menu, select **Comparison**, and then select **Book to Book YTD Depreciation Comparison** in the **Reports** list.

### Step 6: Guarantee that the Fixed Assets calendar is built correctly (This step is optional.)

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then select **Calendar**.
2. Select a Calendar and then select **Verify**. When you're prompted to verify the periods, select **OK**.
3. In the Report Destination window, select **Screen**, and then select **OK**.

### Step 7: Verify that the quarters are set up correctly for all the fiscal years

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then select **Quarter**.
2. Make sure that the following boxes aren't empty:
   - **Start Date**  
   - **Mid Date**  
   - **End Date**

    > [!NOTE]
    > These boxes must exist for each quarter. If any box is empty, type the appropriate date in that box.

### Step 8: Create a backup

This backup should be stored off-site together with the rest of the year-end documentation. This backup gives you a permanent record of the company's financial position at the end of the year. Additionally, this backup can be restored later if it's required. Making a backup guarantees that you can quickly recover if a power fluctuation or other problem occurs during the year-end closing procedures.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Backup**.
2. In the **Company Name** list, select the company name.
3. Change the path of the backup if you must, and then select **OK**.

### Step 9: Do the fixed assets year-end closing routine

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Fixed Assets**, and then select **Year End**.
2. Verify that the fiscal year that is displayed for each book is the current fiscal year. (The current fiscal year is the year that you're closing.)

    > [!NOTE]
    > If the fiscal year that is displayed for a book isn't the current fiscal year, see question 1 in the [Frequently asked questions (FAQ)](#frequently-asked-questions-faq) section.

3. Select a book(s) that you want to close, and then select **Insert**. Repeat this step until all the books that you want to close have been inserted.
4. Select **Continue** to start the process. Select **Continue** to confirm.
5. You'll be prompted to confirm that you've depreciated assets through to the last day or the current FA year. If not, be sure to select **NO** here and do it before you can continue to close the year. If you have, select **Yes**.

> [!NOTE]
> A report isn't generated during the fixed assets year-end closing routine for Microsoft Dynamics GP 2013 and prior versions. For Microsoft Dynamics GP 2015 and higher versions, a Fixed Asset Year-End Closing report is optional to print. This report will provide a list of all the assets affected by the year-end close process by book and a status of those assets.

> [!NOTE]
> Microsoft Dynamics does the following procedures during the year-end closing routine:
>
> - In the Asset General Information window, the **Quantity** field is copied to the **Begin Quantity** field of the Expand Quantity window.
> - In the Expand Last Maintenance window, the **YTD Maintenance** amount is cleared.
> - In the Asset Book window, the **YTD Depreciation Amount** is cleared.
> - The following procedures are performed:
>   - The **Cost Basis** field is copied to the **Begin Year Cost** field.
>   - The **LTD Depreciation** field is copied to the **Begin Reserve** field.
>   - The **Salvage Value** field is copied to the **Begin Salvage** field.
> - In the Book Setup window, the **Current Fiscal Year** field is increased by one.

## Frequently asked questions (FAQ)

**Q1: The fiscal year that is displayed for my book in the Asset Year End window isn't the year I want to close. I closed the year displayed last year, and I haven't yet closed the current year. What should I do?**

A1: See the answer for question 4.

**Q2: I have closed General Ledger in Microsoft Dynamics GP, and I now realize that I haven't yet closed Fixed Asset Management. Can I do the fixed assets year-end closing routine at this point?**

A2: We recommend that you close General Ledger last, after all the subsidiary modules have been closed. However, Fixed Asset Management can be closed after General Ledger is closed. The GL Posting (GL Interface) process can be performed, and then the transaction or transactions can be posted to the closed year or to the historical year in the general ledger. For more information about the GL Posting (GL Interface) process, see step 4 in the [Year-end checklist](#year-end-checklist) section.

To post transactions to the historical year in the general ledger, make sure that the following options are selected in the General Ledger Setup window:

- **Allow Posting to History**  
- **Maintain History Accounts**  
- **Maintain History Transactions**

> [!NOTE]
> To access the General Ledger Setup window in Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **General Ledger**.

The posted transaction will update the historical year, and it will roll forward as a beginning balance to the open year. If any expense accounts or any revenue accounts were included in the transaction, they'll automatically close out to the Retained Earnings account or accounts.

**Q3: I ran the year-end routine in Fixed Asset Management, and then I ran depreciation in the new year. I see that the depreciation is highly overstated and that some assets have a negative number in the Net Book Value field. Why is the system calculating so much depreciation?**  

A3: This problem occurs if the following conditions are true:

- The year was closed.
- The assets weren't depreciated through the last day of the fiscal year. Consider the following example:
- The fiscal year is a calendar year (January 1 through December 31).
- The assets were depreciated through December 28 when the year was closed. In this example, depreciation will be incorrect the next time that depreciation is run. The system doesn't recalculate the yearly rate when the year-end closing routine is done. So fixed assets take a full year of depreciation in the last few days that remain in the previous year (December 29 through December 31). The rate of depreciation is the yearly rate currently on each asset. Additionally, if there are assets that are near the end of their original life, the **Net Book Value** field may become negative.

There are two workarounds for this problem:

- Recommended workaround:

    Restore the data from a backup, run depreciation through the last day of the year, and then do the year-end closing procedures.

- Alternative workaround:

    Reset life on all the assets.

> [!NOTE]
> If amounts on the assets have ever been entered for the **YTD Depreciation** field or for the **LTD Depreciation** field, resetting life on the assets will change these amounts, and the result may be different. If you change the **YTD Depreciation** field or the **LTD Depreciation** field by resetting life on the asset, you'll cause inconsistencies between Fixed Asset Management and General Ledger. These inconsistencies must be explained.

**Q4: Instead of completing the year-end routine for Fixed Asset Management, I manually changed the Current Fiscal Year field in the Book Setup window to the next year. Do I have to go back and run the year-end closing routine, or can I continue to process activity in Fixed Asset Management for the new year?**  

A4: If no activity, such as additions, changes, transfers, retirements, or depreciation, has been run for the new year, the **Current Fiscal Year** field in the Book Setup window can be changed back to the previous year, and then the year-end closing routine can be processed.

If any activity, such as additions, changes, transfers, retirements, or depreciation, has been run for the new year, restore the data from a backup, and then continue with the year-end closing routine.

In either situation, the year-end closing routine must be run. If the year-end closing routine isn't completed, the amount in the **YTD Depreciation** field will be overstated on any report that includes assets that were retired or that were fully depreciated in the previous year. If the year-end closing routine isn't done, the amounts in the **YTD Depreciation** field won't be cleared. The amounts in the **YTD Depreciation** field won't be zeroed out. So these amounts will be incorrectly included in the reports for the new year.
