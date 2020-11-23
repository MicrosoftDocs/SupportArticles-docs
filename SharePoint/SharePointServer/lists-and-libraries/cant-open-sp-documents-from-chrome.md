---
title: Can't open documents in a local client from Chrome
description: Describes an issue that occurs when you open SharePoint Server hosted files in the Chrome browser. Because Chrome has deprecated NPAPI support, SharePoint integration with Chrome has been disrupted. A workaround is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Server 2013
- Microsoft SharePoint Server 2013 Service Pack 1
- SharePoint Online
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

This problem occurs when Netscape Plugin API (NPAPI) support is disabled. In September 2015 NPAPI support was permanently removed from Chrome and Chromium based browsers (such as Microsoft Edge). Installed extensions that require NPAPI plugins are no longer able to load those plugins. More information is available from the following Google blog post:

[The final countdown for NPAPI](https://blog.chromium.org/2014/11/the-final-countdown-for-npapi.html)

## Workarounds

- Internet Explorer 11 relies on ActiveX controls instead of NPAPI and will open Office files in a Office rich client application.
- You can open the file in the browser by using Office Web Apps, and then click the **Edit in Word** button from the web editor to open in a rich client application. 
- You can also open the file in the rich Office client application from the Document library directly in Chrome or Microsoft Edge with the **Edit** button from the document library's file ellipsis menu, in the preview pane.

**Third-party information disclaimer**

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

## More Information

SharePoint 2013 has reached the end of its support lifecycle and is no longer recieving feature fixes or new functionality. Microsoft is providing [extended support](https://docs.microsoft.com/en-us/lifecycle/policies/fixed#extended-support) for [SharePoint 2013 until April 11, 2023.](https://docs.microsoft.com/en-us/lifecycle/products/?alpha=sharepoint%202013&products=office&terms=SharePoint%202013)

Microsoft previously notified customers via the [Microsoft Lifecycle website](https://docs.microsoft.com/en-us/lifecycle/) and the  [Product Servicing Policy for SharePoint 2013](https://docs.microsoft.com/en-gb/SharePoint/product-servicing-policy/updated-product-servicing-policy-for-sharepoint-2013) that the end of mainstream support was approaching. We will be updating these articles with details about the support extension and your upgrade and migration options.

Microsoft recommends that customers migrate to current product versions before the support end dates. This lets them take advantage of the latest product innovations and ensure uninterrupted support from Microsoft.

We encourage customers to evaluate transitioning to Office 365 with the help of their Microsoft representatives or technology partner.

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
