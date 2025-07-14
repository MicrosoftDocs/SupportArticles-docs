---
title: Known issues when you use Teams certified peripherals
description: Lists known issues that occur when you use Teams certified peripherals and provides workarounds.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Compatible Devices and Peripherals
  - CI 187023
  - CSSTroubleshoot
ms.reviewer: elaineho; lbirenboim
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 01/30/2025
---
# Known issues when you use Teams certified peripherals

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Button controls on connected peripherals stop syncing with Microsoft Teams during a meeting.|You have accounts on multiple tenants, and all of them are connected to the Teams app. <br/><br/>However, when you switch from one account to another, the connected peripherals stop syncing with the Teams app. |Make sure that you're signed in to the account to which you want to sync the peripherals. Then restart the Teams app.|
|A call made from the dial pad in the display screen doesn't connect.|This issue occurs if you have accounts on multiple tenants, and all of them are connected to the Teams app.<br/><br/>When you initiate a PSTN call by using the dial pad on the display screen on your device, the call isn't triggered.|Use the Teams app to make PSTN calls instead of the dial pad in the display screen on a device. |
|During a cross-cloud meeting, button controls on connected peripherals don't sync with Teams.|When users from special Microsoft 365 cloud environments participate in a cross-cloud meeting, their connected peripherals no longer sync with the Teams desktop app.<br/><br/>The peripherals resume syncing after the cross-cloud meeting ends.<br/><br/>This issue occurs because syncing connected peripherals is supported only when all the participants are from the same cloud.|No workaround is available at this time.|
|Devices that have a dial pad in the display screen don't show button controls and call details on the device screen.|Devices such as Yealink MP50 that have a dial pad in the display screen don't show user profile information, HID controls to mute the audio during a call, answer a call, or end a call. <br/><br/>This issue occurs because the devices aren't recognized as certified Teams devices.|Use the button controls that are available in the Teams app.|
|The audio status doesn't sync between a connected device and Teams.|You're using a device that is not certified for Teams and you have paired it with your desktop computer by using its native Bluetooth setting.<br/><br/>When you mute your audio by using the controls in the Teams app, the audio status on your device doesn't update to reflect this status.|To force a sync between the status of the Teams app and your device, select the HID control on the device to mute the audio from there as well.|
|The **Sync device buttons** option is disabled when you run Teams and Skype for Business simultaneously.|When you run the new Teams desktop app and the Skype for Business app at the same time, the **Sync device buttons** option under **Settings** > **Devices** is disabled in Teams.<br/><br/>This behavior is by design to avoid potential conflicts between the two apps.|To re-enable the option for Teams, end the Skype for Business session.|
|Can't find the **Invoke camera from desktop** feature in new Teams.|The **Invoke camera from desktop** feature hasn't been ported to new Teams yet.|To start sharing from a content camera after you join a meeting in new Teams, select **Share** > **Content from camera**.|
|Microsoft Presenter+ features are missing in new Teams.|The following features in Microsoft Presenter+ haven't been ported to new Teams yet:<br/><br/><ul><li>The setting for a focus mode when you're using PowerPoint</li><li>The cursor when you're in a Teams meeting</li><li>The laser pointer when you're using PowerPoint Live</li></ul>|No workaround is available at this time.|
|Device might not sync when you restart Teams|When you restart either the Teams desktop app or your computer, a Teams certified peripheral that's connected to your computer might stop syncing with Teams because of the loss of connectivity.|Unplug and reconnect the peripheral to reinitialize connectivity to the Teams desktop app.|
|Button controls on connected peripherals don't work during Teams meetings.|You join a Teams meeting from a computer that is running third-party apps along with Teams. However the button controls on your connected certified peripherals don't work during the meeting.<br/><br/>This issue occurs because the peripherals are either being used by one of the third-party apps or Teams considers them to be in use already.|To ensure that the button controls on your connected peripherals sync with Teams correctly, exit all third-party apps before joining a Teams meeting.|
|Mute and unmute functions on connected peripherals don't work.|When the computer that your peripherals are connected to goes to sleep, Teams and the connected peripherals stop syncing.<br/>After the computer wakes from sleep, neither Teams nor any of the peripherals respond to Mute and Unmute requests from one another.|Restart Teams to restore syncing with the connected peripherals.|
|No ringing tone during an incoming or an outgoing call.|When someone calls you, there's no ringing sound to alert you to the incoming call. Similarly, when you make an outgoing call there's no ring tone to indicate that the call is in progress. The ring tone plays only after the callee picks up the call.<br/><br/>If the caller who is calling you or the callee when you make an outgoing call is using a native Bluetooth audio device connected to a Windows 11 computer, the device might mute the system audio and Teams ring tone, and play only the device-specific built-in ring tone.<br/><br/>When a call comes in, the computer sends the HFP RING response and might play the Teams ring tone and media playback audio to the Bluetooth device. However the paired device decides whether to play the audio received from the computer, its built-in ring tone, or both.|No workaround because this issue is caused by the connected audio device.|
|No audio after joining a town hall event from the desktop client.|When you join a town hall event by using the Teams desktop client and connect an older Bluetooth audio device to your computer, you don't hear the event's audio.|On the pre-join screen for the town hall event, wait until you see the following alert:<br/><br/><b>`Attendee mics and cameras are turned off for this event.`</b><br/><br/>Then select the link to join the town hall event and the audio will work.|
