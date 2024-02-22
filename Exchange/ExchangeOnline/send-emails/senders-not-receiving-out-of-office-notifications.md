---
title: Senders do not receive Out of Office notifications
description: Describes that senders don't receive Out of Office replies from a Microsoft 365 user although an Out of Office MailTip is displayed in the mail clients of the senders. Provides a solution and a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Senders don't receive Out of Office notifications from a Microsoft 365 user when Forwarding is enabled

_Original KB number:_ &nbsp; 2866165

## Symptoms

People who send an email message to a Microsoft 365 user who set up an Out of Office notification don't receive the notification. However, an Out of Office MailTip for the user is displayed in the mail clients of the senders.

## Cause

This issue may occur if one of the following conditions is true:

- An external forwarding rule, or an automatic reply notification is set up in the user's mailbox.
- A global Exchange transport rule is created for this mailbox.By design, a mailbox cannot have forwarding rules and an Out of Office notification active at the same time.

## Resolution - Step 1: Identify and remove the forwarding rule

To identify and remove a forwarding rule from an Exchange Online mailbox, follow these steps:

1. [Connect to Exchange Online by using Windows Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:
  
    ```powershell
    Get-mailbox -identity <UserID> | FL *forwarding*,*deliver*
    ```

    If forwarding is enabled on the mailbox, the command output resembles the following example:

    ```console
    ForwardingAddress:
    ForwardingSmtpAddress: abc@contoso.com
    DeliverToMailboxAndForward: True
    ```

3. If forwarding is enabled, disable it by running the following command:

    ```powershell
    Set-Mailbox -Identity <UserID> -DeliverToMailboxAndForward $false -ForwardingSMTPAddress $null
    ```

## Resolution - Step 2: Identify and remove Exchange transport rules

To identify and remove Exchange transport rules from an Exchange Online mailbox, follow these steps:

1. [Connect to Exchange Online by using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:

    ```powershell
    Get-TransportRule | FL Name,Description
    ```

3. If Exchange transport rules are enabled, follow these steps:

   1. Sign in to the [Microsoft 365 portal](https://portal.office.com/) as an administrator.
   2. To open the Exchange admin center, select **Admin**, and then select **Exchange**.
   3. In the navigation pane, select **mail flow**, clear the rules that you want to delete, and then press **Delete**.

## Workaround

To set up email forwarding rules and an Out of Office notification at the same time, you have to set up Inbox rules for the mailbox instead of setting up a transport rule. To do so, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://portal.office.com/) as an administrator.
2. To open the Exchange admin center, select **Admin**, and then select **Exchange**.
3. In the upper-right corner, select your name, and then select **Open Another user**.
4. Select **Organize Mail**, and then select **Inbox Rules**.
5. Select **New** (:::image type="icon" source="media/senders-not-receiving-out-of-office-notifications/plus-sign-icon.png" border="false":::), and then select **Create a new rule for arriving messages**.
6. In the **Name** box, specify a name for the rule, and then select **More options**.
7. Under **When the Message Arrives**, select **Apply to all messages**.
8. Under **Do the Following**, point to **Move, copy or delete**, and then select **Copy the Message to the Folder**.
9. Select the **Select Folder** option, and then select **Inbox**.
10. Select **Add Conditions**.
11. Under **Forward the Messages to**, select **User whom you have to forward**.
12. Select **Save**.

> [!NOTE]
> If you want to forward the message to a user outside your organization, you must add that user as an external contact.

## More information

- For more information about mail contacts, see [Manage mail contacts](/exchange/recipients-in-exchange-online/manage-mail-contacts).
- For more information about how to use the Out of Office functionality in Exchange Online, see [Send automatic replies when you're out of the office](https://support.microsoft.com/office/video-set-up-automatic-replies-and-inbox-rules-b7b63910-c402-48a3-a313-50d5bd5f80c3?ocmsassetid=rz104151618&correlationid=9fbda6e8-5494-47e0-ad15-101de4e16180).
- For more information about how to create rules to forward mail, see [Use rules to automatically forward messages](https://support.microsoft.com/office/use-rules-to-automatically-forward-messages-45aa9664-4911-4f96-9663-ece42816d746?ocmsassetid=ha102908356&correlationid=9cb7ef03-bddf-4c05-8688-2cc4e6f4945a).
- For more information about how to set up automatic replies, see [Automatic replies (formerly Out of Office assistant)](https://support.microsoft.com/office/automatic-replies-formerly-out-of-office-assistant-48d40166-0129-4653-98f1-eb85f9bd8c20?ocmsassetid=ha102844491&correlationid=bda1a681-d7f6-4368-b572-4ce5bb7dc316).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
