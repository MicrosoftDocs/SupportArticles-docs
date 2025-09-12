---
title: How to disable public folder Conflict Message notification
description: Explains how to disable public folder Conflict Message notification in Exchange Server.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - Exchange Server
  - CSSTroubleshoot
  - CI 163890
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
ms.reviewer: bilong, v-six
ms.date: 01/24/2024
---
# How to disable public folder Conflict Message notification

_Original KB number:_ &nbsp; 980047

## Summary

This article describes how to disable public folder Conflict Message notification in Microsoft Exchange Server 2010.

## Introduction

Two users edit the same message in a public folder. Then, they save their copies of the message. In this scenario, the saved messages are in conflict. Conflicts can occur when a concurrent save operation is made on the same public folder server or if the message is edited on two servers that contain replicas of the same public folder. This article discusses the situation in which the conflict occurs during a replication between two servers.

When a conflict occurs, the owners of the public folder receive an e-mail message from the server that's running Exchange Server. The message notifies them about the conflict. The  owners can then open the message for which the conflict occurred, and decide which changes they want to keep. If the owners keep all changes, two messages are generated in the public folder.

The method that the Exchange server uses to resolve these conflicts is determined by the value of the **PR_RESOLVE_METHOD** property in the folder. This property is identified by the **0x3FE70003** MAPI property tag. The following are possible values for this property:

- **0**: RESOLVE_METHOD_DEFAULT

  Default handling of message conflicts.

- **1**: RESOLVE_METHOD_LAST_WRITER_WINS

  Last writer will win the conflict.

- **2**: RESOLVE_METHOD_NO_CONFLICT_NOTIFICATION

  Same steps as the **RESOLVE_METHOD_DEFAULT**, except that the contacts that are defined on a folder and the modifiers of a message are not notified.

By default, the value is set to **0**. If you do not want a notification message to be sent during a conflict, change the value to **2**.

You can change this value programmatically, or you can use one of the tools that are described in this article. For more information, contact the Microsoft Developer Network (MSDN), or use a tool to change individual folder property values. For example, use the [ExFolders](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-meet-exfolders/ba-p/596799) tool to change folder property values.

> [!NOTE]
> Changing the value of the **PR_RESOLVE_METHOD** property does not resolve existing conflicts.

### How to use ExFolders to change the value of PR_RESOLVE_METHOD

The ExFolders tool must be installed on the server that is running Exchange Server 2010, and put into the bin folder.

> [!NOTE]
> The account that is used for authentication in the ExFolders tool must have rights to change public folder attributes. We recommend that you run the ExFolders tool from a workstation.

To do this, follow these steps:

1. Start the ExFolders tool.
2. On the **File** menu, select **Connect**.
3. Enter the names of the Exchange server and the global catalog.
4. Select the **Authenticate as currently logged-on user** check box, or manually enter another account that you can use for authentication.
5. On the **Connection** tab, select **Public Folders**, and then select **OK**.
6. Expand the **Public Folders** item, locate the public folder that contains the conflict, and then right-click the folder to disable Conflict Message notification.
7. Right-click the folder again, and then select **Property Editor**.
8. In the **Property** text box, type **PR_RESOLVE_METHOD: 0X3FE70003**.
9. Select Set, and then type the desired value. Legitimate values are **0**, **1**, and **2**.

    > [!NOTE]
    > See more information about these values earlier in this article.

10. If you want to make this change to all subfolders of the selected folder, select the **Perform this action on all subfolders of the selected folder** check box.
11. Select **Execute**. You should receive confirmation that the change is successful.
12. Repeat steps 1 to 11 for other folders that have conflicts.

> [!IMPORTANT]
> If a subfolder is created within a parent folder that has a changed value, the subfolder does not inherit the changed value. By default, the subfolder is created to have a value of **0** for the property.

### How to remove conflict messages from a user's mailbox

Conflict messages are assigned to the **IPM.Conflict.Message** message class. You can use the [Search-Mailbox](/powershell/module/exchange/search-mailbox?preserve-view=true&view=exchange-ps) command to delete conflict messages from a user's mailbox. However, **Search-Mailbox** cannot be configured to filter messages according to the message class. When **Search-Mailbox** is used together with subject keyword filtering and sender keyword filtering, only messages from a specific public folder that contain the subject "Conflict Message" are deleted. But if users can send messages from this public folder, and have sent messages that use the same subject line to user mailboxes, those messages will also be deleted.

The following example command shows how to use **Search-Mailbox** to delete conflict messages:

```console
Search-Mailbox -Identity "April Stewart" -SearchQuery 'Subject:"Conflict Message:" And From:"PublicFolderName" -DeleteContent
```

> [!NOTE]
> To obtain the public folder name, open one of the conflict messages, and then note the name in the **From** field. If conflict messages are generated by more than one public folder, you must do this for every public folder that generated the conflict messages.
