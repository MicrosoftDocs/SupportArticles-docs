---
title: Email remains in Outbox if using DelegateSentItemsStyle
description: This article provides a resolution for the issue that the email message is still in Outbox when you use the DelegateSentItemsStyle registry value.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Email remains in the Outbox
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, aruiz
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Email remains in the Outbox when you use the DelegateSentItemsStyle registry value

_Original KB number:_ &nbsp; 2703723

## Symptoms

When you send an email message from a shared mailbox, the sent email message remains in your Outbox until you manually perform a Send/Receive operation.

## Cause

This problem occurs when all the following conditions are true:

- Your Outlook profile is configured in online mode (not cached Exchange mode).
- You have the `DelegateSentItemsStyle` registry value set to **1**.

## Resolution

You can resolve this issue by using one of the following methods. If these methods are not acceptable, see the Workaround section for additional options.

### Method 1 - Change the value of DelegateSentItemsStyle to 0 in the registry

If you set DelegateSentItemsStyle=0 in the registry, email messages that you send from a shared mailbox will be copied to *your* Sent Items folder and not the Sent Items folder of the shared mailbox.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

    Windows 8 and Windows 10: Press Windows Key+R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.

    Windows 7 or Windows Vista: Select **Start**, type *regedit* in the **Start Search** box, and then press Enter. If you are prompted for an administrator password or for confirmation, type the password, or select **Allow**.

    Windows XP: Select **Start**, select **Run**, type *regedit*, and then select **OK**.

3. Locate and then select the following registry key:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Outlook\Preferences`

    > [!NOTE]
    > In this key path, the placeholder <x.0> represents 16.0 for Outlook 2016, Outlook for Microsoft 365 and Outlook 2019, 15.0 for Outlook 2013, 14.0 for Outlook 2010, 12.0 for Outlook 2007, and 11.0 for Outlook 2003.

4. Select the `DelegateSentItemsStyle` value.
5. On the **Edit** menu, select **Modify**.
6. Type *0*, and then select **OK**.
7. Exit Registry Editor.
8. Start Outlook.

### Method 2 - Change your profile to cached mode

If you must have the functionality that is offered by the `DelegateSentItemsStyle` registry value (=1), your other option is to change your profile from online mode to cached mode.

Outlook 2010 and later versions

1. On the **File** tab, select **Account Settings**, and then select **Account Settings**.
2. On the **E-mail** tab, select your Exchange Server account, select **Change**, and then enable the **Use Cached Exchange Mode** option.
3. Select **Next**, and then select **Finish**.
4. Exit and restart Outlook.

Outlook 2007

1. On the **Tools** menu, select **Account Settings**.
2. On the **E-mail** tab, select the Exchange Server account, and then select **Change**.
3. Under Microsoft Exchange server, select to select the **Use Cached Exchange Mode** check box.
4. Select **OK**.
5. Exit and restart Outlook.

Outlook 2003

1. On the **Tools** menu, select **E-mail Accounts**.
2. In the E-mail Accounts dialog box, select **View or change existing e-mail accounts**, and then select **Next**.
3. Select the Exchange Server account, and then select **Change**.
4. In the E-Mail Accounts dialog box, select the **Use Cached Exchange Mode** check box, and then select **Next**.
5. Select **OK**, and then restart Outlook.

## Workaround

If the methods provided in the Resolution section are not acceptable, and if your mailbox is located on Microsoft Exchange Server 2010 Service Pack 2 Update Rollup 4 or later version, or Exchange Server 2013 Cumulative Update 9 or later version or Microsoft 365 Exchange Online, the Exchange administrator can configure similar behavior on the server. These configurations do not require the `DelegateSentItemsStyle` registry key to be enabled, therefore the issue will not occur.

### Microsoft Exchange Server 2010 Service Pack 2 Update Rollup 4 or later

Update Rollup 4 for Exchange Server 2010 Service Pack 2 introduced a new Exchange PowerShell cmdlet to configure the Sent Items folder to which a message is copied. Because this new feature is handled by the Exchange server, Outlook can be configured for online or cached Exchange mode. However, the Exchange server feature works only if the Outlook `DelegateSentItemsStyle` registry value is disabled.

For more information about the `Set-MailboxSentItemsConfiguration` cmdlet, see [Messages sent by using the "Send As" and "Send on behalf" permissions are only copied to the Sent Items folder of the sender in an Exchange Server 2010 environment](https://support.microsoft.com/help/2632409).

### Microsoft Exchange Server 2013 Cumulative Update 9 or later or Microsoft 365 Exchange Online

Cumulative Update 9 for Exchange Server 2013 introduced a new feature that allows administrators to configure the Sent Item folder to which a message is copied. Because this new feature is handled by the Exchange server, Outlook can be configured for online or cached Exchange mode. Note that if you enable this feature and enable the `DelegateSentItemsStyle` registry value with a cached Outlook profile at the same time, two copies of the sent item will be saved in the shared mailboxes Sent Items folder.

For more information about this feature, see [Want more control over Sent Items when using shared mailboxes?](https://techcommunity.microsoft.com/t5/exchange-team-blog/want-more-control-over-sent-items-when-using-shared-mailboxes/ba-p/611106).

## More information

The `DelegateSentItemsStyle` registry value is stored in the following location in the Windows registry:

`HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Outlook\Preferences`

> [!NOTE]
> In this registry path, <x.0> corresponds to your version of Outlook (Outlook 2003 = 11.0, Outlook 2007 = 12.0, Outlook 2010 = 14.0, Outlook 2013 = 15.0, Outlook 2016, Outlook for Microsoft 365 and Outlook 2019 = 16.0).

The functionality that is provided by the `DelegateSentItemsStyle` registry value is described in [When you send an e-mail message from a shared mailbox in Outlook 2007, the sent message is not saved in the Sent Items folder of the shared mailbox](https://support.microsoft.com/help/972148).
