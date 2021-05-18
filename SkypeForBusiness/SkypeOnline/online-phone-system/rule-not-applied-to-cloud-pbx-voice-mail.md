---
title: Mailbox rules aren't applied to Cloud PBX voice mails
description: Describes how Cloud PBX voice mails aren't evaluated by Outlook mailbox rules for new mail delivery.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Outlook mailbox rules aren't applied to Cloud PBX voice mails

## Problem

You receive a Cloud PBX voice mail, but the Outlook mailbox rule to handle the receipt of a new voice mail isn't applied as expected.  

## Solution

This is the expected behavior. There's currently no workaround. Cloud PBX voice mail uses Exchange Web Services (EWS) to put the voice mail in the user's Office 365 mailbox. It does this by adding the voice mail as an attachment to an email message. Therefore, the email message isn't evaluated by the Outlook mailbox rules that are processed during new voice mail delivery.

## More Information

For more information about Cloud PBX voice mail, see [Set up Cloud Voicemail](/microsoftteams/set-up-phone-system-voicemail?bc=%2fskypeforbusiness%2fbreadcrumb%2ftoc.json&toc=%2fskypeforbusiness%2ftoc.json).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).