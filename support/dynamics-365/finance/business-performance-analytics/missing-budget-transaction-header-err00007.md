---
title: Missing budget transaction header error
description: Provides information about the Missing budget transaction header error (error code ERR00007) in business performance analytics in Microsoft Dynamics 365 Finance.
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
# Missing budget transaction header: Error code: ERR00007 [Type: Warning]

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.

## Symptoms

Error code *ERR00007* is logged in the **Transform Log** table in Microsoft Dataverse when there are budget transaction line entries that don't have corresponding budget transaction headers. These records are excluded and won't be transferred to fact tables. Some Microsoft reports might show either fields that have no data or incomplete records. In these cases, you might have to create modified versions of the reports to address the gaps and ensure accurate reporting.

## Resolution

No immediate action is required, because this issue might be caused by data synchronization delays. We recommend that you observe the next few business performance analytics runs to see whether the issue is fixed.

If the issue persists, confirm that the entries exist in the Budget transaction header table in Dynamics 365 Finance.

If the entries exist, contact Microsoft Support for further assistance.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
