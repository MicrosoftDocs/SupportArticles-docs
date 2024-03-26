---
title: Can't open a SharePoint site with scripts error
description: Describes an issue in which you receive an error message when you try to open a SharePoint Server 2013 site. This issue occurs when the JavaScript feature is disabled in Internet Explorer.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Site or Web Administration
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Enable scripts and reload this page when you try to open a SharePoint Server 2013 site

_Original KB number:_ &nbsp; 2752584

## Symptoms

When you try to open a Microsoft SharePoint Server 2013 site, you receive the following error message:

> You may be trying to access this site from a secured browser on the server. Please enable scripts and reload this page.

## Cause

This problem occurs because the JavaScript feature is disabled in Windows Internet Explorer.

## Resolution

To resolve this problem, enable the JavaScript feature in Internet Explorer. To do this, follow these steps:

1. Open Internet Explorer, go to the SharePoint Server 2013 site, press Alt to reveal the **Menu** bar, select **Tools**, and then select **Internet Options**.
2. On the **Security** tab, select **Custom level**.
3. Scroll down to the **Active scripting** section, and then select **Enable**.
