---
title: Creating a team site from SharePoint Home doesn’t finish
description: When you try to create a team site from SharePoint Home, the site creation process never finishes.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
  - CI 150328
ms.collection: SPO_Content
ms.author: luche
appliesto: 
  - SharePoint Online
---

# Creating a team site from SharePoint Home doesn’t finish

## Symptoms

When you try to [create a team site](/sharepoint/create-site-collection) from SharePoint Home, the site creation process stops or never finishes. This might occur if the Limited-access user permission lockdown mode for the SharePoint [root site](/sharepoint/modern-root-site) is activated.

## Cause

Group-Connected Team sites require the ability to mae REST requests to SharePoint. SharePoint uses the UseRemoteAPI [permission level](/sharepoint/understanding-permission-levels#site-permissions-and-permission-levels).

## Resolution

Ask your organization’s SharePoint administrator to create the site for you.

If you are a SharePoint administrator, and you don’t need the Limited-access user permission lockdown mode on your SharePoint root site, you can turn off the mode by following these steps:

1. Select the Settings (gear) icon.

1. Open **Site Settings** > **Site Collection Administrator** > **Site Collection Features**.

1. Select **Limited-access user permission lockdown mode**, and then select **Deactivate**.
