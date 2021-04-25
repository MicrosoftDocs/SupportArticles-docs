---
title: How to set automatic replies on a user's mailbox in Office 365
description: Describes How to set automatic replies on a user's mailbox in Office 365.
author: Norman-sun
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-swei
manager: dcscontentpm
ms.custom: 
- Exchange Online
- CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# How to set automatic replies on a user's mailbox in Office 365

## Introduction

This article describes three methods that administrators can use to set automatic "out of office" replies on a user's mailbox in Microsoft Office 365.

## More Information

### Method 1

1. Sign in to the Office 365 portal.
1. Locate **Users** > **Active users** (or **Groups** > **Shared mailboxes** if you set this on a shared mailbox).
1. Select a user who has a Microsoft Exchange mailbox.
1. On the flyout menu on the right, locate **Mail settings** > **Automatic replies** (if it's a shared mailbox, just locate **Automatic replies** on the flyout).

### Method 2

1. Sign in to the Office 365 admin portal by using administrator credentials.
1. Expand **Admin Centers**, and then select **Exchange**.
1. Click the picture in the upper-right corner, select **Another User**, and then select the user mailbox that you want to change.
1. On the left side, select **Options**, click **Organize E-mail**, and then click **Automatic replies**.

### Method 3

Run the following cmdlet in Exchange Online PowerShell:

```powershell
Set-MailboxAutoReplyConfiguration
```

For more information about this cmdlet, see [Set-MailboxAutoReplyConfiguration](/powershell/module/exchange/mailboxes/set-mailboxautoreplyconfiguration).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).