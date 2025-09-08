---
title: Upgrade Windows on a server that has SharePoint Server installed
description: Describes how to upgrade the Windows Server version of a server used for SharePoint.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Administration\Setup, Upgrade, Migration and Patching
  - CSSTroubleshoot
  - CI 152110
appliesto: 
  - SharePoint Server
ms.date: 12/17/2023
---

# Upgrade Windows on a server that has SharePoint Server installed

If you want to upgrade the version of the Windows Server operating system on a server that has SharePoint Server 2010 or later installed, use the process described below. In-place upgrade of the Windows OS with SharePoint installed is not supported.

**Note** If you apply updates that include only cumulative updates or service packs on a SharePoint server, you don't have to use this process.

1. Create a new server with the version of Windows Server you want.
1. Join the new server to the server farm. For more information about this step, see:
    - [Add a server to a SharePoint Servers 2016 or 2019 farm](/sharepoint/install/add-a-server-to-a-sharepoint-server-2016-farm)
    - [Add web or application servers to farms in SharePoint 2013](/sharepoint/install/add-web-or-application-server-to-the-farm)
    - [Add a database server to an existing farm in SharePoint 2013](/sharepoint/install/add-a-database-server-to-an-existing-farm)
    - [Add a content database (SharePoint Server 2010)](/previous-versions/office/sharepoint-server-2010)

1. Move services to the new server as needed.
1. If you're using the search service application, make sure you remove the search component from the old server.
1. Decommission the old server.
