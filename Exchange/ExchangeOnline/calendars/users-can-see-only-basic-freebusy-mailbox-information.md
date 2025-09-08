---
title: Only see basic free/busy mailbox information
description: Describes an issue in which a user can see only basic free/busy time information about a mailbox in a remote forest by using Scheduling Assistant in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Users can see only basic free/busy mailbox information in a remote forest in Microsoft 365

_Original KB number:_ &nbsp; 3079932

## Symptoms

In Microsoft 365, a user can see only basic free/busy time information about a mailbox in a remote forest by using Scheduling Assistant.

## Cause

The default permissions on the Calendar folder in Microsoft Outlook determine the level of free/busy information that's displayed to users in a remote forest by using Scheduling Assistant. Users who are granted additional free/busy and folder permissions do not see any detailed information in Scheduling Assistant.

These are the Free/Busy permissions:

- Free/Busy time
- Free/Busy time, subject, location (Limited Details)

## Resolution

A user may have additional permissions to a calendar folder. For example, a user may have editor, reviewer, or contributor permissions. However, this behavior doesn't change the free/busy information that's shared in Scheduling Assistant in Outlook across forests.

> [!NOTE]
> An organization relationship is necessary to share free/busy information in an on-premises environment in a hybrid scenario. Please see the "More Information" section.

For example, if the default permissions are set to **Free/Busy time**, all users in the remote forest see only the free/busy time:

:::image type="content" source="media/users-can-see-only-basic-freebusy-mailbox-information/freebusy-time.png" alt-text="Screenshot of the free/busy time.":::

The cross-forest user cannot open the calendar directly and cannot view details based on their individually granted permissions. However, they can do these things by adding another folder in Outlook. To do this, a user selects **File** > **Open** > **Other User's Folder**. If the cross-forest user is granted reviewer or other permissions, the user can see details about the items in the calendar.

> [!NOTE]
> Granting the **Free/Busy time, subject, location (Limited Details)** permission is insufficient in a hybrid environment. The user has to be granted at least **Reviewer** permission to view calendar item details.

The user may see the subjects of the meetings from the calendar:

:::image type="content" source="media/users-can-see-only-basic-freebusy-mailbox-information/meeting-subjects.png" alt-text="Screenshot of the subjects of the meetings from the calendar" border="false.":::

The user can also open and change calendar items:

:::image type="content" source="media/users-can-see-only-basic-freebusy-mailbox-information/open-and-change-calendar-items.png" alt-text="Screenshot of a calendar that you can open or change.":::

> [!NOTE]
> Folder-level permissions are transferred when a mailbox is migrated to the cloud. Or, the permissions can be added if the object that represents the other user is mail-enabled and can be monitored by an access control list (that is, if the value of the `msExchRecipientDisplayType` attribute is set to **-1073741818**).

## More information

The administrator controls the level of the free/busy data to be shared by using the settings on the organization relationship. The user controls the level of free/busy data to share with other users by using the default permissions on the user's calendar folder.

### For administrators

For free/busy information to be shared between an on-premises environment and the cloud (hybrid), an organization relationship must be created. The properties that control the free/busy data shared across the forest are as follows:

- FreeBusyAccessEnabled
- FreeBusyAccessLevel
- FreeBusyAccessScope

The free/busy access level can be set to three values that correspond to the levels available to users in Outlook:

- None
- AvailabilityOnly (Free/Busy time)
- LimitedDetails (Free/Busy time, subject, location)

For more information about organization relationships, see [New-OrganizationRelationship](/powershell/module/exchange/new-organizationrelationship).

Sharing policies will function similarly for remote organizations. For more information, see [New-SharingPolicy](/powershell/module/exchange/new-sharingpolicy).

### For users

The user controls how much free/busy information is displayed to users in a remote forest by using the **Permissions** tab in **Calendar Properties** in Outlook.

:::image type="content" source="media/users-can-see-only-basic-freebusy-mailbox-information/permissions-tab-in-calendar-properties.png" alt-text="Screenshot of the Permission tab" border="false.":::

Scheduling Assistant displays the free/busy details that are configured by using the default permissions:

:::image type="content" source="media/users-can-see-only-basic-freebusy-mailbox-information/freebusy-details.png" alt-text="Screenshot of the free/busy details.":::

For more information about cross-forest free/busy configuration, see [Users can't see free/busy information after a mailbox is moved to Microsoft 365](/exchange/troubleshoot/move-mailboxes/cannot-see-free-busy-information).
