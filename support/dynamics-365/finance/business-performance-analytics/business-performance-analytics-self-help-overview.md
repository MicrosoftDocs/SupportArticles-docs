---
title: Business performance analytics self-help
description: Provides information about business performance analytics self-help in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 01/29/2024
ms.custom:
ms.search.form: business-performance-analytics
audience: Application User
---
# Business performance analytics self-help

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.

To maintain the accuracy of report data, business performance analytics assesses the quality of the source data. If the assessments don't meet defined rules, business performance analytics logs information in the **Bpa self help logs** table in Microsoft Dataverse. This table provides insights into issues and helps you take appropriate action.

## Access the business performanc analytics self help logs table

To access the **Bpa self help logs** table, follow these steps.

1. Open the [Power Apps maker portal](https://make.preview.powerapps.com/).
2. Go to **Tables** > **All**.
3. Search for **BPA\Slef\Help\ Logs**.

## Understand the "Bpa self help logs" table

| Sno | Column name | Description |
|---|---|---|
| 1 | LogCode | The unique code of each error or warning. |
| 2 | LogName | The description of each error or warning. |
| 3 | LogType | <p>This field can have two values:</p><ul><li>**Error** – Users must take action to fix the issue.</li><li>**Warning** – The information is for awareness only. No action is required.</li></ul> |
| 4 | LogDetails | Details about records that have errors or warnings. You can use this information to take appropriate action. |
| 5 | Microsoftdocsurl | Use this URL to go to public documentation that can help you troubleshoot the issue. |
| 6 | Createddate | The date when the record was logged in the table. |

> [!NOTE]
>
> - Errors affect report accuracy and require immediate attention.
> - Warnings aren't critical but can affect report accuracy. If they're aligned with a valid business context, consider adjusting reports for accurate data representation.

For information about specific errors or warnings, see the following articles:

- [Missing fiscal calendar for general ledger: Error code: ERR00001 [Type: Error]](missing-fiscal-calendar-for-general-ledger-err00001.md)
- [Missing fiscal calendar for budget: Error code: ERR00002 [Type: Error]](missing-fiscal-calendar-for-budget-err00002.md)
- [Missing main account in budget: Error code: ERR00003 [Type: Warning]](missing-main-account-in-budget-err00003.md)
- [Missing journal entries: Error code: ERR00004 - [Type: Warning]](missing-journal-entries-err00004.md)
- [Mismatch between debits and credits: Error code: ERR00005 [Type: Warning]](mismatch-between-debits-and-credits-err00005.md)
- [Missing budget data: Error code: ERR00006 [Type: Warning]](missing-budget-data-err00006.md)
- [Missing budget transaction header: Error code: ERR00007 [Type: Warning]](missing-budget-transaction-header-err00007.md)
- [Missing foreign key reference: Error code: ERR00008 [Type: Warning]](missing-foreign-key-err0008.md)
- [Entity dataframe counts differ between prejoin and postjoin: Error code: ERR00009 [Type: Warning]](entity-dataframe-counts-err00009.md)
- [Missing main account in general ledger: Error code: ERR00010 [Type: Warning]](missing-main-account-in-gl-err00010.md)
- [Decimal limit exceeded: Error code: ERR00011 [Type: Warning]](decimal-limit-exceed-err00011.md)
- [Decimal auto rounding: Error code: ERR00012 [Type: Warning]](decimal-auto-rounding-err00012.md)

## See also

- [Create and edit business performance analytics reports](/dynamics365/finance/business-performance-analytics/how-to-create-and-edit-reports)
- [Business performance analytics FAQ](/dynamics365/finance/business-performance-analytics/bpa-faq)
