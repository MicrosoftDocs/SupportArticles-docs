---
title: Creation of team site from SharePoint Home doesn’t complete 
description: When you try to create a team site from SharePoint Home, the site creation might stop or never complete. 
author: salarson
manager: dcscontentpm
localization_priority: Normal
ms.date: 06/04/2021
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 150328
ms.collection: SPO_Content
ms.author: v-matham
appliesto:
- SharePoint Online
---

# Creation of team site from SharePoint Home doesn’t complete

## Symptoms

When you try to [create a team site](/sharepoint/create-site-collection) from SharePoint Home, the site creation might stop or never complete. This might happen if the Limited-access user permission lockdown mode for the SharePoint [root site](/sharepoint/modern-root-site) is Activated.

## Cause

Group-Connected Team sites require the ability to perform REST requests to SharePoint, which uses the UseRemoteAPI [permission level](/sharepoint/understanding-permission-levels#site-permissions-and-permission-levels).

## Resolution

Ask your organization’s SharePoint administrator to create the site for you.

If you are a SharePoint administrator, and don’t need the Limited-access user permission lockdown mode on your SharePoint root site, you can turn it off using these steps:

1. Select Settings (the gear icon).

1. Select **Site Settings**.

1. Under **Site Collection Administrator** > **Site Collection Features**, select **Limited-access user permission lockdown mode**, and then select **Deactivate**.