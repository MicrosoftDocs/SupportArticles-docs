---
title: What to expect when processing an Inventory transfer on Microsoft Dynamics GP 9.0 or later that originated on Microsoft Business Solutions-Great Plains 8.0
description: Describes an issue where the Average Cost is recalculating differently than what was expected.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# What to expect when processing an Inventory transfer on Microsoft Dynamics GP 9.0 or later that originated on Microsoft Business Solutions-Great Plains 8.0

This article describes an issue where the Average Cost is recalculated differently than what was expected.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2006694

## Symptoms

An Inventory Transfer for an Average Cost item has been posted and the Average Cost is recalculating differently than what was expected.

## Cause

Consider the following example:

1. An Inventory Item with Item Number AVERAGE was created.
2. An Inventory Adjustment was posted for AVERAGE with a quantity of 10 and a cost of $1.00 using the date of 4/1/2017 into site WAREHOUSE.
3. Another Inventory Adjustment was posted for AVERAGE with a quantity of 10 and a cost of $2.00 using the date of 4/2/2017 into site WAREHOUSE.
4. An Inventory Transfer was posted for AVERAGE with a quantity of 10 using the date of 4/3/2017, transferring the inventory to NORTH from WAREHOUSE.

## Resolution

In the example, if all of the steps that took place happened when using Microsoft Dynamics GP 9.0 or later, you would see the average cost now show as $1.50. It's reflected by the ADJUNITCOST field in the IV10200 showing 1.50 for the newest transfer into the NORTH site.

When the Inventory Transfer takes place (Step #4) the system writes an outflow record into the IV10201 table. It occurs because quantities at the WAREHOUSE site are being consumed.
The UNITCOST field in the IV10201 will be populated with the current cost since progressive dated transactions are being entered and there's no backdating. In the example, the current cost used would be $1.50 as it's the current cost of the receipt layer entered in Step #3.

Next, the receiving for the NORTH site is written into the IV10200 table. The cost used for this receipt layer is matched to the outflow record written in the IV10201. So the cost that the Inventory went out at from WAREHOUSE is the cost used for the receiving into NORTH.

If you had used Microsoft Business Solutions - Great Plains 8.0 and upgraded after processing the adjustments and before entering the Inventory Transfer (Step #4), the calculation will be different. It's because of the new fields added to the IV10200. These new fields will only be populated on the most recent receipt layer with a quantity on hand on the date of the upgrade. This process is often referred to as "stamping" the receipt layer. In the example above, the receipt layer entered in Step #2 wouldn't be stamped, but the receipt layer entered in Step #3 would be stamped.

This behavior could change the average cost calculation because when the Inventory transfer takes place (Step #4) an outflow record wouldn't be written to the IV10201 table. Because the layer that's being consumed is the first, unstamped layer. Any unstamped layer won't have a record written to the IV10201 table. So when the receipt record for the NORTH site is written into the IV10200 table it isn't going to be pulling the cost from the IV10201 for the quantity being consumed. It can't do this operation since a record doesn't exist. What happens in this case is that the system will then look to the IV10200 record being consumed and use the UNITCOST from that layer as the UNITCOST for the receiving into NORTH.

If that UNITCOST happens to be different than the ADJUNITCOST in the previously entered record in the IV10200, then there will be a recalculation of the average cost.

It may be confusing since the quantity on hand didn't change and there was no backdating, so some may wonder why the cost does.

Make sure to understand the following points:

1. This behavior isn't going to happen once all of the unstamped receipt layers are consumed.

2. If you don't want to see this behavior occur for the unstamped records entered before the upgrade, then implement the Historical Inventory Trial Balance (HITB) Report and run the IV Reset process. This operation will stamp all of the unrelieved records in the IV10200 table. So when an Inventory Transfer takes place, all purchase receipt records would be stamped and write outflow records into the IV10201.
