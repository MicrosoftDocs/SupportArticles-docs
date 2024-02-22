---
title: HTTP 500 error when publishing calendar of shared mailbox
description: Describes an issue that triggers an HTTP 500 error message when a user tries to publish the calendar of a shared mailbox to people outside their Microsoft 365 organization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# HTTP 500 error when a user tries to publish the calendar of a shared mailbox in Microsoft 365

_Original KB number:_ &nbsp; 2934901

## Symptoms

When a user who has Full Access permission to a shared mailbox in Microsoft 365 tries to publish the calendar of the shared mailbox, the user receives an **HTTP 500** error message.

## Cause

This issue occurs if the user isn't the mailbox owner. Only mailbox owners can publish a calendar externally.

## Workaround

1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following command to publish the calendar folder of a mailbox:

    ```powershell
    Set-MailboxCalendarFolder -Identity <user>:\Calendar -PublishEnabled:$True -PublishDateRangeFrom ThreeMonths -PublishDateRangeTo SixMonths -DetailLevel LimitedDetails
    ```

    > [!NOTE]
    > Set the `-DetailLevel` parameter to the value that's appropriate for you. The options are `AvailabilityOnly`, `LimitedDetails`, and `FullDetails`. In this example, the parameter is set to `LimitedDetails`.

3. Run the following command to view the published URL of the calendar folder:

    ```powershell
    Get-MailboxCalendarFolder -Identity <user>:\Calendar
    ```

## More information

For more information about the `Set-MailboxCalendarFolder` and `Get-MailboxCalendarFolder` cmdlets, see the following Microsoft websites:

- [Set-MailboxCalendarFolder](/powershell/module/exchange/set-mailboxcalendarfolder?view=exchange-ps&preserve-view=true)
- [Get-MailboxCalendarFolder](/powershell/module/exchange/get-mailboxcalendarfolder?view=exchange-ps&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
