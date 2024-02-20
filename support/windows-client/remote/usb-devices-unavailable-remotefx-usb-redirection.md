---
title: Some USB devices aren't available
description: This article describes why specific USB devices may not be available for RemoteFX USB redirection, and how to make them available.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:redirection-not-printer, csstroubleshoot
---
# Some USB devices are not available through RemoteFX USB redirection

This article describes why specific USB devices aren't available for RemoteFX USB redirection, and how to make them available.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2653326

## Symptoms

On a system where RemoteFX USB redirection is enabled, devices of the following types may not be listed in Remote Desktop Connection under the **Other Supported RemoteFX USB devices** category:  

- Printer
- Audio Recording/Playback
- Mass Storage Device (examples include hard drives, CD/DVD-RW drives, flash drives, and memory card readers)
- Smart Card Reader
- PTP Camera
- MTP Media Player
- Apple iPod/iPod Touch/iPhone/iPad
- Blackberry PDA
- Windows Mobile PDA
- Network Adapter

Additionally, composite devices that contain a device interface that corresponds to any of these device types also may not be listed in Remote Desktop Connection under the **Other Supported RemoteFX USB devices** category.

## Cause

By default, devices in the categories that are mentioned in the "Symptoms" section are accessible in the remote session by using high-level device redirection methods. These methods of redirection enable optimal performance and backward compatibility of the device in the majority of user scenarios. Therefore, these devices are not offered through RemoteFX USB redirection.

## Resolution

An override mechanism is provided to selectively enable the use of specific device types in the categories that are mentioned in the "Symptoms" section through RemoteFX USB redirection. Device types that are enabled by this mechanism will be made available for RemoteFX USB redirection and will appear in Remote Desktop Connection under the **Other Supported RemoteFX USB devices** category. In order to use the device through RemoteFX USB redirection, the device must be selected for remote access by using the Remote Desktop Connection UI, the "usbdevicestoredirect:s: RDP file string, or another method.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
To enable a device type for RemoteFX USB redirection, follow these steps:  

1. Delete all instances of USB storage devices from the client.
2. Make sure that USB storage devices can't be installed on the client through Group Policy.
3. Identify the appropriate interface class GUID for the device type that you want to make available. Examples are as follows:

    | Device type| Interface class GUID |
    |---|---|
    |Hard Drive|{53F5630 7 -B6BF-11D0-94F2-00A0C91EFB8B}|
    |CD-ROM|{53F5630 8 -B6BF-11D0-94F2-00A0C91EFB8B}|

    For a complete listing of all system-defined device interface classes, please go to the following Microsoft Developer Network website: [System-Defined Device Interface Classes](https://msdn.microsoft.com/library/ff553412%28v=vs.85%29.aspx )  

    > [!NOTE]
    > For a device that has multiple interface class GUIDs that are to be made available through this mechanism, only one corresponding interface class GUID has to be added to the registry.

    > [!IMPORTANT]
    > The addition of the following GUIDs is not supported:  
    >
    > - GUID_CLASS_USB_DEVICE
    > - GUID_CLASS_USB_HOST_CONTROLLER
    > - GUID_CLASS_USBHUB
    > - GUID_DEVINTERFACE_USB_DEVICE
    > - GUID_DEVINTERFACE_USB_HOST_CONTROLLER
    > - GUID_DEVINTERFACE_USB_HUB

4. Locate the following key in the registry of the *client* computer (that is, the computer that is using the Remote Desktop Connection application to connect to another computer):

    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client\UsbSelectDeviceByInterfaces`  
    Under this key, use the following format to add a value for each device interface class GUID that you wish to make available:

    Type: REG_SZ (String)
    Name: Any unique string
    Data: The interface class GUID, in the following format: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}, where each x represents a hexadecimal digit, case insensitive.
     Example To enable RemoteFX USB redirection of CD-ROM drives, add the following value:

    Type: REG_SZ
    Name: 100
    Data: {53F56308-B6BF-11D0-94F2-00A0C91EFB8B}

    Or run the following command from an Administrator command prompt:

    `reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client\UsbSelectDeviceByInterfaces" /v 100 /t REG_SZ /d {53f56308-b6bf-11d0-94f2-00a0c91efb8b} /f`

5. Restart Remote Desktop Connection if it is currently running.

## More information

For step-by-step instructions on configuring an evaluation deployment of RemoteFX USB redirection for Windows 7 SP1, go to the following Microsoft Technet website:  
[Configuring USB Device Redirection with Microsoft RemoteFX Step-by-Step Guide](https://technet.microsoft.com/library/ff817581%28ws.10%29.aspx)  

For more information about RemoteFX USB redirection, review the following article on the Remote Desktop Services Blog:  
[Introducing Microsoft RemoteFX USB Redirection: Part 3](https://techcommunity.microsoft.com/t5/microsoft-security-and/introducing-microsoft-remotefx-usb-redirection-part-3/ba-p/247085)
