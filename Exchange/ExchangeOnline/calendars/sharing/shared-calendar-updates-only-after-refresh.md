---
title: Shared calendar meetings appear only after Update Folder action in classic Outlook
description: Investigate shared calendar notifications when meetings appear after a manual Update Folder action but don't arrive automatically in classic Outlook.
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

# Shared calendar meetings appear only after Update Folder action in classic Outlook

## Summary

This article helps you investigate folder notifications when classic Outlook displays shared calendar meetings only after the receiver selects **Update Folder**. This behavior differs from [meeting-request messages that don't reach a delegate's Inbox](../permissions/fix-delegate-invites.md). The article also lists the information to collect before you contact Microsoft Support.

## Symptoms

- New or changed meetings don't appear automatically in the shared calendar.
- Selecting **Update Folder** makes the missing events appear.
- The calendar uses modern sharing.

## Cause

This issue can occur when an incorrectly stamped folder-notification property on the receiver's local shared-calendar copy prevents Outlook from receiving update notifications. The folder contains the data, but Outlook isn't notified that updates are available. The symptoms alone don't confirm that this property is the cause.

## Report the issue to Microsoft Support

Collect the following evidence, and then [contact Microsoft Support](/microsoft-365/admin/get-help-support). Support works with you to investigate the notification behavior. Selecting **Update Folder** is a diagnostic comparison, not a repair.

1. Confirm that the calendar uses modern sharing by using [Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26).
1. Compare the shared calendar in classic Outlook with the receiver's shared calendar in Outlook on the web. If both are out of date, see [Modern shared calendar stops updating or has missing events](shared-calendar-updates-delayed.md) instead.
1. Create a test event, and record the time. Check whether **Update Folder** displays it.
1. If only the desktop view requires a manual refresh, contact Microsoft Support. Support can check the notification properties of the receiver's folder and determine whether to recreate the affected shared-calendar entry.

Don't manually edit folder flags or delete mailbox folders. If advanced mailbox inspection is necessary, perform it only in a session that Microsoft Support guides. Recreating the entry isn't a general fix for all shared-calendar synchronization issues.
