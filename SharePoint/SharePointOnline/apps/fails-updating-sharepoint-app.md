---
title: Unable to update a SharePoint app because of different version installed
description: You cannot update a SharePoint app with the error message saying that a different version of this App is already installed with the same version number.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "A different version of this App is already installed with the same version number" error when you try to update a SharePoint app

## Problem

When you try to update a Microsoft SharePoint app that you're developing by using Microsoft Visual Studio, you receive the following error message:

**A different version of this App is already installed with the same version number.**

## Solution

To resolve this issue, use a later version number in the App element of the Appmanifest.xml file.

For more information, see [Update SharePoint Add-ins](/sharepoint/dev/sp-add-ins/update-sharepoint-add-ins).

## More information

This error can occur if you don't manually update the app version number in the app manifest file (Appmanifest.xml).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).