---
title: Power Automate Approval Dataverse provisioning errors
description: Resolves errors that occur when Power Automate Approvals can't create and assign approval requests.
ms.reviewer: hamenon, mansong
ms.date: 03/07/2023
ms.subservice: power-automate-approvals
ms.custom: has-azure-ad-ps-ref
---
# Power Automate Approval Dataverse provisioning errors and recommendations

This article describes common error cases and configurations that can result in Power Automate Approvals being unable to create and assign approval requests.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513672

## Error with status code "ViralServicePlanRequired"

> Failed to create the Dataverse database in this environment with status code 'ViralServicePlanRequired'

This error occurs in organizations that have disabled self-service sign-ups. Self-service sign-ups are required to assign viral plans to users attempting to provision resources and interact with Dataverse. Tenants have multiple options to resolve it.

Option 1: Enable the `AllowAdHocSubscriptions` setting (tenant-level configuration) using PowerShell.

```powershell
Install the MSOnline module if necessary: 

Install-Module MSOnline 

Connect to your organization: 

Connect-MsolService 

Confirm that AllowAdHocSubscriptions is false. 

Get-MsolCompanyInformation | fl AllowAdHocSubscriptions 

Enable AllowAdHocSubscriptions 

Set-MsolCompanySettings -AllowAdHocSubscriptions $true 
```

Option 2: Assign a paid Power Automate plan (P1 or P2) to the users attempting to first provision approvals or a Dataverse database via [Office 365](https://portal.office.com/). It's only necessary to get the database provisioned.

> [!NOTE]
> Trial plans aren't sufficient for Approval Dataverse provisioning. Government Community Cloud (GCC) tenants can only use this option to be able to provision database instances.

Option 3: Create the database as an environment admin directly from [Power Platform Admin Center](https://admin.powerplatform.microsoft.com).

## Error with status code "AADApplicationDisabled"

> Failed to create the Dataverse database in this environment with status code 'AADApplicationDisabled'.

> Resource '`https://publishers.crm.dynamics.com`' has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable '`https://publishers.crm.dynamics.com`' in the Azure Portal.'.

These errors occur if the Dynamics CRM Online or Dataverse applications are disabled either in the tenant or through Conditional Access for specific users. The exact error message may vary depending on the exact state of the Dataverse instance corresponding to the Power Apps or Power Automate environment - unprovisioned, provisioned but no approvals installed, or approvals already installed.

To resolve this issue, tenant administrators need to go to the **Enterprise Applications** tab under **Microsoft Entra ID** in [Microsoft Azure](https://ms.portal.azure.com) to ensure application 00000007-0000-0000-c000-000000000000 (Dataverse or Dynamics CRM Online) is enabled for users to sign in, and any relevant Conditional Access policies grant the necessary access to users expecting to use Power Automate Approvals.

:::image type="content" source="media/flow-approval-cds-provisioning-errors/properties-settings.png" alt-text="Screenshot that shows how to set the Enabled for users to sign-in option to Yes.":::

## Error "Database is disabled"

> The Dataverse database for this environment is disabled

The Dataverse instance has been disabled in this environment. It isn't expected and is related to the expiration of all Power Automate & Dataverse plans within your Microsoft Entra tenant. To ensure the database can be enabled, make sure at least one user has active plans.

## Error "Database isn't ready yet"

> The Dataverse Database for this environment is not ready yet.

The database for this instance is still being provisioned or has failed provisioning. Rerunning a flow that uses approvals will attempt to reprovision the instance.

## Error "User has no permission to create database"

> The current user doesn't have permissions to create a Dataverse database for this environment.

For non-default Power Automate and Power Apps environments, only environment admins can directly (through the Power Apps Admin portal) or indirectly (through Power Automate Approvals) create the Dataverse database.

Either an administrator must:

- Create the environment manually from the Power Platform Admin portal.
- Create and run an approvals flow.
- Grant environment administrator permission to the current user.
