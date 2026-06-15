---
title: Manage orphaned flows when owner leaves organization
description: Manage orphan flows in Power Automate when an owner leaves your organization. Learn how to assign new co-owners and maintain automation continuity.
ms.reviewer: tomche, v-shaywood
ms.topic: how-to
ms.date: 06/11/2026
ms.custom: has-azure-ad-ps-ref, sap:Flow management\Flow owner leaves organization
---
# Manage orphaned flows when the owner leaves the organization

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4556130

## Summary

This article helps you manage orphaned flows in Power Automate after a flow owner leaves your organization. An orphaned flow is a flow that no longer has a valid owner. These flows can fail if they use connections tied to that user account. This article explains how admins can identify orphaned flows, assign new co-owners in the Power Platform admin center, and use PowerShell to update ownership for one flow or multiple flows. These steps help maintain business continuity and reduce failures caused by lost or invalid connections.

## Check for orphaned flows in the Power Platform admin center

> [!NOTE]
> Only users with appropriate privileges can view flows that don't have any valid owners.

On the [environment page from Power Platform admin center](https://admin.powerplatform.microsoft.com/environments), go to the **Resources** tab and select **Flows**. Look for flows that don't have an owner listed in the **Owners** column.

If there are many flows, select **Load more** to load the next set of flows. This way, you can ensure you look through all flows that might be orphaned.

## Assign new co-owners to an orphaned flow in the admin center

1. From the flow list, select the orphaned flow.
1. Select **Share** at the top of the page.
1. Enter a new owner name and select the new owner account.
1. Select **Save** to save your changes.

> [!NOTE]
> If there are many flows in your organization, you can also manage orphaned flows through PowerShell cmdlets.

## Manage orphaned flows using PowerShell cmdlets for administrators

Administrators can also manage flows by running [Power Apps cmdlets for administrators](/power-platform/admin/powerapps-powershell#power-apps-cmdlets-for-administrators-preview). Make sure you [install](/power-platform/admin/powershell-getting-started) the PowerShell module if you haven't done so previously.

### Fix permissions for a single orphaned flow

1. Run the `Get-AdminFlowOwnerRole` cmdlet with the environment name and flow name (GUID) to get the list of users and their roles. This list shows you the current permissions set for the flow.

    ```powershell
    Get-AdminFlowOwnerRole -EnvironmentName <env name> -FlowName <flow name>
    ```

1. To assign a co-owner to a flow, run the `Set-AdminFlowOwnerRole` cmdlet with the Microsoft Entra principal object ID of the new owner.

    ```powershell
    Set-AdminFlowOwnerRole -EnvironmentName <env name> -FlowName <flow name> -PrincipalType User -RoleName CanEdit -PrincipalObjectId <new owner object id>
    ```

    > [!NOTE]
    > To get the Microsoft Entra principal object ID of a user, run the [Get-AzureADUser](/powershell/module/azuread/get-azureaduser) cmdlet (which is from the AzureAD module). You need to call the `Connect-AzureAD` cmdlet before running the `Get-AzureADUser` cmdlet.

    [!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Run the `Get-AdminFlowOwnerRole` cmdlet again to verify the new owner is in the list.

For more information on these cmdlets, see [Set-AdminFlowOwnerRole](/powershell/module/microsoft.powerapps.administration.powershell/set-adminflowownerrole) and [Get-AdminFlowOwnerRole](/powershell/module/microsoft.powerapps.administration.powershell/get-adminflowownerrole).

### Fix permissions for all flows created by a specific user

1. To get the list of flows created by a given user, run the following cmdlet:

    ```powershell
    Get-AdminFlow -EnvironmentName <env name> -CreatedBy <user-object-id>
    ```

1. Then apply the steps in the preceding section to assign co-owners to every flow on the list.

### List all orphaned flows in an environment using PowerShell

To get all flows that don't have valid users, loop through all flows in the environment, and verify there's at least one owner or co-owner that exists in Microsoft Entra ID. The following script provides an example:

```powershell
Connect-AzureAD
$env = "<your environment name>"
$flows = Get-AdminFlow -EnvironmentName $env
foreach ($flow in $flows)
{
    $hasValidOwner = $false
    $permissions = Get-AdminFlowOwnerRole -EnvironmentName $env -FlowName $flow.FlowName
    foreach ($permission in $permissions) 
    {
        $roleType = $permission.RoleType
        
        if ($roleType.ToString() -eq "Owner" -or $roleType.ToString() -eq "CanEdit")
        {
            $userId = $permission.PrincipalObjectId
            $users = Get-AzureADUser -Filter "ObjectId eq '$userId'"

            if ($users.Length -gt 0)
            {
                $hasValidOwner = $true
                break
            }
        }
    }

    if ($hasValidOwner -eq $false)
    {
        $flow
    }
}
```

You can also inject the `Set-AdminFlowOwnerRole` cmdlet into the script to assign a co-owner for each flow that doesn't have a valid owner.

## Related content

- [Change the owner of a cloud flow](/power-automate/change-cloud-flow-owner)
- [Guide to cloud sharing and permissions](/power-automate/guide-to-cloud-flow-sharing-permissions)
