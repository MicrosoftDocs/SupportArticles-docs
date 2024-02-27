---
title: Cannot send meeting on behalf of managers
description: When you view a manager's calendar and use that view to create a new meeting, you are unexpectedly shown as the organizer of the new meeting. This occurs even though you expected to send a meeting on behalf of the manager. This article describes a scenario that can cause this issue in Outlook 2010 and Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: rakeshs, aruiz
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Unable to send an Outlook meeting on behalf of a manager when viewing their calendar

_Original KB number:_ &nbsp; 2799147

## Symptoms

You use Microsoft Outlook 2010 or Microsoft Outlook 2013 to open a manager's calendar and use that folder view to create a new meeting. When you do this, you are listed as the organizer of the new meeting. Additionally, the manager is added as an attendee. However, you expect the new meeting to be sent on behalf of the manager.

## Cause

This issue can occur if Outlook cannot immediately open the manager's Calendar folder. In this scenario, Outlook 2010 and Outlook 2013 try to use the manager's Free/Busy information to generate a calendar view. This calendar view differs from opening the Calendar folder. The calendar view is a read-only view and has less functionality. When you double-click in the manager's calendar view to create a new meeting, Outlook determines that you are unable to create a meeting directly in the manager's Calendar. Therefore, Outlook instead creates a new meeting in your Calendar, with the manager added as an attendee.

## Resolution

Make sure that you have appropriate permissions to the manager's Calendar folder. Additionally, make sure that your Outlook client can successfully connect to the Exchange server that the manager's mailbox is located on. To reduce the probability of this issue occurring, enable the **Download Shared Folders** setting in your Exchange account. For more information about the Download Shared Folders setting, see [By default, shared mail folders are downloaded in Cached mode in Outlook 2010 and later versions](https://support.microsoft.com/help/982697).

## More information

This issue is more prevalent when you connect to the manager's Calendar in Online mode. If your Outlook client cannot connect to the Exchange server that the manager's mailbox is located on, you may experience the behavior that is mentioned in the Symptoms section.

In Cached Exchange Mode, the manager's Calendar data and folder permissions are cached. Therefore, this issue is unlikely to occur, unless your permissions to the manager's calendar are revoked. Outlook cannot determine whether you have permissions to or are a delegate of the calendar until Outlook can connect to the manager's calendar.
