---
title: Null join violation
description: Provides information about the Null join violation error (error code ERR00014) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 12/2/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Null join violation Error code: ERR00014 [Type: Warning]

## Symptoms

Error code *ERR00014* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This error occorus when records are missing from an input table. The missing data could impact the accuracy of your reports. 

## Resolution

Validate the source data exists in Dynamics 365 Finance. If the data exists but the issue persists, contact Microsoft support for further assistance.

Here’s an example of a record:

mserp_mainaccountbientity join violated Null check. bf830f89-5736-4988-9a31-0caf982e9962_Id cannot be null in dmo_generalledgerfact.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
