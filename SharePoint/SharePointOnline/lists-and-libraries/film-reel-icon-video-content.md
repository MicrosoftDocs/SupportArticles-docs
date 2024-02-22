---
title: Asset Library displays a film reel icon for the Video content type
description: This article describes an issue where SharePoint Online Asset Library displays a film reel icon for the Video content type in Microsoft 365 and provides solutions.
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
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online Asset Library displays a film reel icon for the Video content type in Microsoft 365

## Problem

Consider the following scenario:

- In SharePoint Online, you create an Asset Library.

- You create a folder in the Asset Library.

- You change the properties of the folder and then change the Content Type setting from Folder to Video.
  In classic UI, the thumbnail image will have film reel icon 
  In Modern UI, the thumbnail image will have folder icon still

- You change the properties and then change the Content Type setting back to Folder from Video.
  In classic UI, the thumbnail image will have film reel icon still
  In Modern UI, the thumbnail image will have folder icon 

## Solution

This is a known issue in SharePoint Online.
Although the film reel icon appears in classic UI, the Content Type will function as a folder.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
