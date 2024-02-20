---
title: cannot connect to mobile broadband
description: Describes an issue that prevents your Windows 10-based device from connecting to mobile broadband. Occurs if an over-the-air update was applied directly to your modem. Resolutions are provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Devices can't connect to mobile broadband after over-the-air update from mobile operator

This article provides a resolution for the issue that devices can't connect to mobile broadband after over-the-air update from mobile operator.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3160433

## Symptoms

Your Windows 10-based device could connect to mobile broadband in the past, but connection attempts fail after your mobile operator applies an over-the-air update to your device. This problem affects only enterprise customers who have special plans with their mobile operator partners.

## Cause

This problem occurs if the mobile operator made an over-the-air update directly to your modem. Windows tries to make a connection by using the configurations in the operating system based on previous successful connections. However, the mobile operator network and modem may block the connection request from Windows because of the mismatch between the Windows request and the configuration in the modem.

## Resolution

> [!WARNING]
> Before you apply the following method, check your version of Windows to make sure that you're running Windows 10, build 10586.420 or later. To do this, press the Window key + R, and then type winver . If you're not running build 10586.420 or later, update your Windows installation to the latest available version.

To resolve the issue that's described in the "Symptoms" section, follow these steps:

1. Open Registry Editor by pressing the Windows Key + R and then typing regedit.
2. Navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Settings\Network.
3. Right-click the **Network** key, and then click **Permissions**.
4. Click **Advanced**, and check whether the owner is **TrustedInstaller**.
5. Click the "Change" link, and then enter < **machine_name** >\Administrators.
6. Click **Check Names** to verify that < **machine_name** >\Administrators is correctly validated (underlined). For example: *MY-LAPTOP\Administrators*. If it is, click **OK**.

    If **Check Names** does not return an underlined name, your user name is not in the correct format.
7. Click **OK** in the **Advanced Security Settings for Network** pane.
8. Select **Administrators**, select the **Full Control** check box in the **Allow** column, and then click **OK**.
9. Create or locate the following registry key, and set the DWORD value to 1 (DWORD=1):

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Settings\Network\ManualConnectionRetry`

10. Go to **Settings** -> **Network and Internet** -> **Cellular** -> **Connect**.
11. A retry page that resembles as:

:::image type="content" source="media/device-cant-connect-mobile-broadband-over-the-air/network-and-internet.png" alt-text="Screenshot of the Mobile operator network connection retry option in the Cellular page of Network and Internet settings." border="false":::

12. Click **Yes**.  
Windows can now connect by using the configuration in the modem. This modem configuration overwrites the existing configuration on the operating system.
