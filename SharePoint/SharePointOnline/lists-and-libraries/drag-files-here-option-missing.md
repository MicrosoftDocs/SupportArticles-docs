---
title: The drag files here option is missing for a list
description: The option to drag files here for a list is missing in SharePoint Online or SharePoint 2013 on-premises.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Files and Documents\Drag and Drop
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# The "drag files here" option is missing for a list in SharePoint Online or SharePoint 2013 on-premises

## Problem

In Microsoft SharePoint Online or Microsoft SharePoint 2013 on-premises, the option to "drag files here" for a list is missing.

## Solution

To resolve this problem, install the latest version of your web browser. Or, install Microsoft Office 2013 or SharePoint Designer 2013.

## More information

This issue occurs because the "drag files here" feature requires software that supports HTML5.

When Office 2013 or SharePoint Designer 2013 is installed on the client computer, it installs the **SharePoint Drag/Upload Control**. This control is required for this feature to work if your browser doesn't support HTML5.

For more information, see [Upload files to a library](https://support.office.com/article/upload-files-to-a-library-da549fb1-1fcb-4167-87d0-4693e93cb7a0?ocmsassetID=HA102803549&CorrelationId=1ddf2bde-436a-4f5e-8cea-ef35150f11b4&ui=en-US&rs=en-US&ad=US).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
