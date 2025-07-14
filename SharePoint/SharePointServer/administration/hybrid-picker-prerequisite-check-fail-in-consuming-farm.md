---
title: Hybrid Picker prerequisite check fail in SharePoint 2016 consuming farm
description: Describes an issue that Hybrid Picker prerequisite check fails in a SharePoint 2016 consuming farm that doesn't have its local User Profile service application.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Service Applications (except Search)
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# Hybrid Picker prerequisite check fail in a consuming farm  

## Symptom  

Consider the following scenario:   

- In a Microsoft SharePoint Server 2016 cross-farm environment, you have a publishing farm (farm P) and a consuming farm (farm C).    
- You publish a User Profile service application in farm P and consume it in farm C.    
- You run the Hybrid Picker wizard in farm C.      

In this scenario, the following prerequisite check fails:

```   
The SPO365LinkSettings cmdlet is accessible on the server.
```

**Note** You may continue with the Hybrid Picker wizard. However, the changes that are made by the SPO365LinkSettings cmdlet won't be configured.  

When you run the Get-SPO365LinkSettings cmdlet in SharePoint management shell, you receive the following error message:

```       
Get-SPO365LinkSettings : UserProfileApplicationNotAvailableException_Logging :: UserProfileApplicationProxy.UserProfileApplication has null upa  
 At line:1 char:1  
 + Get-SPO365LinkSettings  
 +~~~~~~~~~~~~~~~~  
 + CategoryInfo : InvalidData: (Microsoft.Offic...GetLinkSettings:SPO365GetLinkSettings) [Get-SPO365LinkSettings], UserProfileApplicationNotAvailableException  
 + FullyQualifiedErrorId : Microsoft.Office.Server.UserProfiles.Powershell.SPO365GetLinkSetttings       
```

## Cause  

The issue occurs because running Hybrid Picker from a consuming farm that consumes the User Profile service application from a publishing farm isn't supported yet.   

## More Information  

Microsoft is aware of this issue and will address it in a future update.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
