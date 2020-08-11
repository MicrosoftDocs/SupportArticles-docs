---
title: SharePoint Online content isn't displayed in a SharePoint on-premises search
description: Describes an issue in which SharePoint Online content isn't displayed in a SharePoint on-premises search.
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
- SharePoint Server 2013
- SharePoint Online
---

# SharePoint Online content isn't displayed in a SharePoint on-premises search

## Problem

Consider the following scenario.

- You configure outbound Hybrid Search to return results from SharePoint Online in a SharePoint 2013 on-premises environment.

- When a user performs a query from a SharePoint 2013 on-premises site, only results from the SharePoint 2013 on-premises environment are displayed. No results are returned from SharePoint Online.

- An administrator edits the query rule that's associated with the result sources. Then, the administrator opens Query Builder from the result block. However, this triggers the following error:

  **1 3/4 System.Net.WebException: The request was aborted: The request was canceled. -->Microsoft.SharePoint.IdentityModel.OAuth2.SPOAuth2ErrorResponseException: The remote server returned an error: (404) Not Found. at Microsoft.SharePoint.IdentityModel.OAuth2.SPOAuth2Client.GetResponse(Uri stsurl, OAuth2AccessTokenRequest message) at Microsoft.SharePoint.IdentityModel.OAuth2.SPOAuth2Client.RequestOAuthToken(Uri stsUrl. OAuth2AccessTokenRequest request) at stslnfo, OAuth2EndpointIdentity endpointldentity) at Microsoft.SharePoint.IdentityModel.OAuth2.SPOAuth2SecurityTokenManager.GetRawBearerToken(String nameldentifier, SPSecurityTokenServiceConnectionInformation stslnfo.**

Additionally, the following exception is logged in the Unified Logging Service (ULS) log: 

```
An exception occurred during OAuth2 request to <url specific to your site>
The remote server returned an error: (404) Not Found.
at System.Net.HttpWebRequest.GetResponse()
at Microsoft.SharePoint.IdentityModel.OAuth2.SPOAuth2Client.GetResponse(Uri stsUrl,
OAuth2AccessTokenRequest message)
```

## Solution

To resolve this issue, determine whether the Search Service Application Proxy was deployed in partition mode. If it was, remove and then re-create the proxy without using partition mode.

**NOTES**

- Office 365 doesn't support incoming Hybrid Search queries when the on-premises Search Service Application Proxy is deployed in partitioned mode.

- Follow best operational practices and perform a backup before you follow these steps. For more information, go to [Back up Search service applications in SharePoint Server](https://docs.microsoft.com/SharePoint/administration/back-up-a-search-service-application).


To do this, follow these steps in the SharePoint Management Shell.

1. Obtain the ID of Search Service Application. To do this, run the following cmdlet:

   ```
   $ssa=Get-SPEnterpriseSearchServiceApplication
   ```

2. Obtain the ID of Search Service Application Proxy. To do this, run the following cmdlet:

   ```
   $ssaproxy=Get-SPServiceApplicationProxy –identity <guid>
   ```

   **NOTE** The service application proxy GUID is unique to every farm. Run the Get-SPServiceApplicationProxy cmdlet, and note the GUID of the search service applications proxy.

3. Review the $ssaproxy.properties results. The proxy should be listed as partitioned. If this is the case, go to step 4 to update the Proxy Properties.

4. Update the Proxy Properties. To do this, run the following cmdlet:

   ```
   $proxy = get-spenterprisesearchserviceapplicationproxy
   $proxy.Properties["Microsoft.Office.Server.Utilities.SPPartitionOptions"] = 0
   $proxy.Update()
   $ssa = get-spenterprisesearchserviceapplication
   $ssa.SetProperty("IgnoreTenantization",1)
   $ssa.Update()
   ```

   After you complete these steps, check whether the issue is resolved. Otherwise, go to step 5 to remove and re-create the proxy.

5. Remove Search Service Application Proxy. To do this, run the following cmdlet:

   ```
   Remove-SPServiceApplicationProxy $ssaproxy
   ```

6. Create a new Search Service Application Proxy. To do this, run the following cmdlet:

   ```
   New-SPEnterpriseSearchServiceApplicationProxy -SearchApplication $ssa -Name "Search Service Application Proxy"
   ```

After you follow these steps, the SharePoint 2013 on-premises search farm should start returning results from SharePoint Online.

## More information

For more information, go to [Understanding multi-tenancy in SharePoint Server 2013](https://docs.microsoft.com/SharePoint/administration/understanding-multi-tenancy).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
