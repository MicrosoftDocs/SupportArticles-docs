---
title: Missing main account in general ledger error
description: Provides information about the Missing main account in general ledger error (error code ERR00010) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/21/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Missing main account in general ledger: Error code: ERR00010 [Type: Warning]

## Symptoms

Error code *ERR00010* is logged in the **Bpa self help logs** table in Microsoft Dataverse when general journal account entries in Dynamics 365 Finance are missing the corresponding main account entries in the ledger dimension column. To maintain data integrity, these records are excluded and aren't transferred to General Ledger Fact tables.

## Resolution

To solve this problem, you should fix the source data and associate the main account with these transactions. After the source data is fixed, it will be picked up as part of the next scheduled business performance analytics run, and the filtered records will start to be reflected in reports.

Here's an example of a record:

< BPA_DECIMAL_LIMIT_EXCEEDED. 6 values for column dmo_budgetjournallinenumber in output entity dmo_budgetfact have exceeded allowed limits for decimal(19, 4) >

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
