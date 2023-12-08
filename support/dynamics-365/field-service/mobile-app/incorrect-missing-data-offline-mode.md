---
title: Incorrect or missing data in offline mode error
description: Resolves common issues with missing data in the mobile offline profile in the Dynamics 365 Field Service mobile app.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/08/2023
ms.custom: sap:offline-data-sync-other
---
# "Incorrect or missing data in offline mode" error

This article solves common issues with the [mobile offline profile](/dynamics365/field-service/mobile-power-app-system-offline) in the Dynamics 365 Field Service mobile app.

## Symptoms

When you use the mobile offline profile with the Dynamics 365 Field Service mobile app, the following error message might occur:

> Incorrect or missing data in offline mode

## Resolution

To solve this issue, review the mobile offline profile.

> [!NOTE]
> Before making any changes to the offline profile, create a copy to preserve the original filters.

- Verify that the right users are added to the offline profile and the offline profile is published.
- Ensure that the offline profile is associated with the correct app module.
- Recreate the offline profile filters in Advanced Find and see if it matches the data you look for. Refine the filters if needed.
- Verify that the proper item associations are set. If the entity in question is downloaded through an item association, check the filter of the parent item. Item associations transfer their filter to their associated entities. For example, if accounts are associated to a work order, and the work order has a custom filter that downloads only scheduled work orders, only accounts that belong to the scheduled work orders are downloaded.
- If mobile offline is enabled for the app module, the app reads from the offline database. When the device is online, changes sync [according to the configured sync intervals](/dynamics365/field-service/mobile-power-app-system-offline#sync-intervals). You can [sync the offline database manually from the offline status page](/power-apps/mobile/offline-sync-icon).
