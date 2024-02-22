---
title: Spam Confidence Level (SCL) -1 not working
description: Discusses an issue in which Outlook unexpectedly marks messages as junk if the Exchange Server connection becomes disconnected. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: macien, wbrandt, tmoore
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook moves messages to the Junk Mail Folder even if the Spam Confidence Level (SCL) is -1

_Original KB number:_ &nbsp; 2885002

## Symptoms

Some email messages that you receive from internal senders are unexpectedly moved to the **Junk E-mail** folder in Microsoft Outlook. This problem occurs even if the messages are stamped as having a Spam Confidence Level (SCL) value of **-1** in Microsoft Exchange Server.

## Cause

This problem may occur if Outlook does not correctly determine whether a secure connection is used. This may occur when one or both of the following conditions are true:

- Encryption between Outlook and Exchange Server is disabled.
- You are not using Outlook Anywhere to connect to Microsoft Exchange.

Outlook cannot verify that the message was delivered through a secure connection. Therefore, Outlook ignores the SCL value of -1 and treats the message as if it had an SCL value of 0 (zero).

## Resolution

To resolve this issue, determine whether Outlook is configured to use Outlook Anywhere (RPC over HTTPS). For more information about Outlook Anywhere, see [Use Outlook Anywhere to connect to your Exchange server without a VPN](https://support.microsoft.com/office/use-outlook-anywhere-to-connect-to-your-exchange-server-without-vpn-ae01c0d6-8587-4055-9bc9-bbd5ca15e817).

Depending on whether you are using Outlook Anywhere, follow the steps in whichever section is applicable.

### If you are using Outlook Anywhere

If you are using Outlook Anywhere, install the appropriate Microsoft Outlook hotfix.

#### Outlook 2010

This issue is fixed in the Outlook 2010 hotfix package that is dated February 11, 2014. For more information, see [Description of the Outlook 2010 hotfix package (Outlook-x-none.msp): February 11, 2014](https://support.microsoft.com/help/2863918).

#### Outlook 2013

This issue is fixed in the Outlook 2013 hotfix package that is dated April 8, 2014. For more information, see [Description of the Outlook 2013 hotfix package (Outlook-x-none.msp): April 8, 2014](https://support.microsoft.com/help/2878323).

After you install the hotfix, Outlook considers Outlook Anywhere to be a secure connection for the purposes of processing junk email messages.

> [!NOTE]
> Outlook Anywhere is also known as RPC over HTTPS (Secure HTTP). As indicated by the term HTTPS, Outlook Anywhere connects to Exchange by using a Secure Sockets Layer (SSL) connection.

### If you are not using Outlook Anywhere

If you cannot install the latest version of Outlook 2010 or Outlook 2013 and you are not using Outlook Anywhere, you can work around this problem if your mailbox is located on Microsoft Exchange Server 2010, or an earlier version.

To work around this problem, try to enable RPC encryption between Outlook and Exchange. To do this, follow these steps:

1. In **Control Panel**, open the **Mail** item.
2. Select **Show Profiles**.
3. Select your profile, and then select **Properties**.
4. Select **E-mail Accounts**.
5. Select the **Microsoft Exchange Server** account, and then select **Change**.
6. In the dialog box that contains your mailbox server and user name, select **More Settings**.
7. In the **Microsoft Exchange Server** dialog box, select the **Security** tab.
8. Select the **Encrypt data between Microsoft Outlook and Microsoft Exchange** check box, and then select **OK**.

    :::image type="content" source="media/outlook-moves-messages-to-the-junk-mail-folder-unexpectedly/encrypt-data-between-microsoft-outlook-and-microsoft-exchange.png" alt-text="Screenshot of the Security tab of the Microsoft Exchange dialog box." border="false":::

    > [!IMPORTANT]
    > If the check box is unavailable (dimmed), you are most likely connected to Microsoft Exchange Server 2013, or you are using a mailbox in Microsoft 365. In this case, RPC encryption cannot be enabled. Be aware that Outlook Anywhere (RPC over HTTPS) connections are secure as they are encrypted by using Secure HTTP (HTTPS).

9. Select **Next**, and then select **Finish**.
10. Select **Close**, and then select **OK**.

## More information

For more information about how to configure junk email settings in Outlook, see the following Microsoft website, depending on the version of Outlook that you are using:

- Outlook 2013: [Use Junk Email Filters to control which messages you see](https://support.microsoft.com/office/use-junk-email-filters-to-control-which-messages-you-see-274ae301-5db2-4aad-be21-25413cede077)
- Outlook 2010: [Plan for limiting junk e-mail in Outlook 2010](/previous-versions/office/office-2010/cc178957(v=office.14))
- Outlook 2007: [Plan for limiting junk e-mail in Outlook 2007](/previous-versions/office/office-2007-resource-kit/cc178957(v=office.12))
