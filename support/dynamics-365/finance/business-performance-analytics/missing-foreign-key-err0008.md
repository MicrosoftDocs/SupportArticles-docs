---
title: Missing foreign key reference error
description: Provides information about the Missing foreign key reference error (error code ERR00008) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/21/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Missing foreign key reference: Error code: ERR00008 [Type: Warning]

## Symptoms

Error code *ERR00008* is logged in the **Bpa self help logs** table in Microsoft Dataverse when certain foreign key references can't be found in the parent entity. In this scenario, records in the Fact table are mapped to "Unknown."

## Resolution

No immediate action is required, because this issue might be caused by data synchronization delays. We recommend observing the next two to three Business performance analytics runs to see if the error resolves itself.

If the issue persists and the error is still in the **Bpa self help logs** table, contact Microsoft Support for further assistance.

Here's an example of a record:

```output
Foreign key constraint violated for dmo_bankregisterfact.dmo_subledgernumberkey referring dmo_subledgernumberdim.dmo_subledgernumberkey for 7 records.
Violation dmo_bankregistersourcekey - [Decimal('5637196796'), Decimal('35637199580'), Decimal('5637196797'), Decimal('35637199581'), Decimal('35637199579'), Decimal('35637199577'), Decimal('35637199576')]"]
```

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
