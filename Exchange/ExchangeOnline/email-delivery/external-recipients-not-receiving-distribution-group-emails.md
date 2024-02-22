---
title: External recipients don't get distribution group email
description: Describes a scenario in which external recipients of email messages that are sent to a distribution group in Exchange Online don't receive the messages. Additionally, senders don't receive a nondelivery report (NDR). Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: takchow, timothyh, jhayes, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# External recipients don't receive email messages that are sent to a distribution group in Exchange Online and senders don't receive nondelivery reports

_Original KB number:_ &nbsp; 2723654

## Symptoms

In Exchange Online in Microsoft 365, when users send email messages to a distribution group that contains external recipients, the external recipients don't receive the messages and senders don't receive NDRs.

This issue occurs only when the messages are sent to the distribution group. When users send messages to the external recipients individually, the external recipients receive the messages.

## Cause

By default, the `ReportToManagerEnabled` parameter is set to **False** and the `ReportToOriginatorEnabled` parameter is set to **True** when a distribution group is created in Exchange Online. When the parameters are both set to **False**, the **Return-Path** field in the header of the message is <> (blank). This means that the remote messaging system will not send delivery reports to the user who sent the message to the distribution group.

Additionally, if spam filtering is enabled on the remote messaging system, the message is dropped, and delivery reports are suppressed. This occurs because some anti-spam devices might flag messages whose **Return-Path** field is blank and not let the messages be delivered.

## Resolution

To enable external recipients to receive NDRs, take one of the following actions, as appropriate for your situation.

### If the user isn't sending the message as the distribution group

If the user isn't sending the message as the distribution group (that is, if the email address of the sender and of distribution group are not the same), set the `ReportToOriginatorEnabled` parameter to **True**. When you do this, delivery reports are sent to the sender.

To set the `ReportToOriginatorEnabled` parameter to **True**, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Type the following cmdlet, and then press Enter:

    ```powershell
    Set-DistributionGroup "<DistributionGroupName>" -ReportToOriginatorEnabled $true
    ```

### If the user is sending the message as the distribution group

If the user is sending the message as the distribution group (that is, if the email address of the sender and of the distribution group are the same), set the `ReportToManagerEnabled` to **True**. When you do this, delivery reports are sent to the user who is specified in the `ManagedBy` attribute of the distribution group. By default, this is the user who created the group.

To set the `ReportToManagerEnabled` parameter to **True**, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Type the following cmdlet, and then press Enter:

    ```powershell
    Set-DistributionGroup "<DistributionGroupName>" -ReportToManagerEnabled $true
    ```

> [!NOTE]
> Users who have Send As permissions to the distribution group should be added to the `ManagedBy` attribute of the distribution group. To do this, add the user as an Owner.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
