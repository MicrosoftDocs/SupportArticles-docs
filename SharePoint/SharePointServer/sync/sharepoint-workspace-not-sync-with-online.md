---
title: SharePoint Workspace does not sync automatically
description: Describes conditions under which a SharePoint workspace or the SharePoint Files tool does not sync automatically.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Workspace 2010
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Workspace does not always sync with SharePoint Online automatically

## Symptoms

Consider the following scenario: 

- You have Microsoft SharePoint Workspace 2010 or Microsoft Office Groove 2007.   
- You use one of the following methods to take a document library on a SharePoint Online site offline: 
  - You create a Groove 2007 workspace and then use the 2007 SharePoint Files tool to sync the document library.    
  - You create a SharePoint workspace to sync the SharePoint site that contains the document library.    
In this scenario, the first synchronization finishes successfully. However, later synchronization attempts may fail. For a SharePoint workspace, the failure generates a notification, and the SharePoint Files tool may display the following message:

You do not have permission to view this SharePoint Library. Contact the site administrator.

## Cause

The 2007 SharePoint Files tool does not support Forms Based Authentication. This is the authentication scheme that is used by Microsoft SharePoint Online. However, the 2007 SharePoint Files tool will use active credentials from Windows Internet Explorer. Initial synchronization works because the SharePoint Files tool prompts you for your credentials during the tool initialization. Later synchronization attempts will not prompt you for your credentials, and you will be unable to authenticate. Therefore, those attempts will work if you have an active SharePoint Online session in your browser, and they will fail if you do not. 

A SharePoint workspace in SharePoint Workspace 2010 also tries to use the active credentials in Internet Explorer. If you do not have a browser open and you try a manual sync, the SharePoint workspace may prompt for credentials. It will not prompt for credentials for a background sync. However, if a background sync fails, a notification is generated that states that credentials are required. To see SharePoint Workspace notifications, point to the SharePoint Workspace icon in the notification area. 

## Resolution

To synchronize a SharePoint workspace, either log on to the SharePoint Online site in your web browser, or open the workspace and provide your credentials when you receive a notification that credentials are required.

To synchronize the SharePoint Files tool, use the following workaround:

1. Log on to the SharePoint Online site in your browser to establish your logon credentials.    
2. In the SharePoint Files tool, click **Sync**, and then click **Sync Now**.    
Because you have an active SharePoint Online site logon in the browser session, the sync can finish successfully. Scheduled background syncs will finish successfully until you log off from the site or close your browser.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
