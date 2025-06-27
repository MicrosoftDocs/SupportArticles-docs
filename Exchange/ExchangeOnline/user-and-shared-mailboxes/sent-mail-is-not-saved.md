---
title: Messages sent from a shared mailbox aren't saved to the Sent Items folder
description: Provides a workaround for an issue in which email messages that you send on behalf of another user from a shared mailbox in Outlook aren't saved to the Sent Items folder of the shared mailbox.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 05/15/2025
ms.reviewer: gbratton; ninob
---
# Messages sent from a shared mailbox aren't saved to the Sent Items folder

## Symptoms

Assume that you're using Microsoft Outlook 2016 or a later version, and you've been delegated permission to send email messages as another user or on behalf of another user from a shared mailbox. However, when you send a message as another user or on behalf of the user, the sent message isn't saved to the Sent Items folder of the shared mailbox. Instead, it's saved to the Sent Items folder of your mailbox.

## Cause

In Microsoft 365, shared mailboxes don't require a license and can't be added to Outlook as independent mailboxes. You can't sign in to a shared mailbox. Instead, you sign in to your own mailbox, and then you open the shared mailbox. When you send or reply to a new message from the shared mailbox, Outlook automatically sends or replies from the sender's account. Therefore, messages are stored in the Sent Items folder of the sender's mailbox.

## Workaround

To work around this issue, use one of the following methods.

**Note**: If you're using new Outlook, only Method 1 will apply.

**Method 1**

Configure the mailbox to [save a copy of the message to the Sent Items folder of the shared mailbox](https://techcommunity.microsoft.com/t5/exchange-team-blog/want-more-control-over-sent-items-when-using-shared-mailboxes/ba-p/611106) in Exchange Online or in on-premises Exchange Server.

For emails sent as the shared mailbox, run the following command in [Exchange PowerShell](/powershell/exchange/):

```powershell
set-mailbox <mailbox name> -MessageCopyForSentAsEnabled $True
```

For emails sent on behalf of the shared mailbox, run the following command in Exchange PowerShell:

```powershell
set-mailbox <mailbox name> -MessageCopyForSendOnBehalfEnabled $True
```

**Method 2**

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

Set the DelegateSentItemsStyle registry value on the Outlook client.

> [!NOTE]
> For this option to work correctly, Outlook must be configured to run in Cached Exchange mode. For more information, see [Email remains in the Outbox when you use the DelegateSentItemsStyle registry value](https://support.microsoft.com/help/2703723).

Use the following steps:

1. Start the registry Editor.
2. Locate and then click the following registry subkey:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Preferences`

3. On the **Edit** menu, point to **New**, and then click **DWORD 32-bit Value**.
4. Type *DelegateSentItemsStyle*, and then press Enter.
5. Right-click **DelegateSentItemsStyle**, and then click **Modify**.
6. In the **Value data** box, type 1, and then click **OK**.
7. Exit Registry Editor.

## More information

The following table lists the expected behavior based on different combinations of the `DelegateSentItemsStyle` registry value setting and the mailbox's `MessageCopyForSentAsEnabled` parameter value.

|DelegateSentItemsStyle|MessageCopyForSentAsEnabled|Expected behavior|
| -------- | ------- | ------- |
|0|True|A copy of the email will be saved in both the primary mailbox and the shared mailbox.|
|1|True|Two copies of the email will be saved in the shared mailbox and no copies in the primary mailbox.|
|0|False|A copy of the email will be saved in the primary mailbox and no copies in the shared mailbox.|
|1|False|A copy of the email will be saved in the shared mailbox and no copies in the primary mailbox.|

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet forums](/answers/topics/office-exchange-server-itpro.html).
