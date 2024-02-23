---
title: Resource doesn't respond to meeting requests
description: Describes an issue in which resource doesn't respond to meeting requests when you try to use Resource Booking to schedule a resource by using Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-mosha, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# A resource doesn't respond to meeting requests when using Resource Booking to schedule the resource

_Original KB number:_ &nbsp; 2887738

## Symptoms

When you try to use Resource Booking to schedule a resource in Microsoft Exchange Online such as a conference room by using Microsoft Outlook, you may notice the following behavior when Resource Booking isn't successful:

- The resource doesn't automatically respond to meeting requests.
- The resource doesn't respond correctly to meeting requests.

## Cause

Incorrect mailbox or calendar configuration can cause problems in resource mailboxes.

## Resolution

These instructions discuss the settings that you should review to determine whether a resource mailbox is set up correctly by using the Microsoft Exchange Management Shell and Microsoft Office Outlook Web Access. You may have to reference specific customer documentation to determine whether the correct settings are set up. OR you may have to compare the settings to another, similar resource mailbox. If there are any incorrect settings, note them, and then discuss these settings with the Subject Matter Expert before you change the settings.

### Exchange Management Shell cmdlets

To check the mailbox configuration, use the following cmdlet:

```powershell
get-mailbox <Identity>| fl *type*,*link*,*share*
```

The output should resemble the following:

```console
ResourceType : Room
RecipientType : UserMailbox
RecipientTypeDetails : RoomMailbox
IsLinked : False
LinkedMasterAccount : NT AUTHORITY\SELF
IsShared : False
```

> [!NOTE]
>
> - ResourceType: This value should be Room in most cases. If the client set up special resource types, the value may be set to Equipment or to another kind of resource. See the client-specific documentation, or compare the value to another, similar resource mailbox.
> - RecipientType: This value should be User Mailbox.
> - RecipientTypeDetails: In most cases, this value should be Room Mailbox.
> - IsLinked: In most cases, this value should be False.
> - LinkedMasterAccount: This value should be NT Authority\Self.
> - IsShared: In most cases, this value should be False.

If you have to convert the mailbox to a Room mailbox, use the following cmdlet:

```powershell
Set-Mailbox <Identity> -Type Room
```

Next, confirm that the mailbox is configured to respond automatically to meeting invitations. To do this, use the following cmdlets:

```powershell
Get-CalendarProcessing <Identity> | fl AutomateProcessing
```

> [!NOTE]
>
> - In Microsoft Exchange Server 2010, this command was changed to `Get-calendarprocessing`.
> - The `AutomateProcessing` attribute should be set to **AutoAccept**.

To change the `AutomateProcessing` attribute, use the following cmdlet:

```powershell
Set-MailboxCalendarSettings <Identity> -AutomateProcessing AutoAccept -ConflictPercentageAllowed 0 -maximumConflictInstances 0
```

Exchange Server 2010 example

```powershell
Set-CalendarProcessing <Identity> -AutomateProcessing AutoAccept -ConflictPercentageAllowed 0 -maximumConflictInstances 0
```

If the problem is inconsistent, or if the resource produces incorrect responses, check the restriction policies. To do this, use the following cmdlet:

```powershell
get-mailboxcalendarsettings <Identity> | fl *policy
```

Exchange Server 2010 example

```powershell
get-calendarprocessing <Identity> | fl *policy
```

> [!NOTE]
> These settings control how users book resources automatically if they are available and how to submit a request for manual approval if the resource is not automatically available. The output may resemble the following:

```console
RequestOutOfPolicy :
AllRequestOutOfPolicy : False
BookInPolicy :
AllBookInPolicy : True
RequestInPolicy :
AllRequestInPolicy : False
ResourceDelegates :
```

> [!NOTE]
>
> - AllRequestOutOfPolicy: When the value is set to **$True**, this right is granted to everyone. When the value is set to **$False**, only users who are listed in the `RequestOutOfPolicy` parameter are granted permissions to this right. The default setting is **$False**.
> - AllBookInPolicy: This setting controls whether users can book the resource automatically if it is available. When the value is set to **$True**, this right is granted to everyone. When the value is set to **$False**, only users who are listed in the `BookInPolicy` parameter are granted permissions to this right. The default setting is **$True**.
>- AllRequestInPolicy: This setting controls whether users can submit a request for manual approval if the resource is available. The booking isn't automatic. When the value is set to **$True**, this right is granted to everyone. When the value is set to **$False**, only users who are listed in the `RequestInPolicy` parameter are granted permissions to this right. The default setting is **$False**.
> - ResourceDelegates: Specifies a list of users who are resource mailbox delegates. Resource mailbox delegates can approve or reject requests that are sent to this resource mailbox.To change these settings, use the following cmdlet:

```powershell
Set-MailboxCalendarSettings <Identity> -<Property> <Value>
```

Exchange Server 2010 example

```powershell
Set-CalendarProcessing <Identity> -<Property> <Value>
```

### Outlook Web Access settings

To check the mailbox configuration by using Outlook Web Access settings, follow these steps:

1. Sign in to the mailbox by using Outlook Web Access.
2. On the **Options** menu, select **Resource Settings.**

> [!NOTE]
> These settings can be managed by users who have full mailbox permissions to the resource mailbox. These settings are the same as most of the settings that can be changed by using Exchange Management Shell.

#### Resource scheduling options

- Automatically process meeting requests and cancellations: Allows for automatic processing.
- Disable Reminders: No reminders are kept for meetings in the resource mailbox.
- Maximum number of days: Allows for a booking window.
- Always decline if end date is beyond this limit: Indicates whether recurring meetings are declined if the end date is beyond the booking window.
- Maximum allowed minute: Specifies maximum length of each meeting.
- Allow scheduling only during working hours: Rejects meetings that are scheduled after work hours.
- Allow Conflicts: Multiple calendar items can be reserved during the same time.
- Allow recurring meetings: Allows for recurring meetings to be scheduled.
- Allow up to this number of individual conflicts: Specifies the maximum number of conflicts.
- Allow up to this percentage of individual conflicts: Sets a conflict percentage threshold for recurring meetings.

#### Resource scheduling permissions

- Book in Policy: All users who are defined in this option can schedule a meeting automatically.
- Request in Policy: All users who are defined in this option must wait for manual approval even if the mailbox resource is available.
- Request out of policy: These users can automatically schedule the resource if the resource mailbox is available. If the resource isn't available, the meeting that is requested must be approved manually. However, the request is never declined automatically.
- No permission: In this case, the request doesn't fit into any of these groups, and the request is automatically declined. Be aware that if the resource isn't available, the request is declined. The only exception is for the users of the Request out of policy setting.
- Resource Delegates: All users who are delegates of the resource mailbox and can approve or reject scheduling requests.

#### Corrupted free/busy data

Some booking issues are related to corrupted free/busy data. In these cases, best practices are to update the free/busy information for the resource mailbox. To do this, follow these steps:

1. Load an Outlook profile for the resource mailbox in Microsoft Exchange Server MAPI Editor (MFCMapi).
2. Locate the Free/Busy folder for the mailbox in MFCMapi that is located above **Top of Information Store**.
3. Delete the following two files:
   - Local Data
   - Sniffer

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
