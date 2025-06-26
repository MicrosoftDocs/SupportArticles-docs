---
title: Error occurs when opening room calendar
description: Describes an error that users in an Exchange hybrid deployment experience when they try to view a calendar for a room mailbox in Outlook. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: meshel, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Cannot display the folder properties or could not be updated error when opening a room calendar in Outlook

_Original KB number:_ &nbsp; 3155551

## Symptoms

When users in an Exchange hybrid deployment try to open the calendar for a room mailbox in Microsoft Outlook, they receive one of the following error messages:

> could not be updated.

> Cannot display the folder properties. The folder may have been deleted or the server where the folder is stored may be unavailable. You don't have appropriate permission to perform this operation.

## Cause

This problem occurs if the room mailbox was created by using the Exchange admin center in Microsoft 365 or Exchange Online PowerShell, and if the room mailbox doesn't have an associated Active Directory account in the on-premises environment.

## Resolution

To resolve this problem, use SMTP matching to link the room mailbox in Exchange Online with an on-premises account. For more information about how to do this, see [How to use SMTP matching to match on-premises user accounts to Microsoft 365 user accounts for directory synchronization](https://support.microsoft.com/help/2641663).

## More information

For more information about room mailboxes, see [Create and Manage Room Mailboxes](/Exchange/recipients/room-mailboxes).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
