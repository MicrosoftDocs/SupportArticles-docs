---
title: "Error message: Incorrect or missing data in offline mode"
description: Resolve common issues with missing data in the mobile offline profile of the Field Service mobile app.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 11/20/2023
---

# Error message: Incorrect or missing data in offline mode

This article helps you solve issues with the [mobile offline profile](/dynamics365/field-service/mobile-power-app-system-offline).

## Symptoms

If the system reports incorrect or missing records in offline mode, review the mobile offline profile. 

## Resolutions

Before making any changes to the offline profile, create a copy to preserve the original filters.

- Verify that the right users are added to the offline profile and that it's published.

- Ensure that the offline profile is associated with the correct app module.

- Recreate the offline profile filters in Advanced Find and see if it matches the data you look for. Refine the filters if needed.

- Verify that the proper item associations are set. If the entity in question is downloaded through an item association, check the filter of the parent item. Item associations transfer their filter to their associated entities. For example, if accounts are associated to work order, and work order has a custom filter that downloads only scheduled work orders, only accounts belonging to scheduled work orders are downloaded.

- If mobile offline is enabled for the app module, the app reads from the offline database. When the device is online, changes sync [according to the configured sync intervals](/dynamics365/field-service/mobile-power-app-system-offline#sync-intervals). You can [sync the offline database manually from the offline status page](/power-apps/mobile/offline-sync-icon).
