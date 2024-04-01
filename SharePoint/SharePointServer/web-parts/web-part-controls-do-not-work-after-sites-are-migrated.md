---
title: Web part controls don't work after sites are migrated to SharePoint 2016
description: Describes an issue that causes SharePoint 2013 web part controls to stop working once you've migrated to SharePoint 2016. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:User experience\Webpart infrastructure
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Web part controls don't work after sites are migrated to SharePoint Server 2016  

## Symptoms  

After you migrate the sites on Microsoft SharePoint Server 2013 to SharePoint Server 2016, the following web part controls no longer work on the migrated sites:  

- SpListFilterWebPart   
- ExcelWebRenderer   
- ReportViewerWebpart     

## Cause  

These web part controls were replaced by new versions in SharePoint Server 2016.  

## Resolution  

To resolve this issue, use one of the following methods.  

### Method 1  

Delete the web part controls and then reinsert them.  

### Method 2 Mark the web part controls as safe controls  

To do this, add the following entries in the web.config file for the migrated Web Apps.

**SpListFilterWebPart**

Add the following entry to the **SafeControls** section:  

```
<SafeControl Assembly="Microsoft.SharePoint.Portal, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" Namespace="Microsoft.SharePoint.Portal.WebControls" TypeName="SpListFilterWebPart" Safe="True" />   
```

**ExcelWebRenderer**

Add the following entry to the **assemblyBinding** section of the web.config file:  

```
<dependentAssembly>   
 <assemblyIdentity name="Microsoft.Office.Excel.WebUI" publicKeyToken="71e9bce111e9429c" />   
 <!-- Assembly versions can be redirected in application, publisher policy, or machine configuration files. -->   
 <bindingRedirect oldVersion="15.0.0.0" newVersion="16.0.0.0"/>   
 </dependentAssembly>   
```

**ReportViewerWebPart**

Add the following entry to the **SafeControls** section:  

```
<SafeControl Assembly="Microsoft.ReportingServices.SharePoint.UI.WebParts, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.ReportingServices.SharePoint.UI.WebParts" TypeName="*" Safe="True" />
```

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
