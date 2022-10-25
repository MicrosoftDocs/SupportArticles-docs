---
title: Errors when you rename a SharePoint domain
description: Explains error codes and messages that can happen, when you rename a SharePoint domain.
author: helenclu
ms.reviewer: PramodBalusu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.date: 11/1/2021
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

This article lists common error messages that you might encounter when you change a SharePoint domain. Based on the information in each message, you can determine why the SharePoint domain cannot be renamed and how to fix the error.

## Errors

<table>
<tr><th>Error code</th><th>Error message</th><th>Details</th><th>Solution</th></tr>
<tr><td>755</td><td>SPO Tenant Rename is already in progress.</td><td>Tenant rename is in progress. Can’t trigger a tenant rename until the first one completes.</td><td>Wait for current tenant rename to get completed.</td></tr>
<tr><td>756</td><td>An unexpected error occurred while trying to update the tenant URLs.</td><td>An unexpected run time error occurred when starting the Tenant rename job.</td><td>Retry the rename action after some time.</td></tr>
<tr><td>757</td><td>The domain name isn't valid.</td><td>Domain name isn’t in the list of the verified domains for the tenant.</td><td>Add a verified domain and start a rename using it.</td></tr>
<tr><td>758</td><td>The domain name isn't valid.</td><td>The domain name could either be null, empty; is longer than 48 characters; or contains a dash or special characters.</td><td>The domain name you’re trying to use is not in a valid format. The -DomainName parameter should only be the name portion of the domain. For example, if the domain is <i>fabrikam.onmicrosoft.com</i>, the parameter would be just <i>fabrikam</i>.</td></tr>
<tr><td>759</td><td>SharePoint Online Tenant Rename isn't supported for your tenant.</td><td>Tenant has a Microsoft Business Productivity Online Suite (BPOS) site and rename is not supported.<br/>These are sites that were created several years ago when SharePoint Online was still called Business Productivity Office Suite (BPOS).</td><td>BPOS sites and its configuration need to be removed, and scheduling of tenant rename can be attempted.<br/>Please submit a support request by selecting the following link:<a href ="https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20BPOS%20sites"> Rename a SharePoint Tenant with BPOS sites </a>.</td></tr>
<tr><td>760</td><td>A site at <i>[site URL]</i> already exists.</td><td>Both source and target sites are sites created with redirect templates which are not supported for rename. Template of the target site isn’t in the allowed templates (redirect site).</td><td>Remove target sites that have a redirect template and try to rename them again.</td></tr>
<tr><td>763</td><td>There are no sites to rename.</td><td>There are no sites to be renamed.</td><td>The tenant has no sites to be renamed.</td></tr>
<tr><td>768</td><td>SPO Tenant Rename can't be restarted because the current state is {0}.</td><td>Tenant rename job is either suspended, queued, or in progress.</td><td>Wait for the Tenant rename job to complete.</td></tr>
<tr><td>769</td><td>The domain name can't be the same as the current name.</td><td>Original and target domain are same.</td><td>Use a target domain name different from the original domain name.</td></tr>
<tr><td>770</td><td>SPO Tenant Rename is currently blocked.</td><td>Tenant rename is blocked because the server is busy.</td><td>Retry the rename action after some time.</td></tr>
<tr><td>771</td><td>SPO Tenant Rename is currently blocked.</td><td>Tenant rename is blocked as the tenant is undergoing a move.</td><td>Retry the rename action after some time.</td></tr>
<tr><td>772</td><td>Scheduled date/time must be 24 hours in the future.</td><td>Scheduled time is less than 24 hours from current time.</td><td>Provide schedule time greater than 24 hours and start the rename.</td></tr>
<tr><td>773</td><td>Not Implemented.</td><td>Tenant rename isn’t enabled for the customer.</td><td>Tenant rename is not enabled for this customer yet. Please wait for this feature to be implemented for your tenant.</td></tr>
<tr><td>775</td><td>The scheduled date/time must be within 30 days.</td><td>Scheduled time is greater than 30 days from the current time.</td><td>Provide schedule date/time less than 30 days and start the rename.</td></tr>
<tr><td>776</td><td>SPO Tenant Rename isn't supported for Multi-Geo tenants.</td><td>Multi-Geo tenants are not supported.</td><td>SPO Tenant renames currently can’t be scheduled for tenants that have or previously had Multi-Geo configured.</td></tr>
<tr><td>777</td><td>SPO Tenant Rename isn't supported for your tenant.</td><td>Tenant has a public site, so the Tenant rename is cancelled.</td><td>Public site on the tenant need to be removed, and scheduling of tenant rename can be attempted.<br/>Please submit a support request by selecting the following link:<a href ="https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20with%20Public%20site"> Rename a SharePoint Tenant with Public site </a> </td></tr>
<tr><td>779</td><td>Cannot schedule due to system maintenance.</td><td>Tenant rename can’t be scheduled due to maintenance events.</td><td>Retry the rename action after some time.</td></tr>
<tr><td>780</td><td>Cannot perform a rename as you exceed the maximum number of allowed Sites and OneDrives.</td><td>Too many sites in the tenant.</td><td>Tenant has more sites than are currently allowed.</td></tr>
<tr><td>781</td><td>Canceled by the system due to system maintenance.</td><td>Tenant rename cancelled because there is a maintenance event.</td><td>Retry the rename action after some time.</td></tr>
<tr><td>783</td><td>Your organization has already reached the allowed number of SPO tenant renames.</td><td>Tenant can be renamed only once and your organization has been renamed.</td><td>If you have a need for additional renames, please submit a support request by selecting the following link: <a href ="https://admin.microsoft.com/AdminPortal/?searchSolutions=Rename%20a%20SharePoint%20Tenant%20more%20than%20once"> Rename a SharePoint Tenant more than once </a>.</td></tr>
</table>

**Note** You might encounter different errors about individual site renames if they fail as part of the domain rename. For more information, see [Errors when you rename a SharePoint site address](https://support.microsoft.com/office/errors-when-you-rename-a-sharepoint-site-address-165b7c11-1325-4813-b160-ecbe87bc1a86).

## References

- [Frequently asked questions about SharePoint Domain renames](./domain-rename-faq.md)
- [Rename your SharePoint domain](/sharepoint/tenant-rename)
