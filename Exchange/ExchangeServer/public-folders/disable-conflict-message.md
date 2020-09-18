---
title: How to disable public folder Conflict Message notification
description: Explains how to disable public folder Conflict Message notification in Exchange Server.
author: simonxjx
audience: ITPro
ms.service: exchange-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Server 2010 Enterprise
- Microsoft Exchange Server 2003 Enterprise Edition
- Exchange Server 2007
- Microsoft Exchange Server 2003 Standard Edition
- Exchange Server 2010 Standard
ms.reviewer: bilong
---
# How to disable public folder Conflict Message notification

_Original KB number:_ &nbsp; 980047

## Summary

This article describes how to disable public folder Conflict Message notification.

## Introduction

Consider the following scenario. Two users edit and then change the same message in a public folder. Then, they save the messages. In this scenario, the saved messages are in conflict. Conflicts can occur when a concurrent save operation occurs on the same public folder server or when the message is edited on two servers that contain replicas of the same public folder. This article describes a situation in which the conflict occurs during a replication between two servers.

When a conflict occurs, the owners of the public folder receive an e-mail message from the Microsoft Exchange Server server that notifies them about the conflict. Then, the owners can open the message for which the conflict occurred and then decide which changes they want to keep. If the owners keep all changes, two messages are generated in the public folder.

The method that the Exchange Server server uses to resolve these conflicts is determined by the value of the PR_RESOLVE_METHOD property in the folder. This property is identified by the 0x3FE70003 MAPI property tag. The following are three possible values for this property:

- 0: RESOLVE_METHOD_DEFAULT

   Default handling of message conflicts.

- 1: RESOLVE_METHOD_LAST_WRITER_WINS

   Last writer will win the conflict.

- 2: RESOLVE_METHOD_NO_CONFLICT_NOTIFICATION

   Same steps as the RESOLVE_METHOD_DEFAULT, except that the contacts defined on a folder and the modifiers of a message are not notified.

By default, the value is set to 0. If you do not want a notification message to be sent during a conflict, change the value to 2.

You can change this value programmatically, or you can use one of the tools that are described in this article. For more information, contact the Microsoft Developer Network (MSDN), or use a utility to change individual folder property values. For example, use the Exchange Server Public Folder Distributed Authoring and Versioning (DAV)-based Administration tool (PFDAVAdmin) to change folder property values.

> [!NOTE]
> Changing the value of the PR_RESOLVE_METHOD property will not resolve existing conflicts.

For more information about how to programmatically change the value of the PR_RESOLVE_METHOD property, visit the following Microsoft Developer Network (MSDN) Web site: [search for the PR_RESOLVE_METHOD property](https://social.msdn.microsoft.com/search/?query=pr_resolve_method%20&ac=8).

For more information about how to use the PFDAVAdmin utility, visit the following Microsoft Web site: [Microsoft Exchange Server Public Folder DAV-based Administration Tool](https://technet.microsoft.com/library/bb508858%28exchg.65%29.aspx)

### How to use the PFDAVAdmin utility to change the value of the PR_RESOLVE_METHOD property

> [!NOTE]
> The account that is used for authentication in the PFDAVAdmin utility must have rights to change public folder attributes. We recommend that you run the PFDAVAdmin utility from a workstation. To do this, follow these steps:

1. Start the PFDAVAdmin utility.

2. On the **File** menu, click **Connect**.

3. Enter the name of the Exchange Server server and of the global catalog.

4. Select the **Authenticate as currently logged-on user** check box, or manually enter another account that you can use for authentication.

5. On the **Connection** tab, click **Public Folders**, and then click **OK**.

6. Expand the **Public Folders** item, locate the public folder that contains the conflict, and then right-click the folder to disable Conflict Message notification.

7. Right-click the folder and then click **Property Editor**.

8. In the **Property** text box, type PR_RESOLVE_METHOD: 0X3FE70003.

9. Click **Set** and then type the desired value. Possible values are 0, 1, 2 (see earlier for more information about the possible values)

10. If you want to make this change to all subfolders of the selected folder, select the **Perform this action on all subfolders of the selected folder** check box.

11. Click **Execute**. You should receive confirmation that the change is successful.

12. Repeat steps 1 to 11 for other folders that have conflicts.

> [!IMPORTANT]
> When a subfolder is created at the parent folder that has a changed value, the subfolder does not inherit the changed value. By default, the subfolder is created to have a value of 0 for the property.

## How to remove public folder conflict messages from mailboxes in Microsoft Exchange Server 2003

You can use two methods to remove conflict messages in bulk from a Microsoft Exchange Server 2003 mailbox.

Method 1 shows how to use the Microsoft Exchange Mailbox Merge (Exmerge.exe) utility to remove these messages from certain mailboxes. We recommend that you use this method when there are only a few mailboxes and when you know which ones are affected.

Method 2 should be used when there are many mailboxes that may be affected and when you do not know which mailboxes are affected. In this situation, use a mailbox management policy to remove the affected messages.

### Method 1: The ExMerge utility

#### Prerequisites

To perform this procedure, download and then install the ExMerge utility from the following Microsoft Download Center site:

[Microsoft Exchange Server Mailbox Merge Wizard (ExMerge)](https://www.microsoft.com/download/details.aspx?familyid=429163ec-dcdf-47dc-96da-1c12d67327d5)

Install the ExMerge utility in the Exchsrvr\Bin folder that is located on the Exchange Server server.

Then, configure an account to use the ExMerge utility.

> [!NOTE]
> When you run the ExMerge utility against lots of mailboxes, the task takes a lot of time. Therefore, use method 1 to clear conflict messages from a small group of mailboxes. If the number of mailboxes that contain these messages is unknown or large, use method 2.

#### How to use the ExMerge utility

To delete all conflict messages from a mailbox by using the ExMerge utility, follow these steps:

1. Start the ExMerge utility.

2. Click **Next** on the **Welcome** page.

3. Click **Extract or Import (Two Step Procedure)** when you are prompted to select the procedure type, and then click **Next**.

4. Click **Step 1: Extract data from an Exchange Server Mailbox** and then click **Next**.

5. Type the name of the Exchange Server that holds the Mailboxes that contain the conflict messages. Click the **Options** button.

6. On the **Data** tab, click **User messages and folders**  
7. On the **Import Procedure** tab, click **Archive data to target store**  

    > [!NOTE]
    > This behavior moves the conflict messages to a named PST file and delete the messages from the mailbox.

8. On the **Folders** tab, you can specify certain folders in your search. For example if you are sure that the messages exist in the inbox, click **Process only these folders**, and then select the **\Inbox** folder.

9. On the **Dates** tab, you can make your search more specific by selecting the time frame in which the messages were delivered.

10. On the **Message Details** tab, type **Conflict Message** for the subject and then click **Add**  

    > [!NOTE]
    > This behavior may also remove messages that contain "Conflict Message" in the subject and not just the conflict messages. Therefore, review the PST files after you export them to check whether any personal e-mail messages were removed. To exclude ordinary mail messages from being removed, use method 2.

11. Click **OK**.

12. Select the database that contains the mailboxes when you are prompted, and then click **Next**.

13. Select the mailboxes to include in this export, click **Next**.

14. Verify that the value in the **Locale Section** field is correct, and then click **Next**.

15. Verify the Target Directory of the PST files that will be created, click **Next**.

16. Confirm your settings, and then click **Next** to begin the procedure. Errors will be noted on the final page of the Wizard. Additional information can be found in the Exmerge.log file that is saved in the Exchsrvr\Bin folder on the Exchange Server server.

### Method 2: Mailbox management policy

You should understand how the Mailbox Management process works and what risks you may face when you follow this method. You can only apply one mailbox management policy at a time to a mailbox. If you currently have mailbox management policies applied to your mailboxes, this method replaces these policies with a new policy. After you remove the conflict messages, this new policy should be removed so that the original policies can be reapplied to your mailboxes.

#### How to use a mailbox management policy

1. Start Exchange System Manager.
2. On the **Recipients** tab, click **Recipient Policies**.
3. Click **Action**, click **New**, and then click **Recipient Policy**.

4. In the **New Policy** dialog box, select **Mailbox Manager Settings**, click **OK**.

5. On the **General** tab, type a name for the new policy and then click **Modify** to set the filter for the policy.

6. Create a new filter that will capture either all Exchange mailboxes or only the mailboxes that you believe contain the conflict messages. Then, click **OK**.
7. Click the **Mailbox Manager Settings (Policy)** tab.

8. Select the action that you want to apply to the conflict messages. The choices are listed in the **When processing a mailbox** drop-down menu. The following are the menu items:

    - Generate Report Only

    - Move to Deleted Items Folder

    - Move to System Cleanup Folders

    - Delete Immediately

    > [!NOTE]
    > Selecting the **Move to Deleted Items Folder** item could help verify that the correct messages are being selected and that non-conflict messages are not being affected. After you confirm that the correct messages were moved to the deleted items folder, you can change the policy to delete the messages permanently.

9. Select the folders that you believe contain the conflict messages, or select all folders.
10. For each folder click **Edit**, change both the **message size** and **age limit** values to 0, and then click **OK**.

11. Select the **Exclude specific message classes** check box and then click **Customize**.

12. Conflict messages are represented by the IPM.Conflict.Message and IPM.Conflict.Folder message classes. If you exclude all other message classes, you can narrow the scope of this policy to only the conflict messages.

13. For example, exclusions should be created for messages classes such as IPM.A*, IPM.B*, and IPM.Cong*. This behavior excludes all message classes except for the conflict messages.

    For a complete list of message classes visit the following MSDN Web sites:

    [Item types and message classes](https://msdn.microsoft.com/library/aa262246%28office.10%29.aspx)

    [Customizing the Ribbon in Outlook 2007](https://msdn.microsoft.com/library/bb226712.aspx)

    Additionally, REPORT.IPM.NOTE.DR is used for Delivery Receipts and REPORT.IPM.NOTE.IPNRN is used for Read Receipts.

    > [!NOTE]
    > Additional custom message classes may be used by third-party applications and message customization.

14. Click **Add** to add each message class that you want to exclude, and then click **OK**.

15. Make sure that the new policy that you created has a higher priority than any other Mailbox Manager policy. Right-click the policy, and then click **Apply this policy now**. RUS and directory replication may take some time.

16. Wait for the mailbox management process to begin. The process begins according to the schedule that is set on the database properties. Or, right-click a mailbox database, and then click **Start Mailbox Management Process**. After you confirm that conflict messages have been removed from the mailboxes, delete this policy, and then reapply the default policy if one exists.

## How to remove public folder conflict messages from mailboxes in Exchange 2007 Server

Follow the steps that are described in this section to remove conflict messages from these mailboxes.

To find and then delete these messages, use the Export-Mailbox cmdlet. Export-Mailbox searches mailboxes for messages that contain filterable content. Then, Export-Mailbox exports mailboxes that match the filter criteria to a PST file, exports these mailboxes to another user's mailbox folder, or deletes the messages. For more information about how to use the Export-Mailbox cmdlet, visit the following Microsoft TechNet Web site: [Export-Mailbox](https://technet.microsoft.com/library/aa998579.aspx)

You can use the SubjectKeywords and SenderKeywords parameters of Export-Mailbox to configure the filter to delete only the conflict messages that are in a specific public folder. This behavior prevents you from deleting messages that may have "Conflict Message" in the subject but are not actually conflict messages.

> [!NOTE]
> Conflict messages are assigned to the IPM.Conflict.Message message class. However, Export-Mailbox cannot be configured to filter messages according to the message class. When Export-Mailbox is used together with subject keyword filtering and sender keyword filtering, only messages from a specific public folder that contain the subject "Conflict Message" are deleted. However if users are able to send as this Public Folder and have sent messages that have this subject to user mailboxes, these messages will also be deleted.

### Prerequisite

To perform this procedure, the following roles and permissions must be delegated to the account that you use:

- The Exchange Server Administrators role and local Administrators group for the source server and the target server.

- Full access to the source for and target mailboxes. For more information about permissions, about delegating roles, and about the rights that are required for administration in Exchange Server 2007, visit the following Microsoft TechNet Web site: [Permissions Considerations](https://technet.microsoft.com/library/aa996881.aspx).

Additionally, before you perform this procedure, review the requirements and limitations of the Export-Mailbox cmdlet. For information about the requirements and limitations of the Export-Mailbox cmdlet, visit the following Microsoft TechNet Web site: [How to Export Mailbox Data](https://technet.microsoft.com/library/bb266964%28exchg.80%29.aspx)

### How to use the Export-Mailbox cmdlet

To delete all conflict messages from all mailboxes on a specific server that were generated by a specific public folder, run the following command in the Exchange Management Shell:

```powershell
Get-mailbox -server <servername> | Export-mailbox -subjectkeywords "Conflict Message:" -SenderKeywords "PublicFolderName" -deletecontent
```

To delete all conflict messages in a specific mailbox that were generated by a specific public folder, run the following command in the Exchange Management Shell:

```powershell
Export-mailbox -Identity MailboxIdParameter -subjectkeywords "Conflict Message:" -SenderKeywords "PublicFolderName" -deletecontent  
```

> [!NOTE]
> •To obtain the public folder name, open one of the conflict messages, and then note the name in the **From** field. If conflict messages are generated by more than one public folder, you must perform this action for each public folder that generated the conflict messages.

> [!NOTE]
> To export the messages to a PST file and then delete the messages, this cmdlet must be run from a 32-bit client that has Microsoft Outlook and the Exchange Management tools installed.

The Export-Mailbox cmdlet offers other filterable options that may be more appropriate for your environment. For example, if all the conflict messages are in a specific folder in a mailbox, the -IncludeFolders parameter can be used to further specify the scope. For a list of all the parameters that are available for the Export-Mailbox cmdlet, visit the following Microsoft TechNet Web site: [How to Export Mailbox Data](https://technet.microsoft.com/library/bb266964%28exchg.80%29.aspx)
