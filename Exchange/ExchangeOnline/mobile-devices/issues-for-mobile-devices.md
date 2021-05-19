---
title: Collect ActiveSync device logs to troubleshoot sync issues for mobile devices
description: Describes how to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online.
author: Norman-sun
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-swei
ms.custom: 
- Exchange Online
- CSSTroubleshoot
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

To capture ActiveSync device log information, use following methods:

1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
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
