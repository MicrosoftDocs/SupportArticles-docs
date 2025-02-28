---
title: Mismatch between debits and credits error
description: Provides information about the Mismatch between debits and credits error (error code ERR00005) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/21/2024
ms.custom: sap:Business intelligence, reporting, analytics
ms.search.form: business-performance-analytics
audience: Application User
---
# Mismatch between debits and credits: Error code: ERR00005 [Type: Warning]

## Symptoms

Error code *ERR00005* is logged in the **Bpa self help logs** table in Microsoft Dataverse when the following conditions are met:

- The total of values in the `accountingcurrencyamount` column of the `generaljournalaccountentry` table isn't 0 (zero) for a specific combination of `ledger.id` and `gje.journalnumber`.
- The total of values in the `reportingcurrencyamount` column of the `generaljournalaccountentry` table isn't 0 (zero) for the same combination of `ledger.id` and `gje.journalnumber`.

## Resolution

This warning is for information only. No action is required.

The warning highlights instances where the total values in some columns don't balance to **0** (zero) for specific combinations of a ledger and a journal number. It might not indicate an error that requires immediate attention. Instead, consider this information as part of your overall financial data assessment.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
