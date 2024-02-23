---
title: Problems opening documents from a SharePoint site
description: Describes issues that may arise when working with Office documents located on a SharePoint site if the local web client service is disabled.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - Office 2010
ms.date: 12/17/2023
---

# Problems opening Office documents from a SharePoint site if web client service is disabled

## Symptoms

When opening an Office document from a SharePoint site, and clicking "Save As", Office 2010 and 2007 applications may take a long time to show the Save As dialog box. In addition, the default location within the Save As dialog box is a local folder, and not the SharePoint site. 

Office 2007 applications may also display the error "A problem occurred while connecting to the server. If the problem continues, contact your administrator." if a file is opened Read-Only from a SharePoint site, and the user clicks the Edit button within the Office 2007 application.

## Cause

The local web client service on the machine is disabled.

## Resolution

Click Start and type Services in the search pane. Open the Services window, right-click the Web client service and choose Properties. Change the startup type to Manual, then click OK and exit the Services window.

If you are running Windows Server 2008 or Windows Server 2012, the web client service must first be installed as a part of the Desktop Experience. For instructions on how to install the Desktop Experience on Server 2008, please see [Desktop Experience Overview](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772567(v=ws.11)).

For instructions on how to install the Desktop Experience on Server 2012, please see [Install Desktop Experience](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754314(v=ws.11)).

## More Information

This issue affects documents located on SharePoint 2007 and 2010 sites.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).