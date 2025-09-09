---
title: Office files in SharePoint fail to open from an Office 2016 client
description: Can't open Office documents from SharePoint because of Network List Service is stopped and disabled.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
ms.reviewer: zakirh
search.appverid: 
  - MET150
appliesto: 
  - Office 2016
ms.date: 06/06/2024
---

# Office files in SharePoint fail to open from an Office 2016 client

## Symptoms

An error occurs when you try to open a Microsoft Office file from SharePoint by using an Office 2016 client, such as Word, Excel, or PowerPoint. You may receive one of the following error messages, depending on the version of Office or SharePoint and the method that's used to open the file:

> There are network issues stopping us from opening your document. Please try again later.   
  
:::image type="content" source="media/files-fail-to-open/network-issues-error.png" alt-text="Screenshot of the error message, showing there're network issues stopping us from opening your document." border="false":::

> Cannot download the information you requested.  

:::image type="content" source="media/files-fail-to-open/cannot-download-the-information-error.png" alt-text="Screenshot of the error message, showing can't download the information you requested." border="false":::

> Sorry, we couldn't open \<DocumentLocation> 
 
:::image type="content" source="media/files-fail-to-open/cannot-open-file-location-error.png" alt-text="Screenshot of the error message, showing couldn't open the Document Location." border="false":::  
   
> Sorry, we can't open \<DocumentLocation> because the server isn't responding.  
   
:::image type="content" source="media/files-fail-to-open/server-is-not-responding-error.png" alt-text="Screenshot of the error message, showing can't open the Document Location because the server isn't responding." border="false":::

Additionally, you may see one of the following error messages when you try to sign in Office. Or, if you have successfully signed in to Office, you may still see the error message in an Office application:

> Account Error  
> There are problems with your account. To fix them, please sign in again.

:::image type="content" source="media/files-fail-to-open/problems-in-your-account-error.png" alt-text="Screenshot of the error message, showing there're problems with your account." border="false":::

> Account Error  
> Sorry, we can't get to your account right now. To fix this, please sign in again.  
   
:::image type="content" source="media/files-fail-to-open/cannot-get-to-your-account-error.png" alt-text="Screenshot of the error message, showing we can't get to your account right now." border="false":::
   
> No Internet Connection  
> Connect to the Internet to add or manage services.

:::image type="content" source="media/files-fail-to-open/no-internet-connection-error.png" alt-text="Screenshot of the error message, showing no Internet Connection." border="false":::
    
> This feature has been disabled by your administrator.
     
:::image type="content" source="media/files-fail-to-open/feature-has-been-disabled.png" alt-text="Screenshot of the error message, showing this feature has been disabled by your administrator." border="false":::
    
> We are unable to connect right now. Please check your network and try again later.
     
:::image type="content" source="media/files-fail-to-open/unable-to-connect-error.png" alt-text="Screenshot of the error message, showing we are unable to connect right now." border="false":::
   
> No Internet Connection  
> It looks like you are not connected to the Internet. You may not be able to access these folders until you go online.

:::image type="content" source="media/files-fail-to-open/cannot-connect-to-internet.png" alt-text="Screenshot of the error message, showing you may not be able to access these folders until you go online." border="false":::

## Cause

**Network List Service** is stopped and disabled on the client computer. 

## Resolution

Enable and start **Network List Service** on the client computer. To do this, follow these steps:  
 
1. Click Start, type "**services.msc**" (without quotation marks) in the Start Search box and press Enter.    
2. Double-click **Network List Service**.    
3. Right-click the service, and then click **Start**.
