---
title: Can't connect a workspace to a site
description: Describes a problem in which you can't connect SharePoint Workspace 2010 to an Office SharePoint Server 2007 site.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: patrigan, fselkirk
ms.custom: 
  - sap:User experience\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Workspace 2010
ms.date: 12/17/2023
---

# You can't connect a SharePoint workspace in SharePoint Workspace 2010 to an Office SharePoint Server 2007 site

## Symptoms

You have Microsoft Office Groove 2007 installed on a computer. You have Microsoft Office SharePoint Server 2007 installed on a server computer. Then, you upgrade from Office Groove 2007 to Microsoft SharePoint Workspace 2010. However, you don't upgrade from Office SharePoint Server 2007 to SharePoint Server 2010. In this case, you can't connect a SharePoint workspace to the SharePoint site. This behavior is expected. The SharePoint workspace type in SharePoint Workspace 2010 requires SharePoint Server 2010.

## Workaround

To synchronize SharePoint Workspace 2010 to Document Libraries on a SharePoint Server 2007 site, use the legacy SharePoint Files tool in SharePoint Workspace 2010. This is the same SharePoint Files tool that was included in Office Groove 2007. To add this tool, follow these steps:

1. On the **Home** tab of SharePoint Workspace **Launch bar**, select **New**, and then select **Groove workspace**.
2. In the **New Groove Workspace** window, select **Options**, select **2007** in the **Workspace Version** drop-down list, and then select **OK**.
3. In the new workspace, select the **Workspace** tab, select **Add**, and then select **SharePoint Files**.

These steps create a Groove workspace by using the 2007 template and then adds a SharePoint Files tool to the workspace. Each instance of this tool can synchronize a single document library on an Office SharePoint Server 2007 site or on a SharePoint Server 2010 site.

**Note** This tool doesn't sync other Office SharePoint Server content, such as lists.

## More Information

Because the SharePoint Files tool is part of a Groove workspace, content in the tool can be shared with workspace members who don't have access to the SharePoint server. This is sometimes useful for sharing information without providing access to a restricted network. However, it can create issues in security and conflict resolution. 

The preferred means of synchronizing with a SharePoint server is by using a SharePoint workspace. A SharePoint workspace can synchronize many kinds of lists and libraries with a SharePoint 2010 site. You can't invite other members to a SharePoint workspace, and it doesn't replicate to other computers on which you use SharePoint Workspace with the same account. Instead, the SharePoint 2010 Server remains the nexus for content.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
