---
title: Reconcile inventory quantities
description: Describes the order in which you reconcile inventory quantities when you use the Inventory Control module, the Field Service module, or the Project Accounting module in Microsoft Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# How to reconcile inventory quantities in Microsoft Great Plains when you use Inventory Control, Field Service, or Project Accounting

This article describes the order in which you must reconcile inventory quantities in Microsoft Business Solutions - Great Plains when you use the Inventory Control module, the Field Service module, or the Project Accounting module.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 898998

## Introduction

To reconcile inventory quantities, follow these steps in order:

## More Information

1. Reconcile the Sales Order Processing module. To do it, select **Tools**, select **Utilities**, select **Sales**, and then select **Reconcile - Remove Sales Documents**. Select the **Reconcile and Print Report** check box, and then select **Process**.
2. Reconcile the Purchase Order Processing module. To do it, select **Tools**, select **Utilities**, select **Purchasing**, and then select **Reconcile Purchasing Documents**. Select the **Reconcile and Print Report** check box, and then select **Process**.
3. Reconcile the Inventory module. To do it, select **Tools**, select **Utilities**, select **Inventory**, and then select **Reconcile**.
4. Reconcile the Project module. To do it, select **Tools**, select **Utilities**, select **Project**, and then select **PA Reconcile IV**.
5. Reconcile the Field Service module. To do it, select **Tools**, select **Utilities**, select **Project**, select **Service Utilities**, and then select **Reconcile Quantities**.
