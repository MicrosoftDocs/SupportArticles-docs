---
title: Using a template file to send emails fails
description: Describes an issue where email messages aren't received when you use a template file in Outlook 2010. Provides workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: tasitae, paololin
ms.custom: 
  - sap:Exchange Mailbox Accounts\Organizational forms library
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2010
  - Exchange Online
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Standard Edition
ms.date: 01/30/2024
---
# Email messages aren't sent when you use a template file in Outlook 2010

_Original KB number:_ &nbsp; 3154038

## Symptoms

Consider the following scenario:

- You use Microsoft Outlook 2010 to connect to a mailbox in Exchange Server 2013 or a later version or to Exchange Online in Microsoft 365.
- Outlook 2010 is configured in online mode, and it uses a .pst file as the default delivery location.
- You send email messages by using an OFT (.oft) file.

In this scenario, email messages that you send by using the OFT (.oft) file are not always be received by the recipient. The message appears in your **Sent Items** folder even if the recipient doesn't receive it.

To work around this issue, use one of the following methods.

## Workaround 1: Don't use a .pst file as your default delivery location

Instead of using a .pst as your default delivery location, configure Outlook to use Cached Exchange Mode. By default, Cached Exchange mode uses an OST file as the default delivery location. To do this, follow these steps:

1. On the **File** tab in Outlook 2010, click **Account Settings**, and then click **Account Settings**.
2. On the **Data Files** tab, select the Exchange account for which the location is set to **Online**.
3. Click **Set as Default**.
4. On the **E-mail** tab, select your Exchange account, and then click **Change Folder**.
5. In the **Mail Delivery Location** window, click **Yes**.
6. Select your Exchange email address, and then click **OK**.
7. Click **Change**.
8. Select the **Use Cached Exchange Mode** check box.
9. Click **Next**, and then click **OK**.
10. Click **Finish**, click **Close**, exit and then restart Outlook.

After you follow these steps, your Exchange account will be your default delivery location. All the email data that was stored in the .pst file is still stored in the .pst file and not in your Exchange mailbox. If you want to move all the email data from the .pst file to your Exchange mailbox, follow these steps:

1. On the **File** tab in Outlook 2010, click **Account Settings**, and then click **Account Settings**.
1. On the **Data Files** tab, note the location of the Outlook Data File.
1. Select the Outlook Data File, and then click **Remove**. Click **Yes** to confirm.
1. Click **Close**.
1. On the **File** tab, click **Open**.
1. Click **Import**.
1. Select **Import from another program or file**, and then click **Next**.
1. Select **Outlook Data File (.pst)**, and then click **Next**.
1. Browse to the location that you noted in step 2, select the .pst file, and then click **Open**.
1. Select the option that you prefer, and then click **Next**.
1. Click **Finish**.

## Workaround 2: Use a later version of Outlook

Outlook 2016 and Outlook 2013 no longer set the default delivery location to a .pst file. Therefore, these versions of Outlook do not experience this issue.

## Workaround 3: Don't use OFT (.oft) files

Instead of using an OFT (.oft) file, copy the text to a new email message.

## Status

This is a known issue in Outlook 2010.

## More information

To determine whether your Outlook 2010 client is configured in the manner that's described in the "Symptoms" section, follow these steps:

1. On the **File** tab in Outlook 2010, click **Account Settings**, and then click **Account Settings**.
2. On the **E-mail** tab, select your Microsoft Exchange account, and then view the location that's listed under **Selected account delivers new messages to the following location**. If this location is a .pst file, you may experience the issue.

    :::image type="content" source="media/sending-email-by-template-fails/view-email-location.png" alt-text="Screenshot of the Account Settings dialog box in Outlook 2010. Select the Microsoft Exchange account under the E-mail tab, and find the location listed under Selected account delivers new messages to the following location is a .pst file." border="false":::

3. On the **Data Files** tab, view the location that's listed in the **Location** field for each file. If the location of your email address is set to **Online**, and the location of the Outlook data file is a .pst file, you may experience this issue.

    :::image type="content" source="media/sending-email-by-template-fails/view-data-files-location.png" alt-text="Screenshot of the Account Settings dialog box in Outlook 2010. On the Data Files tab, the location of the email address is set to Online, and the location of the Outlook data file is a .pst file." border="false":::
