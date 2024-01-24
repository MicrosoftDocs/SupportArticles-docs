---
title: Missing foreign key reference error
description: Provides information about the  Missing foreign key reference error (error code ERR00008) in business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 1/23/2024
ms.prod: 
ms.technology:
ms.custom:
ms.search.form: business-performance-analytics
audience: Application User
---
# Missing foreign key reference error: Error code: ERR00008 [Type: Warning]

> [!NOTE]
> The functionality that's described in this article is available as part of a preview release. The functionality and the content of this article are subject to change. For more information about how to participate in the public preview for [business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page), contact <bpaquestions@service.microsoft.com>.
## Symptoms
Error code *ERR00008* is logged in the **Bpa self help logs** table in Microsoft Dataverse when certain foreign key references can't be found in the parent entity. In this scenario, records in Fact table would be 
mapped to “Unknown”.

## Resolution

No immediate action is required. This issue might stem from data synchronization delays. We recommend observing the next two to three Business performance analytics runs to see if the error resolves itself.  
If the issue persists and the error is in the **Self help log** table, it's recommended contact Microsoft support for further assistance. 

Here's an example of a record:

Foreign key constraint violated for dmo_bankregisterfact.dmo_subledgernumberkey referring dmo_subledgernumberdim.dmo_subledgernumberkey for 7 records. 
Violation dmo_bankregistersourcekey - [Decimal('5637196796'), Decimal('35637199580'), Decimal('5637196797'), Decimal('35637199581'), Decimal('35637199579'), Decimal('35637199577'), Decimal('35637199576')]"]

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
