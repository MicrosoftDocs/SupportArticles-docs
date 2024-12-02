---
title: Data quality error
description: Provides information about the Data quality error (error code ERR00015) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 12/02/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Data quality error: Error code: ERR00015 [Type: Warning]

## Symptoms

Error code ERR00015 is logged in the Bpa self help logs table in Microsoft Dataverse when unresolvable errors are encountered while processing inputs in the dimensional model. In this case, the output table will be empty and reports will be missing data. The specifics of the unresolvable errors will be included in the log details. 

## Resolution

The resolution depends on the specific error. Below is a list of the errors and how to address them. If the issue persists after attempting resolution, contact Microsoft support for further assistance.

Here’s an example of a record:

One or more data quality issues found - Primary key constraint violated with 1 duplicate count for dmo_generalledgerfact.dmo_generalledgerfactid

### Primary key violations
For primary key violations, contact Microsoft support for assistance.
There are two messages that can be logged for primary key violations. 

Here are examples of the error messages:
**Primary key constraint violated with 1 duplicate count for dmo_budgetfact.dmo_budgetfactid.**
**Primary key constraint violated with 1 null count for dmo_budgetfact.dmo_budgetfactid.**


### Alternate key violation
For alternate key violations, contact Microsoft support for assistance.

Here’s an example of the error message:

**Alternate key constraint AK1 violated with 1 duplicates and 1 null values for dmo_budgetkey.**


### Null guid violation
Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.

Here’s an example of the error message:

**Not null guid constraint violated with 1 null values for dmo_budgetfact.dmo_budgetfactid.**


### Null DateTime violation
Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.

Here’s an example of the error message:

**Not Null DateTime constraint violated with 1 null values for dmo_budgetfact.dmo_budgetpostingtimestamputc.**


### Empty string violation
Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.

Here’s an example of the error message:

**Not empty string constraint violated with 1 empty values for dmo_generalledgerfact.dmo_generalledgercurrency.**


## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)

