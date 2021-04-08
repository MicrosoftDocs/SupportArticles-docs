---
title: SharePoint crawler has insufficient permissions to crawl file shares
description: The crawl account did not have sufficient privileges to access the security attributes of this file or folder when searching a file in the crawled file shares.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- SharePoint Server 2013
---

# SharePoint Server 2013 crawler has insufficient permissions to crawl file shares

## Symptoms

Consider the following scenario:

- You create file shares on a Windows Server 2012 server.
- You set up a Microsoft SharePoint 2013 crawler on the file shares, and you assign Read permissions to the crawler.
- You crawl the file shares by using SharePoint Server 2013.
- You search for a file in the file shares by using SharePoint Server 2013.

In this scenario, no search result is returned. Additionally, the following error message is generated in the crawl log:

**The crawl account did not have sufficient privileges to access the security attributes of this file or folder. Ensure the crawl account has the 'Manage auditing and security log' privilege.**

## Resolution

To resolve this issue, assign the Manage Auditing And Security Log permission to the SharePoint 2013 crawler. To do this, follow these steps on the computer that hosts the file shares:

1. Click **Start**, click **Run**, type gpedit.msc, and then click **OK**.
1. Navigate to the following location in the Local Group Policy Editor:

   Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

1. In the right pane, locate and right-click **Manage auditing and security log**, and then click **Properties**.
1. Click the **Add User or Group** button in the **Manage auditing and security log properties** dialog box, and then add the crawl account that the SharePoint 2013 crawler uses.
1. Click **OK** in the **Manage auditing and security log properties** dialog box.

   > [!NOTE]
   > If you assign the Manage Auditing And Security Log permission by using a Group Policy Object (GPO), add the crawl account to the GPO.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
