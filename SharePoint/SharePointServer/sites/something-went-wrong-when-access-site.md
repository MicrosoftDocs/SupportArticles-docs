---
title: Something went wrong when you access a SharePoint 2013 site
description: Describes an issue in which you receive a Sorry, something went wrong error message when you access a SharePoint 2013 website.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013 Service Pack 1
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# "Something went wrong" when you access a site  

## Symptoms  

When you try to access a Microsoft SharePoint 2013 website, you receive the following error message:    
    
**Sorry, something went wrong**  
**An unexpected error has occurred.**       

Also, the following error entry is logged in the ULS log:

```     
 Application error when access /, Error=Exception of type 'System.ArgumentException' was thrown.  Parameter name: encodedValue  
 at Microsoft.SharePoint.Administration.Claims.SPClaimEncodingManager.DecodeClaimFromFormsSuffix(String encodedValue)  
 at Microsoft.SharePoint.Administration.Claims.SPClaimProviderManager.GetProviderUserKey(IClaimsIdentity claimsIdentity, String encodedIdentityClaimSuffix)  
 at Microsoft.SharePoint.Administration.Claims.SPClaimProviderManager.GetProviderUserKey(String encodedIdentityClaimSuffix)  
 at Microsoft.SharePoint.Utilities.SPUtility.GetFullUserKeyFromLoginName(String loginName)  
 at Microsoft.SharePoint.ApplicationRuntime.SPHeaderManager.AddIsapiHeaders(HttpContext context, String encodedUrl, NameValueCollection headers)  
 at Microsoft.SharePoint.ApplicationRuntime.SPRequestModule.PreRequestExecuteAppHandler(Object oSender, EventArgs ea)  
 at System.Web.HttpApplication.SyncEventExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()  
 at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)     
```

## Cause  

This issue occurs if a Group Policy setting that is applied to the SharePoint server removes the IIS_IUSRS group from the **Impersonate a client after authentication** local security policy.   

## Resolution  

To fix the issue, follow these steps:   

1. On the SharePoint server, type **secpol.msc** in the **Run** dialog box, and then press **Enter** to open the **Local Security Policy** console.    
2. Under **Security Settings**, expand **Local Policies**, and then click **User Rights Assignment**.    
3. In the details pane, double-click **Impersonate a client after authentication**.    
4. Click **Add User or Group**, add **IIS_IUSRS**, and then click **OK** two times to close the dialog box.      

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
