---
title: Null check violation
description: Provides information about the Null check violation error (error code ERR00013) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/20/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Null check violation Error code: ERR00013 [Type: Warning]

## Symptoms

Error code ERR00013 is logged in the Bpa self help logs table in Microsoft Dataverse when a required field lacks data in the final output of the dimensional model. The missing required data will be replaced with the default value -1 and could impact the accuracy of your reports. 

## Resolution

Validate that the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.

Here’s an example of a record:

Not Null constraint violated with 1 null values for ExampleTable.ExampleColumn. dmo_generalledgerfact.dmo_generalledgercurrency.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
