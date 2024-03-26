---
title: 401 unauthorized error when using OAuth and SAML claims in SharePoint Server 2013
description: Discusses a 401 unauthorized error that occurs when you use OAuth and SAML claim types in a farm that has a version number earlier than the March 2016 cumulative update version of SharePoint 2013. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Authentication & User Profiles\Security Assertion Markup Language (SAML)-based claims
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# "401 unauthorized" error when using OAuth and SAML claims

## Symptoms  

Consider the following scenario:   

- You are using Security Assertions Markup Language (SAML) claim types that use Active Directory Federated Services (AD FS) as an authentication provider in your farm.   
- You are using the Role or GroupSID claim to grant permissions to users on Microsoft SharePoint 2013 sites in the farm.    
- Your farm version is earlier than version 15.0.4805.1000 (the March 2016 cumulative update).     

In this scenario, users who have the appropriate permissions assigned to them through the Role or GroupSID claim type receive "401 unauthorized" error messages when they use the OAuth  authentication method in cases such as the following:   
- Workflow Manager (SharePoint 2013 workflows)   
- Web Application Companion (WAC - Office Web Apps)   
- High Trust or Low Trust Provider Hosted Apps   
- Cross Farm Service Application Publishing/Consuming   
- Hybrid SharePoint 2013/SharePoint Online scenarios   
- SharePoint Integration with Exchange and Lync 2013/Skype for Business     

## Resolution  

To resolve this problem, install the [March 2016 Cumulative Update for Microsoft SharePoint Server ](https://support.microsoft.com/help/3114827) on all servers in the farm.   

As part of the fix, a new property, GroupClaimType, is added to the SPTrustedIdentityTokenIssuer object. For OAuth  to be able to work correctly, this property must be set to the correct claim type for authorization for users who are assigned permissions through the Role or GroupSID claim type.

To set the GroupClaimType  property, run the following Windows PowerShell commands:  

```
#Create a variable containing the SPTrustedIdentityTokenIssuer object  
$issuer = Get-SPTrustedIdentityTokenIssuer  

#Set the GroupClaimType property to the Role claim type, do not run for GroupSID claim type  
$issuer.GroupClaimType = [Microsoft.IdentityModel.Claims.ClaimTypes]::Role   

#Set the GroupClaimType property to the GroupSID claim type, do not run for Role claim type  
$issuer.GroupClaimType = [Microsoft.IdentityModel.Claims.ClaimTypes]::GroupSid  

#Update the SPTrustedIdenityTokenIssuer object to apply the change   
$issuer.Update()   
```

## More Information  

Example error message from a failed workflow:  

```
RequestorId: <Requestor ID>. Details: System.ApplicationException: HTTP 401 {"error":{"code":"-2147024891, System.UnauthorizedAccessException","message":{"lang":"en-US","value":"Access denied. You do not have permission to perform this action or access this resource."}} } {"Transfer-Encoding":["chunked"],"X-SharePointHealthScore":["0"],"SPRequestGuid":["<SP Request GUID>"],"request-id":["<Request ID>"],"X-FRAME-OPTIONS":["SAMEORIGIN"],"MicrosoftSharePointTeamServices":["15.0.0.4805"],"X-Content-Type-Options":["nosniff"],"X-MS-InvokeApp":["1; RequireReadOnly"],"Cache-Control":["max-age=0, private"],"Date":["Fri, 19 Aug 2016 20:35:30 GMT"],"Server":["Microsoft-IIS\/8.0"],"WWW-Authenticate":["NTLM"],"X-AspNet-Version":["4.0.30319"],"X-Powered-By":["ASP.NET"]} at Microsoft.Activities.Hosting.Runtime.Subroutine.SubroutineChild.Execute(CodeActivityContext context) at System.Activities.CodeActivity.InternalExecute(ActivityInstance instance, ActivityExecutor executor, BookmarkManager bookmarkManager) at System.Activities.Runtime.ActivityExecutor.ExecuteActivityWorkItem.ExecuteBody(ActivityExecutor executor, BookmarkManager bookmarkManager, Location resultLocation)
```

Example log entries in the Unified Logging System (ULS) logs:  

```
15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Foundation CSOM aii1c Verbose Checking   
SPBasePermissions.Open permission  

15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Foundation Authentication Authorization ajmmu   
Medium Permission check failed. asking for 0x10000, have 0x2000000000 645f0edc-7ec9-44c5-84b7-  
2adfba2f7f92  

15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Foundation CSOM afxwb High  
System.UnauthorizedAccessException: Attempted to perform an unauthorized operation. at   
Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex) at   
Microsoft.SharePoint.SPSecurableObject.CheckPermissions(SPBasePermissions permissionMask) at   
Microsoft.SharePoint.Client.SPClientServiceHost.OnBeginRequest() at   
Microsoft.SharePoint.Client.Rest.RestService.ProcessQuery(Stream inputStream, IList`1   
pendingDisposableContainer)  

15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Foundation CSOM agmjp High Original error:  
System.UnauthorizedAccessException: Attempted to perform an unauthorized operation. at   
Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex) at   
Microsoft.SharePoint.SPSecurableObject.CheckPermissions(SPBasePermissions permissionMask) at   
Microsoft.SharePoint.Client.SPClientServiceHost.OnBeginRequest() at   
Microsoft.SharePoint.Client.Rest.RestService.ProcessQuery(Stream inputStream, IList`1   
pendingDisposableContainer)   

15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Portal Server Microfeeds aizmo Medium   
SocialRESTExceptionProcessingHandler.DoServerExceptionProcessing - SharePoint Server Exception   
[System.UnauthorizedAccessException: Attempted to perform an unauthorized operation. at   
Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex) at   
Microsoft.SharePoint.SPSecurableObject.CheckPermissions(SPBasePermissions permissionMask) at   
Microsoft.SharePoint.Client.SPClientServiceHost.OnBeginRequest() at   
Microsoft.SharePoint.Client.Rest.RestService.ProcessQuery(Stream inputStream, IList`1   
pendingDisposableContainer)] 645f0edc-7ec9-44c5-84b7-2adfba2f7f92  

15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Foundation Claims Authentication af32v Verbose   
Claims Windows Sign-In: Sending 401 for request  
'http://<;servername>;:30079/_vti_bin/client.svc/web/lists/getbyid(guid'<GUID>')' because the request is not from a browser.   

15:54:30.25 w3wp.exe (0x9FCC) 0x5F78 SharePoint Foundation Authentication Authorization alkvd   
Medium Throw UnauthorizedAccessException instead of SPUtilityInternal.Send401 for client.svc request.      
```

## Status  

Microsoft has confirmed that this is a problem in the SharePoint farm versions that are earlier than the March 2016 cumulative update (v. 15.0.4805.1000).  

## References  

[SharePoint Updates](/officeupdates/sharepoint-updates)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
