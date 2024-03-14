---
title: Revenue recognition calculation for service fees
description: Describes the calculation that is used for revenue recognition for service fees in Project Accounting in Microsoft Dynamics GP.
ms.reviewer: theley, jchrist, lmuelle
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# Information about the revenue recognition calculation for service fees in Project Accounting

This article discusses information about service fees in Project Accounting in Microsoft Dynamics GP. This article also discusses how the revenue recognition amount is calculated.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 885070

A service fee can be set up for any time period that you specify. The percent complete is based on the total number of days for the service fee. The **Begin Date** field and the **End Date** field are used to calculate the number of days for the service fee.

Then, the percent complete is multiplied by the fee amount to obtain the revenue recognition amount. Billing has no affect on the amount that is recognized.

The following examples show how the revenue recognition amount is calculated:

- Service fee example 1

  **Fee Amount**: $10,000  
  **Begin Date**: 1/1/2007  
  **End Date**: 4/30/2007  
  **Total Number of Days** = 121 days (31 + 29 + 31 + 30)

  If revenue recognition is run with a cutoff date of 2/15/2007, the percent complete is calculated as follows:

  **Percent Complete** = ((31 + 15) - 1) / (121 - 1) = 0.375 = 37.50%  
   **Amount Recognized** = 37.50% * $10,000 = $3750

- Service fee example 2

  **Fee Amount**: $1000  
  **Begin Date**: 1/1/2006  
  **End Date**: 2/29/2007  
  **Total Number of Days** = 425 days (365 + 31 + 29)

  If revenue recognition is run with a cutoff date of 2/15/2007, the percent complete is calculated as follows:

  **Percent Complete** = ((365 + 31 + 15) - 1) / (425 - 1) = 0.9669811 = 96.70%  
  **Amount Recognized** = 96.70% * $1000 = $967
