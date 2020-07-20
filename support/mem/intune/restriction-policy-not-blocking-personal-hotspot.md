---
title: Block iOS Personal Hotspot policy doesn't work
description: Describes a default behavior in Microsoft Intune where an active device restriction policy to block iOS Personal Hotspot still allows the setting to be enabled.
ms.date: 05/18/2020
ms.prod-support-area-path: Configure device restrictions
---
# Intune device restriction policy to block iOS Personal Hotspot doesn't prevent users from enabling it

This article describes a behavior that an active device restriction policy to block iOS **Personal Hotspot** doesn't prevent the setting from being enabled in iOS 12.1 or earlier.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4490864

## Symptom

After you deploy a device restriction policy in Microsoft Intune to block the iOS **Personal Hotspot** setting, users of iOS devices that run iOS 12.1 or earlier can still enable the **Personal Hotspot** feature.

:::image type="content" source="./media/restriction-policy-not-blocking-personal-hotspot/personal-hotspot.png" alt-text="Screenshot of the Personal Hotspot feature.":::

## Cause

This is an expected behavior in iOS 12.1 and earlier. In iOS 12.2 and later, users can be prevented from enabling the **Personal Hotspot** feature as expected.

## Resolution

Ask users to upgrade the device to iOS 12.2 or later.
