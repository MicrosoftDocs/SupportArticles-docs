---
title: Contact card doesn't show user photo, details, or presence
description: You can't see user's details or presence information in Outlook contact card, in Search People box, or in the TO field when a policy is applied.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
- CI 142155
ms.reviewer: bobz, tasitae
appliesto:
- Outlook 2016
search.appverid: MET150
---
# A recipient's photo, details, or presence information doesn't appear in Outlook contact card

_Original KB number:_ &nbsp; 4467874

## Symptoms

You experience one or more of the following symptoms in Microsoft Outlook:

- An Outlook contact card doesn't display a recipient's photo, details, or presence information.
- When you try to search for a recipient by using the **Search People** box, the search results display the user name without the presence information. Additionally, when you click to open the user's contact card, only minimal details are displayed.
- No presence information is displayed for a recipient who's listed in the **TO** field. When you open that recipient's contact card, no photo or details are displayed.

## Cause

This issue occurs if the Outlook client is set in Online mode, and the following policy registry key is applied in your organization:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **DownloadDetailsFromAD**  
Values: **0**

This registry sub key tells the Outlook client not to reach out to the online global address list (GAL) for the recipient's information. Instead, the Outlook client will only use the information that's in the offline address book (OAB). An online client doesn't download the OAB, which is why no recipient details are displayed.

> [!NOTE]
> When `DownloadDetailsFromAD` = 0, the information that's displayed in the **People** pane depends on the source location of the contact details. If the information is available only in Active Directory, the information isn't displayed in the **People** pane.

## Resolution

Before you troubleshoot this issue, you must differentiate between the following kinds of recipients:

- A corporate recipient that exists in your GAL that includes information
- A recipient that consists only of an SMTP address

Presence information and contact card details will not be displayed for a recipient that's just an SMTP address.

If the recipient exists in the GAL and includes information, remove the registry key that's mentioned in the Cause section to resolve this issue. Additionally, the `DownloadDetailsFromAD` setting is typically set by a Group Policy object (GPO), so you can also use Group Policy Object Editor to manage the setting.

1. Start Group Policy Object Editor.
2. Under **User Configuration**, expand **Administrative Templates** > **Microsoft Outlook 2016**, and then select the **Outlook Social Connector** node.
3. Double-click the **Do not download photos from Active Directory** setting, select **Disabled** or **Not Configured**, and then select **OK**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
