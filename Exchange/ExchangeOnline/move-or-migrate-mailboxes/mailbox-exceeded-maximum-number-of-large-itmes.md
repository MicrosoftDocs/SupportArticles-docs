---
title: Can't migrate a user's mailbox data from the on-premises to Microsoft 365
description: Fixes an issue in which you receive an error message when you try to migrate a user's mailbox data from the on-premises messaging environment to Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
- xchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# This mailbox exceeded the maximum number of large items when migrating a user's mailbox data from the on-premises environment to Microsoft 365

_Original KB number:_ &nbsp; 2584294

## Problem

You use one of the following to try to migrate a user's mailbox data from your on-premises messaging environment to Microsoft 365:

- The New Migration Batch Wizard in the Exchange admin center of Microsoft 365
- The E-mail Migration wizard in the Exchange admin center of Microsoft 365
- Exchange Online PowerShell

However, you receive an error message that resembles the following:

> FailureType : TooManyLargeItemsPermanentException
>
> FailureSide : Target
>
> Message : Error: This mailbox exceeded the maximum number of large items that were specified for this request. --> MapiExceptionMaxSubmissionExceeded: IExchangeFastTransferEx.TransferBuffer failed (hr=0x80004005, ec=1242)

This issue occurs if the user's mailbox contains one or more messages that exceed the 150-megabyte (MB) message limit.

## Solution

To fix this issue, locate and remove messages that are larger than 150 MB from the user's on-premises mailbox. To do this, follow these steps:

1. Access the user's on-premises mailbox by using Microsoft Outlook.
2. Arrange all items in all folders of the user's mailbox by size. Sort the items from largest to smallest so that the largest items are at the top of the list.
3. Locate the items that are larger than 150 MB. If these items contain important info, save them to another location such as the local computer or a local Personal Folders file (.pst). Then, delete the items that are larger than 150 MB from the user's mailbox.
4. Return to the Exchange admin center, and then resume the migration.
5. After the migration is complete, the data can be reimported to the Exchange Online mailbox.

## More information

For more info about how to import items into Outlook in Microsoft 365, go to the following Microsoft websites:

- [Import email, contacts, and calendar from an Outlook .pst file](https://support.microsoft.com/office/import-email-contacts-and-calendar-from-an-outlook-pst-file-431a8e9a-f99f-4d5f-ae48-ded54b3440ac)
- [Import a .pst file into Outlook for Mac from Outlook for Windows](https://support.microsoft.com/office/import-a-pst-file-into-outlook-for-mac-from-outlook-for-windows-b4a6a1d6-94bb-4c85-a4fc-a83dc690e18c)

For more info about Microsoft 365 messaging limits, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
