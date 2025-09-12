---
title: Decimal auto rounding error
description: Provides information about the Decimal auto rounding error (error code ERR00012) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/21/2024
ms.search.form: business-performance-analytics
audience: Application User
ms.custom: sap:Business intelligence, reporting, analytics
---
# Decimal auto rounding: Error code: ERR00012 [Type: Warning]

## Symptoms

Error code *ERR00012* is logged in the **Bpa self help logs** table in Microsoft Dataverse. This issue occurs when the decimal entries of certain columns in the final output of the dimensional model don't match the decimal limit of (19, 4), where `19` denotes the precision and `4` denotes the scale.

## Resolution

No immediate action is needed. This warning is displayed because a mismatch in decimal entries has been detected. The rounding process ensures that values conform to the required format without significantly impacting data accuracy. This warning is for informational purposes only to make you aware of the automatic rounding adjustment.

Here's an example of a record:

This warning is displayed if the `GeneralLedgerAmount` has a value **922337203687.58097** and needs to be rounded to **922337203687.5810** to fit in DECIMAL (19,4) in the General Ledger Fact tables in the output dimensional model.

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
