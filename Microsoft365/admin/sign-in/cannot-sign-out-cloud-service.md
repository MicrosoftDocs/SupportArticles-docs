---
title: Problems when signing out of Microsoft 365, Azure, or Intune in a web browser
description: Describes an issue in which users can't sign out of a Microsoft cloud service such as Microsoft 365, Microsoft Intune, or Azure in a web browser. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 10/20/2023
---

# Problems when signing out of Microsoft 365, Azure, or Intune in a web browser

## Problem

Users experience issues when they try to sign out of Microsoft 365, Microsoft Intune, or Microsoft Azure in a web browser. For example, users may experience one of the following issues:

- When a user signs out of one of the portals or signs out of Microsoft Outlook Web App, the user isn't signed out of Microsoft SharePoint Online.    
- When a user signs out of SharePoint Online, the user isn't signed out of the portal or Outlook Web App.    
- When a user clicks **Sign out**, the user isn't signed out. Instead, the web browser reloads the current webpage.   
- If your Microsoft account ends in the ".edu" domain extension and is managed by your university domain administrator, or if your Microsoft account was registered or is still registered in Microsoft 365, you may see one of the following messages:

    ```adoc
    Sorry, but we're having trouble signing you out"
    ```
    
    ```adoc
    We're having trouble signing you in
    
    We're currently signed in with a Microsoft account as <>, but that account can't be used with Outlook Web App.
    Please sign out of your Microsoft account, then sign in to Outlook Web App with the account you use to read your 
    organization's email. Click here to sign out. Learn more.   
    ``` 

## Solution

To resolve this issue, use one of the following methods.

### Method 1: Sign out and then sign in to [https://mail.office365.com](https://mail.office365.com/) to access your mailbox
  
If you're receiving the "We're having trouble signing you in" error message, see ["We're having trouble signing you in" message when you try to access your mail in Microsoft 365](https://support.microsoft.com/help/2912643). 

### Method 2: Close and reopen all web browsers
  
Close all web browsers and then reopen them.

To end the task for your browser, follow these steps: 
 
1. Right-click the taskbar, and then click **Task Manager**.    
2. Click the **Details** tab, and then do one of the following:  
     - If you're using Internet Explorer, find **iexplore.exe** in the list, right-click it, and then click **End task**.

       **Note** Make sure that you end the Iexplore.exe task. Don't end the Explore.exe task.    
     - If you're using Mozilla Firefox, find and right-click **firefox.exe** in the list, and then click **End task**.    
     - If you're using Apple Safari, find and right-click **safari.exe** in the list, and then click **End task**.    
     - If you're using Google Chrome, find and right-click **chrome.exe** in the list, and then click **End task**.    
 
    > [!NOTE]
    > - If more than one browser is listed, end the task for each browser.    
    > - If you're using a different browser than those that are listed here, end the task for that browser.    
    
### Method 3: Sign out of all Microsoft online services  
  
You may be signed in to another Microsoft online service, and it may be preventing you from signing out. If so, sign out of all Microsoft online services: 
 
1. Go to [https://login.microsoftonline.com/logout.srf](https://login.microsoftonline.com/logout.srf), and then sign out (if you aren't already signed out).    
2. Go to [https://login.live.com/logout.srf](https://login.live.com/logout.srf), and then sign out (if you aren't already signed out).    

### Method 4: Clear cookies from the web browser 
 
Clear cookies from the web browser, and then try signing out again. The steps for doing this vary, depending on the browser that you're using. For more information, see the following resources: 
 
- If you're using Internet Explorer, see [How to delete cookie files in Internet Explorer ](https://support.microsoft.com/help/278835).     
- If you're using Google Chrome, see [Manage your cookies and site data](https://support.google.com/chrome/answer/95647).    

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.     

## More information

This behavior is by design. Microsoft Entra ID-based services (including Microsoft 365, Azure, and Intune) use cookies to remember who you are and to automatically sign you in. 

The sign-out process for services forces the session cookies to expire. These session cookies are used to maintain your sign-in state when you use these services. However, because the web browser is still running and may not be updated to handle cookies correctly, you may have a cookie that isn't updated to expire and finish the sign-out process. By default, these cookies are valid for eight hours or are set to expire when you close all web browsers.

To prevent session cookies from inadvertently being re-used, it's recommended to close all browsers after signing out of any Microsoft 365 web application.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
