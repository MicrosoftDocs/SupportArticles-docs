---
title: Collect ActiveSync device logs to troubleshoot sync issues for mobile devices
description: Describes how to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# How to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online

## Introduction

This article describes how to collect Exchange ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online in Microsoft 365. If you can't sync your mobile device to your mailbox, you may be asked by Microsoft 365 Support to collect logs for troubleshooting.

## Procedure

To capture ActiveSync device log information, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Run the [Set-CASMailbox](/powershell/module/exchange/set-casmailbox) cmdlet to enable ActiveSync logging for a specific user:

    > [!NOTE]
    > Exchange ActiveSync debug logging is enabled for 48 hours in Exchange Online, and 72 hours in Exchange Server. After the time period expires, the value reverts to `$false`.

    ```powershell
    Set-CASMailbox tony@contoso.com -ActiveSyncDebugLogging $true
    ```

    > [!NOTE]
    > This example enables Exchange ActiveSync debug logging for the user tony@contoso.com.

1. Reproduce the behavior that you want to capture.
1. Run the [Get-MobileDeviceStatistics](/powershell/module/exchange/get-mobiledevicestatistics) cmdlet to retrieve the log:

    ```powershell
    Get-MobileDeviceStatistics -Mailbox TonySmith -GetMailboxLog -NotificationEmailAddresses "admin@contoso.com"
    ```

    > [!NOTE]
    > This example retrieves the statistics for the mobile phone configured to synchronize with the mailbox that belongs to the user Tony Smith. It also outputs the log file and sends it to the System Administrator at admin@contoso.com.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
