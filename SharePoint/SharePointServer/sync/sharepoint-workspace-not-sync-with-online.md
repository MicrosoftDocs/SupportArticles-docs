---
title: SharePoint Workspace doesn't sync automatically
description: Describes conditions under which a SharePoint workspace or the SharePoint Files tool doesn't sync automatically.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Hybrid with M365 (OneDrive,App launcher, Site following, PowerApps, Flow, etc.)
  - CSSTroubleshoot
appliesto: 
  - SharePoint Workspace 2010
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Workspace doesn't always sync with SharePoint Online automatically

## Symptoms

Consider the following scenario:

- You have Microsoft SharePoint Workspace 2010 or Microsoft Office Groove 2007.
- You use one of the following methods to take a document library on a SharePoint Online site offline:
  - You create a Groove 2007 workspace and then use the 2007 SharePoint Files tool to sync the document library.
  - You create a SharePoint workspace to sync the SharePoint site that contains the document library.

In this scenario, the first synchronization finishes successfully. However, later synchronization attempts may fail. For a SharePoint workspace, the failure generates a notification, and the SharePoint Files tool may display the following message:

> You don't have permission to view this SharePoint Library. Contact the site administrator.

## Cause

The 2007 SharePoint Files tool doesn't support Forms Based Authentication. It's the authentication scheme that's used by Microsoft SharePoint Online. However, the 2007 SharePoint Files tool uses active credentials from Windows Internet Explorer. Initial synchronization works because the SharePoint Files tool prompts you for your credentials during the tool initialization. Later synchronization attempts don't prompt you for your credentials, and you can't authenticate. Therefore, those attempts work if you have an active SharePoint Online session in your browser, and they fail if you don't.

A SharePoint workspace in SharePoint Workspace 2010 also tries to use the active credentials in Internet Explorer. If you don't have a browser open and you try a manual sync, the SharePoint workspace may prompt for credentials. It doesn't prompt for credentials for a background sync. However, if a background sync fails, a notification is generated that states that credentials are required. To see SharePoint Workspace notifications, point to the SharePoint Workspace icon in the notification area.

## Resolution

To synchronize a SharePoint workspace, either sign in to the SharePoint Online site in your web browser, or open the workspace and provide your credentials when you receive a notification that credentials are required.

To synchronize the SharePoint Files tool, use the following workaround:

1. Sign in to the SharePoint Online site in your browser to establish your logon credentials.
2. In the SharePoint Files tool, select **Sync**, and then select **Sync Now**.

Because you have an active SharePoint Online site logon in the browser session, the sync can finish successfully. Scheduled background syncs will finish successfully until you sign out from the site or close your browser.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
