---
title: Message store has reached its maximum size when delete an item
description: Describes an issue that triggers a "maximum size" error message when an Office 365 user tries to delete an item such as a calendar event in Outlook or Outlook on the Web.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# "Message store has reached its maximum size" error when an Office 365 user tries to delete an item in Outlook or Outlook on the Web

## Symptoms

When a Microsoft Office 365 user tries to delete an item such as a calendar event in Outlook or Outlook on the Web, the user experiences the following symptoms: 
 
- In Outlook, the user receives the following error message:  

    **The message store has reached its maximum size. To reduce the amount of data in this message store, select some items that you no longer need, permanently (Shift + Del) delete them.**      
- In Outlook on the Web, the user receives the following error message:  

    **The action couldn't be completed. An error occurred on the server.**      
  
## Cause

This issue occurs if the items in the Recoverable Items folder of the user's mailbox exceed the default quota of 30 gigabytes (GB). 

## Solution

To fix this issue, use either of the following methods: 
 
- Make sure that Litigation Hold or In-Place Hold is enabled. If either feature is enabled, the storage quota for the Recoverable Items folder is automatically increased from 30 GB to 100 GB.
- Enable the archive mailbox, turn on the auto-expanding archiving feature in Exchange Online, and then create a custom retention policy for mailboxes on hold. After you complete these steps, the storage quota for the Recoverable Items folder in the user's archive will be unlimited.    
 
For more information about how to increase the storage quota, see [Increase the Recoverable Items quota for mailboxes on hold](https://docs.microsoft.com/office365/securitycompliance/increase-the-recoverable-quota-for-mailboxes-on-hold).  

## More information

The Recoverable Items folder is not visible to the user. It contains mail items that have been soft-deleted.

An item is considered soft-deleted in the following cases: 

- A user deletes an item or empties all items from the Deleted Items folder.    
- A user presses Shift+Delete to delete an item from any other mailbox folder.    

Users can use the **Recover Deleted Items** feature in Outlook or Outlook Web App to recover a deleted item.

For more information about deleted item recovery, see [Recoverable Items folder](https://technet.microsoft.com/library/ee364755%28v=exchg.150%29.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).