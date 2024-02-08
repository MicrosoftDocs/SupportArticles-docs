---
title: PAC setting in per-app VPN profile is ignored by Microsoft Edge in Android 13
description: Provides a workaround for an issue where Microsoft Edge in Android 13 ignores a PAC setting in a per-app VPN profile that's created in Microsoft Intune.
ms.date: 11/02/2022
ms.reviewer: kaushika, ochukwunyere, intunecic, v-weizhu
---
# Microsoft Edge in Android 13 ignores PAC setting in Microsoft Intune VPN profile

This article provides a workaround for an issue where Microsoft Edge in Android 13 ignores a Proxy Auto-Configuration (PAC) setting configured in a per-app VPN profile in Microsoft Intune.

## Symptoms

Consider the following scenario:

- In Microsoft Intune, administrators create a per-app VPN profile for Android devices.
- In the VPN profile, a PAC setting is configured for Microsoft Edge to consume proxy settings.
- After the VPN connection is established, users open Microsoft Edge on devices with Android 13.

In this scenario, the PAC setting is ignored by Microsoft Edge.

## Workaround

To work around this issue, use one of the following methods:

- While Microsoft Edge is running, disconnect and reconnect to the VPN.

    > [!NOTE]
    > If the VPN has **Always-on VPN** set to **Enable**, users won't be able to disconnect and reconnect to the VPN. In this case, users can force a VPN reconnection by resetting the network of the device. To reset the network of the device, disable and enable airplane mode or use **Reset network settings** under **Settings**.

- Postpone the Android 13 upgrade.
