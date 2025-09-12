---
title: How to specify the email message format that's used for external recipients to prevent Winmail.dat attachments
description: Describes how Microsoft 365 admins can change the message format so that messages that are sent from Microsoft 365 users to external recipients don't contain the Winmail.dat attachment.
manager: dcscontentpm
audience: ITPro
ms.topic: how-to
ms.custom: 
  - sap:Mail Flow
  - CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
ms.reviewer: jhayes, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# How to specify the email message format that's used for external recipients to prevent Winmail.dat attachments

## Introduction

This article describes how Microsoft 365 admins can change the message format so that messages that are sent from Microsoft 365 users to external recipients don't contain Winmail.dat attachments.

By default, email messages that are sent from Exchange Online in Microsoft 365 use the Transport Neutral Encapsulation Format (TNEF) format. Messaging systems that aren't based on Microsoft Exchange may be unable to interpret messages that use this rich text format. If the recipient's messaging system can't process this format, a file attachment that's called Winmail.dat is added to the message.

Microsoft 365 admins can use Windows PowerShell to change the message format to prevent the Winmail.dat attachment from being sent to external recipients.

## Procedure

To change the message format to prevent Winmail.dat attachments, use one of the following methods.

### Scenario 1: Change the message format for external contacts

To change the message format for an external contact that was added to Exchange Online, follow these steps:

1. [Connect to Exchange Online by using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the following Windows PowerShell commands to configure the message format as Text Only:

    ```powershell
    Set-MailContact <ExternalEmailAddress or GUID> -UseMapiRichTextFormat Never
    
    Set-MailContact -Identity <ExternalEmailAddress or GUID> -UsePreferMessageFormat $True
    ```

1. Run the following Windows PowerShell command to confirm that the message format was applied:

    ```powershell
    Get-MailContact | Select <ExternalEmailAddress or GUID> | Select UseMapiRichTextFormat
    ```

### Scenario 2: Change the message format for all messages that are sent to a specific domain

This method requires you to create a remote domain object in Exchange Online to control how messages are sent to external domains. You can also use this method to change the message format for messages that are sent to coexistence domains.

1. [Connect to Exchange Online by using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the following Windows PowerShell command to create a remote domain for an external domain:

    ```powershell
    New-RemoteDomain -Name <Name of External Domain> -DomainName domain.com

    ```

1. Run the following Windows PowerShell command to prevent messages from being sent in rich text format:

    ```powershell
    Set-RemoteDomain -Identity <Name of Domain> -TNEFEnabled $false

    ```

1. Run the following WindowsPowerShell command to check that the setting was applied:

    ```powershell
    Get-RemoteDomain -Identity <Name of Domain>| Select TNEFEnabled
    ```

## More information

For more information about specific Windows PowerShell cmdlets, go to the following Microsoft websites:

- [Set-MailContact](/powershell/module/exchange/set-mailcontact)
- [Get-MailContact](/powershell/module/exchange/get-mailcontact)
- [New-RemoteDomain](/powershell/module/exchange/new-remotedomain)
- [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
