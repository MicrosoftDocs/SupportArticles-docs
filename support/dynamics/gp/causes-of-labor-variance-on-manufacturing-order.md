---
title: Causes of labor variance that occurs on a manufacturing order
description: Describes the causes of labor variance that occurs on a manufacturing order.
ms.reviewer: theley, beckyber
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# Description of the causes of labor variance when you enter standard cost manufacturing orders and when all labor is backflushed in Manufacturing in Microsoft Dynamics GP

This article describes the causes of labor variance when you enter standard cost manufacturing orders and when all labor is backflushed in Manufacturing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927318

## Summary

A labor variance may occur on the manufacturing order. This variance occurs when there is a setup labor that is assigned to a routing for a standard cost item and when the labor is backflushed. The amount in the **Cost put into WIP** field and the amount in the **Cost Consumed from WIP** field determine whether there is a labor variance for the standard cost manufacturing order.

For the amounts in these fields, the calculation varies depending on:

- Whether the setup labor is prorated for the standard cost item.
- Whether the prorating is based on the standard quantity or the average quantity. To access the prorating options, open the Costing Preference Defaults window. To do this, point to **Setup** on the **Tools** menu, point to **Manufacturing**, point to **System Defaults**, and then click **Costing**.

The amount in the **Cost Put into WIP** field and the amount in the **Cost Consumed from WIP** field are calculated by using one of the following methods.

## The setup labor is not prorated

1. Cost Put into WIP = Setup Time from the Routing
2. Cost Consumed from WIP = (Setup Time from the Routing) x (MO Quantity)

If the MO Quantity is 1, there will be no labor variance.

## The setup labor is prorated by using the average quantity

1. Cost Put into WIP = (Setup Time from the Routing) / (Average Quantity)
2. Cost Consumed from WIP = (Setup Time from the Routing / Average Quantity) x (MO Quantity)

If the MO Quantity is 1, there will be no variance.

If the MO Quantity matches the Average Quantity, there will be a labor variance.

## The setup labor is prorated by using the standard quantity

1. Cost Put into WIP = Setup Time from the Routing
2. Cost Consumed from WIP = (Setup Time from the Routing / Standard Quantity) x (MO Quantity)

If the MO Quantity is equal to the Standard Quantity, there will be no labor variance.
