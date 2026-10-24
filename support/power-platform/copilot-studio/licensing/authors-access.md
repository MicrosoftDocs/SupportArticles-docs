---
title: Users outside the Copilot Studio authors security group can access Copilot Studio
description: Learn how to identify, troubleshoot, and resolve issues with user access for users outside the Copilot Studio authors setting in Microsoft Copilot Studio.
ms.date: 09/09/2025
ms.reviewer: erickinser
ms.custom: sap:Licensing
---

# Users outside the Copilot Studio authors security group can access Copilot Studio

This article explains how the **Copilot Studio authors** tenant setting interacts with licenses, Power Platform environments, and authoring permissions.

## Issue

After assigning a Microsoft Entra security group to the **Copilot Studio authors** setting in the Power Platform admin center, users outside the group might still be able to open Copilot Studio or perform some authoring actions.

## Cause

The **Copilot Studio authors** setting grants author access to members of the selected security group in applicable pay-as-you-go scenarios. Assigning a group doesn't automatically revoke access that a user receives through another license, role, or permission.

The following controls serve different purposes:

- Copilot Studio and Microsoft 365 licenses determine whether a user has an applicable product entitlement.
- The **Copilot Studio authors** setting grants author access in applicable pay-as-you-go scenarios.
- Power Platform environment security groups determine who can enter specific environments.
- Dataverse security roles determine which actions users can perform in an environment.
- Publishing agents can have additional permission and licensing requirements.

Opening Copilot Studio, creating or saving an agent, editing an existing agent, and publishing an agent are separate actions. A control that blocks one action might not block the others.

## Solution

Choose the controls that correspond to the experience and actions that you want to restrict.

### Restrict access to agents powered by the standard harness

The following conditions apply to the standard Copilot Studio experience. To block access supplied through the documented standard-harness licensing paths, all the following conditions must be met:

1. The user isn't in the security group assigned to the **Copilot Studio authors** setting.
1. The user doesn't have a Copilot Studio per-user license or trial license.
1. The user doesn't have a Microsoft 365 Copilot license that provides access to Copilot Studio.

Removing only one service plan or license might not block access if another applicable entitlement remains.

These conditions don't establish a complete access block for agents powered by the GitHub Copilot harness.

For more information, see [Assign user licenses and manage access](/microsoft-copilot-studio/requirements-licensing).

### Restrict who can create or edit agents in an environment

Use Power Platform environment access and Dataverse security roles to control authoring in governed environments:

1. Create or use a non-default environment for governed agent development.
1. Assign a Microsoft Entra security group to the environment.
1. Include only approved makers in the environment security group.
1. Assign the **Environment Maker** role, or an appropriate custom security role, only to users who need to create or edit agents.
1. Remove authoring roles from users who shouldn't create, save, or edit agents in the environment.
1. Test the configuration by using an account that isn't an approved maker.

Environment membership and security-role assignment are separate controls. A user must have access to the environment and the required table privileges to create or modify agents.

> [!NOTE]
> You can't assign an environment security group to the default environment or to developer environments. Use dedicated development and production environments when you need controlled environment membership.

For more information, see:

- [Control user access to environments with security groups and licenses](/power-platform/admin/control-user-access)
- [Assign Copilot Studio authoring permissions by using security roles](/microsoft-copilot-studio/guidance/sec-gov-phase3#assign-copilot-studio-authoring-permissions-by-using-security-roles)
- [Work with Power Platform environments in Copilot Studio](/microsoft-copilot-studio/environments-first-run-experience)

### Restrict access to the GitHub Copilot harness experience

An individually assigned Copilot Studio user license isn't required to enter the experience powered by the GitHub Copilot harness. Removing that license doesn't, by itself, prevent someone from entering the experience.

Creating, editing, and publishing agents depends on the applicable Copilot Studio and environment permissions. Use governed environments, environment security groups, and security roles to limit who can author agents.

Don't rely on removal of an individually assigned Copilot Studio user license as a list of approved authors. Use the applicable environment access and authoring permissions to control who can create or modify agents.

> [!NOTE]
> The **Copilot Studio authors** setting shouldn't be treated as a guaranteed complete portal-access block for the GitHub Copilot harness. Users might still be able to enter the experience even when they can't create, edit, or publish agents in a governed environment.

### Understand what each restriction controls

Environment-level controls apply only to the selected environment. They don't establish a tenant-wide portal-access block or restrict authoring in other environments that a user can access. Review environment-creation permissions separately; see [Control environment creation and management](/power-platform/admin/control-environment-creation).

| Action to restrict | Applicable experience and scope | Supported control or procedure | What this doesn't block |
|---|---|---|---|
| Access to a selected environment | Environments that support security-group assignment; not default or developer environments | Assign an [environment security group](/power-platform/admin/control-user-access) containing approved users. Review the documented administrator exceptions. | Opening Copilot Studio or accessing another environment. Security-group membership restrictions don't apply to every administrator account. |
| Agent creation and draft saves in a selected environment | Authoring in that governed environment; not a tenant-wide or harness-specific restriction | Review and remove all applicable roles that grant agent creation or modification, including assignments through group teams. See [authoring permissions](/microsoft-copilot-studio/guidance/sec-gov-phase3#assign-copilot-studio-authoring-permissions-by-using-security-roles). | The user might still open the portal or begin configuring an agent. Authoring in another environment where the user has permissions isn't affected. Verify creation and draft-save enforcement separately. |
| Edits to an existing agent | The selected agent in its environment | Review agent sharing and all security roles that grant update privileges. Removing one sharing grant doesn't remove permissions supplied by another role. | Other actions allowed by the user's remaining permissions, potentially including using the published agent. |
| Publishing a standard-harness agent | Standard-harness publishing; not a universal restriction across harnesses | Review the applicable license, capacity, and tenant-setting checks in the [publishing guidance](/microsoft-copilot-studio/faq-billing-licensing). Apply the control that corresponds to the publishing requirement. | Portal entry, agent creation, or draft saves aren't necessarily blocked. Don't apply standard-harness license checks as a publishing restriction for the GitHub Copilot harness. |
| Access through the listed standard-experience entitlements | The entitlement paths listed in the standard-experience checklist | Follow the [standard-experience checklist](#restrict-access-to-agents-powered-by-the-standard-harness) and check for other access grants. Review [self-service trial signup](/microsoft-copilot-studio/requirements-licensing#trial-plans) separately. | Removing these entitlements alone doesn't establish a complete portal-access block or a verified draft-save block. It doesn't, by itself, prevent entry to the GitHub Copilot harness experience. |

Test each required restriction with an account that isn't an approved maker and doesn't have administrator privileges. Record portal entry, starting agent configuration, creating and saving a draft, editing an existing agent, and publishing as separate outcomes. Being able to open an authoring page or start configuring an agent doesn't confirm permission to save or publish it.

For guidance about allocations, agent limits, alerts, and other consumption controls, see [Manage costs for agents powered by the GitHub Copilot harness](/power-platform/admin/manage-usage-github-copilot-harness).

### Copilot Studio for Teams and classic agents

After the end of June 2026, the Copilot Studio for Teams app redirects makers to the Copilot Studio web app instead of creating classic chatbots directly in Teams.

This change affects the authoring surface for classic agents. It doesn't establish that the same license-removal or Authors-group behavior applies to agents powered by the standard or GitHub Copilot harness.

For users whose Microsoft 365 license includes the Teams plan, disabling the **Power Virtual Agents for Office 365** service plan prevents creating and editing classic agents in the Copilot Studio web app and Teams app.

For more information, see:

- [Create a classic agent with the Teams plan](/microsoft-copilot-studio/fundamentals-get-started-teams)
- [FAQ for Copilot Studio billing and licensing](/microsoft-copilot-studio/faq-billing-licensing)

## Related information

- [Tenant settings](/power-platform/admin/tenant-settings)
- [Assign user licenses and manage access](/microsoft-copilot-studio/requirements-licensing)
- [Work with Power Platform environments in Copilot Studio](/microsoft-copilot-studio/environments-first-run-experience)
- [Control user access to environments with security groups and licenses](/power-platform/admin/control-user-access)
- [Secure your Copilot Studio projects](/microsoft-copilot-studio/guidance/sec-gov-phase3)
- [Manage costs for agents powered by the GitHub Copilot harness](/power-platform/admin/manage-usage-github-copilot-harness)
