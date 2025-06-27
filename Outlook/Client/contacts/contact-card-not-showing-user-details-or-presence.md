---
title: Contact card doesn't show user photo, details, or presence
description: You can't see user's photo, details, or presence information in Outlook contact card, in Search People box, or in the TO field when a policy is applied.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:People or Contacts\Contact pictures
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 142155
ms.reviewer: bobz, tasitae
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# A recipient's photo, details, or presence doesn't appear in Outlook contact card

_Original KB number:_ &nbsp; 4467874

## Symptoms

You experience one or more of the following symptoms in Microsoft Outlook:

- An Outlook contact card doesn't display a recipient's photo, details, or presence.
- When you try to search for a recipient by using the **Search People** box, the search results display the user name without the presence information. Additionally, when you select to open the user's contact card, only minimal details are displayed.
- No presence is displayed for a recipient who's listed in the **TO** field. When you open that recipient's contact card, no photo or details are displayed.

## Cause

This issue occurs if the following policy registry key is applied in your organization:

Subkey: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: `DownloadDetailsFromAD`  
Value: **0**

## Resolution

Before you troubleshoot this issue, you must differentiate between the following kinds of recipients:

- A corporate recipient that exists in your GAL and includes information
- A recipient that consists of only an SMTP address

Presence information and contact card details will not be displayed for a recipient that has only an SMTP address.

To resolve this issue for a recipient that exists in the GAL and includes information, remove the registry key that's mentioned in the "Cause" section. Additionally, the `DownloadDetailsFromAD` setting is typically set by a Group Policy Object (GPO). Therefore, you can also use Group Policy Object Editor to manage the setting.

1. Start Group Policy Object Editor or Group Policy Management Console.
2. Under **User Configuration**, expand **Administrative Templates** > **Microsoft Outlook 2016**, and then select the **Outlook Social Connector** node.
3. Double-click the **Do not download photos from Active Directory** setting, select **Disabled** or **Not Configured**, and then select **OK**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
