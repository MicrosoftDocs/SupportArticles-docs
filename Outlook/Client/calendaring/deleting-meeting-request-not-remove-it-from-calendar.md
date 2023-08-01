---
title: Deleting meeting request not removes it from Calendar
description: When you delete a meeting invitation from your Inbox in Outlook 2013, the tentative meeting remains in the Calendar. This also applies to Outlook 2007 and Outlook 2010 if the hotfix packages dated August 28, 2012 are installed. Additionally, Outlook 2013 writes an event 64 into the Windows Application Log.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, aruiz
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 3/31/2022
---
# Deleting a meeting request does not remove the meeting from the Outlook Calendar

_Original KB number:_ &nbsp; 2771436

## Summary

In Microsoft Outlook 2013, when you delete a meeting invitation from your Inbox, the tentative copy of the associated meeting remains in the Calendar. Additionally, an event 64 is written to the Application log. The event contains details similar to the following:

> Log Name: Application  
Source: Outlook  
Event ID: 64  
Task Category: None  
Level: Information  
User: N/A  
Computer: UserWorkstation02  
Description:  
A meeting request has been deleted but the meeting will remain tentative on the calendar until the user either chooses a response or deletes the item directly from the calendar folder. Subject: Budget Review Current User: UserA Flags: 0x00000000 Start Time: 10/15/2012 6:00 PM End Time: 10/15/2012 6:30 PM EntryID:  0000000042CE0E32AD5F7C49A6F42B1C1C8716CD0700C3B68E10F77511CEB4CD00AA00BBB6E600000000000  
C0000D9539C2261A6BB45B9DAB62C7081B3C10100150000000000.

## More information

Starting with the Outlook 2007 and Outlook 2010 hotfix packages dated August 28, 2012 (KB2687336 and [KB2687351](https://support.microsoft.com/help/2687351), respectively), Outlook keeps the tentative copy of the associated meeting in the Calendar when you delete a meeting invitation from your Inbox. The new behavior also applies in the manager and delegate scenario. If you intend to remove the tentative copy of the meeting from the calendar, you must decline the meeting invitation.

> [!NOTE]
> Only Outlook 2013 logs the event 64. Outlook 2007 and Outlook 2010 do not write the event 64 to the Application log. This applies whether you have the August 28, 2012 hotfix package installed or not.

If you are using an Outlook 2010 or Outlook 2007 build that is earlier than August 28, 2012, when you delete the meeting invitation from the Inbox, the tentative copy of the meeting is also deleted from the Calendar.
