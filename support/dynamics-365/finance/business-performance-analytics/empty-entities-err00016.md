---
title: Output table is empty error in Business performance analytics
description: Provides information about when an Output table is empty error (error code ERR00016) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 12/04/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics\Business Performance Analytics (BPA)
---
# Output table is empty:Error code: ERR00016 [Type: Info]

This article provides a resolution for the Output table is empty error (error code ERR00016) that occurs in [Business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page) in Microsoft Dynamics 365 Finance.

## Symptoms

Error code *ERR00016* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This error occurs when an output table is empty but no errors occur during processing.

## Resolution

No immediate action is required. Most often an output is empty because its corresponding input tables were empty, making the message is strictly informational and not indicative of a problem. If the output table is incorrectly empty, it might be due to a delay in data synchronization. In such cases, it's recommended to observe the next few Business performance analytics runs to see if the issue resolves itself.

If the issue persists, confirm that the relevant data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft Support for further assistance.

Here's an example of a record:

> One or more output entities empty - Output dmo_salescontractbillingschedulenumberdim in Transform SalesContractBillingScheduleNumberDimTransform is empty!

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
