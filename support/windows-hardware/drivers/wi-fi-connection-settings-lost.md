---
title: Wi-Fi connection settings are lost
description: This article provides a workaround for the issue that occurs when you configure the Wi-Fi connection settings in the Network Connections item in Control Panel on a Windows Embedded Compact 7 device.
ms.date: 08/27/2020
ms.reviewer: riwaida
ms.subservice: network-driver
---
# Wi-Fi connection settings are lost after a Windows Embedded Compact 7 device restarts

This article helps you work around the problem that occurs when you configure the Wi-Fi connection settings in the Network Connections item in Control Panel on a Windows Embedded Compact 7 device.

_Original product version:_ &nbsp; Windows Embedded Compact 7  
_Original KB number:_ &nbsp; 4476975

## Symptoms

After you configure the Wi-Fi connection settings in the Network Connections item in Control Panel on a Windows Embedded Compact 7 device, the settings are lost when the device restarts. This problem occurs during either a warm reboot or a cold reboot.
For example, this problem occurs when you configure following settings:

**Name (SSID):** TEST-WPA2-Enterprise  
**Network type:** Access point  
**Security type:** WPA2 Enterprise  
**Encryption type:** AES  
**EAP type:** PEAP  
**Authentication method:** Username and Password

:::image type="content" source="media/wi-fi-connection-settings-lost/security-properties.png" alt-text="Screenshot of the example of the configuration settings in security properties." border="false":::

**Validate server:** Cleared

:::image type="content" source="media/wi-fi-connection-settings-lost/authentication-method-username.png" alt-text="Select the Username and Password option in Authentication Method." border="false":::

**Domain\Username:** *wpa2user*

**Password:** *123456#*

:::image type="content" source="media/wi-fi-connection-settings-lost/username-and-password.png" alt-text="Screenshot of the username and password dialog box." border="false":::

## Cause

This problem occurs because of an issue in the Connection Manager service (CmService.dll) of Windows Embedded Compact 7. When the data length of a Wi-Fi profile that is encrypted by CmService.dll becomes a specific size (multiples of 4,096 bytes), the data is not saved correctly to the device's registry. Therefore, the Wi-Fi profile is lost after the device restarts.

For example, the following registry value of the profile will be lost:

`[HKLM\Comm\ConnMgr\Settings\Connection\Wi-Fi Profile Name] "Size"=dword:1000 ; 4096 bytes`

## Workaround

To avoid this problem, change the character length of the SSID. In the example in the [Symptoms](#symptoms) section, you can change the SSID to **My-WPA2-Enterprise**.
