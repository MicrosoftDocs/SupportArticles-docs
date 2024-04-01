---
title: A Web Part that is configured to refresh automatically on a SharePoint Foundation 2010 Web page never finishes refreshing
description: Provides a workaround for a problem in SharePoint Foundation 2010 in which a virtual List Web Part never finishes refreshing. However, the Web Part is configured to refresh automatically.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:User experience\Webpart infrastructure
  - CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2010
ms.date: 12/17/2023
---

# A Web Part that is configured to refresh automatically on a SharePoint Foundation 2010 Web page never finishes refreshing

## Symptoms

You have a virtual List Web Part that is configured to refresh automatically on a Microsoft SharePoint Foundation 2010 Web page. However, the refresh never finishes. This problem also occurs in a Data Form Web Part (DFWP) and a regular list.

## Cause

This problem occurs because the JScript code for the automatic refresh is not processed.

## Workaround

To work around this problem, configure the Web Part or the regular list in Microsoft SharePoint Designer 2010. To do this, follow these steps:

1. Open the page that contains the virtual List Web Part in Microsoft SharePoint Designer 2010.   
2. Click **Edit file**.   
3. Click the Web part.   
4. On the **Options** tab, click to select the **Asynchronous Update** check box.   
5. Click the **Refresh Interval** drop-down list, select an interval, and then save the settings.   

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
