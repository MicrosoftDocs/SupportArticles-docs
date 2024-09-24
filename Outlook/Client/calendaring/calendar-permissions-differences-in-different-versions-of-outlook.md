---
title: Calendar permissions differences
description: This article provides a resolution to solve the calendar permissions differences issue between different versions of Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, aruiz, meshel
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Calendar permissions differences in Outlook 2013, 2010, and 2007

_Original KB number:_ &nbsp; 2816258

## Symptoms

In Microsoft Outlook 2010 and Microsoft Outlook 2013, you can use the Open Other User's Folder feature to view another Microsoft Exchange Server user's free/busy information. When you try to open the same Calendar in Microsoft Office Outlook 2007, you see one of the following errors:

> You do not have permission to view this calendar. Do you want to ask **user** to share his or her Calendar with you?

Where **user** is the name of the person whose Calendar that you are trying to open.

> You do not have sufficient permission to perform this operation on this object. See the folder contact or your system administrator.

## Cause

Outlook 2010 introduced the ability to display another user's free/busy data in a Calendar view when that user's Calendar folder permission is set to Free/Busy. That feature is not available in Outlook 2007.

## Resolution

To open a shared Calendar in Outlook 2007, the user must grant you **Reviewer** or higher permission. Or, you can view that user's free/busy information by opening a new Meeting Request and adding that user in the **Scheduling Assistant**.

## More information

When the shared mailbox is moved from Microsoft Exchange Server 2003 to Microsoft Exchange Server 2007 or newer, Outlook 2010 or later versions may no longer be able to view availability information by using **Open Other User's Folder**.

This is because Microsoft Exchange Server 2003 and earlier versions publish user free/busy information in the SCHEDULE+ FREE BUSY dedicated public folder. The SCHEDULE+ FREE BUSY folder is available to any authenticated user. However, Exchange Server 2007 introduced the Availability Service. The Exchange Availability Service allows for access to be configured per user and to control how much free/busy information is shared. If a user does not configure free/busy information to be shared, you cannot use **Open Other User's Folder** to view their free/busy information.

> [!NOTE]
> Outlook 2007 and newer versions retrieve free/busy information from the Availability Service when the mailboxes are on Exchange Server 2007 or later versions.

For more information about the Exchange Availability Service, see [Understanding the Availability Service](/previous-versions/office/exchange-server-2007/bb232134(v=exchg.80)).

To use Open Other User's Folder, follow these steps:

1. Start Outlook.
2. On the **File** menu, point to **Open**, and then select **Other User's Folder**.
3. In the **Open Other User's Folder** dialog box and then type the name of the user who owns the folder in the **Name** box.
4. Change **Folder type** to **Calendar** and then select **OK**.
