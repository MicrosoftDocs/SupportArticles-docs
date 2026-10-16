---
title: Your Organization Has Prevented This Agent from Being Installed
description: Resolve blocked installation of shared Copilot Studio agents caused by Microsoft 365 agent settings, user access, or Microsoft Teams app policies.
ms.date: 10/16/2026
ms.reviewer: vibhutinair
ms.custom: sap:Authoring
ai-usage: ai-assisted
---

# "Your organization has prevented this agent from being installed" error in Copilot Studio

## Summary

When a user tries to install a Microsoft Copilot Studio agent that was shared with them, they might receive the error "Your organization has prevented this agent from being installed." This error occurs when your organization's Microsoft 365 agent settings, user access settings, or Microsoft Teams app policies block the installation. This article explains the causes and describes how an administrator can resolve the error so that the user can install the agent.

## Symptoms

When a user tries to install an agent that was shared with them, they receive the following error:

> Your organization has prevented this agent from being installed.

The agent can't be installed even though it was successfully shared with the user.

## Cause

This issue can occur when one or more of the following conditions apply:

- Your organization's Microsoft 365 agent settings don't allow the user to install the applicable type of agent.
- The user isn't included in the users or groups that are allowed to access agents.
- The user isn't a member of a security group that has been granted access to the agent.
- If the agent is being installed through Microsoft Teams, organizational app policies might prevent the user from installing the agent.

Microsoft 365 administrators control which types of agents users can access, and which users or groups can use agents, through the agent settings in the Microsoft 365 admin center. For more information, see [Manage agent settings in the Microsoft 365 admin center](/microsoft-365/admin/manage/agent-settings).

## Solution

Ask a Microsoft 365 administrator to check the following settings.

### Allow the agent type in Microsoft 365 admin center

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/).
1. Select **Agents** > **Settings**.
1. Select **Agent and plugin access**.
1. Verify that **Allow agents and plugins built by your organization** is turned on.

### Verify that the user has access to agents

1. In the [Microsoft 365 admin center](https://admin.microsoft.com/), select **Agents** > **Settings**.
1. Select **User access**.
1. Verify that access is available to all users, or to a specific user or group that includes the affected user.

### Check Teams app policies

1. Sign in to the [Teams admin center](https://admin.teams.microsoft.com/).
1. Select **Teams apps** > **Manage apps**.
1. Select **Org-wide app settings**, and then make sure that custom apps are allowed for users.
1. Check the app permission and app setup policies that are assigned to the user, and make sure that they don't block the agent.

For more information, see [Manage your apps in the Microsoft Teams admin center](/microsoftteams/manage-apps) and [Manage custom app policies and settings in Microsoft Teams](/microsoftteams/teams-custom-app-policies-and-settings).

### Confirm security group membership

Confirm that the user belongs to the exact security group that's specified in the agent's access control list. If the user isn't a member, add the user to the group, and then ask the user to try installing the agent again.

## Related content

- [Resolve Microsoft Copilot Studio agent error codes](error-codes.md)
