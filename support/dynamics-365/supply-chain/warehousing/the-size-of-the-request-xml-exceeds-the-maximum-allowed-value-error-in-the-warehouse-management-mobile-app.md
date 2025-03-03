---
title: The size of the request xml exceeds the maximum allowed value error in the Warehouse management mobile app
description: Provides resolution on how to resolve the "The size of the request xml exceeds the maximum allowed value" error in the Warehouse management mobile app.
ms.date: 03/03/2025
# ms.search.form:
audience: Application User
ms.reviewer: kamaybac, ivanma
ms.search.region: Global
ms.author: mirzaab
ms.search.validFrom: 2025-03-03
ms.dyn365.ops.version: 10.0.39
ms.custom: sap:Warehouse management
---
# The size of the request xml exceeds the maximum allowed value error in the Warehouse management mobile app

This article provides resolutions on how to resolve the "The size of the request xml exceeds the maximum allowed value" error in the Warehouse management mobile app.

## Symptoms

The "The size of the request xml exceeds the maximum allowed value" error is shown in the Warehouse management mobile app when opening a *Display open work list* mobile device flow.

## Cause

The Warehouse management mobile app is communicating with the Dynamics 365 Supply Chain Management service through an XML file. The system has built-in limit on the size of that XML file. So, if there are many warehouse works that should be displayed in the Warehouse management mobile app, this can lead to the XML file size being too large.

## Resolution

To resolve this issue, you can limit the number of warehouse works shown in the Warehouse management mobile app.

Follow these steps to reduce the number of shown warehouse works:
1. Open the **Mobile device menu items** form (**Warehouse management** > **Setup** > **Mobile device** > **Mobile device menu items**).
1. Find the impacted menu item.
1. Click the **Edit query** button in the Action Pane.
1. Edit the query to reduce the number of displayed works.

> [!NOTE]
> For more information about editing the queries, see [User-configurable queries in warehouse management](/dynamics365/supply-chain/warehousing/user-configurable-queries-in-warehouse-management).