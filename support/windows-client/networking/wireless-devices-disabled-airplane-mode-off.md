---
title: Wireless devices disabled after Airplane mode is off
description: Discusses that wireless devices are disabled after you turn off Airplane Mode in Windows 8.1 or Windows 8. Provides a workaround.
ms.date: 10/15/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, takondo, match
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
ms.subservice: networking
---
# Wireless devices are disabled after you turn off Airplane mode

This article provides a solution to an issue where wireless devices are disabled after you turn off Airplane mode.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2826798

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows 8.1 or Windows 8.
- You turn on Airplane mode to disable all wireless communication.
- You put the computer into Sleep or Hibernation mode, or you shut down the computer.
- You wake the computer from Sleep or Hibernation mode, or you restart the computer.
- You turn off Airplane mode to enable all wireless communication.

In this scenario, if you turn off Airplane mode before the wireless devices are initialized, the devices stay off even though Airplane mode is off.

## Cause

This issue occurs because the Airplane mode setting changes before the wireless devices are configured. Therefore, the system cannot relay the Airplane mode settings to the devices.

## Workaround

To work around this issue, follow these steps:

1. Swipe in from the right edge of the screen, or press the Windows logo key + C.
2. Tap or click **Settings**.
3. Tap or click **Change PC Settings**.
4. Tap or click **Wireless**.
5. Tap or click an affected device to turn it on again.
