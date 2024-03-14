---
title: MRP is suggesting to create a Purchase Order instead of Moving in an existing PO
description: Provides a solution to an issue where MRP is suggesting to create a Purchase Order instead of moving in an existing PO.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# MRP is suggesting to create a Purchase Order instead of moving in an existing PO in Microsoft Dynamics GP

This article provides a solution to an issue where MRP is suggesting to create a Purchase Order instead of moving in an existing PO.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2288415

## Symptom

MRP is suggesting to create a Purchase Order instead of moving in an existing Purchase Order that is already in the system.

## Cause

This is the design of the software.

Potential reasons why MRP will not move Purchase Orders:

- An order will not be suggested for moving in if the status is not Quote/Estimate, Open, or Released for MO's OR New, Released, or Change order for PO's.

- Orders will not be moved if MOP/SOP or SOP/POP links exist or, in the case of Manufacturing Orders, there is data collection activity, pending CTE transactions or quantities issued or backflushed. These particular checks are made in the MRPV4001 view.

- Orders will also not be suggested for moving if doing so would create an oversupply situation for the Projected Available Balance (PAB) and the Order Up to Level (ORDRUPTOLVL) isn't zero.

## Resolution

Increase your Order Up to Level on the Item Resource Planning window for that site.

Cards > Inventory > Item Resource Planning. Select your item and site and update the Order Up to Level.

Or decrease the size of the existing Purchase Order, so that it doesn't result in an oversupply situation.
