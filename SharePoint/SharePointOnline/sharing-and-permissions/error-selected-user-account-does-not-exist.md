---
title: New guests can't access a SharePoint resource
description: Fix the Selected user account does not exist error when new guests access a SharePoint site, list, or library.
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Sharing with external
  - CSSTroubleshoot
  - CI 183016
search.appverid: 
  - SPO160
  - MET150
---
# Error "Selected user account does not exist" when new guests access a SharePoint resource

## Symptoms

Consider the following scenario:

- Your organization uses Microsoft Entra Conditional Access policies for access control. For example, users are [required to accept terms of use](/azure/active-directory/conditional-access/require-tou), or [guests are required to use MFA](/azure/active-directory/conditional-access/howto-policy-guest-mfa).
- A user in your organization [shares a SharePoint site](https://support.microsoft.com/office/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658), [a list, or a library](https://support.microsoft.com/office/customize-permissions-for-a-sharepoint-list-or-library-02d770f3-59eb-4910-a608-5f84cc297782) with a new guest through the **Permissions** page.

In this scenario, when guests try to access the resource by signing in by using their credentials, they receive the following error message:

> Selected user account does not exist in tenant '\<tenant name\>' and cannot access the application '\<application GUID\>' in that tenant. The account needs to be added as an external user in the tenant first. Please use a different account.

## Cause

This issue is caused by changes in SharePoint sharing invitation redemption for guests. Because of these changes, when a site, list, or library is shared with guests, the guest account isn't provisioned in Microsoft Entra ID. Therefore, guest access to the resource is blocked by the Conditional Access policies.

## Resolution

To fix this issue, use one of the following methods:

- **Method 1**

  [Enable Microsoft SharePoint integration with Microsoft Entra B2B](/sharepoint/sharepoint-azureb2b-integration)
- **Method 2**

  [Add the guest user to your directory](/azure/role-based-access-control/role-assignments-external-users#add-a-guest-user-to-your-directory)

## More information

Microsoft is updating the SharePoint Online sharing back-end process to use Azure B2B Invitation Manager instead of the legacy SharePoint Invitation Manager. After the changes are completed, this issue will no longer occur.
