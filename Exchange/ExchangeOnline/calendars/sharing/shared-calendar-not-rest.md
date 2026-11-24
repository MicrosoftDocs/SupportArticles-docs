---
title: Shared calendar is blank, won't open, or doesn't show REST in classic Outlook
description: Check modern shared calendar prerequisites, acceptance, and the receiver's calendar entry when a shared calendar won't open or doesn't use REST.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Online
  - Outlook for Windows
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Shared calendar is blank, won't open, or doesn't show REST in classic Outlook

## Summary

This article describes how to check the sharing model and the calendar entry when a shared calendar won't open, is blank after invitation acceptance, or doesn't show `(REST)` in classic Outlook.

## Symptoms

- Classic Outlook reports that it can't display or add the shared calendar.
- An accepted shared calendar doesn't appear or doesn't populate.
- Shared calendar improvements are enabled, but the folder type doesn't include `(REST)`.

## Cause

Classic Outlook might be using legacy MAPI access, an availability-only calendar entry, or an incomplete sharing relationship. The modern sharing model uses a local copy of the calendar in the receiver's mailbox. Enabling a client setting doesn't create this copy or make Outlook use it.

## Resolution

1. Confirm that both mailboxes are hosted in Exchange Online. Internal modern sharing requires this configuration.
1. In classic Outlook, confirm that the Exchange account uses Cached Exchange Mode and that **Turn on shared calendar improvements** is enabled. Online mode doesn't use the modern shared calendar path.
1. Right-click the receiver's shared calendar, and then select **Properties**. A modern shared calendar shows the following folder type:

   ```text
   Type: Folder containing Calendar Items (REST)
   ```

1. Confirm that the owner shared the intended calendar and that the receiver accepted the invitation. If access is in question, check the [owner's calendar permissions](../permissions/troubleshoot-calendar-delegate-permissions.md).
1. If the relationship is valid but the receiver's calendar entry is missing, select **Add Calendar** > **Open Shared Calendar** in classic Outlook, and then select the owner. Don't use an availability-only **From Address Book** entry to test modern sharing.
1. Open the added calendar and check its folder type. If the calendar opens, shows `(REST)`, and displays a new test change to both users, no further action is needed.
1. If a legacy entry needs an upgrade, follow [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26). Don't repeatedly delete and recreate a confirmed modern calendar.
1. After the upgrade, confirm that the intended calendar opens, its type includes `(REST)`, and a new test change is visible to both users.

### If the issue persists

If the calendar still won't open, opens but doesn't update, or Outlook crashes or times out, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the exact error, the Outlook build, the account mode, the owner and receiver identities, and the reproduction time with time zone with the support request. Microsoft Support might request a client trace.
