---
title: Feature id not assigned when saving a list as a template
description: Provides a solution for the issue where Feature id is not assigned when saving a list as a template.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft SharePoint
---

# Feature id not assigned when saving a list as a template  

## Symptoms  

After saving a list as a template, the file created in the template gallery does not have a feature ID or product version associated with it. Also, when using the create new list dialog, the list template is not available as an option.  

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

[Document Property Promotion and Demotion](https://msdn.microsoft.com/library/aa543341.aspx)
