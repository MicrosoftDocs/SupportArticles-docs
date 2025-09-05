---
title: Can't open a shared Calendar folder
description: Resolves an Outlook for Mac Calendar issue in which you can't open a shared folder after the owner assigns permissions for the subcalendar to you.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019 for Mac
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# You do not have permission error when trying to open a shared Calendar folder in Outlook for Mac

_Original KB number:_ &nbsp; 2743752

## Symptoms

When you try to open a shared Calendar folder in Outlook 2016 for Mac or Outlook for Mac 2011, you receive the following error message even though you're granted permission to the folder:

> Outlook cannot open the folder. You do not have permission to open this folder. Contact **\<Calendar owner's name\>** for permission.

## Cause

This issue occurs because the owner of the folder that you want to access shares the subcalendar folder with you but doesn't share their default (primary) Calendar folder.

## Resolution

To fix this issue, the calendar owner must share both the primary and the secondary Calendar folders with you.

## More information

This issue doesn't occur for Microsoft 365 accounts that are using the REST protocol for Calendar.

This issue is caused by a limitation in the EWS protocol that is used for Exchange on-premises accounts. Microsoft 365 accounts that use REST are no longer affected by this issue.

In Outlook for Mac, you must have at least the Reviewer permission to access the other user's default Calendar folder so that you can also access any subcalendar folders.

For example, you have permissions to the following shared Calendar folders:

- Calendar
- Second Calendar

In this example, Second Calendar is a subfolder of Calendar, which is displayed as follows.

:::image type="content" source="media/you-do-not-have-permission-error/second-calendar.png" alt-text="Screenshot of Sub Calendar in Calendar folders." border="false":::

To be able to open the other user's Second Calendar folder, you must have at least the Reviewer permission to their default Calendar folder.

## References

For more information about REST for Outlook for Mac, see [Outlook for Mac improves calendar sharing performance with REST](https://techcommunity.microsoft.com/t5/outlook-blog/outlook-for-mac-improves-calendar-sharing-performance-with-rest/ba-p/273005).

For more information about how to share a folder in Outlook for Mac, see [Share a folder in an Exchange account](https://support.microsoft.com/office/share-a-folder-in-an-exchange-account-645b7a89-2c2e-42b0-92b6-97a703b406b3).
