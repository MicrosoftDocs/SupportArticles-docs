---
title: System.ArgumentException exception when you sign out of a SharePoint 2013 web application
description: Fixes an issue that occurs if a SharePoint 2013 web application is configured by multiple authentication providers.
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
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# System.ArgumentException exception when you sign out of a web application  

## Symptoms  

When you sign out of a SharePoint 2013 web application that is configured by multiple authentication providers (for example, Windows Claims and FBA Claims authentication providers), the following call-stack exception message is displayed on an exception page:

```
Exception of type 'System.ArgumentException' was thrown. Parameter name: encodedValue at  
Microsoft.SharePoint.Administration.Claims.SPClaimEncodingManager.DecodeClaimFromFormsSuffix(System.String)  
Microsoft.SharePoint.Administration.Claims.SPClaimProviderManager.GetProviderUserKey(Microsoft.IdentityModel.Claims.IClaimsIdentity, System.String)  
Microsoft.SharePoint.Administration.Claims.SPClaimProviderManager.GetProviderUserKey(System.String)  
Microsoft.SharePoint.Utilities.SPUtility.GetFullUserKeyFromLoginName(System.String)  
Microsoft.SharePoint.ApplicationRuntime.SPHeaderManager.AddIsapiHeaders(System.Web.HttpContext, System.String, System.Collections.Specialized.NameValueCollection)  
Microsoft.SharePoint.ApplicationRuntime.SPRequestModule.PreRequestExecuteAppHandler(System.Object, System.EventArgs)  
```

## Cause  

This issue occurs because an invalid user context is left in the IIS cache.  

## Resolution  

To resolve this issue, replace the **Sign Out**  link with the **Sign-in As Different User**  link for all web front end-servers on the SharePoint farm by following these steps:  

1. In the following folder, open the welcome.ascx file in a text editor such as notepad: 

   ```
   C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\CONTROLTEMPLATES
   ```   

2. Replace the old text with the new text as follows:  
   **Old text**  

   ```  
   <SharePoint:MenuItemTemplate runat="server" id="ID_Logout"  
   Text="<%$Resources:wss,personalactions_logout%>"  
   Description="<%$Resources:wss,personalactions_logoutdescription%>"  
   MenuGroupId="100"  
   Sequence="400"  
   UseShortId="true"  
   />  
   ```  
   **New text**

   ```  
   <SharePoint:MenuItemTemplate runat="server" ID="ID_LoginAsDifferentUser"  
   Text="<%$Resources:wss,personalactions_loginasdifferentuser%>"   
   Description="<%$Resources:wss,personalactions_loginasdifferentuserdescription%>"   
   MenuGroupId="100"   
   Sequence="400"   
   UseShortId="true"   
   />  
   ```  

   **Note** The text and description attributes are changed to mimic the logoff button.     

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
