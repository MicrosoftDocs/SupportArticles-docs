---
title: Meeting requests are added to resource delegate's calendar
description: Describes a scenario in which meeting requests sent to a resource mailbox in on-premises are added to a resource delegate's calendar migrated to cloud.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: gabesl, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Meeting requests sent to resource mailbox in on-premises are added to resource delegate's calendar migrated to cloud

_Original KB number:_ &nbsp; 4036518

## Symptoms

After a user's mailbox is migrated to Microsoft 365, they receive meeting requests from an on-premises room mailbox of which the user is a delegate, as expected.

However, these meetings show on the user's calendar directly as if they were added as an attendee by the organizer. Also, any attempt to accept or decline the request comes directly from the user, instead of from the resource mailbox.

## Cause

This issue occurs if the following conditions are true:

- The resource delegate of the on-premises room mailbox is a distribution group that contains the cloud user.
- Transport Neutral Encapsulation Format (TNEF) is not explicitly enabled on the remote domain that's used when the meeting requests are sent to the cloud mailbox.

## Resolution 1

To resolve the issue at an organizational level (recommended), enable TNEF on the `*.mail.onmicrosoft.com` remote domain, depending on what is used as the target address for cloud users. To do this, run the following cmdlet:

```powershell
Set-RemoteDomain <domain> - TNEFEnabled $true
```

## Resolution 2

To resolve the issue at a single-user level, remove the distribution group as the resource delegate for the room mailbox, and then replace that distribution group with a list of all the members who should be a resource delegate. To do this, follow these steps:

1. Obtain the list of current delegates by using the following cmdlet:

    ```powershell
    [System.Collections.ArrayList]$delegates=@((Get-CalendarProcessing <room>).ResourceDelegates)
    ```

2. Remove the distribution group from the array by using the following cmdlet:

    ```powershell
    $delegates.remove("<Identity of distribution group to remove>")
    ```

3. Add a single user to the array (that is repeated for any additional users to add) by using the following cmdlet:

    ```powershell
    $delegates.add("<Identity of single user to add>")
    ```

4. Apply the changes by using the following cmdlet:

    ```powershell
    Set-calendarprocessing <room> -resourcedelegates $delegates
    ```

## Resolution 3

Migrate the room mailbox from on-premises to cloud, and then migrate all other delegates who are a member of that distribution group.

## More Information

For more information about TNEF, see [Manage TNEF Message Formatting with Remote Domains](/previous-versions/exchange-server/exchangeserver-149/gg263346(v=exchsrvcs.149)).

For more information about the `Set-remotedomain` cmdlet, see [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain?view=exchange-ps&preserve-view=true).
