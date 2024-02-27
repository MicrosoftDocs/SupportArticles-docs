---
title: The operation failed error when you send email messages in Outlook
description: Describes an error (The operation failed. The messaging interfaces have returned an unknown error.) that occurs when a Google Apps Sync for Outlook account and an Exchange Server account are configured in the same Outlook profile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/30/2024
---
# The operation failed error when you send email messages in Outlook

_Original KB number:_ &nbsp;3028159

## Symptoms

When you send email messages in Microsoft Outlook, you receive the following error message:

> The operation failed. The messaging interfaces have returned an unknown error. If the problem persists, restart Outlook.

## Cause

This issue occurs when a Google Apps Sync for Outlook account and an Exchange Server account are configured in the same Outlook profile.

## Resolution

Don't configure an Exchange Server account and a Google Apps Sync for Outlook account in the same Outlook profile. Instead, create separate Outlook profiles, and then configure the Google Apps Sync for Outlook account in one profile and the Exchange Server account in another profile. This Microsoft Knowledge Base article describes [how to create profile and set up an e-mail account in Outlook](https://support.microsoft.com/help/829918).

## More information

For more information about this issue, go to the [Google Apps Known Issues](https://support.google.com/a/known-issues/15721?rd=1) page, and then expand the "Email Clients and Mobile Devices" section.  

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
