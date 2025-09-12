---
title: How Message Format Affects Email Messages
description: Describes how message format and encoding, such as HTML, Rich Text, and TNEF, affect email messages.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Issues with product features
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 2633
ms.reviewer: gbratton, meerak, v-shorestris
appliesto:
  - Outlook for Windows
search.appverid: MET150
ms.date: 12/05/2024
---

# How message format affects email messages

<!-- Principal SPM Gabe Bratton requested that this article is retained even though PVs and engagement are low -->

Microsoft Outlook can send email messages in any of the following formats:

- **HTML**: By default, Outlook sends email messages in HTML format. This format is compatible with most email clients. The received message closely resembles the original message.

- **Plain Text**: Compatible with all email clients. However, any formatting, pictures, and links in the message are lost.

- **Rich Text**: Outlook uses Transport Neutral Encapsulation Format (TNEF) to package message information. Recipient messaging systems that aren't based on Microsoft Exchange might not be able to interpret messages that use this TNEF format. If the recipient's messaging system can't process this format, a file attachment that's named **Winmail.dat** is added to the message.

## TNEF details

A TNEF-encoded message contains a plain text version of the message, and a binary attachment that packages other parts of the original message. In most cases, the binary attachment is named **Winmail.dat**, and might include the following information:

- The formatted text version of the message (for example, font information and colors)
- OLE objects (for example, embedded pictures and embedded Microsoft Office documents)
- Special Outlook features (for example, custom forms, voting buttons, and meeting requests)
- Regular file attachments that were added to the original message

Additionally, the path of your personal folders (.pst) file and your sign-in name are embedded in the **Winmail.dat** file. Although this data isn't explicitly exposed to the recipient, if the recipient opens the **Winmail.dat** file in a binary or text editor, they can see the path and sign-in name. Password information isn't revealed. To make sure that the path of your .pst file and your sign-in name aren't sent, follow the recommendations in this article for how to send messages that don't include the **Winmail.dat** file.

Some Outlook features require internet email recipients that use Outlook to have TNEF encoding enabled. For example, if you send a message that has voting buttons to a recipient over the internet, the voting buttons aren't available if the recipient doesn't have TNEF enabled. TNEF isn't required for messages that have regular file attachments. If you're sending messages that have file attachments to a recipient who doesn't use Outlook or the Exchange client, we recommend that you manually choose an email format that doesn't require TNEF (such as HTML or plain text). If a message is sent without TNEF, the recipient can view and save attachments as expected.

### Send/receive issues

When an email client that doesn't support TNEF receives a message containing TNEF information, the following outcomes commonly occur:

- The plain text version of the message is received and the message has an attachment that's named **Winmail.dat**. The **Winmail.dat** attachment has no useful information when it's opened because it's in the TNEF format.

- The plain text version of the message is received and the message has an attachment that has a generic name such as **ATT00008.DAT** or **ATT00005.eml**. In this case, the client can't recognize either the TNEF part of the message or the **Winmail.dat** file name. Therefore, a file name is created to hold the TNEF information.

Similar to how the receiving client behaves, it's common for an email server to strip out TNEF information from messages as it delivers them. If a server option to remove TNEF is enabled, clients always receive a plain text version of the message. Exchange Server is an example of an email server that can remove TNEF from messages.

### Message encoding

The internet standards for message encoding, such as Multipart Internet Mail Extensions (MIME) and UUENCODE, are independent of TNEF. TNEF can exist in a MIME-encoded message as a MIME body part of type `application/ms-tnef`, or in a UUENCODED message as an attachment that's named **Winmail.dat**. To correctly display the encapsulated information, the receiving client must support TNEF encoding.

### Manage TNEF in messages

You can manage TNEF by using any of the following methods:

- **Global configuration in Outlook**: If you change the default message format to HTML or plain text, Outlook doesn't use TNEF for outgoing messages unless an Outlook feature needs it.

- **Global configuration in Windows registry**: The **DisableTNEF** registry entry makes sure that Outlook doesn't use TNEF for outgoing messages unless an Outlook feature needs it.

- **Per-message configuration in Outlook**: If you change the format of a message to plain text or HTML, Outlook doesn't use TNEF for that message unless an Outlook feature needs it.

> [!NOTE]
> Some Outlook features require TNEF. These include meeting requests and responses, voting buttons, task requests, rich text formatting, and embedded attachments.

#### Global configuration in Outlook

1. In Outlook, select **File** \> **Options** \> **Mail**.

2. Select **Compose messages in this format** to view the format options.

   - To disable TNEF, select **HTML** or **Plain Text**, and then select **OK**.
   - To enable TNEF, select **Rich Text**, and then select **OK**.

#### Global configuration in Windows registry

To disable TNEF, follow these steps:

1. Create a text file that's named **disable-tnef.reg**.

2. Copy and paste the following text into the file, and then save the file:

   > Windows Registry Editor Version 5.00
   > [HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Preferences]
   > "DisableTNEF"=dword:1

3. Double-click **disable-tnef.reg** to run it.

4. When you're prompted for approval, select **Yes**.

5. Restart Outlook.

To enable TNEF, follow these steps:

1. Locate the **DisableTNEF** entry under the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Preferences`

2. Delete the **DisableTNEF** entry or set its value to `0`.

3. Restart Outlook.

#### Per-message configuration in Outlook

1. In Outlook, open a new mail message, or reply to a received message.

2. On the **Format Text** tab, select **Message Format** to view the format options.

   - To disable TNEF, select **HTML** or **Plain Text**.
   - To enable TNEF, select **Rich Text**.

### Resolve TNEF issues

Use the relevant solution for each of the following issues:

- Problem: Recipient receives the **Winmail.dat** attachment.

   Solution: Disable TNEF (globally or per-message).

- Problem: Recipient receives the **ATT00001.DAT** attachment.

   Solution: Disable TNEF (globally or per-message).

- Problem: Recipient doesn't receive regular file attachments.

   Solution: Disable TNEF (globally or per-message).

- Problem: Recipient doesn't have voting buttons in Outlook.

   Solution: Enable TNEF (per-message).

- Problem: Recipient receives meeting requests as regular messages.

   Solution: Enable TNEF (per-message).

- Problem: Recipient doesn't receive custom form information.

   Solution: Enable TNEF (per-message).

- Problem: Recipient doesn't receive formatted message text.

   Solution: Enable TNEF (per-message).
