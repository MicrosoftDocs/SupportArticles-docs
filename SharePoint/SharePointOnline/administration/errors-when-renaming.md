---
title: Errors when you rename a SharePoint domain
description: Explains error codes and messages that can happen, when you rename a SharePoint domain.
author: helenclu
ms.reviewer: PramodBalusu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 158077
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
---

# Errors when you rename a SharePoint domain  

This article lists common error messages that you might encounter when you change a SharePoint domain. Based on the information in each message, you can determine why the SharePoint domain can't be renamed and how to fix the error.

## Errors

|Error code|Error message|Details|Solution|
|---|---|---|---|
|755|SPO Tenant Rename is already in progress.|Tenant renaming is in progress. Can't trigger a tenant renaming until the first one completes.|Wait for the current tenant renaming to be completed.|
|756|An unexpected error occurred while trying to update the tenant URLs.|An unexpected run time error occurred when starting the tenant renaming job.|Retry the renaming action after some time.|
|757|The domain name isn't valid.|The domain name isn't in the list of the verified domains for the tenant.|Add a verified domain and start a renaming using the domain.|
|758|The domain name isn't valid.|The domain name could either be null, empty; is longer than 48 characters; or contains a dash or special characters.|The domain name you're trying to use isn't in a valid format. The `-DomainName` parameter should only be the name portion of the domain. For example, if the domain is `fabrikam.onmicrosoft.com`, the parameter would be just `fabrikam`.|
|759|SharePoint Online Tenant Rename isn't supported for your tenant.|The tenant has a Microsoft Business Productivity Online Suite (BPOS) site and renaming isn't supported.<br/>These sites were created several years ago when SharePoint Online was still called Business Productivity Office Suite (BPOS).|BPOS sites and its configuration need to be removed before scheduling of tenant renaming can be attempted.<br/>Submit a support request by selecting [Rename a SharePoint Tenant with BPOS sites](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20BPOS%20sites)|
|760|A site at [site URL] already exists.|Both source and target sites are sites created with redirect templates which aren't supported for renaming. Template of the target site isn't in the allowed templates (redirect site).|Remove target sites that have a redirect template and try to rename them again.|
|763|There are no sites to rename.|There are no sites to be renamed.|The tenant has no sites to be renamed.|
|768|SPO Tenant Rename can't be restarted because the current state is {0}.|The tenant renaming job is either suspended, queued, or in progress.|Wait for the tenant renaming job to complete.|
|769|The domain name can't be the same as the current name.|Original and target domain are same.|Use a target domain name different from the original domain name.|
|770|SPO Tenant Rename is currently blocked.|Tenant renaming is blocked because the server is busy.|Retry the renaming action after some time.|
|771|SPO Tenant Rename is currently blocked.|Tenant renaming is blocked as the tenant is undergoing a move.|Retry the renaming action after some time.|
|772|Scheduled date/time must be 24 hours in the future.|Scheduled time is less than 24 hours from current time.|Provide schedule time greater than 24 hours and start the renaming.|
|773|Not Implemented.|Tenant renaming isn't enabled for the customer.|Tenant renaming isn't enabled for this customer yet. Wait for this feature to be implemented for your tenant.|
|775|The scheduled date/time must be within 30 days.|Scheduled time is greater than 30 days from the current time.|Provide schedule date/time less than 30 days and start the renaming.|
|776|SPO Tenant Rename isn't supported for Multi-Geo tenants.|Multi-Geo tenants aren't supported.|Tenant renaming currently can't be scheduled for tenants that have or previously had Multi-Geo configured.|
|777|SPO Tenant Rename isn't supported for your tenant.|The tenant has a public site, so the tenant renaming is cancelled.|Public site on the tenant need to be removed before scheduling of tenant renaming can be attempted.<br/>Submit a support request by selecting [Rename a SharePoint Tenant with Public site](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20Public%20site)|
|779|Cannot schedule due to system maintenance.|Tenant renaming can't be scheduled due to maintenance events.|Retry the renaming action after some time.|
|780|Cannot perform a rename as you exceed the maximum number of allowed Sites and OneDrives.|Too many sites in the tenant.|Tenant has more sites than are currently allowed.|
|781|Canceled by the system due to system maintenance.|Tenant renaming is cancelled because there's a maintenance event.|Retry the renaming action after some time.|
|783|Your organization has already reached the allowed number of SPO tenant renames.|Tenant can be renamed only once and your organization has been renamed.|If you need more renaming, submit a support request by selecting [Rename a SharePoint Tenant more than once](https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20more%20than%20once)|

**Note** You might encounter different errors about individual site renamings if they fail as part of the domain renaming. For more information, see [Errors when you rename a SharePoint site address](https://support.microsoft.com/office/errors-when-you-rename-a-sharepoint-site-address-165b7c11-1325-4813-b160-ecbe87bc1a86).

## References

- [Frequently asked questions about SharePoint Domain renames](domain-rename-faq.md)
- [Rename your SharePoint domain](/sharepoint/tenant-rename)
