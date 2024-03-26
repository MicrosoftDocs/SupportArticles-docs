---
title: Need an assigned license in order to retain an Exchange Online mailbox
description: Discusses a scenario in which you receive a One or more users need an assigned license in order to retain an Exchange Online mailbox or archive message when you view the Users page of the Microsoft 365 portal. A resolution is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Exchange Online
  - Microsoft 365
ms.date: 03/31/2022
---

# You receive a "One or more users need an assigned license in order to retain an Exchange Online mailbox or archive" message on the Users page of the Microsoft 365 portal

## Problem 

When you view the Users page of the Microsoft 365 portal in Microsoft 365, you receive the following message:

**One or more users need an assigned license in order to retain an Exchange Online mailbox. Create a new view and select "Users with mailboxes and no licenses." Select all users in the list, and then click "Edit" to assign licenses.**

Additionally, you experience the following symptoms:

- Exchange Online licenses are missing for users who were created in the Exchange admin center or in Exchange Online PowerShell.   
- Sudden mailbox loss for users who were created in the Exchange admin center or Exchange Online PowerShell.   

## Cause 

This occurs if the user mailboxes are created in the Exchange admin center, and the users aren't yet assigned a license. 

## Solution 

Create a view in the Microsoft 365 portal to display a list of users who have mailboxes but who don't have a license. To do this, follow these steps:

1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com)) as an admin.   
2. Click **users and groups**, and then click **active users**.   
3. Click **Filter** (:::image type="icon" source="media/license-issue-when-retain-online-mailbox/filter-icon.png":::), and then in the drop-down box, click **Unlicensed users**.   
NoteTo assign a license to a user, double-click the user. On the "Assign licenses" page, click to select the check boxes next to the items that you want to assign, and then click save. 

## More information

Users must be assigned a license, or the mailbox is deleted. From the time that the user mailbox is created in the Exchange admin center, admins have 30 days to assign the user a license in the Microsoft 365 portal.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
