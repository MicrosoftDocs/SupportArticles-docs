---
title: Known issues when you use Teams certified peripherals
description: Lists known issues that occur when you use Teams certified peripherals and provides workarounds.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Teams Compatible Devices and Peripherals
  - CI 187023
  - CSSTroubleshoot
ms.reviewer: elaineho
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 06/06/2024
---
# Known issues when you use Teams certified peripherals

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Button controls on connected peripherals stop syncing with Microsoft Teams during a meeting.|You have accounts on multiple tenants, and all of them are connected to the Teams app. <br/><br/>However, when you switch from one account to another, the connected peripherals stop syncing with the Teams app. |Make sure that you're signed in to the account to which you want to sync the peripherals. Then restart the Teams app.|
|A call made from the dial pad in the display  screen triggers a call from other connected accounts.|You have accounts on multiple tenants, and all of them are connected to the Teams app.<br/><br/>If you initiate a PSTN call by using the dial pad on the display screen on your device, calls are also triggered simultaneously from your other accounts to the same number.|Use the Teams app to make PSTN calls instead of the dial pad in the display screen on a device. |
|During a cross-cloud meeting, button controls on connected peripherals don't sync with Teams.|When users from special Microsoft 365 cloud environments participate in a cross-cloud meeting, their connected peripherals no longer sync with the Teams desktop app.<br/><br/>The peripherals resume syncing after the cross-cloud meeting ends.<br/><br/>This issue occurs because syncing connected peripherals is supported only when all the participants are from the same cloud.|No workaround is available at this time.|
|Devices that have a dial pad in the display screen don't show button controls and call details on the device screen.|Devices such as Yealink MP50 that have a dial pad in the display screen don't show user profile information, HID controls to mute the audio during a call, answer a call, or end a call. <br/><br/>This issue occurs because the devices aren't recognized as certified Teams devices.|Use the button controls that are available in the Teams app.|
|The audio status doesn't sync between a connected device and Teams.|You're using a device that is not certified for Teams and you have paired it with your desktop computer by using its native Bluetooth setting.<br/><br/>When you mute your audio by using the controls in the Teams app, the audio status on your device doesn't update to reflect this status.|To force a sync between the status of the Teams app and your device, select the HID control on the device to mute the audio from there as well.|
|The **Sync device buttons** option is disabled when you run Teams and Skype for Business simultaneously.|When you run the new Teams desktop app and the Skype for Business app at the same time, the **Sync device buttons** option under **Settings** > **Devices** is disabled in Teams.<br/><br/>This behavior is by design to avoid potential conflicts between the two apps.|To re-enable the option for Teams, end the Skype for Business session.|
|Can't find the **Invoke camera from desktop** feature in new Teams.|The **Invoke camera from desktop** feature hasn't been ported to new Teams yet.|To start sharing from a content camera after you join a meeting in new Teams, select **Share** > **Content from camera**.|
|Microsoft Presenter+ features are missing in new Teams.|The following features in Microsoft Presenter+ haven't been ported to new Teams yet:<br/><br/><ul><li>The setting for a focus mode when you're using PowerPoint</li><li>The cursor when you're in a Teams meeting</li><li>The laser pointer when you're using PowerPoint Live</li></ul>|No workaround is available at this time.|
|Device might not sync when you restart Teams|When you restart either the Teams desktop app or your computer, a Teams certified peripheral that's connected to your computer might stop syncing with Teams because of the loss of connectivity.|Unplug and reconnect the peripheral to reinitialize connectivity to the Teams desktop app.|
