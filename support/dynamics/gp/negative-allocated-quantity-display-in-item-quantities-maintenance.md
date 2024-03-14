---
title: A negative allocated quantity in Inventory Control is displayed in the Item Quantities Maintenance window in Microsoft Dynamics GP
description: Describes how to resolve an issue in which the Item Quantities Maintenance window displays a negative allocated quantity.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# A negative allocated quantity in Inventory Control is displayed in the Item Quantities Maintenance window in Microsoft Dynamics GP

This article provides a solution to an issue where a negative allocated quantity appears in the Item Quantities Maintenance window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850365

## Symptoms

A negative allocated quantity appears in the Item Quantities Maintenance window in Microsoft Dynamics GP.

Allocated quantity is defined by the following equation:

On hand quantity - quantity available = quantity allocated

## Cause

The quantity fields in the Item Quantities Maintenance window are populated from the quantity fields in the Item Quantity Master table. A negative allocated quantity does not occur when Microsoft Dynamics GP works as designed. However, there several scenarios where this issue may occur, including the following scenarios:

- Transactions have been imported incorrectly.
- A third-party product has affected posting.
- A posting interruption has occurred and the Item Quantity Master table was updated incorrectly.

## Resolution

To correct the negative allocated quantities, use the reconcile utility. To use the reconcile utility, follow the appropriate steps in the following modules:

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

- Reconcile Sales Order Processing
  - Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

    On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Sales**, and then click **Reconcile - Remove Sales Documents**.
  - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

    On the **Tools** menu, point to **Utilities**, point to **Sales**, and then click **Reconcile - Remove Sales Documents**.

- Reconcile Purchase Order Processing
  - Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

    On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Purchasing**, and then click **Reconcile Purchasing Documents**.
  - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

    On the **Tools** menu, point to **Utilities**, point to **Purchasing**, and then click **Reconcile Purchasing Documents**.

- Reconcile Inventory
  - Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

    On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Inventory**, and then click **Reconcile**.
  - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

    On the **Tools** menu, point to **Utilities**, point to **Inventory**, and then click **Reconcile**.

- Reconcile Field Service

    > [!NOTE]
    > This step is required only if you are using any of the Field Service functionalities on a version that is earlier than Microsoft Dynamics GP 10.0 Service Pack 2. In Microsoft Dynamics GP 10.0 Service Pack 2 and later versions, the Field Service reconcile is performed when you reconcile Inventory in the Reconcile Inventory Quantities window.
  - Microsoft Dynamics GP 10.0

    On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, point to **Service Utilities**, and then click **Reconcile Quantities**.
  - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

    On the **Tools** menu, point to **Utilities**, point to **Project**, point to **Service Utilities**, and then click **Reconcile Quantities**.

- Reconcile Project Accounting
  - Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

    On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, and then click **PA Reconcile IV**.

    - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

    On the **Tools** menu, point to **Utilities**, point to **Project**, and then click **PA Reconcile IV**.

## More information

If you are using Intellisol Advanced Purchase Order Processing, reconcile the modules in the following order:

1. Sales Order Processing
2. Inventory
3. Advanced Purchase Order
4. Field Service

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
