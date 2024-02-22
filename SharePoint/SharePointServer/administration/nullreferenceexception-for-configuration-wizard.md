---
title: NullReferenceException with SharePoint 2013 Products Configuration Wizard
description: Describes an issue in which you receive a NullReferenceException when there are comments in the web.config file of the SharePoint Web application.
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
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# NullReferenceException with Products Configuration Wizard  

## Symptoms  

You may experience the following issues:   

- When you use the SharePoint Products Configuration Wizard, it fails during task 8 and returns the following error message:  

   ```
   Failed to install the application content files.  
   This is a critical task. You have to fix the failures before you can continue.   
   An exception of type System.NullReferenceException was thrown. Additional exception information: Object reference not set to an instance of an object.   
   To diagnose the problem, review the application event log and the configuration log file located at:C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\LOGS\        
   ```

   And the following error is recorded in the PSCDiagnostics log file:

   ```       
   Exception: System.NullReferenceException: Object reference not set to an instance of an object.   
   at Microsoft.SharePoint.Administration.SPAspConfigurationFile.ApplyActionToXmlDocument(XmlDocument xdAction, XmlDocument xd, String sourceFileName, SupportedXmlDocutmentActions supportedActions)   
   at Microsoft.SharePoint.Administration.SPAspConfigurationFile.MergeWebConfig(XmlDocument xdWebConfig, String fileMask)   
   at Microsoft.SharePoint.Administration.SPWebService.ApplyApplicationContentToLocalServer()   
   at Microsoft.SharePoint.PostSetupConfiguration.ApplicationContentTask.Run()   
   at Microsoft.SharePoint.PostSetupConfiguration.TaskThread.ExecuteTask()
   ```

- When you use the SPWebService.ApplyApplicationContentToLocalServer method, you receive the following error message:  

   ```
   Message Title     
   Exception calling "ApplyApplicationContentToLocalServer" with "0" argument(s):   
   "Object reference not set to an instance of an object."   
   At line:1 char:1   
   + $webservice.ApplyApplicationContentToLocalServer()  
   + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   + CategoryInfo : NotSpecified: (:) [], MethodInvocationException
   + FullyQualifiedErrorId : NullReferenceException           
   ```

## Cause  

The issues occur because there are comments in the web.config file of the SharePoint Web application.   

## Resolution  

To resolve the issue, find and remove all comments from the web.config files for all SharePoint Web applications.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
