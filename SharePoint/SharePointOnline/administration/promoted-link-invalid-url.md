---
title: Invalid URL when clicking a SharePoint Online Promoted Link
description: "You cannot open a link to a local file that uses the file:// protocol in the Promoted Links list."
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Invalid URL" error when you click a SharePoint Online Promoted Link which uses the file:// protocol

## Problem

Consider the following scenario:

- On a SharePoint Online site, you have a Promoted Links list.
- In the Promoted Links list, you create a link to a local file that uses the file:// protocol.

However, when you view the Promoted Links list in the tile view and then click the link that you created, you receive the following error message:

**Invalid URL**

## Solution

This is the expected behavior in SharePoint Online. This issue occurs because the file:// protocol isn't supported for local files in the Promoted Links list. The http:// and https:// protocols are supported in the Promoted Links list in SharePoint Online.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
