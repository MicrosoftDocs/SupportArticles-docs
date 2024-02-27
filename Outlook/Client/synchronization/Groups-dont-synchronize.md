---
title: Microsoft 365 groups don't synchronize in Outlook 
description: Provides a fix for when Microsoft 365 groups don't synchronize in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 164031
  - CSSTroubleshoot
ms.reviewer: pedrocorreia
appliesto: 
  - Outlook for Microsoft 365
search.appverid: 
  - MET150
ms.date: 01/30/2024
---

# Microsoft 365 groups don't synchronize in Outlook

## Symptoms

In an Exchange Online mailbox that's configured in Microsoft Outlook, either some or all Microsoft 365 groups don't synchronize automatically.

In the status bar in Outlook, the sync status displays the message, "This folder has not been updated yet".

## Cause

The issue can occur if:

- Modern authentication isn't enabled for the tenant.
- Modern authentication is enabled, and the affected Microsoft 365 groups have 100K items or more.

## Resolution

To resolve this issue, use resolution 1 or resolution 2 depending on the cause of your issue.

Resolution 1: If modern authentication isn't enabled for your tenant, use the following steps:

1. [Enable modern authentication for Outlook in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/enable-or-disable-modern-authentication-in-exchange-online) and wait for replication to complete, which should take a few minutes.
2. [Create an Outlook profile](https://support.microsoft.com/office/create-an-outlook-profile-f544c1ba-3352-4b3b-be0b-8d42a540459d).
3. Open the [Outlook Connection Status](../connectivity/description-of-the-connection-status-dialog-box.md) dialog.
4. Verify that the entries in the **Authn** column display **Bearer***. This value confirms that Outlook is using modern authentication.
5. Check whether the sync status in the status bar in Outlook has updated to display "This folder is up to date".

Resolution 2: If some of the Microsoft 365 groups have 100K items or more, use the following information.

If modern authentication is enabled for your tenant, and the item count in some of the affected groups is 100K or more, you might need to reduce the time period for which Outlook caches items from Microsoft 365 groups. The default time period is 12 months.

To reduce this time period and fix the issue, use the following steps:

1. Create the following registry key:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode`
    DWORD = GroupsSyncWindowSetting <br>
    Value = 3

    The value is a number that specifies the time period in months for Outlook to cache content in Microsoft 365 groups.
2. Restart Outlook.
3. Check  whether the sync status in the status bar in Outlook has updated to display "This folder is up to date".
