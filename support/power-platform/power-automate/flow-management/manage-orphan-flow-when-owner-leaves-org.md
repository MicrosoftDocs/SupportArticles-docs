---
title: Manage orphan flow when owner leaves org
description: Describes how to manage orphan flows when the owner leaves the organization.
ms.reviewer: tomche
ms.topic: how-to
ms.date: 09/25/2023
ms.subservice: power-automate-flow management
ms.custom: has-azure-ad-ps-ref
---
# How to manage orphan flows when the owner leaves the organization

This article describes how to manage orphan flows when the owner leaves the organization.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4556130

## What are orphaned flows?

A flow turns into an orphaned flow when it doesn't have a valid owner anymore. It often happens when the creator or owner of the flow has left the organization and there's no co-owner. If the flow uses connections that require authentication, then it may start failing because the user identity isn't valid anymore.

Admins can maintain continuity on the business process automated by the flow by adding one or more co-owners to it. Co-owners basically have full control over the flow just like the original owner, and can fix authentication for connections if any and enable the flow if it has been disabled.

## How to check if there are orphaned flows

> [!NOTE]
> Only privileged users can view flows that don't have any valid owners.

On the [environment page from Power Platform Admin Center](https://admin.powerplatform.microsoft.com/environments), go to **Resources** tab and then open the **Flow** list. Orphaned flows don't have an owner displayed in the **Owners** column.

Select **Load more** to load the next set of flows so as to ensure you've looked through all flows that might be orphaned.

## Assign new co-owner(s) to an orphaned flow

1. From the flow list, select the orphaned flow to open the flow details page.
2. Select **Manage sharing** at the bottom of the Owners list.
3. Type in a new owner name and select the new owner account.
4. Select **Save** to save the changes.

> [!NOTE]
> It may be hard to find the orphaned flows if there are a large amount of flows in your organization. In that case, you can also manage orphaned flows through PowerShell cmdlets.

## Manage orphaned flows through Power Automate cmdlets for administrators

As an Admin, you can also manage flows by running [Power Apps cmdlets for administrators](/power-platform/admin/powerapps-powershell#power-apps-cmdlets-for-administrators-preview). Make sure you've followed the instructions to complete the installation if you haven't done it before.

### Fixing permissions for one flow

You'll need the environment name and flow name (a GUID).
Run the `Get-AdminFlowOwnerRole` cmdlet with environment name and flow name to get the list of users and their roles. Which will enable you to verify the current permissions set for the flow.

To assign a co-owner to a flow, run the `Set-AdminFlowOwnerRole` cmdlet with the Microsoft Entra principal object ID of the new owner.

```powershell
Set-AdminFlowOwnerRole -EnvironmentName <env name> -FlowName <flow name> -PrincipalType User -RoleName CanEdit -PrincipalObjectId <new owner object id>
```

> [!NOTE]
> You can get the Microsoft Entra principal object ID of a user by running the [Get-AzureADUser](/powershell/module/azuread/get-azureaduser) cmdlet (which is from AzureAD module). You need to call the `Connect-AzureAD` cmdlet before running the `Get-AzureADUser` cmdlet.

Run the `Get-AdminFlowOwnerRole` cmdlet again to verify the new owner is in the list.

### Fixing permissions for flows created by a particular user

Get a list of flows created by a given user by running the following cmdlet, and then apply the above section to fix every flow on the list.

```powershell
Get-AdminFlow -EnvironmentName <env name> -CreatedBy <user-object-id>
```

### Listing all orphaned flows in an environment

To get all flows that don't have valid users, loop through all flows in one environment, and verify there's at least one owner or co-owner that exists in Microsoft Entra ID. The following script provides an example:

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

You can also inject the `Set-AdminFlowOwnerRole` cmdlet to assign a co-owner for each flow that doesn't have a valid owner.
