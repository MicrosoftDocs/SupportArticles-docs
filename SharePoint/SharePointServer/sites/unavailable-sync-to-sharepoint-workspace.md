---
title: Sync to SharePoint Workspace is not available
description: This document describes why Sync to SharePoint Workspace might not display for SharePoint 2010 sites.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: gregjo
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Workspace 2010
- SharePoint 2010 For Internet Sites Enterprise
- SharePoint 2010 For Internet Sites Standard
---

# "Sync to SharePoint Workspace" is not available on any SharePoint 2010 sites

## Symptoms

Consider the following scenario. You install SharePoint Workspace on your computer. On the Home tab, if you click New and then click SharePoint Workspace, you can create a workspace that synchronizes to a SharePoint 2010 site. However, if you browse to a SharePoint 2010 site in Internet Explorer, the Site Actions menu never includes Sync to SharePoint Workspace. 

## Cause

You will experience this problem if Run Active X controls and plug-insis disabled in Internet Explorer security settings. 

## Resolution

To resolve this issue, follow these steps:

1. In Internet Explorer, click Tools and then click Internet Options.   
2. Click the Security tab, click the zone for the SharePoint server, and then click Custom Level.   
3. Under Run Active X controls and plug-ins, click to select Enable, and then click OK.   

**Caution** This procedure lessens browser security for all sites in the affected security zone.

## More Information

If you also cannot create the workspace from the SharePoint Workspace application, Sync to SharePoint Workspace may be unavailable for other reasons, such as: 

- Workspaces are disabled on the server   
- FSSHTTP is disabled on the server   
- The server is a 2007 SharePoint sever   
