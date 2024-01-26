---
title: Decimal limit exceeded error
description: Provides information about the Decimal limit exceeded error (error code ERR00011) in business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 01/26/2024
ms.search.form: business-performance-analytics
audience: Application User
---
# Decimal limit exceeded error: Error code: ERR00011 [Type: Warning]

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.

## Symptoms

Error code *ERR00011* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This issue occurs when the entries in certain decimal data type columns in dimensional model are outside the maximum (922337203685477.5807) and minimum (-922337203685477.5807) value supported by decimal(19, 4). This is the decimal precision, scale required by Power BI. For more information, see [Data types used in tabular models](/analysis-services/tabular-models/data-types-supported-ssas-tabular?view=asallproducts-allversions#bkmk_data_types).

## Resolution

No immediate action is needed. This warning highlights data in source tables that don't fit in the Power BI Decimal fields. Business performance analytics attempts to automatically round the value for such fields and might result in rounded values appearing in the output.

Here's an example of a record:

This warning is written if the `GeneralLedgerAmount` turns out to be **922337203685478** in the General Ledger Fact in the output dimensional model. In such cases, the `GeneralLedgerAmount` will be set to the maximum value for DECIMAL(19,4) = **922337203685477.5807**.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
