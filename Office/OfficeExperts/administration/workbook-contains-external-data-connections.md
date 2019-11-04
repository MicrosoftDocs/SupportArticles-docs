---
title: You receive a "This workbook contains external data connections or BI features that are not supported." error when you use a guest link to a workbook in Excel Online
author: AmandaAZ
ms.author: thempel
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Excel Online
---

# "This workbook contains external data connections or BI features that are not supported." when you use a guest link to a workbook in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you click slicers in a Microsoft SharePoint Online PowerPivot workbook that contains external data connections or Business Intelligence (BI) features that are not supported, you receive the following error:

**This workbook contains external data connections or BI features that are not supported.**

![the error message dialog box](./media/workbook-contains-external-data-connections/error-message.png)

## Cause

By default, a guest link URL that is provided by SharePoint doesn't include the required parameters for guests to use workbooks that contain data connections to data models or BI.

## Resolution

By default, a URL that is accessed by a guest will be formatted like:

**https://sharepointserver/:x:/r/_layouts/15/Doc.aspx?sourcedoc=%7B5e748b77-3447-4dce-a676-c1d12c4ef531%7D&action=default**

To use the data refresh or BI function, replace "action=default" with "action=embedview&wdbipreview=true". Then the URL will be like:

**https://sharepointserver/:x:/r/_layouts/15/Doc.aspx?sourcedoc=%7B5e748b77-3447-4dce-a676-c1d12c4ef531%7D&action=embedview&wdbipreview=true**