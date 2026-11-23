---
title: Room resource accounts don't update after Pro license assignment
description: Learn why room resource accounts might not show the correct email address or license type in the Teams Rooms Pro Management portal after you assign Teams Rooms Pro licenses, and how to fix the issue.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows, Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/12/2026
---

# Room resource accounts don't update after Pro license assignment

## Summary

If a room resource account doesn't update in the Teams Rooms Pro Management portal after you assign a Teams Rooms Pro license, the portal might show the wrong email address or license type. This issue can also prevent you from associating the device for Autopilot. In this case, make sure that the room resource account isn't hidden from the Global Address List (GAL).

## Symptoms

You see one or more of the following behaviors in the Teams Rooms Pro Management portal:

- A room resource account doesn't sync after you assign a Teams Rooms Pro license.
- The portal shows an incorrect email address for the room resource account.
- The portal shows an incorrect license type.
- You can't associate the device for Autopilot.

## Cause

This issue occurs when the room resource account is hidden from the Global Address List (GAL). When the account is hidden, the service can't pull the room into the Teams Rooms Pro Management portal.

## Resolution

Make the room resource account visible in the GAL.

### Use the Exchange admin center

1. Sign in to the Microsoft 365 admin center at https://admin.microsoft.com with your admin account.
1. In the left navigation pane, go to **Users** > **Active users**.
1. Search for the resource account, such as a room mailbox.
1. Open the account details pane, and then select **Mail** or **Mail settings** to open the Exchange properties for the mailbox.
1. In the Exchange admin center, find the **Hide from address lists** setting for the mailbox.
1. Ensure **Hide from global address list (GAL)** is set to **No**, then save.

### Use Exchange Online PowerShell

1. Connect to Exchange Online PowerShell.
1. Run the following command to make the resource account visible in the GAL:
   ```powershell
   Set-Mailbox -Identity "resourceaccount@domain.com" -HiddenFromAddressListsEnabled $false
   ```
1. If needed, update the Global Address List:
   ```powershell
   Update-GlobalAddressList -Identity "Default Global Address List"
   ```

## More information

- After you make the account visible, directory replication can take up to 24 hours.
- To keep the room synced with the Teams Rooms Pro Management portal, leave the resource account visible in the GAL.
- [Manage your resource account and device inventory](/microsoftteams/rooms/inventory#manage-your-location-directory-and-view-meeting-rooms)
