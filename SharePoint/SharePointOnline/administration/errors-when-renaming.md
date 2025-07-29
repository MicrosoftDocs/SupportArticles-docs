---
title: Errors when you rename a SharePoint domain
description: Explains error codes and messages that can occur when you rename a SharePoint domain.
author: Cloud-Writer
ms.reviewer: PramodBalusu
ms.author: meerak
manager: dcscontentpm
ms.date: 07/24/2025
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Domain Rename\Other
  - CSSTroubleshoot
  - CI 158077
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
---

# Errors when you rename a SharePoint domain  

This article lists common error messages that you might receive when you change a Microsoft SharePoint Online (SPO) domain. By using the information in each message, you can determine why the SharePoint domain can't be renamed and how to fix the error.

## Errors

|Error code|Error message|Details|Solution|
|---|---|---|---|
|755|SPO Tenant Rename is already in progress.|Tenant renaming is in progress. You can't trigger a tenant renaming while another renaming process is running.|Wait for the current tenant renaming to finish.|
|756|An unexpected error occurred while trying to update the tenant URLs.|An unexpected run-time error occurred when you started the tenant renaming job.|Retry the renaming action after some time passes.|
|757|The domain name isn't valid.|The domain name isn't in the list of verified domains for the tenant.|Add a verified domain, and start a renaming by using the domain.|
|758|The domain name isn't valid.|The domain name could be null (empty), is longer than 48 characters, or contains a hyphen or special characters.|The domain name that you're trying to use isn't in a valid format. The `-DomainName` parameter should be only the name portion of the domain. For example, if the domain is `fabrikam.onmicrosoft.com`, the parameter would be only `fabrikam`.|
|759|SharePoint Online Tenant Rename isn't supported for your tenant.|The tenant has a Microsoft Business Productivity Online Suite (BPOS) site for which renaming isn't supported.<br/>These sites were created several years ago when SharePoint Online was named Business Productivity Office Suite (BPOS).|BPOS sites and its configuration must be removed before you can schedule tenant renaming.<br/>Submit a support request by selecting [Rename a SharePoint Tenant with BPOS sites](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20BPOS%20sites)|
|760|A site at [site URL] already exists.|Both the source and target sites are created by using redirect templates that aren't supported for renaming. The template of the target site isn't in the allowed templates (redirect site).|Remove target sites that have a redirect template, and then try again to rename them.|
|763|There are no sites to rename.|There are no sites to be renamed.|The tenant has no sites to be renamed.|
|768|SPO Tenant Rename can't be restarted because the current state is {0}.|The tenant renaming job is either suspended, queued, or in progress.|Wait for the tenant renaming job to finish.|
|769|The domain name can't be the same as the current name.|Original and target domain are the same.|Use a target domain name that's different from the original domain name.|
|770|SPO Tenant Rename is currently blocked.|Tenant renaming is blocked because the server is busy.|Retry the renaming action after some time passes.|
|771 1090 1091 1092 |SPO Tenant Rename is currently blocked.|Tenant renaming is blocked because the tenant is undergoing a move.|Retry the renaming action after some time passes.|
|772|Scheduled date/time must be 24 hours in the future.|Scheduled time is less than 24 hours from the current time.|Provide a schedule time that's equal to or greater than 24 hours from the current time, and then start the renaming.|
|773|Not Implemented.|Tenant renaming isn't enabled for the customer.|Tenant renaming isn't enabled yet for this customer. Wait for this feature to be implemented for your tenant.|
|775|The scheduled date/time must be within 30 days.|The scheduled time is greater than 30 days from the current time.|Provide a schedule date/time value that's 30 days or fewer from the current day, and then start the renaming.|
|776|SPO Tenant Rename isn't supported for Multi-Geo tenants.|Multi-Geo tenants aren't supported.|Tenant renaming currently can't be scheduled for tenants that have, or previously had, Multi-Geo configured.|
|777|SPO Tenant Rename isn't supported for your tenant.|The tenant has a public site, so the tenant renaming is canceled.|The public site on the tenant has to be removed before you can try to schedule the tenant renaming.<br/>Submit a support request by selecting [Rename a SharePoint Tenant with Public site](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20Public%20site)|
|779|Cannot schedule due to system maintenance.|Tenant renaming can't be scheduled because of maintenance events.|Retry the renaming action after some time passes.|
|780|Cannot perform a rename as you exceed the maximum number of allowed Sites and OneDrive.|There are too many sites in the tenant.|The tenant has more sites than is currently allowed.|
|781|Canceled by the system due to system maintenance.|Tenant renaming is canceled because a maintenance event is occurring.|Retry the renaming action after some time passes.|
|783|Your organization has already reached the allowed number of SPO tenant renames.|The tenant can be renamed only one time, and your organization has already been renamed.|If you have to do additional renaming, submit a support request by selecting [Rename a SharePoint Tenant more than once](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20more%20than%20once)|
|-1076|No applicable licenses found for this feature. Please check the documentation for more information.|SharePoint Advanced Management licenses are required. |Activate the [Syntex SharePoint Advanced Management ](/sharepoint/advanced-management#licensing) offering in your tenant.|
|-1077|There is no applicable tenant rename scheduled in your organization. |Tenant rename isn't scheduled. |Run the `Start-SPOTenantRename` cmdlet, and then try again.|
|-1078|Prioritizing sites cannot be performed since the tenant rename is in progress. |Prioritization isn't allowed when a rename is in progress.|None. |
|-1086| The limit on the number of prioritized sites has been reached. No further sites can be added unless some are removed first. |The 4,000-site limit for prioritization was reached.|Remove a site that was already prioritized, and then try again to prioritize the desired site. For more information, see [prioritizing sites](/sharepoint/change-your-sharepoint-domain-name#prioritizing-sites).|
|-1081|Prioritization for root sites is not supported. |Root sites can't be prioritized.|None.|
|-1082|The site is locked. Please unlock the site and try again.|A rename can't be done on a locked site. |[Unlock the site](/sharepoint/manage-lock-status).|
|-1080|The specified site does not exist. Please check the URL and try again.| The specified site doesn't exist. |Check whether the site exists, or whether there are any typos in the URL. |
|-15|This site URL is invalid. Please double-check your site URL.|The specified URL has an invalid format.|Check the format of the specified URL. |
|1095|The rename cannot be scheduled currently since alternate URLs exist in the tenant.| The tenant has alternate URLs configured for which renames aren't supported. These likely remain from earlier SharePoint on-premises implementations.| The alternate URLs must be removed before you try again to schedule a rename. Submit a support request by selecting [Rename a SharePoint Tenant with Alternate URLs](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20Alternate%20URLs).|
|1089|Max no. of allowed sites exceeded.|During a tenant rename, the maximum number of sites allowed by the standard rename has been exceeded.|For larger organizations, use [Advanced Tenant Rename](https://aka.ms/AdvancedTenantRename).|
|1104|Renames to older domains are not supported. Please try again with a different domain.| Renaming to a domain that has been used previously is not supported.|Use a new domain name.|

**Note:** You might encounter different errors about individual site renaming if the actions fail as part of the domain renaming. For more information, see [Errors when you rename a SharePoint site address](https://support.microsoft.com/office/errors-when-you-rename-a-sharepoint-site-address-165b7c11-1325-4813-b160-ecbe87bc1a86).

**Note for Tenant Renames for more than 100k sites**: The Start-SPOTenantRename cmdlet may timeout with the following message: _It looks like the command has timed out. Please do not retry at this time. Continue monitoring the status using `Get-SPOTenantRenameStatus`_." - In such scenarios please avoid retrying Start-SPOTenantRename. You can continue checking the status using Get-SPOTenantRenameStatus. Details of the Rename will be available in this cmdlet output once the scheduling goes through. If the status does not update after a couple of hours or you observe unexpected behavior, please reach out to Microsoft Support for assistance.

## References

- [Frequently asked questions about SharePoint Domain renames](domain-rename-faq.md)
- [Rename your SharePoint domain](/sharepoint/tenant-rename)
