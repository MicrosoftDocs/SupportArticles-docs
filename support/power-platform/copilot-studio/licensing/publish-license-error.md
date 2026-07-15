---
title: Fix Copilot Studio License Errors Blocking Access and Publishing
description: License errors in Copilot Studio can block publishing and access. Learn how to fix per-user license, tenant enablement, security group, and viral trial conflicts.
ms.date: 07/15/2026
ms.reviewer: 
  - nansari
  - erickinser
  - v-shaywood
ms.custom: sap:Licensing
ai-usage: ai-assisted
---

# License errors when publishing or accessing Copilot Studio

## Summary

This article helps you fix licensing errors that stop users from publishing agents in or accessing Microsoft Copilot Studio. The same error message can come from several distinct causes, including a missing per-user license, tenant enablement that isn't set up, a security group that doesn't include the author, a viral trial license conflict, or error 7604 at the tenant level. Review each cause in order to find and fix the one that applies to you.

## Symptoms

You might encounter one of the following symptoms:

- When a user tries to publish an agent, the following error appears:

  > You currently do not have a user license that allows you to publish in Copilot Studio. Please contact your administrator to upgrade your license or enable the required permissions.

- A user can't open Copilot Studio. The [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com/) page loads only the splash screen, signing up for a trial doesn't resolve the issue, and error code **7604** appears in the URL.

## Cause 1: The Copilot Studio authors security group isn't configured or the user isn't a member

Under [pay-as-you-go billing](/microsoft-copilot-studio/billing-licensing#copilot-studio-pay-as-you-go), a user still needs to be a member of the security group assigned to the **Copilot Studio authors** tenant setting to be recognized as an authorized author. If you don't configure a security group, or the affected user isn't in it, the publish action fails with the license error even though pay-as-you-go is enabled.

### Solution

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) as a tenant administrator.
1. Go to **Manage** > **Tenant settings**.
1. Select **Copilot Studio authors**.
1. Create or select a Microsoft Entra security group for Copilot Studio authors, and add the affected user (and any other users who need publishing rights).
1. Ask the user to sign in again, open the agent, and try to publish.

Learn more about how this setting interacts with user access in [Users outside the Copilot Studio authors security group can access Copilot Studio](authors-access.md).

## Cause 2: The user doesn't have a Copilot Studio per-user license

The user account isn't assigned a **Microsoft Copilot Studio Per User** license, which is required for publishing.

### Solution

Assign the **Microsoft Copilot Studio Per User** license to the affected user in the Microsoft 365 admin center, then have the user sign out and sign back in before retrying the publish action. Learn more about licensing details in [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing).

## Cause 3: A viral trial license or the "Publish bots with AI features" setting is blocking publish

Even with a valid **Microsoft Copilot Studio User License** assigned, publishing can still fail when:

- A **Microsoft Copilot Studio viral trial** license is also present on the user account and overrides the assigned user license.
- The **Publish bots with AI features** tenant setting isn't enabled in the Power Platform admin center.

### Solution

1. In the Microsoft 365 admin center, remove the **Microsoft Copilot Studio viral trial** license from the affected user account.
1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), go to **Manage** > **Tenant settings** and confirm that **Publish bots with AI features** is enabled.
1. Have the user sign out and back in, then retry the publish action.

## Cause 4: Copilot Studio isn't enabled at the tenant level (error 7604)

A user license alone isn't sufficient to access Copilot Studio. Both a tenant-level license *and* a user-level license are required. When tenant-level enablement is missing, the user sees only the splash screen at [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com/) and error code **7604** in the URL.

### Solution

Have a tenant administrator set up one of the following tenant-level licensing options:

- **Copilot Studio Credits**
- A **Copilot Studio message pack**
- **Pay-as-you-go** billing

After tenant-level licensing is in place and the user has an appropriate user-level license, ask the user to sign in again to Copilot Studio.

Learn more in [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing).

## Related content

- [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing)
- [Tenant settings](/power-platform/admin/tenant-settings)
- [Users outside the Copilot Studio authors security group can access Copilot Studio](authors-access.md)
