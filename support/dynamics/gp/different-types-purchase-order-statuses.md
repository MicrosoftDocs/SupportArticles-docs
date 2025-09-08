---
title: Different types of purchase order statuses
description: Describes the different types of purchase order statuses in Microsoft Dynamics GP.
ms.reviewer: theley, jchrist
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# The different types of purchase order statuses in Microsoft Dynamics GP

This article describes the different types of purchase order statuses in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861607

## Introduction

The different types of purchase order statuses are as follows.

## New

A purchase order is assigned a New status when it's saved for the first time, and before it has been released to the vendor. A new purchase order can exist without line items. If you change a new purchase order, the purchase order still has a New status. The inventory quantities aren't adjusted when the new purchase order is entered. The inventory quantities are adjusted when the purchase order line status changes to a Released status.

## Released

A Released status indicates that the purchase order has been sent to the vendor. A new purchase order is assigned a Released status if at least one purchase order line changes from a New status to a Released status. Or, a new purchase order is assigned a Released status if a receipt is posted. If a change order purchase order is printed, it changes the status to Released. Additionally, this change results in at least one released purchase order line. This change also results in no remaining change order purchase order lines.

When a purchase order has a Released status, the following amounts increase for any purchase order lines that change to a Released status:

- Inventory on Order Quantity
- Item/Vendor on Order Quantity
- Vendor on Order Currency

## Received

A purchase order is assigned a Received status if there are no quantities remaining to receive, and if there are quantities that remain to be invoiced. A purchase order that has a Received status can have a combination of the following line items:

- Received
- Canceled
- Closed

## Change Order

A Change Order status notifies users that the original order is no longer valid. If a purchase order that has a Released status is edited in a manner that affects the vendor, the purchase order is assigned a Change Order status, and the revision number increases. Use the revision number to make sure that you and the vendor refer to the same order. The revision number doesn't increase if you change a purchase order that already has a Change Order status.

## Canceled

A Canceled status indicates that the purchase order will not be processed anymore. A purchase order is assigned a Canceled status if all the line items have been canceled, and if no amounts have been received against the line items.

To change a Canceled status, change at least one of the canceled line items to a New status or to a Change Order status.

You can transfer a purchase order that has a Canceled status to history. To do it, use the Remove Completed Purchase Orders window. You can remove the purchase order by using the Remove Purchasing History window.

## Closed

A purchase order is assigned the Closed status if all the line items have been closed, and if there are no remaining quantities to receive or to match to invoices. A purchase order that has a Closed status can also have canceled lines.
