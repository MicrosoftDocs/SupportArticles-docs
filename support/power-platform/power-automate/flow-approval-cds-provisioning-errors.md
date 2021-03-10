---
title: Flow Approval CDS Provisioning errors
description: Common error cases and configuration that can result in Flow Approvals being unable to create and assign approvals requests.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Flow Approval CDS Provisioning errors and recommendations

This article describes common error cases and configuration that can result in Flow Approvals being unable to create and assign approvals requests.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513672

## Common error case 1

> Failed to create the Common Data Service database in this environment with status code 'ViralServicePlanRequired'

This error occurs in organizations that have disabled self-service signups. Self-service signups are required to assign viral plans to users attempting to provision resources and interact with the Common Data service (CDS). Tenants have multiple options to resolve it.

1. Enable `AllowAdHocSubscriptions` (tenant level configuration) via PowerShell.

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

1. Assign a paid Microsoft Flow plan (P1 or P2) to the users attempting to first provision approvals or a Common Data Service database via [Office 365](https://portal.office.com/). It's only necessary to get the database provisioned.  

    > [!NOTE]
    > Trial plans aren't sufficient to for Approval CDS provisioning. GCC tenants can only use approach #2 to be able to provision database instances.

1. Create the database as an environment admin directly from [Power Platform admin center](https://admin.powerplatform.microsoft.com)  

## Common error case 2

> Failed to create the Common Data Service database in this environment with status code 'AADApplicationDisabled'.

> Resource '`https://publishers.crm.dynamics.com`' has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable '`https://publishers.crm.dynamics.com`' in the Azure Portal.'.

These errors occur if the Dynamics CRM Online / Common Data Service applications are disabled either in the tenant, or through Conditional Access for specific users. The exact error message may vary depending on the exact state of the Common Data Service instance corresponding to the PowerApps/Flow environment - unprovisioned, provisioned but no Approvals installed, or Approvals already installed.

To resolve, tenant administrators will need to go to the **Enterprise Applications** tab under **Azure Active Directory** on [Microsoft Azure](https://ms.portal.azure.com) to ensure application 00000007-0000-0000-c000-000000000000 (Common Data Service / Dynamics CRM Online) is enabled for users to sign in, and any relevant Conditional Access policies grant the necessary access to users expecting to use Flow Approvals.

:::image type="content" source="./media/flow-approval-cds-provisioning-errors/properties-settings.png" alt-text="Set the Enabled for users to sign-in option to Yes.":::

## The Common Data Service database for this environment is disabled

The Common Data Service instance has been disabled in this environment. It isn't expected, and is related to the expiration of all Flow & CDS plans within your AAD tenancy. To ensure the database can be enabled, make sure at least one user has active plans.

## The Common Data Service Database for this environment isn't ready yet

The database for this instance is still being provisioned, or has failed provisioning. Rerunning a Flow that uses approvals will attempt to reprovision the instance.  

## The current user doesn't have permissions to create a Common Data Service database for this environment

For non-Default Flow and PowerApps environments, only environment admins can directly (through the Flow Admin portal) or indirectly (through Flow Approvals) create the Common Data Service database.

Either an administrator must:

- Create the environment manually from the Flow Admin portal.
- Create and run an Approvals Flow.
- Grant environment administrator permission to the current user.
