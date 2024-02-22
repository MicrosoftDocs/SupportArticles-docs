---
title: EAS device is blocked by ABQ list
description: Describes an issue in which the Allow/Block/Quarantine list unexpectedly blocks an Exchange ActiveSync client. In this situation, the Exchange ActiveSync device can no longer sync with Exchange Server after you restore or factory reset the device.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange ActiveSync device is blocked unexpectedly by ABQ list

_Original KB number:_ &nbsp; 3013802

## Symptoms

After you perform a remote wipe or factory reset of an Exchange ActiveSync device, or after you restore the device from Backup, the Exchange ActiveSync client on the device can no longer synchronize with Exchange Server.

This issue occurs when one or more of the following conditions are true:

- The Exchange ActiveSync organization setting for the default access level is set to **Block** or **Quarantine**.
- There is an Exchange ActiveSync device access rule for which the access level set to **Block** or **Quarantine**.
- The mailbox has the `ActiveSyncAllowedDeviceID` setting configured.

## Cause

The Exchange ActiveSync client on these devices has a process that generates a Device ID when the first Exchange ActiveSync profile is created. By resetting the device, this removes any existing Exchange ActiveSync profiles and resets the Device ID.

## Resolution

This behavior is by design. The new Device ID must be added to the mailbox's `ActiveSyncAllowedDeviceIDs` list.

## More information

In this situation, the user receives a quarantine notification message that resembles the following:

> Your mobile device is temporarily blocked from accessing content via Exchange ActiveSync because the mobile device has been quarantined. You don't need to take any action. Content will automatically be downloaded as soon as access is granted by your administrator.
>
> You need to wait for me to check my messages before your device will be activated.
>
> Information about your mobile device:
>
> Device model:Virtual  
Device type:*DeviceType*  
Device ID:*DeviceID*  
Device OS:*Device OS*  
Device user agent:*DeviceUserAgent*  
Device IMEI:*Device IMEI*  
Exchange ActiveSync version:*EASversion*  
Device access state:Quarantined  
Device access state reason:Global  
>
> Sent at *DateTime* to *EmailAddress*
