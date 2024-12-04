---
title: Data quality ERR00015 in Business performance analytics
description: Provides information about the Data quality error (error code ERR00015) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 12/04/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics\Business Performance Analytics (BPA)
---
# Data quality error: Error code: ERR00015 [Type: Warning]

This article provides a resolution for the Data quality error (error code ERR00015) that occurs in [Business performance analytics](/dynamics365/finance/business-performance-analytics/business-performance-analytics-home-page) in Microsoft Dynamics 365 Finance.

## Symptoms

When inputs are processed in the [dimensional data model](/dynamics365/finance/business-performance-analytics/business-performance-analytics-data-model), an unresolvable error occurs, and the *ERR00015* error code is logged in the **Bpa self help logs** table in Microsoft Dataverse. In this case, the output table is empty, and reports are missing data. The details of the unresolvable error are included in the log details.

Here's an example of a record:

> One or more data quality issues found - Primary key constraint violated with 1 duplicate count for dmo_generalledgerfact.dmo_generalledgerfactid

## Resolution

The following table lists the errors and the related resolutions.

|Error|Example of the error|Resolution|
|--|--|--|
|Primary key violations| Here are examples of two messages that can be logged for primary key violations: <br> - Primary key constraint violated with `1` duplicate count for dmo_budgetfact.dmo_budgetfactid. <br> - Primary key constraint violated with `1` null count for dmo_budgetfact.dmo_budgetfactid.| Contact Microsoft Support for assistance.|
|Alternate key violation|Alternate key constraint AK1 violated with `1` duplicates and `1` null values for dmo_budgetkey.| Contact Microsoft Support for assistance.|
|Null guid violation|Not null guid constraint violated with `1` null values for dmo_budgetfact.dmo_budgetfactid.|Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft Support for further assistance.|
|Null DateTime violation|Not Null DateTime constraint violated with `1` null values for dmo_budgetfact.dmo_budgetpostingtimestamputc.|Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft Support for further assistance.|
|Empty string violation|Not empty string constraint violated with `1` empty values for dmo_generalledgerfact.dmo_generalledgercurrency.|Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft Support for further assistance.|

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
