---
title: 2016341112 iOS device is currently busy error
description: Describes an issue in which you receive the 2016341112 -iOS device is currently busy error message when you deploy a device profile to an iOS device.
ms.date: 05/13/2020
ms.prod-support-area-path: Monitor profiles 
---
# 2016341112 -iOS device is currently busy error when you deploy a device profile to an iOS device

This article discusses a behavior that the **2016341112 -iOS device is currently busy** error occurs when deploying a device configuration profile to iOS devices in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4462900

## Symptoms

When you try to deploy a device configuration profile to iOS devices in Microsoft Intune, you notice the following behavior:

- When the iOS device is locked, the device profile isn't applied to the device. In Intune in the Azure portal, the device is marked as noncompliant, and you see the following error message:

    > 2016341112 -iOS device is currently busy

    > [!NOTE]
    > This issue occurs even if the device is connected to the Internet and has the **Background App Refresh** setting turned on.

- When the iOS device is unlocked, the profile is applied to the device successfully.

## Cause

This issue occurs because the iOS device is busy and can't complete evaluation or enforcement of the profile. This error typically occurs when an iOS device has been powered on but not unlocked, or when a device is currently installing an app or iOS update.

## More information

This is a function of the iOS platform and not specific to Intune. After the device is unlocked, the profile will be applied.

There are certain times when a device cannot do what the server requests. When the device can't follow a command, it sends a **NotNow** status.

|Status value|Description|
|---|---|
|NotNow|The device received the command, but it cannot follow the command at this time. The device will poll the server again later.|
|||

For more information about Apple's MDM protocol, see [Mobile Device Management Protocol Reference](https://developer.apple.com/business/documentation/MDM-Protocol-Reference.pdf).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
