---
title: Office files in SharePoint fail to open from an Office 2016 client
description: Can't open Office documents from SharePoint because of Network List Service is stopped and disabled.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
ms.reviewer: zakirh
search.appverid: 
- MET150
appliesto:
- Office 2016
---

# Office files in SharePoint fail to open from an Office 2016 client

## Symptoms

An error occurs when you try to open a Microsoft Office file from SharePoint by using an Office 2016 client, such as Word, Excel, or PowerPoint. You may receive one of the following error messages, depending on the version of Office or SharePoint and the method that's used to open the file: 
    
    There are network issues stopping us from opening your document. Please try again later.   
  
![network issues error stopping you from opening your document](./media/files-fail-to-open/network-issues-error.png)
     
    Cannot download the information you requested.  
   
![Cannot download the information error](./media/files-fail-to-open/cannot-download-the-information-error.png) 
    
    Sorry, we couldn’t open <DocumentLocation>    
 
![cannot open file location error](./media/files-fail-to-open/cannot-open-file-location-error.png)  
   
    Sorry, we can’t open <DocumentLocation> because the server isn’t responding.  
   
![cannot open file because the server isn’t responding error](./media/files-fail-to-open/server-is-not-responding-error.png)

Additionally, you may see one of the following error messages when you try to sign in Office. Or, if you have successfully signed in to Office, you may still see the error message in an Office application: 

    Account Error   
    There are problems with your account. To fix them, please sign in again.   

![Problems in your account error](./media/files-fail-to-open/problems-in-your-account-error.png)   

    Account Error   
    Sorry, we can’t get to your account right now. To fix this, please sign in again.  
   
![Cannot get to your account error](./media/files-fail-to-open/cannot-get-to-your-account-error.png)
   
    No Internet Connection   
    Connect to the Internet to add or manage services.
     
![No internet connection error](./media/files-fail-to-open/no-internet-connection-error.png) 
    
    This feature has been disabled by your administrator.
     
![Feature has been disabled](./media/files-fail-to-open/feature-has-been-disabled.png) 
    
    We are unable to connect right now. Please check your network and try again later.
     
![unable to connect error](./media/files-fail-to-open/unable-to-connect-error.png)
   
    No Internet Connection
    It looks like you are not connected to the Internet. You may not be able to access these folders until you go online.
     
![Cannot connect to Internet](./media/files-fail-to-open/cannot-connect-to-internet.png) 

## Cause

**Network List Service** is stopped and disabled on the client computer. 

## Resolution

Enable and start **Network List Service** on the client computer. To do this, follow these steps:  
 
1. Click Start, type "**services.msc**" (without quotation marks) in the Start Search box and press Enter.    
2. Double-click **Network List Service**.    
3. Right-click the service, and then click **Start**.    
