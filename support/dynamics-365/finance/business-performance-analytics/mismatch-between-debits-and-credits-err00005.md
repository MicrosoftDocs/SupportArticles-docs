---
title: Mismatch between debits and credits error
description: Provides information about the Mismatch between debits and credits error (error code ERR00005) in business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/30/2023
ms.prod: 
ms.technology:
ms.custom:
ms.search.form: business-performance-analytics
audience: Application User
---
# Mismatch between debits and credits: Error code: ERR00005 [Type: Warning]

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.

## Symptoms

Error code *ERR00005* is logged in the **Bpa self help logs** table in Microsoft Dataverse when the following conditions are met:

- The total of values in the `accountingcurrencyamount` column of the `generaljournalaccountentry` table isn't 0 (zero) for a specific combination of `ledger.id` and `gje.journalnumber`.
- The total of values in the `reportingcurrencyamount` column of the `generaljournalaccountentry` table isn't 0 (zero) for the same combination of `ledger.id` and `gje.journalnumber`.

## Resolution

This warning is for information only. No action is required.

The warning highlights instances where the total values in some columns don't balance to **0** (zero) for specific combinations of a ledger and a journal number. It might not indicate an error that requires immediate attention. Instead, consider this information as part of your overall financial data assessment.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
