---
title: Can’t deploy add-ins by using the Integrated apps menu in the Microsoft 365 admin center
description: Discusses an issue when deploying an add-in by using the Integrated apps menu and provides a resolution.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - CI 7849
  - CSSTroubleshoot
ms.reviewer: haembab
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 05/22/2026
---
# Can’t deploy add-ins by using the Integrated apps menu in the Microsoft 365 admin center

## Summary

This article discusses an issue that occurs if you deploy an add-in by using the Integrated apps menu in the Microsoft 365 admin center. The article provides a list of causes of this issue and a resolution for each cause.

## Symptoms

When you try to deploy either an Office Store add-in or a custom add-in by using the Integrated Apps menu in the Microsoft 365 admin center, you receive the following error message:

> Deployment failed

:::image type="content" source="media/cannot-deploy-addin-integrated-apps-menu/error-deploying-add-in.png" alt-text="Screenshot of the error message when you try to deploy an add-in.":::

If you capture either a Fiddler trace or an HTTP Archive (HAR) trace, you see an error response that includes a message such as "FailedWriteToExchange" or "UnableToParseManifest".

**Error response 1**:

`{"appsManagementStatus": [{"appId": "657e833a-c931-4ad9-a378-c781ec631057","workload": "WXPO","status": "Failed",`

`"commandType":"Deploy","errorReason": "Error while processing app management request for f9005841-826f-45bb-be31-3e4e62b36027 with message = {\"ResponseResult\":\"**FailedWriteToExchange**\",\"ResponseResultDetails\":{\"Code\":\"**FailedWriteToExchange**\"},\"ErrorMessages\":null} Error Response : , Error Message : , Response …} and status code = OK",`

`"additionalData": null]}`

**Error response 2**:

`{"appsManagementStatus":[{"appId":"921e76ef-d73e-567f-adae-5a76b39052cf","workload":"WXPO","status":"Failed",`

`"commandType":"Deploy","errorReason":"Error while processing app management request for 38758492-9790-4f10-8db5-7f348d19f46f with message = {\"ResponseResult\":\"**FailedWriteToExchange**\",\"ResponseResultDetails\":{\"Code\":\"**UnableToParseManifest**\"}}}]}`

If you try to deploy the add-in by using the New-OrganizationAddIn PowerShell cmdlet, you receive the following error message:

`New-OrganizationAddIn : There was an error uploading the Add-In. Activity ID: 41391eb8-3117-4c4d-82c2-ec7da4ca14ae`

`At line:1 char:1`

`+ New-OrganizationAddIn -ManifestPath 'C:\Users\User1\Downloads`

`+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`

`+ CategoryInfo : WriteError: (:) [New-OrganizationAddIn], AddInCreationException`

`+ FullyQualifiedErrorId : **FailedWriteToExchange**,Microsoft.OrganizationAddInPowerShell.Cmdlets.NewOrganizationAddIn”`

## Cause

The issue occurs because of one of the following reasons:

- You’re using a [PIM-activated](/entra/id-governance/privileged-identity-management/pim-configure) role to deploy the add-in.

- You require the [Org Marketplace Apps role](/exchange/org-marketplace-apps-role-exchange-2013-help) to deploy an Office Store add-in, but your role assignment is either missing or delegating, not regular.

- You require the [Org Custom Apps role](/exchange/org-custom-apps-role-exchange-2013-help) to deploy a custom add-in, but your role assignment is either missing or delegating, not regular.

- The manifest file contains a typo.

## Resolution

Use one of the following resolutions, as appropriate to the cause of your issue.

### Resolution for PIM-activated role assignments

PIM-activated roles aren’t supported to deploy add-ins. You can use only an appropriate role assignment that's permanently active to deploy add-ins.

### Resolution for missing and delegating role assignments

By default, both the Org Marketplace Apps role and the Org Custom Apps role are enabled for all administrators in the Organization Management role group.

To get a list of all users who have these roles enabled, and to learn whether the roles are delegating or regular, run the following commands:

```powershell

Get-ManagementRoleAssignment -Role "Org Marketplace Apps" -GetEffectiveUsers

Get-ManagementRoleAssignment -Role " Org Custom Apps" -GetEffectiveUsers
```

The output of these commands resembles the following examples.

**Example 1**: In this example, all members of the Organization Management role group have both delegating and regular role assignments for the Org Marketplace Apps role.

:::image type="content" source="media/cannot-deploy-addin-integrated-apps-menu/org-marketplace-apps-users.png" alt-text="Output displaying the delegating and regular role assignments for the Org Marketplace Apps role.":::

**Example 2**: In this example, all members of the Organization Management role group have only delegating role assignments for the Org Custom Apps role.

:::image type="content" source="media/cannot-deploy-addin-integrated-apps-menu/org-custom-apps-users.png" alt-text="Output displaying the delegating and regular role assignments for the Org Custom Apps role.":::

If your user name isn't displayed in the command output for the role that’s required to deploy the add-in, or your role assignment is delegating, an admin who has the appropriate, regular role assignment can use one of the following methods to assign the necessary role to you.  
  
**Method 1:** Assign the Org Marketplace Apps role or Org Custom Apps role, as appropriate, explicitly by using the Exchange admin center.

Use the following steps:

1. Open the Exchange admin center.
1. Select **Roles** > **Admin roles** > **Organization Management**.
1. In the Organization Management flyout pane, on the **Permissions** tab, select the role that you want to assign.
1. Select **Save**.

:::image type="content" source="media/cannot-deploy-addin-integrated-apps-menu/assign-role-explicitly.png" alt-text="screenshot of the menu options in the Exchange admin center that're required to assign a role explicitly":::

**Method 2:** Create the missing role assignments under **Organization Management** by running the following script.  
An admin must have at least the **RoleManagement** role to run the script.

```powershell

$roleGroup = "Organization Management"`
$roleGroupGuid =(Get-RoleGroup -Identity $roleGroup | Where-Object {$.Name -eq $roleGroup}).Guid

New-ManagementRoleAssignment  -Role "Org Marketplace Apps" -SecurityGroup $roleGroupGuid

New-ManagementRoleAssignment  -Role "Org Custom Apps" -SecurityGroup $roleGroupGuid
```

### Resolution for a typo in the manifest file

If the issue persists after the appropriate role assignments are made, the manifest file might contain a typo. To get help to resolve the issue, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=2189021), and share HAR logs and the manifest file.
