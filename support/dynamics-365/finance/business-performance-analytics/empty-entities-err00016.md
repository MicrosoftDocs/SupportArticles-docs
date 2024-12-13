---
title: Output Table Is Empty Error in Business Performance Analytics
description: Provides information about the Output table is empty error (error code ERR00016) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 12/13/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics\Business Performance Analytics (BPA)
---
# Output table is empty: Error code: ERR00016 [Type: Info]

This article provides a resolution for the Output table is empty error (error code ERR00016) that occurs in [Business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page) in Microsoft Dynamics 365 Finance.

## Symptoms

Error code *ERR00016* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This error occurs when an output table is empty but no errors occur during processing.

## Resolution

No immediate action is required. An output table is often empty because its corresponding input tables are empty. Therefore, the message is purely informational and doesn't indicate a problem. If the output table is incorrectly empty, it might be due to a delay in data synchronization. In such cases, we recommend observing the next few Business performance analytics runs to see if the issue resolves itself.

If the issue persists, confirm that the relevant data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft Support for further assistance.

Here's an example of a record:

> One or more output entities empty - Output dmo_salescontractbillingschedulenumberdim in Transform SalesContractBillingScheduleNumberDimTransform is empty!

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
