---
title: The Open Year button in the Fiscal Period Modifier
description: Introduces the Open Year button in the Fiscal Period Modifier.
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# The Open Year button in the Fiscal Period Modifier

This article provides more information about the Open Year button in the Fiscal Period Modifier in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859205

Once the Professional Services Tools Library has been installed, the Fiscal Period Modifier can be used as follows:

1. Make a backup of the company database, and restore the data into a test company. This solution will need to be thoroughly tested as each customer's environment can be unique. For more information, see [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211).

2. Sign in to Microsoft Dynamics GP as the **sa** user, and sign in to the test company.
3. Open the Professional Services Tools Library, and select the **Fiscal Period Modifier** option.

4. Select the **Setup Periods** button (in step 1 of the fiscal period modifier window).

   > [!NOTE]
   > When this button is selected, it will remove all existing fiscal period setup information. (It is all deleted, so you have to start completely over entering your fiscal period calendar again.)

5. Begin entering the new fiscal years and date ranges, starting with the earliest Fiscal Year. (Enter the prior year stamp, but use the same start and end dates for the next year.)

6. For historical years, check the box next to **Historical Year** (while you can relabel the year stamp, you cannot reopen a closed date range).

    > [!NOTE]
    > Never change the beginning or ending date of a Historical Year. This will cause incorrect data due to BBF created during the Year End Close Process. The beginning and end dates have to remain the same.

7. Select **Calculate** to populate and save the fiscal period date ranges.

    > [!NOTE]
    > Selecting the **OK** button will close the Fiscal Periods Setup window. Selecting the **Setup Periods** button again will clear the fiscal period data. If you select the **OK** button by mistake, you can continue to define the fiscal years through **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.

8. Repeat steps 5-8 for all historical fiscal years.

9. For open years, do not mark the historical year checkbox.
10. Continue creating the remainder of the open fiscal years, making sure the historical year checkbox is unchecked.
11. Once all of the fiscal years have been created and defined, return to the **Fiscal Period Modifier** option within the Professional Services Tools Library.

12. If the Year label in the Fiscal Period Setup window that previously represented a date range for transactions that existed in the Historical table is changed to now represent a date range for transactions that exist in the Open table, use the **Open Year** button (in **step 2** of the fiscal period modifier window) to mark the label as Open.

    > [!NOTE]
    > Never use the **Open Year** button to attempt to move transactions from a Historical Year to an Open Year. This tool will not do that. It only removes the historical checkmark. It does not move data between open and history tables.

13. Select **Process** (in step 3 of the fiscal period modifier window). This will update the year/period fields on all current transactions in the GL20000 open table.

14. When it has finished processing, you will need to run the **Reconcile** process for all historical years, from oldest year to the most recent year. (under **Microsoft Dynamics GP** > **Tools** > **Utilities** > **Financial** > **Reconcile** and mark **YEAR**.)

Again, we highly recommend testing this process in a **test company**, not only to verify that it works correctly, but also to establish a baseline for the amount of time this process will take.
