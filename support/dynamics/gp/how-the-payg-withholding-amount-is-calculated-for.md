---
title: How PAYG withholding amount is calculated
description: Describes how the PAYG withholding amount is calculated for the Australian version of Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 04/17/2025
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# How the PAYG withholding amount is calculated for the Australian version of Microsoft Dynamics GP

This article describes how Pay As You Go (PAYG) withholding is calculated for the different withholding types for the Australian version of Microsoft Dynamics GP. The calculations involve rounding, and this rounding may cause different results to a simple multiplication calculation.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949661

## Introduction

There are two main types of PAYG withholding which are calculated slightly differently:

- Standard PAYG Withholding: The standard PAYG withholding can be due to a voluntary agreement, labor hire agreement, and so on.
- No Australian Business Number (ABN) PAYG Withholding: This is PAYG withholding when the supplier has not provided an ABN.

The following is an excerpt from the "Statement of formulas for calculating amounts to be withheld" document from the Australian Taxation Office (ATO).

> [!NOTE]
> Scale 4 refers to withholding when no Tax File Number (TFN) or Australian Business Number (ABN) is provided.

*ROUNDING OF WITHHOLDING AMOUNTS*  
*Withholding amounts calculated as a result of applying the above formulas should be rounded to the nearest dollar. Values ending in exactly 50 cents are rounded to the next higher dollar. Do this rounding directly - that is, don't make a preliminary rounding to the nearest cent.*

*Use these rounding rules across all scales except scale 4 (where tax file number not provided by payee). For scale 4, cents are ignored when applying the tax rate to earnings and when withholding amounts are calculated.*  

The formulas for calculating the amount of PAYG withholding are displayed for the two types of withholding:

- Standard PAYG Withholding
- No ABN PAYG Withholding

## Standard PAYG Withholding

Withholding Amount = Round (Document Amount * Rate)

For example with a Document Amount = $531.90 and a Rate of 20.0%  
Withholding Amount = Round ($531.90 * 20.0%)

Withholding Amount = Round ($106.38)

Withholding Amount = $106.00

So $106.00 will be withheld for the ATO and the creditor will receive the balance of $425.90. Which gives a different result to the simple multiplication calculation without rounding:

Incorrect Withholding value = $531.90 * 20.0% = $106.38 leaving $425.52 for the creditor.

## No ABN PAYG Withholding

Withholding Amount = Truncate (Truncate (Document Amount) * Rate)

For example with a Document Amount = $531.90 and the No ABN Rate of 48.5%  
Withholding Amount = Truncate (Truncate ($531.90) * 48.5%)

Withholding Amount = Truncate ($531.00 * 48.5%)

Withholding Amount = Truncate ($257.535)

Withholding Amount = $257.00

So $257.00 will be withheld for the ATO and the Creditor will receive the balance of $274.90. Which gives a different result to the simple multiplication calculation without rounding:

Incorrect withholding value = $531.90 * 48.5% = $257.97 leaving $273.93 for the creditor.

## References

Australian Taxation Office - SCHEDULE 1: PAY AS YOU GO (PAYG) WITHHOLDING - "Statement of formulas for calculating amounts to be withheld".

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
