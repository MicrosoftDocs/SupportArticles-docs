---
title: Description of the Fiscal Period Modifier tool
description: Description of the Fiscal Period Modifier tool in Microsoft Dynamics.
ms.reviewer: theley, cwaswick
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# Description of the Fiscal Period Modifier tool in Microsoft Dynamics GP

You can use the Fiscal period modifier tool in PSTL to change fiscal year definitions and reset data in the open and history tables.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855493

> [!NOTE]
> This tool does not support changing the month/day on closed years as the tool does not recalculate the ending and beginning balances. Only use this tool to change the YEAR STAMP for years that are currently closed. This tool does not move transactions back to the open GL table.

## More information

Overview ofFiscal Period Modifier window in PSTL:

Step 1 - removes all current fiscal periods and prompts you to reset up the same year/dates with new year stamp.
Step 2 - removes the **historical** flag on any previously closed years that should now be open.
Step 3 - Updates the year stamp in all the tables per the new calendar setup and removes all GL summary data.

If the years to be changed are *open*, these steps should work:

> [!NOTE]
> You should make a current backup before doing this or do this in a Test company first.

1. Open the Professional Services Tools Library (PSTL) shortcut.
2. On the Financial Tools section, mark **Fiscal Period Modifier** and select **Next**. The Fiscal Period Modifier window will open showing three steps.
3. Start with **Step 1** to **Setup Periods.** (Selecting step 1 will remove all prior fiscal periods set up, and prompts you to reset them up.)

4. On the Fiscal Periods Setup window, enter the first year that you need to modify by entering the First and Last Day. Make sure to set up EACH period in the company database. (When defining new periods, be sure to use the same year/dates, and only change the year stamp. This utility does not allow transactions for a year to be split between different years.)

5. Select **calculate** and appropriately mark the year as **Historical Year** as needed.
6. Repeat the process for every year that you wanted to process.
7. Select **Ok** after setting up the last year.
8. Go back to the PSTL Main Window and mark Fiscal Period Modifier again and select **Next**.

9. If there are years that were previously closed and need to be opened, select or enter the year in **Step 2** and select **Open Year**. You will receive a message that the year selected has been changed to an open year. (This step does not reopen the year. It just removed the Historical check mark.) Otherwise, proceed with step 3.

10. For **Step 3**, select the **Process** button to process the new Fiscal Periods and align your history and open data and remove the old GL summary data. (This process updates the YEAR STAMP in the SQL tables to match the new calendar.)

11. After this procedure, you need to run the **Reconcile** Utility to repopulate the GL summary tables by going to **Tools** > **Utilities** > **Financial** > **Reconcile** and reconcile each year, starting from the earliest year in the system.

12. Review the GL data. Go back to the **Inquiry** > **Financial** > **Summary** window, and verify the account balance for the new periods.
