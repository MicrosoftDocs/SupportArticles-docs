---
title: Authorization_RequestDenied error message when you try to change a password if you use Graph API
description: Discusses an Authorization_RequestDenied error message that you receive when you try to change a password if you use Graph API. Provides a resolution.
ms.date: 07/20/2020
ms.reviewer: willfid, maxv, nmanis
ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Authorization_RequestDenied error when you try to change a password using Graph API

This article provides information about troubleshooting a problem in which you receive Authorization_RequestDenied error when trying to change a password using Graph API.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3004133

## Symptoms

You try to change the password of a Microsoft Entra user. If the **Organizational Role** setting for that user is set to any "Administrator" option, the process fails. It generates the following error message:

> {"odata.error":{"code":"Authorization_RequestDenied","message":{"lang":"en","value":"Insufficient privileges to complete the operation." }} }

When you give the **Read and write directory data** permission to your application or Application Service Principal, the application can change the password of a typical Microsoft Entra user by using Graph API. This setting is shown in the following screenshot.

:::image type="content" source="media/authorization-request-denied-graph-api/application-permission.png" alt-text="Screenshot of the application permissions filed where Read and write directory data permission is selected.":::

You can delegate a Microsoft Entra user as an administrator by changing the user's **Organizational Role** setting, as shown in the following screenshot.

:::image type="content" source="media/authorization-request-denied-graph-api/organizational-role.png" alt-text="Screenshot shows the Organizational Role option is set to User.":::

## Cause

This problem occurs because the users who have any of the **Administrator** organizational roles aren't members of **Company Administrator** or **User Account Administrator** in the Office 365 administrative roles.

## Resolution

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

To resolve this problem, add your application to **Company Administrator** in the Office 365 administrative roles. To do so, run all the following Azure AD module for Windows PowerShell (MSOL) cmdlets:

 ```powershell
 Connect-MsolService
 ```

 It will prompt you for your tenant's credential. You should be able to use your Microsoft Entra administrative user name in the `admin@tenant.onmicrosoft.com` format.

```powershell
$displayName = "Application Name" 
$objectId = (Get-MsolServicePrincipal -SearchString $displayName).ObjectId
```

Replace the "Application Name" with the name of your "Application Service Principal".

```powershell
$roleName = "Company Administrator"
Add-MsolRoleMember -RoleName $roleName -RoleMemberType ServicePrincipal -RoleMemberObjectId $objectId
```

It will add your "Application Service Principal" to the Company Administrator role.

Also, you must add your application to **User Account Administrator** in the Office 365 administrative roles if the Microsoft Entra user has any of the following **Administrator** organizational roles:

- Global Administrator
- Billing Administrator
- Service Administrator

To do so, run all the following MSOL cmdlets:

```powershell
Connect-MsolService
$displayName = "Application Name" 
$objectId = (Get-MsolServicePrincipal -SearchString $displayName).ObjectId
$roleName = "User Account Administrator"
Add-MsolRoleMember -RoleName $roleName -RoleMemberType ServicePrincipal -RoleMemberObjectId $objectId
```

After you run both sets of cmdlets, your application will be enabled to change the password of all **Administrator** organizational roles.

> [!NOTE]
> It can take up to 30 minutes for the permissions to be applied to the Application Service Principal after you add the permissions to the Office 365 administrative roles.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
