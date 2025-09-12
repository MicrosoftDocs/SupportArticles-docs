---
title: 0x800ccc80 error when sending mail from Outlook
description: Provides a resolution to solve the error 0x800ccc80 that may occur when you send mail from Outlook.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Other
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: aruiz, doakm, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Sending mail from Outlook results in error 0x800ccc80

## Symptoms

When you try to send email from Microsoft Outlook using a POP3 or IMAP account, you receive the following error message:

> Error Message: 0x800CCC80 - None of the authentication methods supported by this client are supported by your server.

## Cause

The error described in the Symptoms section can occur if your Outlook email account is not configured to sign in to the incoming server before sending mail, but your Internet Service Provider (ISP) requires you to authenticate before sending email via SMTP.

Other conditions not described in this article may also result in the same error.

## Resolution

You can use Outlook to repair your email account or enable the **Log on to incoming server before sending mail** option for your email account.

For more information about repairing or configuring your Outlook email account, see [Add an email account to Outlook](https://support.microsoft.com/office/add-an-email-account-to-outlook-6e27792a-9267-4aa4-8bb6-c84ef146101b).
