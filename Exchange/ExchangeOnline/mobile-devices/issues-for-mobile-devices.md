---
title: Collect ActiveSync device logs to troubleshoot sync issues for mobile devices
description: Describes how to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 07/12/2024
ms.reviewer: v-six
---
# How to collect ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online

## Introduction

This article describes how to collect Exchange ActiveSync device logs to troubleshoot sync issues between mobile devices and Exchange Online in Microsoft 365. If you can't sync your mobile device to your mailbox, you might be asked by Microsoft 365 Support to collect logs for troubleshooting.

## Procedure

To capture ActiveSync device log information, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the following [Set-CASMailbox](/powershell/module/exchange/set-casmailbox) cmdlet to enable ActiveSync logging for a specific user:

    ```powershell
    Set-CASMailbox -Identity <user email address> -ActiveSyncDebugLogging $true
    ```

    > [!NOTE]
    > Exchange ActiveSync debug logging is enabled for 48 hours in Exchange Online, and 72 hours in Exchange Server. After the time period expires, the value reverts to `$false`.

    To verify that ActiveSync debug logging is enabled for a user, run the following PowerShell cmdlet:

    ```powershell
    Get-CasMailbox -Identity <user email address> -ActiveSyncDebugLogging | FL ActiveSyncDebugLogging
    ```

    > [!NOTE]
    > If you don't use the `-ActiveSyncDebugLogging` switch when you check whether ActiveSync debug logging is enabled, the returned `ActiveSyncDebugLogging` value will always be `False`. For more information, see [Get-CasMailbox](/powershell/module/exchange/get-casmailbox#-activesyncdebuglogging).

1. Reproduce the behavior that you want to capture.

1. Run the following [Get-MobileDeviceStatistics](/powershell/module/exchange/get-mobiledevicestatistics) cmdlet to retrieve the log:

    ```powershell
    Get-MobileDeviceStatistics -Mailbox TonySmith -GetMailboxLog -NotificationEmailAddresses "admin@contoso.com"
    ```

    > [!NOTE]
    > This example retrieves the statistics for the mobile phone configured to synchronize with the mailbox that belongs to the user Tony Smith. It also outputs the log file and sends it to the System Administrator at `admin@contoso.com`.
