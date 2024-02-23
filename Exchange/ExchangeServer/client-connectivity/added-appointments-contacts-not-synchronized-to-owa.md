---
title: New appointments and contacts not synchronized to Outlook Web App
description: In Outlook for Mac, you add appointments to Calendar and contacts in Contacts folder. These appointments and contacts do not synchronize to Outlook Web App (Outlook Web App) or your mobile devices and other mail clients.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: tasitae, tsimon, v-six
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Mac 2011
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/24/2024
---
# Added appointments and contacts in Outlook for Mac do not synchronize to Outlook Web App

_Original KB number:_ &nbsp; 2744157

## Symptoms

When you add appointments to your Calendar folder and add contacts to your Contacts folder in Outlook 2016 for Mac or Outlook for Mac 2011, the added appointments and contacts do not synchronize to Outlook Web App or to your mobile devices and other mail clients.

## Cause

This behavior is by design. When you add appointments or contacts to the On My Computer folders in Outlook for Mac, they are local to the Mac and do not synchronize to Microsoft Exchange Server.

## Workaround

To work around this behavior, take the following actions:

- Move all your calendar data to the Calendar folder in your Exchange account.
- Move all your contact data to the Contacts folder in your Exchange account. You can hide the On My Computer folders to prevent this behavior from occurring again.

To do this in Outlook for Mac, select **Preferences**, select **General**, and then select the **Hide On My Computer folders** check box.

## More information

For more information about the On My Computer folders, see [How information is synchronized between Outlook for Mac 2011 and Exchange Server](/previous-versions/office/office-for-mac-2011/jj984226(v=office.14)).
