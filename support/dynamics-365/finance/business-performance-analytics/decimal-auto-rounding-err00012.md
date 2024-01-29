---
title: Decimal auto rounding error
description: Provides information about the Decimal auto rounding error (error code ERR00012) in business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 01/29/2024
ms.search.form: business-performance-analytics
audience: Application User
---
# Decimal auto rounding: Error code: ERR00012 [Type: Warning]

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.

## Symptoms

Error code *ERR00012* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This issue occurs when the decimal entries of certain columns in the final output of the dimensional model don't match the decimal limit of (19, 4), where `19` denotes the precision and `4` denotes the scale.

## Resolution

No immediate action is needed because this issue might be caused by a mismatch in the decimal entries.

Here's an example of a record:

This warning is displayed if the `GeneralLedgerAmount` has a value **922337203687.58097** and needs to be rounded to **922337203687.5810** to fit in DECIMAL (19,4) in the General Ledger Fact tables in the output dimensional model.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
