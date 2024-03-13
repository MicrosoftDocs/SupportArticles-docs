---
title: Description of the source of the value in Actual Demand
description: Describes where Microsoft Dynamics GP looks when it determines the value of the Actual Demand field in the Manufacturing Entry window in Microsoft Dynamics GP.
ms.reviewer: aeckman
ms.date: 03/13/2024
---
# Description of the source of the value in the "Actual Demand" field in the Manufacturing Entry window in Microsoft Dynamics GP

This article describes the source of the value in the **Actual Demand** field in the Manufacturing Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921227

## More information

You can enter a manufacturing order in the following two ways:

1. From a sales order in Sales Order Processing
2. Through Manufacturing

> [!NOTE]
> In the second case, you link the manufacturing order to a sales order in Sales Order Processing. This link is referred to as the MOP/SOP link.

The value in the **Actual Demand** field is based on how you enter the manufacturing order. If you enter the manufacturing order from a sales order, the value in the **Actual Demand** field is the backorder quantity from the manufacturing order that you enter from the sales order. If you use the MOP/SOP link to enter the manufacturing order, the value in the **Actual Demand** field is the backorder quantity from the sales order that is entered in Sales Order Processing.
