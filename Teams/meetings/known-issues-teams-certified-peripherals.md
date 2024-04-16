---
title: Known issues when you use Teams certified peripherals
description: Lists known issues that occur when you use Microsoft Teams certified peripherals and provides workarounds.
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
ms.date: 04/15/2024
---
# Known issues when you use Teams certified peripherals

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Button controls on connected peripherals don't sync with Microsoft Teams during meetings.|When you join a meeting in which all the participants are from the same Microsoft 365 cloud environment, your connected peripherals stop syncing with the Teams desktop app.<br/><br/>This issue is likely to occur if you have accounts on multiple tenants, but you're not signed in to the tenant from which you want to sync the peripherals.|Make sure that you're signed in to the tenant to which you want to sync the peripherals. Then restart the Teams app.|
|Button controls on connected peripherals don't sync with Teams during a cross-cloud meeting.|When users from special Microsoft 365 cloud environments participate in a cross-cloud meeting, their connected peripherals no longer sync with the Teams desktop app.<br/><br/>The peripherals resume syncing after the cross-cloud meeting ends.<br/><br/>This issue occurs because syncing connected peripherals is supported only when all the participants are from the same cloud.|No workaround is available at this time.|
|Devices that have a dial pad on the display don't show button controls and call details on the device screen.|Devices such as Yealink MP50 that have a dial pad in the display screen don't show HID controls to mute the audio during a call, answer a call, or end a call.<br/><br/>This issue occurs because the devices aren't recognized as certified Teams devices.|Use the button controls that are available on the Teams desktop app.|
|The **Sync device buttons** option is disabled when you run Teams and Skype for Business simultaneously.|When you run the new Teams desktop app and the Skype for Business app at the same time, the **Sync device buttons** option under **Settings** > **Devices** is disabled in Teams.<br/><br/>This behavior is by design to avoid potential conflicts between the two apps.|To re-enable the option for Teams, end the Skype for Business session.|
|Can't find the **Invoke camera from desktop** feature in new Teams.|The **Invoke camera from desktop** feature hasn't been ported to new Teams yet.|To start sharing from a content camera after you join a meeting in new Teams, select **Share** > **Content from camera**.|
|Microsoft Presenter+ features are missing in new Teams.|The following features in Microsoft Presenter+ haven't been ported to new Teams yet:<br/><br/><ul><li>The setting for a focus mode when you're using PowerPoint</li><li>The cursor when you're in a Teams meeting</li><li>The laser pointer when you're using PowerPoint Live</li></ul>|No workaround is available at this time.|
|Device might not sync when you restart Teams|When you restart either the Teams desktop app or your computer, a Teams certified peripheral that's connected to your computer might stop syncing with Teams because of the loss of connectivity.|Unplug and reconnect the peripheral to reinitialize connectivity to the Teams desktop app.|
