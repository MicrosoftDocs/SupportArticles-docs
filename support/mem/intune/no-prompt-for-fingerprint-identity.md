---
title: No prompt for fingerprint identity for Samsung Note 4
description: Describes an issue that you aren't prompted for fingerprint when you use Intune app protection policy managed apps on a Samsung Galaxy Note 4 device.
ms.prod-support-area-path: App management
ms.date: 05/20/2020
---
# You aren't prompted for fingerprint identity when you use policy-managed apps on Samsung Note 4

This article provides the workaround to solve the fingerprint authentication issue when using policy-managed apps on Samsung Galaxy Note 4 devices.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4493781

## Symptoms

You have Intune app protection policies configured for some enlightened apps on Android devices. The **Allow fingerprint instead of PIN (Android 6.0+)** policy setting is set to **Yes**, users are not prompted for fingerprint authentication when using the targeted apps.

This issue is typically seen with Samsung Galaxy Note 4 devices, but the issue can affect other devices as well.

## Cause

Samsung Galaxy Note 4 devices use a Samsung proprietary fingerprint management API that isn't supported by Intune.

## Workarounds

To work around the issue, use an alternate device that supports a fingerprint management API that is supported by Intune.
