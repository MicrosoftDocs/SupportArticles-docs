---
title: The new experience doesn't show after enabling it in settings
description: Resolves the issue where the Microsoft Dynamics 365 Field Service mobile app doesn't load the new experience.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 10/28/2024
ms.custom: sap:Mobile application
---

# The new experience doesn't show after enabling it in settings

## Symptoms

The mobile app doesn't load the new experience, even if it has been [enabled in the settings](/dynamics365/field-service/set-up-field-service-mobile).

## Resolution

The new experience currently doesn't support users or apps with offline enabled. Verify and update the following cases:

1. The user of the mobile app isn't part of the Mobile Offline Profile.
1. The app itself isn't set up for offline. In the app designer, open **Field Service Mobile** and open **Settings** for the app. On the **General** tab, turn off **Can be used offline**. For more information, go to [Set up mobile offline](/power-apps/mobile/setup-mobile-offline#enable-your-app-for-offline-use-preview).
