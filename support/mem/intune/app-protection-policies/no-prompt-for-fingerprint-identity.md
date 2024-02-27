---
title: No prompt for fingerprint identity for Intune-managed apps on Samsung Note 4
description: Describes an issue where users aren't prompted for fingerprint when they use Intune app protection policy managed apps on a Samsung Galaxy Note 4 devices.
search.appverid: MET150
ms.custom: sap:App management
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Users aren't prompted for fingerprint identity for managed apps on Samsung Note 4

This article describes a fingerprint authentication issue when using Microsoft Intune policy-managed apps on Samsung Galaxy Note 4 devices.

## Symptoms

You have Intune app protection policies configured for some apps on Android devices. Although the **Allow fingerprint instead of PIN (Android 6.0+)** policy setting is set to **Yes**, users are not prompted for fingerprint authentication when using the targeted apps.

This issue is typically seen with Samsung Galaxy Note 4 devices, but the issue can affect other devices as well.

## Cause

Samsung Galaxy Note 4 devices use a Samsung proprietary fingerprint management API that isn't supported by Intune.

## Workaround

To work around the issue, use an alternate device that supports a fingerprint management API that is supported by Intune.
