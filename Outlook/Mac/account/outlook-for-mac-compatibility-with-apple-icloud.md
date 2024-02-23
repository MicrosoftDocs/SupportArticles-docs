---
title: Outlook for Mac compatibility with Apple iCloud
description: Provides information on how to configure an iCloud Mail account with Outlook for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: danv
appliesto: 
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 10/30/2023
---
# Microsoft Outlook for Mac compatibility with Apple iCloud

_Original KB number:_ &nbsp; 2648915

## Summary

This article contains information about the compatibility of Microsoft Outlook for Mac and Apple iCloud.

Outlook for Mac does not support Apple iCloud calendar (CalDAV) and contact (CardDAV) synchronization.

Outlook for Mac does support iCloud Mail. For steps on how to configure your iCloud email account in Outlook for Mac, go to the More Information section of this article.

## More information

To configure your Apple iCloud email account in Microsoft Outlook for Mac, follow these steps:

1. Start Outlook for Mac.
2. On the **Tools** menu, select **Accounts**.
3. Select the plus (+) sign in the lower-left corner, and then select **Other E-mail**.
4. Enter your **E-mail Address** and **Password**, and then select **Add Account**.

    > [!NOTE]
    > The new account will appear in the left navigation pane of the **Accounts** dialog box. The Server Information may be automatically entered. If not, follow the remaining steps to enter this information manually.

5. Enter one of the following in the **Incoming server** box:
   - `imap.mail.me.com` (for `me.com` email addresses)
   - `mail.mac.com` (for `mac.com` email addresses)
   - `imap.mail.me.com` (for `icloud.com` email addresses)

6. Select **Use SSL to connect (recommended)** under the **Incoming server** box.

7. Enter one of the following in the **Outgoing server** box:
   - `smtp.mail.me.com` (for `me.com` email addresses)
   - `smtp.mac.com` (for `mac.com` email addresses)
   - `smtp.mail.me.com` (for `icloud.com` email addresses)

8. Select **Use SSL to connect (recommended)** under the **Outgoing server** box.

9. Select **Override default port** under the **Outgoing server** box, and then enter *587* in the **Outgoing server** port text box.

   :::image type="content" source="media/outlook-for-mac-compatibility-with-apple-icloud/configure-email.png" alt-text="Screenshot shows steps to configure the Apple iCloud email account in Microsoft Outlook for Mac." border="false":::

After you have entered the incoming and outgoing server information, Outlook for Mac will start to receive your email messages.

> [!NOTE]
> You can select **Advanced** to enter additional settings, such as leaving a copy of each message on the server.
