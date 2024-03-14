---
title: Feature ID not assigned when saving a list as a template
description: Provides a solution for the issue where Feature ID is not assigned when saving a list as a template.
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
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# Feature ID not assigned when saving a list as a template  

## Symptoms  

After saving a list as a template, the file created in the template gallery does not have a feature ID or product version associated with it. Also, when creating a new list dialog, the list template is not available as an option.  

## Cause  

This can be caused by having the 'ParserEnabled' property on the SPWeb set to 'false'.  

## Resolution  

Use PowerShell to enable the 'ParserEnabled' property for the web site:  

```
$web = Get-SPWeb <url of web>  
$web.ParserEnabled = $true  
$web.Update()  
```

## More Information  

[Document Property Promotion and Demotion](/previous-versions/office/developer/sharepoint-2010/aa543341(v=office.14))

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).