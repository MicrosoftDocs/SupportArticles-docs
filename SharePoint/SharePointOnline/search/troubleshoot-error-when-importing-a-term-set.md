---
title: Error when you try to import a term set into SharePoint Online
description: Describes an issue when you try to import a term set into SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Search\Customize and Configure Results
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Not all terms were imported successfully" error when you try to import a term set

## Problem

Consider the following scenario:

- You create a .csv file to import a term set into SharePoint Online.

- In the SharePoint admin center, you use the **term store** tool to import the file.

In this scenario, you receive the following error message:

**Not all terms were imported successfully. Please see the server log for more information.**

## Solution/Workaround

To work around this issue, only use the term store tool to import term sets that contain fewer than 5,000 terms. To import large term sets, use the Client Side Object Model (CSOM).

## More information

This issue occurs when you try to import more than 5,000 terms by using the term store tool in the SharePoint admin center. This is a known issue in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
