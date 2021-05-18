---
title: Room Finder doesn't display any conference rooms when a user creates a meeting
description: Describes an issue that prevents conference rooms from being listed in Room Finder when users create a meeting in Outlook. Provides a resolution.
author: Norman-sun
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
ms.author: v-swei
manager: dcscontentpm
ms.custom: 
- Exchange Online
- CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Office 2016
- Office 2013
---
# Room Finder in Outlook doesn't display any conference rooms when a user creates a meeting

## Problem

When a user creates a new meeting in Microsoft Outlook, no conference rooms are listed in the **Choose an available room** box in the Room Finder.

This issue may occur if the user doesn't select a room list. A room list must be selected before available rooms are displayed in the Room Finder.

## Solution

To display available rooms, select a room list from the **Show a room list** box.

## More information

To create a room list and to add existing rooms to the room list, follow these steps:

1. Do one of the following:  
   - In on-premises Exchange Server or in an Exchange hybrid environment, open the Exchange Management Shell.
   - In Exchange Online, connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the following command to create a room list:

    ```powershell
    New-DistributionGroup <RoomListName> -RoomList -Members $Members
    ```

1. Run the following command to add existing rooms to the room list:

    ```powershell
    Add-DistributionGroupMember <RoomListName> -Member <RoomMailbox>
    ```

For more information, see [Create a room list distribution group](/previous-versions/office/exchange-server-2010/ee633471(v=exchg.141)) and [Create and manage room mailboxes](/Exchange/recipients/room-mailboxes).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).