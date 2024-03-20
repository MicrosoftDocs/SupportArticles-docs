---
title: SharePoint Online or OneDrive for Business access denied due to organizational policies error message
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:SharePoint Admin Center\Sharing Policies
  - CSSTroubleshoot
  - CI 125266
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
description: Describe a resolution to an (Access Denied due to organizational policies) error in SharePoint and OneDrive.
appliesto: 
  - SharePoint Online
  - OneDrive for Business
---

# (Access Denied due to organizational policies) error in SharePoint or OneDrive

## Symptoms

Users receive the following error message when they try to sign in to SharePoint or OneDrive:

> **Access Denied**<br/>
> Due to organizational policies, you can't access this resource from this **network location**.

## Cause

There are similar errors with different root causes, make sure that you check the following information before proceeding:

- If you're receiving an error message that states "Due to organizational policies, **you can't access this resource**" it may be due to [Information Barriers](/sharepoint/information-barriers).
- If you're receiving an error message that states "Due to organizational policies, you can't access this resource from this **untrusted device**" it may be due to an [Unmanaged Device Policy](/sharepoint/control-access-from-unmanaged-devices).
- If you're receiving an error message that states "Due to organizational policies, you can't access this resource from this **network location**.", continue with the 
 [resolution](#resolution). 

## Resolution

To resolve this issue, try the following method, depending on your level of permissions.

### Non-administrators

If you receive this error message, contact your [Microsoft 365 Administrator](/microsoft-365/admin/add-users/about-admin-roles?view=o365-worldwide&preserve-view=true). 

### Administrators

> [!NOTE]
> This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet, or for Microsoft 365 Germany customers.

If you are an administrator, and you have locked yourself out of SharePoint and OneDrive because of a location-based policy, follow these steps to unlock the tenant:

1. Select **Run Tests**, which will populate the diagnostic in the Microsoft 365 Admin Center. 

    > [!div class="nextstepaction"]
    > [Run Tests: Access Denied due to Network Location](https://aka.ms/AccessDeniedDuetoNetworkLocation)

2. In the diagnostic form, select the SharePoint Online root URL and then select **Run Tests**.

    :::image type="content" source="media/access-denied-due-to-org-policies/diagnostic-form.png" alt-text="Screenshot of the diagnostic form in the Admin Center.":::
    
3. If the test detects that you have a network-based location policy set and you are currently locked out of your tenant, you can choose to disable the policy.

    :::image type="content" source="media/access-denied-due-to-org-policies/network-based-location-policy-enabled.png" alt-text="Screenshot of the test result, which shows you have a network-based location policy set.":::
 
## More information

For more information about location-based policies, see [Control access to SharePoint and OneDrive data based on network location](/sharepoint/control-access-based-on-network-location).
