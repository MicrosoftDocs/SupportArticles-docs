---
title: Entity dataframe counts differ between prejoin and postjoin
description: Provides information about the Entity dataframe counts differ between prejoin and postjoin error (error code ERR00009) in business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 01/29/2024
ms.search.form: business-performance-analytics
audience: Application User
---
# Entity dataframe counts differ between prejoin and postjoin: Error code: ERR00009 [Type: Warning]

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.

## Symptoms

In the business performance analytics dimensional data model, the number of rows in any fact or dimension should match the number of rows in the Dynamics 365 Finance driving table. To ensure this, business performance analytics internally performs multiple checks when joining multiple tables during transformation. In any of these joins, if the count of rows in the output is different from the source table, error code *ERR00009* is logged in the **Bpa self help logs** table in Microsoft Dataverse.

## Resolution

No immediate action is required because this issue might be caused by data synchronization delays. We recommend observing the next two to three business performance analytics runs to see if the error resolves itself.

If the issue persists and the error is still in the **Bpa self help logs** table, contact Microsoft Support for further assistance.

Here's an example of a record:

```output
BPA_COUNT_CHECKVIOLATION. There is a mismatch in the row count of tables used to generate the General Ledger Account Dim dimensional table.
Details: mserp_ledgertransvoucherlinkbientity join violated count check.
Prejoin count – 40550, Postjoin count - 40450
```

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
