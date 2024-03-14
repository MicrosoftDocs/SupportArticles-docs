---
title: Your session has expired in Office Online
description: If you begin IP address enforcement for OneDrive for Business, you'll receive a Your session has expired error in Office Online after 15 minutes.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Office apps for the web
ms.date: 03/31/2022
---

# "Your session has expired" error message in Office Online

## Symptoms

Users receive a "Your session has expired" error message in Microsoft Office Online after 15 minutes.This error may occur when they do one or more of the following actions: 
 
- Locate a document library in Microsoft Edge    
- Open documents from OneDrive for Business or SharePoint Online libraries in Office    
- Open documents from OneDrive for Business or SharePoint Online libraries in Office Online    

## Cause

If you're a tenant administrator and you begin IP address enforcement for OneDrive for Business in Microsoft 365, this enforcement automatically activates a tenant parameter that's called **IPAddressWACTokenLifetime**. The default value of the **IPAddressWACTokenLifetime** parameter is 15 minutes.  
You can determine whether you're using IP address enforcement in the following two ways:  

- See whether the **Allow access only from specific IP address locations** check box is selected in your OneDrive admin portal ([https://admin.onedrive.com/?v=AccessPolicySettings](https://admin.onedrive.com/?v=AccessPolicySettings)).    
- Check if the **IPAddressEnforcement** parameter value is set to **True**. To do this, follow these steps:   
  1. Download and install [SharePoint Online Management Shell](https://www.microsoft.com/download/details.aspx?id=35588).     
  1. In the SharePoint Online Management Shell module, connect to the SharePoint Online admin center by using the [Connect-SPOService](/powershell/module/sharepoint-online/connect-sposervice) cmdlet. For example, run the following cmdlet: 

        ```powershell
        Connect-SPOService -URL https://contoso-admin.sharepoint.com
        ```
  1. Run the following cmdlet to check the **IPAddressEnforcement** parameter:

     ```powershell
     Get-SPOTenant | fl
     ```

## Resolution

To resolve this issue, change the **IPAddressWACTokenLifetime** parameter value through the SharePoint Online PowerShell module to extend the lifetime of the token. To do this, run the following cmdlet.

> [!NOTE]
> The **IPAddressWACTokenLifetime** parameter is valued in minutes.  

```powershell
Set-SPOTenant -IPAddressWACTokenLifetime <integer value in minutes that's greater than 15> 
```

For example:

```powershell
Set-SPOTenant -IPAddressWACTokenLifetime 20 
```

For more information, see the following articles:  

- [Set-SPOTenant](/powershell/module/sharepoint-online/set-spotenant)    
- [Manage SharePoint Online with Microsoft 365 PowerShell](/office365/enterprise/powershell/manage-sharepoint-online-with-office-365-powershell)    

## More Information

After you authenticate any application in SharePoint Online, the application is issued an access token. In a default setup, any access token that's issued by SharePoint Online is valid for about 8 hours. This behavior minimizes users getting prompted for credentials during a usual workday because of tokens expiring.

When you use IP address enforcement, it directs SharePoint Online to greatly reduce the time-out of the tokens that are issued to Office Online specifically.