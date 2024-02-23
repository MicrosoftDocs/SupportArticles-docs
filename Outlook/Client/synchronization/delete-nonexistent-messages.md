---
title: How to delete nonexistent messages from Microsoft Outlook
description: Outlook keeps trying to send a nonexistent message while Outbox folder shows zero messages.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 112768
  - CSSTroubleshoot
ms.reviewer: gbratton
appliesto: 
  - Outlook for Microsoft 365
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Outlook keeps trying to send a nonexistent message while Outbox folder shows zero messages

## Symptoms

You experience one or more of the following problems when you use Outlook:

- Outlook continuously displays a message such as "Sending message 4 of 6" in the Progress bar even though there are no email messages queued. Additionally, Outlook stops responding when you try to close it. For example, you see the following message in the Progress bar:

    :::image type="content" source="./media/delete-nonexistent-messages/outbox-error.png" alt-text="Screenshot of the Outlook status bar, which displays a message: Sending message 4 of 6." border="false":::

    You may also receive an error message that resembles the following:

    *Task 'user@example.com - Sending' reported error (0x8004210b) : 'The operation timed out waiting for a response from the sending (SMTP) server.  If you continue to receive this message, contact your server administrator or Internet service provider (ISP).  The server responded:  550 5.1.0 <> sender rejected.  AUP#O-1580'*

    :::image type="content" source="./media/delete-nonexistent-messages/outlook-sending-error.png" alt-text="Screenshot of the Outlook Send/Receive Progress dialog box, which displays a sending error." border="false":::

- You are continually prompted to log in to internet email.
- Outlook displays a number next to the **Outbox** folder (for example: **Outbox [4]**) even though there are no messages in the **Outbox**.

## Cause

These problems are caused by a read receipt that is stuck in progress and that Outlook keeps trying to resend.

## Workaround

Use the MFCMAPI tool to delete the stuck messages. To do this, follow these steps:

> [!IMPORTANT]
> Make sure that Outlook is closed during this procedure.

> [!NOTE]
> If you have the 64-bit version of Outlook installed, you must install the 64-bit build of the MFCMAPI tool.

1. [Download and install the MFCMAPI tool](https://aka.ms/mfcmapi_download).
2. Open the MFCMAPI tool, and then select **OK**.
3. Select the **Session** tab, and then select the **Logon** option.
4. In the window that opens, select the Outlook profile, and then select the **OK** button.
5. Double-click the account that's experiencing the problems (it shows a small cylindrical icon next to the name).
6. Right-click **Root Mailbox**, and select the **Open contents table** option.
7. In the next window, examine the columns, such as **From**, **To**, and **Subject**. Under **Subject**, if you see something called **Read**, or if you see a message that has "Read" as the subject, select that item, and then select **Actions** > **Submit** > **Abort submit**.
8. Right-click the **Delete message** option, select **Permanent delete passing DELETE_HARD_DELETE (unrecoverable)** option, and then select **OK**.
9. If you cannot right-click the **Delete message** option, delete the message that contains the read receipt subject.
10. Repeat steps 6–9 for each read receipt that you have to delete.
11. Restart Outlook, and check its behavior.
