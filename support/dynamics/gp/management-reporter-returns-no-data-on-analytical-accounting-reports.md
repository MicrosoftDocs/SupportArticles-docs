---
title: Management Reporter returns no data on Analytical Accounting reports
description: Describes a problem with Analytical Accounting reports after you change to the GP DDM provider.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Analytical Accounting
---
# Management Reporter 2012 may return no data on Analytical Accounting reports after changing to the GP DDM provider

This article provides a resolution for the issue that Management Reporter 2012 Analytical Accounting report may return no data after you change from GP Legacy to GP DDM provider.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2785525

## Symptoms

Your Management Reporter 2012 Analytical Accounting report may return no data after you change from GP Legacy to GP DDM provider. You may also see Plus Signs (+) in your row definitions under the Link to Financial Dimension column.

## Cause

Management Reporter uses the dimension name to identify the AA segments used in your report definitions. These dimension names are pulled into the GP DDM provider differently than the Legacy provider. If the dimension name in the report does not match the name in GP DDM, the report will not generate correctly.

Example:

In Microsoft Dynamics GP, select **Cards**, point to **Financial**, point to **Analytical Accounting** and then select **Transaction Dimension**. You see an AA dimension with a "Trx Dimension" = "AIRLINE" and a "Description" = "Airline Company".

- GP Legacy provider would use "Airline Company" in Report Designer on your reports.
- GP DDM provider would use "AIRLINE" in Report Designer on your reports.

## Resolution

Contact Support for assistance with synchronizing the AA dimension names in your Management Reporter reports with your GP DDM database.
