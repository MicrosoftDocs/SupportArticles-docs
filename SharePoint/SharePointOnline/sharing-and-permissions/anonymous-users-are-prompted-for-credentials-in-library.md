---
title: Anonymous users are prompted for credentials in a SharePoint Online library
description: Anonymous users receives an authentication prompt when they try to access an asset in a Microsoft SharePoint Online library. Provides a resolution.
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
  - SharePoint Online
ms.date: 12/17/2023
---

# Anonymous users are prompted for credentials in a library  

## Symptoms  

When anonymous users try to access an asset in a Microsoft SharePoint Online style library, they receive an authentication prompt.

The following list includes the affected file name extensions that trigger the prompt:

```  
.gif, .jpg, .jpeg, .jpe, .jfif, .bmp, .dib, .tif, .tiff, .themedbmp, .themedcss, .themedgif, .themedjpg, .themedpng, .ico, .png, .wdp, .hdp, .css, .js, .asf, .avi, .flv, .m4v, .mov, .mp3, .mp4, .mpeg, .mpg, .rm, .rmvb, .wma, .wmv, .ogg, .ogv, .oga, .webm, .xap
```

## Cause  

Microsoft has changed the behavior of the "Everyone" claim. This claim no longer includes anonymous users in SharePoint Online.   

## Resolution  

If you use SharePoint Online to host assets in a custom solution, and people try to access those assets as anonymous users, we recommend that you use external Content Delivery Networks (CDNs) to host the assets.   

## More Information  

For more information about how to use CDNs in SharePoint Online, see the following articles:   
- [Using content delivery networks with SharePoint Online](https://support.office.com/en-us/article/Using-content-delivery-networks-with-SharePoint-Online-9a64268c-0b74-4eaa-b971-fb6380b1b165)    
- [Use the Microsoft 365 content delivery ntework with SharePoint Online](https://support.office.com/en-us/article/Use-the-Office-365-content-delivery-network-with-SharePoint-Online-BEBB285F-1D54-4F79-90A5-94985AFC6AF8)      

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
