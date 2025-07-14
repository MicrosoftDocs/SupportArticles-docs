---
title: Messages in an E-mail Thread Are Automatically Moved to the Deleted Items Folder
description: This article describes an issue in which messages are automatically moved to the Deleted Items folder when you use the Ignore feature in Microsoft Outlook 2010 or later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
search.appverid: 
  - MET150
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Exchange Server 2010 Enterprise
  - Outlook for Microsoft 365
ms.date: 07/14/2025
---
# Messages in an e-mail thread are automatically moved to the Deleted Items folder

_Original KB number:_ &nbsp; 2697913

## Symptoms

When you use the **Ignore** feature in Microsoft Outlook 2010 or later versions, messages are automatically moved to the **Deleted Items** folder.

When this problem occurs, a message trace indicates a **DefaultFolderType:DeletedItems-Conversations Processing Agent** event. Email messages that trigger this event are delivered directly to the **Deleted Items** folder.

## Cause

This problem occurs if you select Ignore on an e-mail message, and then another message from that same thread is delivered into your mailbox.

When you select **Ignore** on an e-mail message, Outlook deletes that e-mail message and also keeps track of all future e-mail messages that are related to the ignored message. If a future message that is related to the originally ignored message arrives in your Inbox, Outlook automatically moves that future message to your Deleted Items folder.

> [!NOTE]
> This feature isn't available or functional in the following configuration:
>
> - Online mode profile in Outlook
> - Microsoft Exchange Server 2007 or Microsoft Exchange Server 2003 mailboxes

## Resolution

To resolve this problem, remove the **Ignore** status of the e-mail thread. To do this, follow these steps:

1. Select the **Deleted Items** folder.

1. Select the message that is currently set to be ignored by Outlook.

1. On the **Home** tab on the ribbon, select **Ignore** in the **Delete** section.

    > [!NOTE]
    > You can determine whether a message is being ignored by the status of the **Ignore** control on the ribbon. If the **Ignore** control is highlighted, the conversation thread on that message is currently being ignored by Outlook.

1. If you're prompted, select **Stop Ignoring Conversation**.

At this point, the message is automatically moved from your Deleted Items folder to the folder from which the message originated. Future messages for this thread won't be automatically deleted.

When you enable the **Ignore** option on a conversation, a message is created in the Associated Contents table of the Conversation Action Settings folder of your mailbox (The screenshot for the **Conversation Action Settings** folder is listed in the following screenshot.)

:::image type="content" source="media/message-automatically-moved-deleted-items-folder/conversation-action-settings.png" alt-text="Screenshot that shows the Conversation Action Settings folder.":::

The associated messages in the **Conversation Action Settings** folder use the following rules:

- If there's no activity on a thread for 14 days, the conversation action message for the thread is automatically deleted.

- The age of the conversation action message is determined by the oldest message for the conversation.

- You can modify the number of days at which the conversation action messages expire by using the following registry data.

    **Subkey**: **HKEY_CURRENT_USER\Software\Microsoft\Office\\<x.0>\Outlook\Options\Conversations**
    **DWORD**: **OnGoingActionsExpiration**
    **Value**: Integer specifying the number of days after which an inactive conversation has its conversation action message deleted

    > [!NOTE]
    > The \<x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 365, and Office 2019, 15.0 = Office 2013, 14.0 = Office 2010).

- You can start Outlook by using the following command line to delete all conversation action messages in the Associated Contents table of the Conversation Actions folder.

    `Outlook.exe /CleanConvOnGoingActions`

    > [!NOTE]
    > Conversations whose conversation action messages get deleted by the `/CleanConvOnGoingActions` switch don't reappear in the Inbox. The conversation remains in the Deleted Items folder. However, because the hidden conversation action message no longer exists for the conversation, any new messages for the conversation remain in the Inbox.

You can also get different behavior from this feature, depending on the version of Exchange Server that you're using:

- In Exchange Server 2007 and a cached mode profile, "Ignore" is based on SUBJECT. For example, any message that has "Help" as the subject will automatically be sent to Deleted Items as long as you clicked **Ignore** for a previous message that had "Help!" as the subject.

- In Exchange Server 2010 and later versions, "Ignore" is based on the CONVERSATION ID, and only the messages that are related to the same ignored conversation are automatically sent to the Deleted Items folder.

When you **Ignore** a conversation, you receive the following prompt to confirm the action.

:::image type="content" source="media/message-automatically-moved-deleted-items-folder/ignore-conversation.png" alt-text="Screenshot that shows the Ignore Conversation dialog box.":::

In this dialog box, there's also a **Don't show this message again** option. If you enable this option, you won't be prompted to confirm the **Ignore Conversation** action the next time you select to ignore a message. If this option is enabled, the following data is written into the registry.

**Key**: **HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Options\General**
**String**: P**ONT_STRING**
**Value**: **63**

> [!NOTE]
> The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 365, and Office 2019, 15.0 = Office 2013, 14.0 = Office 2010).
>
> The Pont_String value may include numbers other than 63.
