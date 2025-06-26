---
title: Sync to SharePoint Workspace isn't available
description: This document describes why Sync to SharePoint Workspace might not display for SharePoint 2010 sites.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: gregjo
ms.custom: 
  - sap:User experience\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Workspace 2010
  - SharePoint 2010 For Internet Sites Enterprise
  - SharePoint 2010 For Internet Sites Standard
ms.date: 12/17/2023
---

# "Sync to SharePoint Workspace" isn't available on any SharePoint 2010 sites

## Symptoms

You install SharePoint Workspace on your computer. On the Home tab, if you select New and then select SharePoint Workspace, you can create a workspace that synchronizes to a SharePoint 2010 site. However, if you browse to a SharePoint 2010 site in Internet Explorer, the Site Actions menu never includes Sync to SharePoint Workspace. 

## Cause

You experience this problem if **Run Active X controls and plug-ins** is disabled in Internet Explorer security settings.

## Resolution

To resolve this issue, follow these steps:

1. In Internet Explorer, select **Tools**, and then select **Internet Options**.
2. Select the **Security** tab, select the zone for the SharePoint server, and then select **Custom Level**.
3. Under **Run Active X controls and plug-ins**, select **Enable**, and then select **OK**.

**Caution** This procedure lessens browser security for all sites in the affected security zone.

## More Information

If you also can't create the workspace from the SharePoint Workspace application, Sync to SharePoint Workspace may be unavailable for other reasons, such as: 

- Workspaces are disabled on the server
- FSSHTTP is disabled on the server
- The server is a 2007 SharePoint server

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
