---
title: Incorrect or missing data in offline mode error
description: Resolves a common issue with missing data in the mobile offline profile in the Dynamics 365 Field Service mobile app.
ms.reviewer: jobaker, v-wendysmith, v-shaywood
ms.date: 01/29/2026
ms.custom: sap:Mobile application\Offline data sync - Other
---
# "Incorrect or missing data in offline mode" error

This article addresses a common issue with the mobile offline profile in the Microsoft Dynamics 365 Field Service mobile app.

## Symptoms

When you use the mobile offline profile in the Dynamics 365 Field Service mobile app, you might see the following error message:

> Incorrect or missing data in offline mode

## Resolution

To resolve this issue, review the [mobile offline profile](/dynamics365/field-service/mobile/set-up-offline-profile).

> [!NOTE]
> Before making any changes to the offline profile, create a copy to preserve the original filters.

- Verify that the right users are added to the offline profile and that the offline profile is published.
- Ensure that the offline profile is associated with the correct app module.
- Recreate the offline profile filters in **Advanced Find** and see if they match the data you're looking for. Refine the filters if needed.
- Verify that the proper item associations are set. If the entity in question is downloaded through an item association, check the filter of the parent item. Item associations transfer their filter to their associated entities. For example, if accounts are associated with a work order, and the work order has a custom filter that downloads only scheduled work orders, only accounts that belong to the scheduled work orders are downloaded.
- If you enable mobile offline for the app module, the app reads from the offline database. When the device is online, change the sync [according to the configured sync intervals](/dynamics365/field-service/mobile/offline-data-sync#set-sync-intervals). You can [sync the offline database manually from the offline status page](/power-apps/mobile/offline-sync-icon).
