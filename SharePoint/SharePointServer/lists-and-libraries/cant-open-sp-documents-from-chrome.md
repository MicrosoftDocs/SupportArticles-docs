---
title: Can't open documents in a local client from Chrome
description: Describes an issue that occurs when you open SharePoint-based files in the Chrome browser. Because Chrome has deprecated NPAPI support, SharePoint integration with Chrome has been disrupted. A workaround is provided.
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
  - SharePoint Server 2013
  - Microsoft SharePoint Server 2013 Service Pack 1
  - SharePoint Online
ms.date: 12/17/2023
---

# Can't open SharePoint documents in a local client (rich client) from Chrome when NPAPI plug-in is missing

## Symptoms

When you try to open a file from an on-premises installation of Microsoft SharePoint Server or from SharePoint Online in classic view, the browser defaults to either downloading a local copy or trying to open the file in the browser. This issue occurs regardless of your library settings.

Additionally, many other SharePoint integration features don't work. These include the following:

- The ability to open documents in a rich client app when a document library link is selected   
- Lync Presence information   
- The ability to export to Excel from a document library or a SharePoint list    
- The **Edit Library** button and functionality   
- The **New Quick Step **option    
- The **Create a workflow in SharePoint Designer** option under **Workflow Settings**   
- The **Open with Access** and **Open with Project** options   
- The **Edit Lists** feature   

## Cause

This issue occurs because Netscape Plugin API (NPAPI) support is disabled. In September 2015, NPAPI support was permanently removed from Chrome and Chromium based browsers (such as Microsoft Edge). Installed extensions that require NPAPI plugins can no longer load those plugins. For more information, see [The final countdown for NPAPI](https://blog.chromium.org/2014/11/the-final-countdown-for-npapi.html).

## Workarounds

- Internet Explorer 11 relies on ActiveX controls instead of NPAPI, and will open Office files in an Office rich client application.
- You can open the file in the browser by using Office Web Apps, and then select **Edit in Word** from the web editor to open the file in a rich client application. 
- You can also open the file in the rich Office client application from the Document library directly in Chrome or Microsoft Edge with the **Edit** button from the document library's file ellipsis menu in the preview pane.

## More Information

SharePoint Server 2013 has reached the end of its support lifecycle and is no longer receiving feature fixes or new functionality. Microsoft is providing [extended support](/lifecycle/policies/fixed#extended-support) for [SharePoint Server 2013 until April 11, 2023](/lifecycle/products/sharepoint-server-2013).

For more information about the servicing policy, see [Product Servicing Policy for SharePoint 2013](/SharePoint/product-servicing-policy/updated-product-servicing-policy-for-sharepoint-2013).

Microsoft recommends that customers migrate to current product versions before the support end date. This way enables the customers to take advantage of the latest product innovations, and ensures uninterrupted support from Microsoft. We encourage customers to evaluate transition to Microsoft 365 with the help of their Microsoft representatives or technology partner.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
