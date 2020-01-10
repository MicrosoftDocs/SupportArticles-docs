---
title: Collect ActiveSync device logs to troubleshoot sync issues for mobile devices
description: Describes how to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online.
author: simonxjx
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# How to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online

## Introduction 

This article describes how to collect Exchange ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online in Microsoft Office 365. If you can't sync your mobile device to your mailbox, you may be asked by Office 365 Support to collect logs for troubleshooting.

## Procedure

To capture ActiveSync device log information, use one of the following methods. 

### Method 1: Use Outlook on the web

1. Sign in to the Office 365 portal (https://portal.office.com/).
1. Click **Mail** to open Outlook on the web (formerly known as Outlook Web App).
In the upper-right area of the page, click **Settings**, and then click **Options**.
1. In the navigation pane on the left, expand **General**, and then click **Mobile Devices**.
1. In the list of devices, select the device that you want to track, and then click **Start Logging**.
1. In the **Information** dialog box, click **Yes**.
1. Reproduce the behavior that you want to capture, and then click **Retrieve Log**.

    An email message that contains the log file (EASMailboxLog.txt) as an attachment is sent to your mailbox.

### Method 2: Use Exchange Online PowerShell

1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online using remote PowerShell](https://docs.microsoft.com/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps).
1. Run the following command to enable ActiveSync logging for a specific user:

    ```powershell
    Set-CASMailbox alias -ActiveSyncDebugLogging:$true
    ```
1. Reproduce the behavior that you want to capture.
1. Run the following command to retrieve the log:

    ```powershell
    Get-MobileDeviceStatistics -Mailbox alias -GetMailboxLog:$true -NotificationEmailAddresses "admin@contoso.com"
    ```
    > [!NOTE]
    > This command retrieves the statistics for the mobile device that's set up to synchronize with the mailbox of the user who you specified. In this example, it also sends the log file to admin@contoso.com.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).