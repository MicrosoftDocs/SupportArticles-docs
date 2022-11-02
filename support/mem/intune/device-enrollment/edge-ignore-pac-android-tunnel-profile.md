---
title: PAC setting in Tunnel profile is ignored by Microsoft Edge in Android 13
description: Provides a workaround to an issue where Microsoft Edge in Android 13 ignores a PAC setting in Microsoft Tunnel profile.
ms.date: 11/02/2022
author: AmandaAZ
ms.author: v-weizhu
ms.service: microsoft-intune
ms.subservice: intune-device-enrollment
ms.reviewer: ochukwunyere, intunecic
---
# Microsoft Edge in Android 13 ignores PAC setting in Tunnel profile

This article works around an issue where a Proxy Auto-Configuration (PAC) setting in an Android Tunnel profile is ignored by Microsoft Edge.

## Symptoms

Consider the following scenario:

- Microsoft Tunnel is used for providing per-app VPN on Android Enterprise devices.
- In the VPN profile, a PAC setting is configured for Microsoft Edge to consume proxy settings.
- After the VPN connection is established, users launch Microsoft Edge on devices with Android 13.

In this scenario, the PAC setting is ignored by Microsoft Edge.

## Workaround

To work around this issue, use one of the following methods:

- While Microsoft Edge is running, disconnect and reconnect to the VPN.

    > [!NOTE]
    > If the VPN has **Always-on VPN** set to **Enable**, users won't be able to disconnect and reconnect to the VPN.

- Postpone the Android 13 upgrade.
- Use some other methods to deliver the PAC setting to Microsoft Edge.