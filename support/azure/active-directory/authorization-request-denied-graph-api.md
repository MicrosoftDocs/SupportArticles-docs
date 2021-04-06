---
title: Authorization_RequestDenied error message when you try to change a password if you use Graph API
description: Discusses an Authorization_RequestDenied error message that you receive when you try to change a password if you use Graph API. Provides a resolution.
ms.date: 07/20/2020
ms.technology: 
ms.reviewer: willfid, maxv, nmanis
---
# Authorization_RequestDenied error when you try to change a password using Graph API

This article provides information about troubleshooting a problem in which you receive Authorization_RequestDenied error when trying to change a password using Graph API.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 3004133

## Symptoms

You try to change the password of a Microsoft Azure Active Directory (Azure AD) user. If the **Organizational Role** setting for that user is set to any "Administrator" option, the process fails. It generates the following error message:

> {"odata.error":{"code":"Authorization_RequestDenied","message":{"lang":"en","value":"Insufficient privileges to complete the operation." }} }

When you give the **Read and write directory data** permission to your application or Application Service Principal, the application can change the password of a typical Azure AD user by using Graph API. This setting is shown in the following screenshot.

:::image type="content" source="media/authorization-requestdenied-change-password-graph-api/3004143.png" alt-text="screenshot of permissions.":::

You can delegate an Azure AD user as an administrator by changing the user's **Organizational Role** setting, as shown in the following screenshot.

:::image type="content" source="media/authorization-requestdenied-change-password-graph-api/3004144.png" alt-text="screenshot of role.":::

## Cause

This problem occurs because the users who have any of the **Administrator** organizational roles aren't members of **Company Administrator** or **User Account Administrator** in the Office 365 administrative roles.

## Resolution

To resolve this problem, add your application to **Company Administrator** in the Office 365 administrative roles. To do so, run all the following Azure AD Module for Windows PowerShell (MSOL) cmdlets:

 ```powershell
 Connect-MsolService
 ```

 It will prompt you for your tenant's credential. You should be able to use your Azure AD administrative user name in the `admin@tenant.onmicrosoft.com` format.

```powershell
$displayName = "Application Name" $objectId = (Get-MsolServicePrincipal -SearchString $displayName).ObjectId
```

Replace the "Application Name" with the name of your "Application Service Principal".

```powershell
$roleName = "Company Administrator" Add-MsolRoleMember -RoleName $roleName -RoleMemberType ServicePrincipal -RoleMemberObjectId $objectId
```

It will add your "Application Service Principal" to the Company Administrator role.

Also, you must add your application to **User Account Administrator** in the Office 365 administrative roles if the Azure AD user has any of the following **Administrator** organizational roles:

- Global Administrator
- Billing Administrator
- Service Administrator

To do so, run all the following MSOL cmdlets:

```powershell
Connect-MsolService
$displayName = "Application Name" $objectId = (Get-MsolServicePrincipal -SearchString $displayName).ObjectId
$roleName = "User Account Administrator" Add-MsolRoleMember -RoleName $roleName -RoleMemberType ServicePrincipal -RoleMemberObjectId $objectId
```

After you run both sets of cmdlets, your application will be enabled to change the password of all **Administrator** organizational roles.

> [!NOTE]
> It can take up to 30 minutes for the permissions to be applied to the Application Service Principal after you add the permissions to the Office 365 administrative roles.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums) website.
