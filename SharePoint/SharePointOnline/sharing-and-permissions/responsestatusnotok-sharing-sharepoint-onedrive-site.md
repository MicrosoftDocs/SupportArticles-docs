---
title: ResponseStatusNotOK when sharing a SharePoint or OneDrive site
description: Fix error ResponseStatusNotOK when users in your organization try to share a site with external users. This error is caused by restrictions in B2B collaboration settings.
manager: dcscontentpm
localization_priority: Normal
ms.date: 09/25/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 181471
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
  - OneDrive for Business
---
# Error: ResponseStatusNotOK when sharing a SharePoint or OneDrive site

## Symptoms

When users in your organization try to share a SharePoint or OneDrive site with external users, they receive one of the following error messages:

- Error: ResponseStatusNotOK, message: This invitation is blocked by cross-tenant access settings.
- At least one invitation failed. Error: ResponseStatusNotOK, message: Guest invitations not allowed for your company.

## Cause

These errors usually occur because of restrictions in the [B2B collaboration](/azure/active-directory/external-identities/what-is-b2b) settings in your organization.

## Resolution

To fix the issues, make sure that the settings that are appropriate for your organization’s needs are configured correctly for external and B2B collaboration:

- [External collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure)
- [Microsoft cloud settings](/azure/active-directory/external-identities/cross-cloud-settings)
- [Cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-settings-b2b-collaboration)
