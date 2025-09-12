---
title: No permissions to the calendar of a room mailbox
description: Describes a scenario that prevents a user from accepting a meeting invitation for a room mailbox in Outlook when the delegate is a shared mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't accept a meeting invitation for a room mailbox in Outlook if the delegate is a shared mailbox

_Original KB number:_ &nbsp; 3191290

## Problem

Consider the following scenario.

- You add a shared mailbox as a delegate for a room mailbox by running the following PowerShell command:

    ```powershell
    Set-CalendarProcessing room -ResourceDelegates sharedmbx -AllBookInPolicy $false -AllRequestInPolicy $true
    ```

- When a user tries to accept the meeting invitation from the Inbox of the shared mailbox in Microsoft Outlook, they receive an error message that resembles the following:

    > Cannot open the Calendar folder for user "room alias". The operation failed.

- The user can accept the meeting request from the Inbox of the shared mailbox in Outlook on the web. However, the user who sent the meeting request doesn't receive an email message that confirms that the meeting was accepted.

## Cause

This behavior is by design. Users who have access to the shared mailbox don't inherit permissions to the calendar of the room mailbox.

## Workaround

Users who have full access permission to the shared mailbox must have explicit editing permissions to the calendar of the room mailbox. To assign editing permission to users for the calendar of the room mailbox, follow these steps:

1. Do one of the following, as appropriate for your situation:
   - Connect to Exchange Online by using remote PowerShell. For more info, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   - Open the on-premises Exchange Management Shell.

2. Run the following command:

    ```powershell
    Add-MailboxFolderPermission -Identity room@contoso.com:\Calendar -User ed@contoso.com -AccessRights Editor
    ```

    > [!NOTE]
    > In this command, replace *room@contoso.com* with the email address of the room, and replace *ed@contoso.com* with the email address of the user who has full access permissions to the shared mailbox.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
