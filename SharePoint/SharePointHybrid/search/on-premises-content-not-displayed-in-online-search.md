---
title: SharePoint on-premises content isn't displayed in SharePoint Online search results
description: Describes an issue in which SharePoint on-premises content isn't displayed as expected in a search. Provides a workaround.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Search\Syntex, Queries and Results
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Server 2016
  - SharePoint Server 2019
  - SharePoint Server Subscription Edition
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint on-premises content isn't displayed in SharePoint Online search results  

## Symptoms  

Consider the following scenario,  

- You configure _inbound hybrid_ Search to return results in SharePoint Online from a Microsoft SharePoint on-premises environment.
- When a user performs a search query from a SharePoint Online site, only results from the SharePoint Online sites are displayed. No results are returned from SharePoint on-premises, or the user even receives the following error message:  

  > **Sorry, something went wrong. (Search has encountered a problem that prevents results from being returned. If this issue persists, please contact your administrator)**
- An administrator edits the query rule associated with the result sources in SharePoint Online. Then, the administrator opens Query Builder from the result block. However, this triggers the following error:

```output
System.Net.WebException: The remote server returned an error: (401) Unauthorized.
   at System.Net.HttpWebRequest.GetResponse()
   at Microsoft.SharePoint.Client.SPWebRequestExecutor.Execute()
   at Microsoft.SharePoint.Client.ClientContext.GetFormDigestInfoPrivate()
   at Microsoft.SharePoint.Client.ClientContext.EnsureFormDigest()
   at Microsoft.SharePoint.Client.ClientContext.ExecuteQuery()
   at Microsoft.Office.Server.Search.RemoteSharepoint.RemoteSharepointEvaluator.RemoteSharepointProducer.RetrieveDataFromRemoteServer(Object unused)
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
   at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
   at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state)
   at Microsoft.Office.Server.Search.RemoteSharepoint.RemoteSharepointEvaluator.RemoteSharepointProducer.ProcessRecordCore(IRecord record)
```

## Workaround

To work around this issue, change your SharePoint on-premises identity provider. To do so, run the following cmdlet on your on-premises SharePoint farm:

```powershell
$config = Get-SPSecurityTokenServiceConfig  
$config.AuthenticationPipelineClaimMappingRules.AddIdentityProviderNameMappingRule("OrgId Rule", Microsoft.SharePoint.Administration.Claims.SPIdentityProviderTypes]::Forms, "membership", "urn:federation:microsoftonline")  
$config.Update()   
```

## More information  

In the scenario described in the "Symptoms" section, the following exception is logged in the Unified Logging Service (ULS) log of the on-premises SharePoint environment:

```output
w3wp.exe - SharePoint Portal Server - User Profiles - ae0sx - Unexpected - Error trying to search in the UPA.
The exception message is 'System.ArgumentException: Exception of type 'System.ArgumentException' was thrown. Parameter name: value
   at Microsoft.SharePoint.Administration.Claims.SPIdentityProviders.GetIdentityProviderType(String value)   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.SearchUsingNameIdOrThrow(UserProfileManager upManager, String nameId, String nameIdIssuer)
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetSingleUserProfileFromClaimsList(UserProfileManager upManager, IEnumerable`1 identityClaims)'  
   
w3wp.exe - SharePoint Portal Server - User Profiles - ae0su - High - The set of claims could not be mapped to a single user identity.
Exception Exception of type 'System.ArgumentException' was thrown. Parameter name: value has occured. 

w3wp.exe - SharePoint Foundation - Claims Authentication - ae0tc - High - The registered mappered failed to resolve to one identity claim.   
Exception: System.InvalidOperationException: Exception of type 'System.ArgumentException' was thrown. Parameter name: value
---> System.ArgumentException: Exception of type 'System.ArgumentException' was thrown. Parameter name: value
   at Microsoft.SharePoint.Administration.Claims.SPIdentityProviders.GetIdentityProviderType(String value)
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.SearchUsingNameIdOrThrow(UserProfileManager upManager, String nameId, String nameIdIssuer) 
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetSingleUserProfileFromClaimsList(UserProfileManager upManager, IEnumerable`1 identityClaims)   
   --- End of inner exception stack trace ---   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetSingleUserProfileFromClaimsList(UserProfileManager upManager, IEnumerable`1 identityClaims)   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.<>c__DisplayClass2.<GetMappedIdentityClaim>b__0()
   at Microsoft.SharePoint.SPSecurity.<>c__DisplayClass5.<RunWithElevatedPrivileges>b__3()   
   at Microsoft.SharePoint.Utilities.SecurityContext.RunAsProcess(CodeToRunElevated secureCode)   
   at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(WaitCallback secureCode, Object param)   
   at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(CodeToRunElevated secureCode)   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetMappedIdentityClaim(Uri context, IEnumerable`1 identityClaims) 
   at Microsoft.SharePoint.IdentityModel.SPIdentityClaimMapperOperations.GetClaimFromExternalMapper(Uri contextUri, List`1 claims)  
   
w3wp.exe - SharePoint Foundation - Claims Authentication - af3zp - Unexpected - STS Call Claims Saml: Problem getting output claims identity.   
Exception: 'System.InvalidOperationException: Exception of type 'System.ArgumentException' was thrown. Parameter name: value
---> System.ArgumentException: Exception of type 'System.ArgumentException' was thrown. Parameter name: value 
   at Microsoft.SharePoint.Administration.Claims.SPIdentityProviders.GetIdentityProviderType(String value)
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.SearchUsingNameIdOrThrow(UserProfileManager upManager, String nameId, String nameIdIssuer)   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetSingleUserProfileFromClaimsList(UserProfileManager upManager, IEnumerable`1 identityClaims)   
   --- End of inner exception stack trace ---   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetSingleUserProfileFromClaimsList(UserProfileManager upManager, IEnumerable`1 identityClaims)   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.<>c__DisplayClass2.<GetMappedIdentityClaim>b__0()
   at Microsoft.SharePoint.SPSecurity.<>c__DisplayClass5.<RunWithElevatedPrivileges>b__3()   
   at Microsoft.SharePoint.Utilities.SecurityContext.RunAsProcess(CodeToRunElevated secureCode)   
   at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(WaitCallback secureCode, Object param)   
   at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(CodeToRunElevated secureCode)   
   at Microsoft.Office.Server.Security.UserProfileIdentityClaimMapper.GetMappedIdentityClaim(Uri context, IEnumerable`1 identityClaims) 
   at Microsoft.SharePoint.IdentityModel.SPIdentityClaimMapperOperations.GetClaimFromExternalMapper(Uri contextUri, List`1 claims)
   at Microsoft.SharePoint.IdentityModel.SPIdentityClaimMapperOperations.ResolveUserIdentityClaim(Uri contextUri, ClaimCollection inputClaims)   
   at Microsoft.SharePoint.IdentityModel.SPIdentityClaimMapperOperations.GetIdentityClaim(Uri contextUri, ClaimCollection inputClaims, SPCallingIdentityType callerType) at Microsoft.SharePoint.IdentityModel.SPSecurityTokenService.GetLogonIdentityClaim(SPRequestInfo requestInfo, IClaimsIdentity inputIdentity, IClaimsIdentity outputIdentity, SPCallingIdentityType callerType)
   at Microsoft.SharePoint.IdentityModel.SPSecurityTokenService.EnsureSharePointClaims(SPRequestInfo requestInfo, IClaimsIdentity outputIdentity, SPCallingIdentityType callerType)
   at Microsoft.SharePoint.IdentityModel.SPSecurityTokenService.AugmentOutputIdentityForRequest(SPRequestInfo requestInfo, IClaimsIdentity outputIdentity)
   at Microsoft.SharePoint.IdentityModel.SPSecurityTokenService.GetOutputClaimsIdentity(IClaimsPrincipal principal, RequestSecurityToken request, Scope scope)'.   
```

For more information about how to configure hybrid search for SharePoint Server, see [SharePoint Server hybrid configuration roadmaps](/SharePoint/hybrid/configuration-roadmaps). 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
