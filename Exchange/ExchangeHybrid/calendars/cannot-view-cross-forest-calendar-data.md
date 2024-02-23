---
title: Cannot view cross-forest calendar data
description: Describes an issue in which you can't view cross-forest calendar data in Microsoft 365 hybrid.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't view cross-forest calendar data in Microsoft 365 hybrid environment

_Original KB number:_ &nbsp; 3187044

## Symptoms

After your mailbox is moved to the cloud, you can't view calendar data in Microsoft Outlook 2016 or Outlook 2013 for a mailbox that exists on-premises. Only free/busy information is displayed.

## Cause

This behavior is by design. In some configurations of an on-premises environment, calendar data is not returned if only the calendar is displayed. In these situations, you can have an on-premises resource forest that doesn't share trust with your logon forest.

## More information

Free/busy and mailbox data is returned in different ways, depending on whether the mailboxes exist in different hybrid forests and how the user chooses to display the information. The following rules apply to the calendar view in Outlook when you view a calendar folder for a mailbox that is in a hybrid forest:

- Outlook creates a local, read-only folder and then retrieves free/busy information for that mailbox by using Exchange Web Services (EWS).
- Outlook almost immediately tries to connect to that mailbox.
- If the connection is successful, and if the user has folder-level or Full Access permissions to the mailbox, Outlook displays the full calendar details and provides the appropriate access level to the user for the folder. For example, a user who has Editor permissions to the calendar folder can create items on the calendar.

Outlook 2016 and Outlook 2013 do not prompt for credentials if the user doesn't have permissions to the target mailbox or calendar folder.

If Modern Authentication is being used when you connect to Exchange Online, there may be some problems authenticating by using the legacy authentication stack to the on-premises environment. Users may find that they intermittently only see free/busy data.
