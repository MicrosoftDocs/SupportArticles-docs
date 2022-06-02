---
title: Office 365 Groups do not synchronize in Outlook for Windows
description: Provides troubleshooting steps for what to do when Office 365 Groups do not synchronize in Outlook for Windows.
author: Devon-Miller
ms.author: pedrocorreia
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
  - Outlook for Office 365
search.appverid: 
  - MET150
ms.date: 6/2/2022
---

# Office 365 Groups don't synchronize in Outlook for Windows

## Symptoms

You have an Exchange Online mailbox configured in Outlook for Windows, and some or all Office 365 Groups don't update automatically.

In the Outlook status bar, the sync status shows “This folder has not been updated yet”.

Recreating the Outlook profile or recreating the ".nst" file (located in `%localappdaa%\Microsoft\Outlook`) only fixes the issue temporarily.
- How to [Create an Outlook profile](https://support.microsoft.com/office/create-an-outlook-profile-f544c1ba-3352-4b3b-be0b-8d42a540459d)

## Resolution

The resolve this issue, follow the steps below in the same order as presented. Only move to the next step if the previous step didn't fix it:

1.	[Enable modern authentication for Outlook in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/enable-or-disable-modern-authentication-in-exchange-online) and wait for replication before testing again.
    1. It's recommended that you create a new Outlook profile.
    1. You can confirm if Outlook is using Modern Auth by opening the [Outlook Connection Status](../connectivity/description-of-the-connection-status-dialog-box.md) and confirming that the ‘Authn’ column shows ‘Bearer*’.

2.	In some cases, with exceptionally high item count on the non-syncing Office 365 Groups, we might need to reduce the cached period for the Office 365 Groups. You can reduce the cached period by applying the following registry key (without affecting the general sync slider settings):
    1. After adding the registry key below, creating a new Outlook profile or recreating the ".nst" file located in `%localappdaa%\Microsoft\Outlook` is needed.
        - `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode`
        - DWORD = GroupsSyncWindowSetting
        - Value = 3
            - ‘Value’ specifies the amount (in months) of user email Outlook synchronizes locally for Office 365 Groups content. The default value is 12 months, and 0 is All data.
