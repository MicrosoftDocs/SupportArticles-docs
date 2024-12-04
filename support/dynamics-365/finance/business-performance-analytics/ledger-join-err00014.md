---
title: Null join violation error
description: Provides information about the Null join violation error (error code ERR00014) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 12/04/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics\Business Performance Analytics (BPA)
---
# Null join violation Error code: ERR00014 [Type: Warning]

This article provides a resolution for the Null join violation error (error code ERR00014) that occurs in [Business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page) in Microsoft Dynamics 365 Finance.

## Symptoms

Error code *ERR00014* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This error occurs when records are missing from an input table. The missing data could impact the accuracy of your reports.

## Resolution

Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.

Here's an example of a record:

> mserp_mainaccountbientity join violated Null check. bf830f89-5736-4988-9a31-0caf982e9962_Id cannot be null in dmo_generalledgerfact.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
