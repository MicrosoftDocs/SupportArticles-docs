---
title: Additional RSS feeds in Outlook after sign in to Microsoft 365 on a new computer
description: Describes a scenarion in which RSS feeds are added to a user's account when that user signs in to Microsoft 365 on a different computer.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
  - Outlook
ms.date: 10/30/2023
---

# Additional RSS feeds appear in Outlook after a user signs in to Microsoft 365 on a new computer

## Problem 

Consider the following scenario. When a user signs in to Microsoft 365 on a new computer, the user's RSS feeds are transferred to the new computer. Additionally, the RSS feeds that are already on the new computer are also added to the user's account. If a second user signs in to Microsoft 365 on the new computer, the second user's RSS feeds are added to the new computer. Additionally, all the RSS feeds that are available on the new computer are added to the second user's account. This includes the RSS feeds of the first user. In this scenario, the following issues may occur:

- If you obtain a secure RSS feed when you log on to a computer, you may be prompted for your credentials every time that you use the account.   
- The RSS feeds may contain personal data.   

## Cause 

Windows Internet Explorer uses the common feeds list to check RSS feeds. A separate list for Microsoft Outlook is included so that the RSS feeds are displayed in Outlook instead of in Internet Explorer or vice versa. Outlook saves the RSS feeds to your Microsoft Exchange Online account. If you have multiple accounts on multiple computers, the RSS feeds propagate from one account to another. 

## Solution 

To resolve this issue, follow these steps:

## In Outlook 2010

1. Prevent Outlook from synchronizing the RSS feeds with the common feeds list. To do this, follow these steps: 
   1. In Microsoft Outlook 2010, click **Options** on the **File** tab.   
   2. Click **Advanced**, and then under **RSS Feeds**, click to clear the **Synchronize RSS Feeds to the Common Feed List (CFL) in Windows** check box.   
   3. Click **OK**.   
   
2. Delete the RSS feeds that you don't need or the RSS feeds that you don't own from your account. To do this, follow these steps: 
   1. In Outlook 2010, on the **File** tab, click **Account Settings**, and then click **Account Settings**.   
   2. Click the **RSS Feeds** tab.   
   3. Under **Feed Name**, click the RSS feed you want to delete, click **Remove**, and then when you're prompted, confirm the deletion.

        > [!NOTE]
        > To cancel multiple RSS feeds, hold down the CTRL key while you click the multiple RSS feed names.   
   4. In your mailbox, expand the RSS Feeds folder.   
   5. Click the RSS feed that you want to delete, click **Delete**, and then when you're prompted, confirm the deletion.   
   6. Repeat steps 2e for all the feeds.   
   
## In Outlook 2007

1. Prevent Outlook from synchronizing the RSS feeds with the common feeds list. To do this, follow these steps:
   1. In Microsoft Office Outlook 2007, click **Options** on the **Tools** menu.   
   2. Click the **Other** tab, and then click **Advanced Options** under **General**.   
   3. Under **General settings**, click to clear the **Sync RSS Feeds to the Common Feed List** check box.   
   4. Click **OK** two times.   
   
2. Delete the RSS feeds that you don't need or the RSS feeds that you don't own from your account. To do this, follow these steps:
   1. In Outlook 2007, click **Options** on the **Tools** menu.   
   2. Click the **Mail Setup** tab, click **Data Files**, and then click the **RSS Feeds** tab.   
   3. Under **Feed Name**, click the RSS feed you want to delete, click **Remove**, and then when you're prompted, confirm the deletion.

        > [!NOTE]
        > To cancel multiple RSS feeds, hold down the CTRL key while you click the multiple RSS feed names.   
   4. In your mailbox, expand the RSS feed folder under **Personal Folders**.   
   5. Click the RSS feed that you want to delete, click **Delete**, and then when you're prompted, confirm the deletion.   
   6. Repeat steps 2e for all the feeds.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).