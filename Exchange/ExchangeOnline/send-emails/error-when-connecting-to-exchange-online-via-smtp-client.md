---
title: Error when connecting via SMTP client
description: Describes a problem in which you receive an error that states that the Exchange Online server is unknown, cannot be located, or is configured incorrectly.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you try to connect to Exchange Online by using an SMTP client

_Original KB number:_ &nbsp; 3009995

## Symptoms

When you try to connect to Microsoft Exchange Online by using a Simple Mail Transfer Protocol (SMTP) client, you receive an error message that states that the Exchange Online server is unknown, cannot be located, or is configured incorrectly.

The text of the error message varies, depending on the kind of client or connection that's used. Here's one example of an error message that you may receive:

> Sending of message failed.  
An error occurred sending mail: \<SMTPLocation>.outlook.com is unknown. The server may be incorrectly configured. Please verify that your SMTP server settings are correct and try again.

## Cause

This issue may occur if the SMTP client tries to connect to one of the following regional Exchange Online SMTP servers:

- `smtp-apacnorth.outlook.com`
- `smtp-apacsouth.outlook.com`
- `smtp-emea.outlook.com`
- `smtp-emeacenter.outlook.com`
- `smtp-emeacentral.outlook.com`
- `smtp-emeaeast.outlook.com`
- `smtp-emeasouth.outlook.com`
- `smtp-emeawest.outlook.com`
- `smtp-latam.outlook.com`
- `smtp-nameast.outlook.com`
- `smtp-namnorth.outlook.com`
- `smtp-namsouth.outlook.com`
- `smtp-namwest.outlook.com`
- `smtp-unisa.outlook.com`

## Resolution

Make sure that SMTP clients connect to smtp.outlook.com instead of one of the regional SMTP addresses. For more information, see the following webpages:

- [POP and IMAP account settings](https://support.microsoft.com/office/pop-and-imap-account-settings-cb41d2b8-98cb-4ab2-ad60-218349f37e2e)
- [How to set up a multifunction device or application to send email using Microsoft 365 or Office 365](/Exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365)

## More information

The regional SMTP endpoints were used in earlier versions of Exchange Online. They are replaced by the `smtp.outlook.com` endpoint in the current version of Exchange Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
