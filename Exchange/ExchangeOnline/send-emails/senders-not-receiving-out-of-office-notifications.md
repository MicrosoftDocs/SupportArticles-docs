---
title: No out of office replies received from a mailbox that has automatic replies enabled
description: Describes the scenarios in which a sender doesn't receive an out of office reply from the recipient, and provides a resolution to fix the issue.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Online\Mail Flow
  - sap:Exchange Server SE\Mailflow
  - CI 11886
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: arindamt
appliesto: 
  - Exchange Online
  - Exchange Server SE
search.appverid: MET150
ms.date: 06/22/2026
---
# No out of office replies received from a mailbox that has automatic replies enabled

## Summary

This article describes the situations when out-of-office replies aren't sent to a user who sends an email message to a recipient who has out-of-office replies configured. The article also provides resolutions to fix the issue.

## Symptoms

When a user in your organization sends an email to a recipient whose mailbox has out-of-office automatic replies enabled, they don't receive an out-of-office reply. However, the user's mail client still displays the **Automatic reply** mailtip for the recipient.

## Cause

This issue might occur in one of the following scenarios:

- [Email forwarding](/exchange/recipients-in-exchange-online/manage-user-mailboxes/configure-email-forwarding) is configured in the recipient's mailbox but the **Deliver message to both forwarding address and mailbox** option isn't selected.
- An Exchange transport rule is configured to redirect email messages that are sent to the recipient's mailbox.

In these scenarios, the user's email message isn't delivered to the recipient's mailbox and no automatic reply is triggered. This behavior is by design.

## Resolution

Determine the cause of the issue and then use the appropriate resolution to fix it.

### Email forwarding

To check whether email forwarding is set up in the recipient's mailbox and disable it if it's configured, use the following steps:

1. If the recipient's mailbox is hosted on Exchange Online, navigate to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).<br/>
   If the recipient's mailbox is hosted on Exchange Server SE, navigate to [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following command:
  
    ```powershell
    Get-mailbox -identity <UserID> | FL *forwarding*
    ```

    If email forwarding is enabled on the mailbox, you see a value displayed in the command's output for either the **ForwardingAddress** parameter or the **ForwardingSmtpAddress** parameter.
3. If email forwarding is enabled, disable it by running the following command:

    ```powershell
    Set-Mailbox -Identity <UserID> -ForwardingAddress $null -ForwardingSMTPAddress $null
    ```

    If email forwarding is a requirement for your organization and can't be disabled, then set the **DeliverToMailboxAndForward** parameter to **True**. This setting ensures that the user's email message is delivered to the recipient's mailbox and the configured out-of-office reply is generated.

    Run the following command:

    ```powershell
    Set-Mailbox -Identity <UserID> -DeliverToMailboxAndForward $true
    ```

### Exchange transport rule

To check for and remove an Exchange transport rule from a mailbox, use the following steps:

1. If the recipient's mailbox is hosted on Exchange Online, navigate to [Exchange admin center in Exchange Online](https://admin.exchange.microsoft.com/) > **Mail flow** > **Rules**.<br/>
   If the recipient's mailbox is hosted on Exchange Server SE, navigate to [Exchange admin center in Exchange Server](/exchange/architecture/client-access/exchange-admin-center#accessing-the-eac) > **Mail flow** > **Rules**.
2. From the list of transport rules that are displayed, either disable or delete all forwarding rules that are created for the recipient's mailbox.

> [!NOTE]
> To enable automatic replies in a mailbox that has email forwarding configured, set up [Inbox rules](https://support.microsoft.com/office/use-rules-to-automatically-forward-messages-45aa9664-4911-4f96-9663-ece42816d746) for the mailbox. This option is better than setting up either a transport rule or SMTP forwarding for the mailbox.
