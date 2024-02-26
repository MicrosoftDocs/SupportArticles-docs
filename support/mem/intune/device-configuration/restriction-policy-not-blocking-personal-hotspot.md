---
title: Block iOS Personal Hotspot policy in Intune doesn't work
description: Describes a default behavior in Microsoft Intune where an active device restriction policy to block iOS Personal Hotspot still allows the setting to be enabled.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure device restrictions
ms.reviewer: kaushika
---
# Intune device restriction policy to block iOS Personal Hotspot doesn't prevent users from enabling it

This article describes an issue where an active Intune device restriction policy to block iOS **Personal Hotspot** doesn't prevent the setting from being enabled in iOS 12.1 or earlier.

## Symptom

After you deploy a device restriction policy in Microsoft Intune to block the iOS **Personal Hotspot** setting, users of iOS devices that run iOS 12.1 or earlier can still enable the **Personal Hotspot** feature.

:::image type="content" source="media/restriction-policy-not-blocking-personal-hotspot/personal-hotspot.png" alt-text="Screenshot of the Personal Hotspot feature in Device restrictions.":::

## Cause

This is an expected behavior in iOS 12.1 and earlier. In iOS 12.2 and later, users can be prevented from enabling the **Personal Hotspot** feature as expected.

## Solution

Ask users to upgrade the device to iOS 12.2 or later.
