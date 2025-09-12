---
title: Calendar on mobile device isn't synced to Online mailbox
description: Describes a scenario in which the calendar on a mobile device is not synced with the calendar in the Exchange Online mailbox when you use Exchange ActiveSync. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-jhayes, jhayes, v-lanac, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Calendar on mobile device isn't synced to the calendar in an Exchange Online mailbox when you use Exchange ActiveSync

_Original KB number:_ &nbsp; 2293282

## Symptoms

When you use Microsoft Exchange ActiveSync to connect a mobile device to Exchange Online in Microsoft 365, the calendar on the mobile device and the calendar in the Exchange Online mailbox are out of sync. For example, you experience one or both of the following symptoms:

- Calendar items that are created on the mobile device are missing from the Exchange Online mailbox.
- Calendar items that are created in the Exchange Online mailbox are missing from the mobile device.

Typically, the calendar on the mobile device is missing events that appear in Microsoft Outlook or in Outlook Web App in Exchange Online.

## Resolution

To troubleshoot this issue, re-create the ActiveSync relationship on the mobile device. Depending on how you connect to Exchange Online, the specific steps will vary.

1. Remove the ActiveSync relationship on the mobile device.

2. Remove the ActiveSync relationship from Outlook Web App. To do this, follow these steps:
   1. Sign in to Outlook Web App.
   2. Select **Settings** (:::image type="icon" source="media/calendar-on-mobile-device-not-synced-to-online-mailbox/settings-button.png" border="false":::), and then select **Options**.
   3. In the left navigation pane, select **Phone**, and then select **Mobile Phones** or **Mobile Devices**.
   4. In the list, select the ActiveSync relationship, and then select **Delete**.

3. Disable any Outlook add-ins that are used to set up calendar items. This includes add-ins that are used to set up conference rooms.

    > [!NOTE]
    > The Outlook add-ins can be re-enabled after the issue is resolved.

4. Restart the mobile device.
5. Re-create the ActiveSync relationship on the device, and then confirm that the issue is fixed.

## More information

This issue may occur for several reasons, including the following:

- A corrupted ActiveSync relationship.
- Third-party Outlook add-ins that change the calendar items.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
