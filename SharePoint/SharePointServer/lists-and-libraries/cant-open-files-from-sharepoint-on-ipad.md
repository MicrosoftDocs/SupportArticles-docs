---
title: Can't open Office files from SharePoint on an iPad
description: Describes an issue in which you are unable to open Office files from SharePoint 2010 on an iPad. Provides a solution.
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
appliesto: 
  - Word for iPad, iPhone and iPod touch
  - PowerPoint for iPad, iPhone and iPod touch
ms.date: 12/17/2023
---

# Unable to open Office files from SharePoint 2010 on an iPad

## Symptoms

When you try to open a Microsoft Office file such as Word, PowerPoint or Excel from a SharePoint 2010 Document Library on an iPad with Microsoft Office applications installed, the file will not open. Additionally, you will receive an error.

There is no SharePoint Foundation application available to open the app.

## Cause

There is an issue with SharePoint 2010. It is required a plugin or active X control to start client applications. The plugin or active X control is not allowed on the iOS platform.

SharePoint 2013 and SharePoint online, however, support protocol handlers that is the modern method for communicating with client apps. Therefore, when you open an Office file from SharePoint 2013 or SharePoint Online, the Office file can open with Office for iPad.

## Resolution

To resolve this issue, use one of the following solutions:

- Add a SharePoint place within an Office for iPad application that will connect to the SharePoint Document Library. Follow these steps:
   1. Open Office for iPad installed application such as Word, Excel, or PowerPoint.   
   2. Select Add a Place.   
  3. In the Add a Place window click SharePoint site URL.   
   4. Enter the URL or an Internet address of the SharePoint Document Library.
   5. Click Next.   
   6. Enter username and password when you are prompted.   

- Download a copy of an Office file. Follow these steps:   

   1. Go to the SharePoint Document Library.   
   2. Click on Download a copy.   

Note: The document will be displayed in the browser window with the option to select how to open in the appropriate application. When the file opens, it will be read-only with the option to edit and save.   

## More Information

This issue only occurs with SharePoint 2010.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
