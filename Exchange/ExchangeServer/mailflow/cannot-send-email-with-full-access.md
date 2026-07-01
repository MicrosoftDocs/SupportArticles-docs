---
title: Can't send email message when Full Access is granted to a shared mailbox
description: Fixes an issue that prevents email from being sent in an Exchange Server or Exchange Online environment. Occurs when you have Full Access permissions to a shared mailbox.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Mail Flow Issues
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 12268
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.reviewer: v-six, v-kccross
ms.date: 06/29/2026
---

# Can't send an email message when Full Access permission is granted to a shared mailbox in Exchange Server

## Summary

Users can’t send email messages from a shared mailbox even if they have Full Access and Send on Behalf permissions. This issue occurs because Exchange requires Send As permission to send messages from the shared mailbox. Without this permission, Outlook returns access denied errors or non-delivery reports. Granting Send As permission resolves the issue.

## Symptoms

Consider the following scenario:

- You have Full Access and Send On Behalf Of permissions to a shared mailbox in an Exchange Server environment.
- You configure a Microsoft Outlook profile for the shared mailbox and enter your own credentials to access it.
- You send an email message from this Outlook profile.

If you are running Outlook in Cached mode, you receive a non-deliverable report (NDR) in your Inbox that contains the following details:

```asciidoc
    Subject: Undeliverable: Subject_Of_Message Your message did not reach some or all of the intended recipients.
   Subject: Subject_Of_Message
 Sent: Date_and_Time

The following recipient(s) cannot be reached:
 RecipientName on Date_and_Time This message could not be sent. Try sending the message again later, or contact your network administrator. Error is [0x80070005-00000000-00000000].
```
  
Or

```asciidoc
Subject: Undeliverable: Subject_of_Message Your message did not reach some or all of the intended recipients.

Subject: Subject_Of_Message
 Sent: Date_and_Time The following recipient(s) cannot be reached: RecipientName on Date_and_Time

This message could not be sent. Try sending the message again later, or contact your network administrator. You do not have the permission to send the message on behalf of the specified user. Error is [0x80070005-0x0004dc-0x000524].     
```

And if you are running Outlook in Online mode, you receive the following error message:

> You do not have the permission to send the message on behalf of the specified users.

:::image type="content" source="./media/cannot-send-email-with-full-access/outlook-error-message.png" alt-text="Screenshot shows the error message after running Outlook in Online mode." border="false":::

## Cause

In this configuration, Exchange Server requires Send As permissions to send the email message. If you don't have Send As permissions for the shared mailbox, Outlook can't send the message.

## Resolution

Grant Send As permission to the user for the shared mailbox. For information about how to do this in the Exchange admin center (EAC) or by using PowerShell, see [Manage permissions for recipients](/Exchange/recipients/mailbox-permissions?redirectedfrom=MSDN&view=exchserver-2019&preserve-view=true).
