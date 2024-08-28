---
# required metadata

title: Tips for troubleshooting India GST performance issues
description: Provides troubleshooting information for India GST performance issues.
author: shaoling
ms.date: 08/27/2024

# optional metadata

#ms.search.form:
audience: Application user
# ms.devlang: 
ms.reviewer:

# ms.tgt_pltfrm: 
ms.search.region: India
# ms.search.industry: 
ms.author: shaoling
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---

# Tips for troubleshooting India GST performance issues

This article lists some tips for toubleshooting India GST performance issue.

## Mark as dirty instead of calculating tax frequently
For performance issues caused by calling the method `TaxBusinessService::calculateTax` too frequently, check if it is necessary to calculate tax so often. The best practice is to call this method only when the tax result is needed immediately. Otherwise, call `TaxBusinessService::markTaxDocumentTaxStatus` to mark the tax document status as dirty. This approach avoids duplicate tax calculations and improve performance.

## Enable delayed tax calculation on journal
By default, sales tax amounts on journal lines are calculated whenever tax-related fields are updated. These fields include the fields for sales tax groups and item sales tax groups. Any update to a journal line causes tax amounts to be recalculated for all journal lines. Although this behavior helps user see tax amounts calculated in real time, it can also affect performance if the number of journal lines is very large.

This article [Enable delayed tax calculation on journals](https://github.com/MicrosoftDocs/Dynamics-365-Unified-Operations-Public/blob/main/articles/finance/general-ledger/enable-delayed-tax-calculation.md) explains how you can delay sales tax calculation on journals. This capability helps improve the performance of tax calculations when there are many journal lines.





