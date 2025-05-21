---
title: Size of Request XML Exceeds Maximum Allowed Value Error
description: Resolves the size of the request xml exceeds the maximum allowed value error in the Warehouse Management mobile app.
ms.date: 03/13/2025
# ms.search.form:
audience: Application User
ms.reviewer: kamaybac, ivanma
ms.search.region: Global
ms.author: ivanma
ms.search.validFrom: 2025-03-03
ms.dyn365.ops.version: 10.0.39
ms.custom: sap:Warehouse management
---
# "The size of the request xml exceeds the maximum allowed value" error in the Warehouse management mobile app

This article provides a resolution for "The size of the request xml exceeds the maximum allowed value" error that occurs in the [Warehouse Management mobile app](/dynamics365/supply-chain/warehousing/install-configure-warehouse-management-app).

## Symptoms

When you open a [Display open work list](/dynamics365/supply-chain/warehousing/configure-mobile-devices-warehouse#configure-menu-items-for-activities-and-inquiries) mobile device flow in the Warehouse Management mobile app, you might receive the following error message:

> The size of the request xml exceeds the maximum allowed value.

## Cause

The Warehouse Management mobile app communicates with the Dynamics 365 Supply Chain Management service through an XML file. The system has a built-in limit on the size of this XML file. If there are many warehouse work items to be displayed in the Warehouse Management mobile app, the XML file size might exceed this limit.

## Resolution

To resolve this issue, follow these steps to reduce the number of warehouse work items shown in the Warehouse Management mobile app:

1. Open the **Mobile device menu items** form by navigating to **Warehouse management** > **Setup** > **Mobile device** > **Mobile device menu items**.
1. Find the impacted menu item.
1. Select the **Edit query** button in the Action Pane.
1. Edit the query to reduce the number of displayed warehouse work items.

For more information about editing the queries, see [User-configurable queries in Warehouse management](/dynamics365/supply-chain/warehousing/user-configurable-queries-in-warehouse-management).
