---
title: Output table is empty
description: Provides information about when an Output table is empty error (error code ERR00016) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/20/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Output table is empty:Error code: ERR00016 [Type: Info]

## Symptoms

Error code ERR00016 is logged in the Bpa self help logs table in Microsoft Dataverse when an output table is empty but no errors were encountered during processing.

## Resolution

No immediate action is required. Most often an output will be empty because its corresponding input tables were empty and so the message is strictly informational, not indicative of a problem. If the output table is incorrectly empty, it could be caused by a delay in data synchronization. In that case, we recommend that you observe the next few Business performance analytics runs to see whether the issue is fixed.
If the issue persists, confirm that the relevant data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.


Here’s an example of a record:
One or more output entities empty - Output dmo_salescontractbillingschedulenumberdim in Transform SalesContractBillingScheduleNumberDimTransform is empty!


## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview


