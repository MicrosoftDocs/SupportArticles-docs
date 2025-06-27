---
title: Room Finder doesn't display any conference rooms when a user creates a meeting
description: Describes an issue that prevents conference rooms from being listed in Room Finder when users create a meeting in Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Office 2016
  - Office 2013
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Room Finder in Outlook doesn't display any conference rooms when a user creates a meeting

## Problem

When a user creates a new meeting in Microsoft Outlook, no conference rooms are listed in the **Choose an available room** box in the Room Finder, or some conference rooms are listed and other conference rooms are missing.

This issue may occur if the user doesn't select a room list. A room list must be selected before available rooms are displayed in the Room Finder. This issue may also occur if the conference room is hidden from the Global Address List (GAL).

## Solution

To display available rooms, select a room list from the **Show a room list** box. If a room list is selected and the room is still not visible, verify that the room is visible in the GAL.

## More information

To create a room list and to add existing rooms to the room list, follow these steps:

1. Do one of the following:  
   - In on-premises Exchange Server or in an Exchange hybrid environment, open the Exchange Management Shell.
   - In Exchange Online, connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the following command to create a room list:

    ```powershell
    New-DistributionGroup <RoomListName> -RoomList -Members $Members
    ```

1. Run the following command to add existing rooms to the room list:

    ```powershell
    Add-DistributionGroupMember <RoomListName> -Member <RoomMailbox>
    ```

To verify that a room is visible in the GAL, run the following command and verify that `HiddenFromAddressListsEnabled` is set to false:

```powershell
Get-Mailbox <RoomSMTPAddress>
```

For more information, see [Create a room list distribution group](/previous-versions/office/exchange-server-2010/ee633471(v=exchg.141)) and [Create and manage room mailboxes](/Exchange/recipients/room-mailboxes).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
