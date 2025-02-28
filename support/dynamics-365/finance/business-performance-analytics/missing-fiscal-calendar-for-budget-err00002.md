---
title: Missing fiscal calendar for budget error
description: Provides information about the Missing fiscal calendar for budget error (error code ERR00002) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/21/2024
ms.custom: sap:Business intelligence, reporting, analytics
ms.search.form: business-performance-analytics
audience: Application User
---
# Missing fiscal calendar for budget: Error code: ERR00002 [Type: Error]

## Symptoms

Error code *ERR00002* is logged in the **Bpa self help logs** table in Microsoft Dataverse when the transaction dates on budget transaction lines in Dynamics 365 Finance aren't aligned with the corresponding fiscal calendar in the ledger. This misalignment causes the transaction in the Budget fact to be linked to an accounting date key of **-1**.

## Resolution

To solve this error, include calendar years or periods from the `minBudgetTransactionDate` value through the `maxBudgetTransactionDate` value for the relevant Fiscal calendars. You can find the fiscal calendar, the `minBudgetTransactionDate` value, and the `maxBudgetTransactionDate` value in the `LogDetails` column of the **Bpa self help logs** table.

Here's an example of a record:

> 1 records in BudgetTransactionLine have TransactionDate outside of the Fiscal Calendar - [Row(b9d140ec-7227-4942-b20f-b0e0a3012d41_mserp_calendarid='Fiscal', fiscalCalendarStartDate='2014-01-01 00:00:00', fiscalCalendarEndDate='2025-12-31 00:00:00', cae61f4c-c088-4bc4-b600-c5bd07f1af3d_mserp_name='USMF', minBudgetTransactionDate='2026-01-01 00:00:00', maxBudgetTransactionDate='2026-02-01 00:00:00')]

> [!IMPORTANT]
> Before you fix this issue, confirm that you have the permissions to make changes to the fiscal calendar.

1. In Dynamics 365 Finance, go to **General ledger** > **Calendars** > **Fiscal calendar**.
2. In the dropdown list, select the fiscal calendar that requires the addition of a new year. This calendar should be the calendar that corresponds to the reported issue.
3. In the selected fiscal calendar, select **New year**.
4. Enter the relevant information for the new fiscal year, such as the start and end dates. For this example, confirm that the new fiscal year includes the months of January and February (as specified in `minBudgetTransactionDate` and `maxBudgetTransactionDate`).
5. Confirm that the date range for the new fiscal year accurately covers the required periods.
6. Save the new fiscal year entry.

> [!IMPORTANT]
> You can't add a new year in the past. You can add only future years. If transactions were posted in a year before the calendar's start year, you can't create a new year in the existing fiscal calendar.

There are two options for fixing fiscal calendar issues:

- Create a new calendar.
- Keep the current calendar.

Keeping the current calendar might lead to a situation where transactions don't match your reporting periods. Therefore, it might cause reporting issues and make historical comparisons difficult. You might have to make adjustments that can complicate audits. When the fix is successfully implemented, transactions that were previously misaligned will be mapped to the appropriate accounting date key, and will therefore ensure accurate financial processing and reporting.

After you complete these steps, a new fiscal year is added to the relevant calendar and fixes issues that are related to misaligned transaction dates.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
