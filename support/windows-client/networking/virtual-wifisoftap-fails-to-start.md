---
title: Virtual WiFi/SoftAP fails to start
description: When you attempt to start Virtual WiFi/SoftAP, you may receive an error. This article provides a solution to this issue.
ms.date: 09/16/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, nbassett
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
ms.subservice: networking
---
# Virtual WiFi/SoftAP fails to start with error: The hosted network couldn't be started

This article provides a solution to an error (The hosted network couldn't be started) that occurs when you start Virtual WiFi/SoftAP.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2625519

## Symptoms

On Windows 7 and Windows Server 2008 R2, when you attempt to start Virtual WiFi/SoftAP you may receive the error: The hosted network couldn't be started.

## Cause

This can occur if the "Allow the computer to turn off the device to save power" power option for the wireless network adapter is cleared.

## Resolution

Enable the "Allow the computer to turn off the device to save power" power management option for the wireless network adapter using the following steps:

1. Click on the Start button and select Control Panel.
2. Select System and Security.
3. Select Device Manager under System.
4. Select and expand the Network adapters from the list of devices.
5. Find the wireless network adapter and right-click on it and select Properties.
6. Select the Power Management tab.
7. Under the Power Management tab, make sure the following option is checked (enabled): *Allow the computer to turn off this device to save power*.

Note: If you have Control Panel configured to view by small or large icons, you may not see the System and Security category listed in step 2. In this case, select System from the available Control Panel applets and select Device Manager from the left pane. You can then skip steps 2-3 and continue with step 4.

## More information

Microsoft Virtual WiFi/SoftAP is not supported on Windows 7/Windows Server 2008 R2 when this power option is disabled.

For more information about Virtual WiFi/SoftAP, see the following article:

[About the Wireless Hosted Network](/windows/win32/nativewifi/about-the-wireless-hosted-network)
