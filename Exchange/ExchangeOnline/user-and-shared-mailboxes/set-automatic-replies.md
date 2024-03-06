---
title: How to set automatic replies on a user's mailbox in Microsoft 365
description: Describes How to set automatic replies on a user's mailbox in Microsoft 365.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 03/06/2024
ms.reviewer: v-six
---
# How to set automatic replies on a user's mailbox in Microsoft 365

## Introduction

This article describes four methods that administrators can use to set automatic "out of office" replies on a user's mailbox in Microsoft 365.

## Method 1

1. Sign in to the Microsoft 365 portal.
1. Locate **Users** > **Active users** (or **Groups** > **Shared mailboxes** if you set this on a shared mailbox).
1. Select a user who has a Microsoft Exchange mailbox.
1. On the flyout menu on the right, locate **Mail settings** > **Automatic replies** (if it's a shared mailbox, just locate **Automatic replies** on the flyout).

## Method 2

1. Sign in to the Microsoft 365 admin portal by using administrator credentials.
1. Expand **Admin Centers**, and then select **Exchange**.
1. Under **Recipients** > **Mailboxes**, select the mailbox that you want to change.
1. Select **Others**, and then select **Manage automatic replies** under **Automatic replies**.

## Method 3

Run the following cmdlet in Exchange Online PowerShell:

```powershell
Set-MailboxAutoReplyConfiguration
```

For more information about this cmdlet, see [Set-MailboxAutoReplyConfiguration](/powershell/module/exchange/mailboxes/set-mailboxautoreplyconfiguration).

## Method 4

[Use rules to create an out of office message](https://support.microsoft.com/office/use-rules-to-create-an-out-of-office-message-9f124e4a-749e-4288-a266-2d009686b403).

## More information

[Understanding and troubleshooting Out of Office (OOF) replies](../email-delivery/understand-troubleshoot-oof-replies.md).
 
Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
