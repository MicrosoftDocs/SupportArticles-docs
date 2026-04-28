---
title: Resolve Dataverse Provisioning Errors in Power Automate Approvals
description: Resolve Power Automate Approvals errors when Dataverse provisioning fails. Get step-by-step solutions for licensing, Microsoft Entra app, and permission issues.
ms.reviewer: hamenon, mansong, matow, v-shaywood
ms.date: 04/28/2026
ms.custom: has-azure-ad-ps-ref, sap:Approvals\Approval action failing
---
# Power Automate Approvals Dataverse provisioning errors and recommendations

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513672

## Summary

This article describes common errors and configurations that can prevent [Power Automate Approvals](/power-automate/get-started-approvals) from creating and assigning approval requests. Most provisioning failures happen the first time an approval flow runs in an environment, when Power Automate tries to create or link a Dataverse database, install the Approvals solutions, and configure the application user that manages approval data.

Use this article to identify the cause of a provisioning failure based on the error message you see, confirm the prerequisites for your tenant and environment, verify that the Dataverse database and Approvals solutions provisioned correctly, and apply the recommended solution for each error. Common error scenarios covered include `ViralServicePlanRequired`, `AADApplicationDisabled`, a disabled Dataverse database, a database that isn't ready yet, and missing permissions to create a database.

## Prerequisites

Power Automate Approvals depend on successful provisioning of a [Dataverse](/power-apps/maker/data-platform/data-platform-intro) database in the target environment. Provisioning can fail if environment prerequisites, licensing, or [Microsoft Entra](/entra/fundamentals/whatis) application configurations are incomplete.

Use this checklist before you start provisioning. For more information, see [Get started with approvals](/power-automate/get-started-approvals#prerequisites).

- Confirm at least one active Power Automate, Power Apps, or Dataverse license exists in the tenant.
- Make sure the target environment is active and Dataverse is provisioned (or can be created). Check the environment and database state in the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
- Confirm the required Microsoft Entra enterprise applications are enabled for user sign-in in the Microsoft Entra admin center:
  - Microsoft Flow Service
  - Microsoft Flow Dataverse Integration Service
  - Dynamics CRM Online / Dataverse
- Check that [Conditional Access](/entra/identity/conditional-access/overview) policies don't block registration or sign-in for these applications.
- Confirm the user starting provisioning has Environment Admin privileges (for non-default environments).

## Verify provisioning succeeded

To check that provisioning succeeded, complete these steps:

1. Confirm a Dataverse database is created and linked to the environment. Check this in the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. Confirm the Dataverse database linked to the environment is in the **Ready** state. Check this in the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

   > [!NOTE]
   > Some lifecycle operations like backup and restore can leave the database in a **Disabled** or **Admin-only** state, which prevents Power Automate Approvals and other Dataverse functionality from working.

1. Confirm the Approvals solutions are installed. View installed solutions in any of these locations:

   - [Power Platform admin center](https://admin.powerplatform.microsoft.com): select **Dynamics 365 apps**.
   - [Power Automate portal](https://make.powerautomate.com): select **Solutions** from the left navigation.
   - [Power Apps](https://make.powerapps.com): select **Solutions** from the left navigation.

## Error with status code "ViralServicePlanRequired"

> Failed to create the Dataverse database in this environment with status code 'ViralServicePlanRequired'

This error occurs in organizations that disable [self-service sign-ups](/microsoft-365/admin/misc/self-service-sign-up). Self-service sign-ups are required to assign viral plans to users who provision resources and interact with Dataverse. To resolve this issue, choose one of the following options:

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

- **Option 1: Enable the `AllowAdHocSubscriptions` setting (tenant-level)**

  Run the following PowerShell commands to enable this tenant-level setting:

  ```powershell
  # Install the MSOnline module if necessary.
  Install-Module MSOnline

  # Connect to your organization.
  Connect-MsolService

  # Confirm that AllowAdHocSubscriptions is false.
  Get-MsolCompanyInformation | fl AllowAdHocSubscriptions

  # Enable AllowAdHocSubscriptions.
  Set-MsolCompanySettings -AllowAdHocSubscriptions $true
  ```

- **Option 2: Assign a paid Power Automate plan**

  Assign a paid Power Automate plan (P1 or P2) from [Office 365](https://portal.office.com/) to the users provisioning approvals or a Dataverse database for the first time. The plan is only required to get the database provisioned.

  > [!NOTE]
  > Trial plans aren't sufficient for Approvals Dataverse provisioning. Government Community Cloud (GCC) tenants can only use this option to provision database instances.

- **Option 3: Create the database as an environment admin**

  Create the database directly from the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

## Error with status code "AADApplicationDisabled"

> Failed to create the Dataverse database in this environment with status code 'AADApplicationDisabled'.

> Resource '`https://publishers.crm.dynamics.com`' has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable '`https://publishers.crm.dynamics.com`' in the Azure Portal.'.

These errors occur if the Dynamics CRM Online or Dataverse applications are disabled in the tenant or blocked by Conditional Access for specific users. The exact message varies depending on the state of the Dataverse instance for the Power Apps or Power Automate environment, such as unprovisioned, provisioned without Approvals installed, or Approvals already installed.

To resolve this issue, a tenant administrator should go to the **Enterprise Applications** tab under **Microsoft Entra ID** in [Microsoft Azure](https://ms.portal.azure.com) and confirm that application `00000007-0000-0000-c000-000000000000` (Dataverse or Dynamics CRM Online) is enabled for users to sign in. Also confirm that any relevant Conditional Access policies grant the required access to users who use Power Automate Approvals.

:::image type="content" source="media/flow-approval-cds-provisioning-errors/properties-settings.png" alt-text="Screenshot that shows how to set the Enabled for users to sign-in option to Yes.":::

## Error "Database is disabled"

> The Dataverse database for this environment is disabled

The Dataverse instance is disabled in this environment. This condition usually means all Power Automate and Dataverse plans in your Microsoft Entra tenant expired. To re-enable the database, make sure at least one user has active plans.

## Error "Database isn't ready yet"

> The Dataverse Database for this environment is not ready yet.

The database is still provisioning or provisioning failed. Rerun a flow that uses approvals to retry provisioning.

## Error "User has no permission to create database"

> The current user doesn't have permissions to create a Dataverse database for this environment.

For non-default Power Automate and Power Apps environments, only environment admins can create the Dataverse database, either directly through the Power Platform admin center or indirectly through Power Automate Approvals.

To resolve this issue, an administrator must do one of the following actions:

- Create the environment manually from the Power Platform admin center.
- Create and run an approvals flow.
- Grant environment administrator permission to the current user.

## Related content

- [Power Platform environments overview](/power-platform/admin/environments-overview)
- [Role-based security roles for Dataverse](/power-platform/admin/database-security)
- [Types of Power Automate licenses](/power-platform/admin/power-automate-licensing/types)
