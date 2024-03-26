---
title: Text is not displayed when you open the drawing in a browser
description: Resolves an issue in which text in a Visio 2010 / 2013 drawing is not displayed if the drawing is saved as a Web drawing (*.vdw) file on an HTTP server.
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
ms.reviewer: poyant, Arykhus, Kemille, barbway
appliesto: 
  - Visio Premium 2010
  - Visio Standard 2010
  - Visio Professional 2013
  - Visio Standard 2013
ms.date: 03/31/2022
---

# Text is not displayed in a Visio 2010 / 2013 drawing when you open the drawing in a browser

## Symptoms

Using Microsoft Visio 2010 / 2013, you save a Microsoft Visio Drawing as a Web Page (.htm; .html) to an HTTP server. However, the text in the Visio drawing is not displayed when you open the Web Page (.htm; .html) file in a browser.

## Cause

This issue occurs because the ".odttf" MIME type is not registered in the HTTP server. The Silverlight Extensible Application Markup Language (XAML) output from HTTP servers only works if the ".odttf" MIME type is recognized by the servers.

## Resolution

To resolve this issue, contact your HTTP server administrator and make sure that the ".odttf" MIME type is registered in the server. 

File name extension: 

.odttf 

MIME type: 

application/octet-stream

## Workaround

Resave the Web Page from Visio with the output format set to something other than XAML, like VML. Specifically, when choosing Web Pages (.htm; .html), click on the Publish... button in the Save As dialog, click on the Advanced tab and choose something other than XAML (Extensible Application Markup Language). For example, this won't occur when you choose VML (Vector Markup Language), the default in Visio 2007. The drawback to this workaround is the web page will not be using Silverlight, if you have Silverlight installed on the client machine opening the web page.

Choosing XAML as the output format requires a Microsoft Silverlight browser plug-in or a browser capable of displaying XAML. If you choose another output format when publishing the Visio Drawing, you will not benefit from Silverlight rendering of the Visio Web Page.

## More Information

Configure MIME Types

IIS 7
[https://technet.microsoft.com/en-us/library/cc725608(WS.10).aspx](https://technet.microsoft.com/library/cc725608%28ws.10%29.aspx)

IIS 6
[https://technet.microsoft.com/en-us/library/cc786786(WS.10).aspx](https://technet.microsoft.com/library/cc786786%28ws.10%29.aspx)