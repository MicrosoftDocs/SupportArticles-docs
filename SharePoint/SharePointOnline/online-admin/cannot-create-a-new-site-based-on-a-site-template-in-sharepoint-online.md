---
title: Cannot create a new site based on a site template in SharePoint Online
description: Fix an issue in which you cannot create new site based on a site template in SharePoint Online due to issues with Authors and ID fields.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# Cannot create a new site based on a site template in SharePoint Online  

## Symptoms  

When you try to create a new site based on a site template in Microsoft SharePoint Online, you receive the following error message:

**The field specified with name Authors and ID {746bb255-b0f7-47d5-9a3e-1c8e52468420} is not accessible or does not exist.**

## Cause  

This issue occurs because of name conflicts with the **Authors** and **OriginalSourceUrl** fields in SharePoint code.   

## Status  

This issue is addressed by the Microsoft product team for sites and site templates when the conflicting fields are present.   

## Resolution  

To resolve this issue, you can use one of the following methods:

### Method 1 (recommended)  

Remove the invalid columns from the **Content Type** in the site where the source template is located, and then save the template again.

### Method 2  

Update the WSP file by running a CSOM script. Follow these steps:   

1. Download the site template (.wsp file) from the source site.    
2. Run the following CSOM script.   

  **Note** You must insert values for the** $siteUrl** and **$admin** parameters in the script.

  ```   
 [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client") [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime") **$siteUrl** = "https://contoso.sharepoint.com" **$admin** = "user@domain.com" $contentTypeId = "0x0101009D1CB255DA76424F860D91F20E6C4118" Write-host "Please input password for $admin" $securePass = read-host -AsSecureString [Microsoft.SharePoint.Client.ClientContext] $clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl) $clientContext.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($admin, $securePass) $contentType = $clientContext.Web.ContentTypes.GetById($contentTypeId) $clientContext.Load($contentType) $clientContext.ExecuteQuery() $contentType.Sealed = $false $contentType.Update($true) $clientContext.ExecuteQuery() $fieldLink = $contentType.FieldLinks.GetById("{746bb255-b0f7-47d5-9a3e-1c8e52468420}") $fieldLink.DeleteObject() $fieldLink = $contentType.FieldLinks.GetById("{8a8804d8-ad51-48ef-9acf-0df7b3cc7ef6}") $fieldLink.DeleteObject() $contentType.Update($true) $clientContext.ExecuteQuery() Write-Host "Done" -ForegroundColor Green   
 ```

3. Upload the updated .wsp file to the destination site.

## More Information  

### Hub sites and site designs   

Subsite creation from a template is possible but is not a recommended or supported method for site extensibility. We recommend that you use hub sites and site designs.  

[Hub sites](https://aka.ms/hubsites) enable you to connect/organize sites in a way similar to how subsites are associated to a root site.    

[Site designs](https://aka.ms/spsitedesigns/) are a new scripting construct to apply custom configurations to a site post-creation. Unlike a "save site as template" template, site designs are intended to be more flexible and explicit in the customizations that they apply. Site designs are also re-entrant so that they can better support future upgrade/update scenarios.    

Hub sites and site designs are available worldwide. For more information about site templates, see [Create and use site templates](https://support.office.com/en-us/article/create-and-use-site-templates-60371b0f-00e0-4c49-a844-34759ebdd989) and  [Planning your SharePoint hub sites](https://aka.ms/PlanningSPhubsites).
