---
title: SharePoint crawler has insufficient permissions to crawl file shares
description: The crawl account did not have sufficient privileges to access the security attributes of this file or folder when searching a file in the crawled file shares.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2013
  - SharePoint Server 2016
  - SharePoint Server 2019
  - SharePoint Server Subscription Edition
  - Windows Server 2012
  - Windows Server 2012 R2
  - Windows Server 2016
  - Windows Server 2019
  - Windows Server 2022
ms.date: 3/31/2022
---

# SharePoint crawler has insufficient permissions to crawl file shares

## Symptoms

Consider the following scenario:

- You create a file share on a server based on Windows Server 2012 (or a later version) and assign Read permissions to the SharePoint crawler (content access account).
- For this file share you set up a content source of the "File Shares" type via the SharePoint Search Service Application administration.
- You start a crawl for the content source of type "File Shares".
- In your SharePoint Search Center, run a search query for a file stored in the file share.

In this scenario, no search result is returned. Additionally, the following error message is generated in the crawl log:

**The crawl account did not have sufficient privileges to access the security attributes of this file or folder. Ensure the crawl account has the 'Manage auditing and security log' privilege.**

## Resolution

To resolve this issue, assign the 'Manage Auditing And Security Log' (SeSecurityPrivilege) privilege to the SharePoint content access account. To do this, follow these steps on the computer that hosts the file shares:

1. Click **Start**, click **Run**, type gpedit.msc, and then click **OK**.
1. Navigate to the following location in the Local Group Policy Editor:

   Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

1. In the right pane, locate and right-click **Manage auditing and security log**, and then click **Properties**.
1. Click the **Add User or Group** button in the **Manage auditing and security log properties** dialog box, and then add the crawl (content access) account that the SharePoint crawler uses.
1. Click **OK** in the **Manage auditing and security log properties** dialog box.

   > [!NOTE]
   > If you assign the 'Manage Auditing And Security Log permission' by using a Group Policy Object (GPO), add the crawl account to the GPO.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
