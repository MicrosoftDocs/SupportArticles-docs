---
title: Errors When Enabling Salesforce with Server-to-Server Flow
description: Troubleshoot errors that occur when you enable Salesforce with a server-to-server flow in Sales agent, including license limits and inactive users.
ms.date: 07/13/2026
ms.reviewer: marrabi, shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
ai-usage: ai-assisted
---
# Errors when you enable Salesforce with server-to-server flow

## Summary

This article helps you troubleshoot errors that occur when you enable Salesforce with a server-to-server flow in the Sales agent. It covers errors related to the integration user, Salesforce Integration license limits, connected app and permission set deployment, duplicate profile names, and missing required fields or failing custom field validations.

## Affected clients and configurations

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Microsoft Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrators  |

## Couldn't assign permission set because the integration user is inactive in Salesforce

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you receive the following error message:

> Couldn't assign permission set because the integration user is inactive in Salesforce.

### Cause

During the Salesforce server-to-server flow setup, the process deploys a connected app to the Salesforce organization. The connected app associates with an integration user that the process creates automatically. The process assigns a permission set to the integration user. The error occurs if the integration user is inactive in Salesforce because you can't assign a permission set to an inactive user.

### Resolution

To resolve this issue:

1. In Salesforce, search for the **Sales Integration User** user.
1. Check whether the user is active.
1. If the user is inactive, set the user status to active. If you can't activate the user, contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## Couldn't create user because Salesforce integration license limit reached

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you receive the following error message:

> Couldn't create user because Salesforce integration license limit reached.

### Cause

During the Salesforce server-to-server flow setup, the process deploys a connected app to the Salesforce organization. The connected app associates with an integration user that the process creates automatically. A Salesforce Integration user license is assigned to this integration user. The error occurs if the maximum number of Salesforce Integration user licenses is reached.

### Resolution

To resolve this issue, check whether you reached the maximum number of Salesforce Integration user licenses. If you reached the maximum, reassign existing integration users to other licenses, or purchase more licenses.

To check the number of integration user licenses available in your Salesforce organization:

1. Sign in to Salesforce as an administrator.

1. Go to **Setup** > **Company Settings** > **Company Information**.

1. Under **User Licenses**, check the number of available **Salesforce Integration** licenses in the **Remaining Licenses** column. If the number is **0**, deactivate existing integration users or change their licenses to other types. You can also purchase more licenses.

## Errors when enabling Salesforce with a server-to-server flow

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you receive one of the following error messages:

> Couldn't get deployment status due to incorrect ID format.

> Couldn't find the connected app.

> Couldn't get user license ID is missing to create connection user.

> Couldn't fully remove connection data from Dataverse. Contact Sales support to request manual cleanup.

> Couldn't complete the connected app or permission set deployment to Salesforce. Try again.

> Couldn't complete the connected app deployment to Salesforce. Try again.

> Couldn't complete the permission set deployment to Salesforce. Try again.

### Cause

During the Salesforce server-to-server flow setup, the process deploys a connected app to the Salesforce organization. The connected app associates with an integration user that the process creates automatically. The process assigns a permission set to the integration user. During this process, errors occur.

### Resolution

To resolve this issue, retry the operation. If the problem continues, gather the error details, and contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## No changes were made

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you receive the following error message:

> No changes were made.

### Cause

During the Salesforce server-to-server flow setup, the process deploys a connected app to the Salesforce organization. The connected app associates with an integration user that the process creates automatically. The process assigns a permission set to the integration user. This error occurs if the same permission set is already assigned to the user.

### Resolution

To resolve this problem, check for any manual changes to the External Client Apps (ECA), connected app, or profiles that have the `CopilotForSales`, `M365CopilotSales`, or `M365 Copilot Sales` prefix. If you find unintentional changes, revert them. Otherwise, retry the operation. If the problem continues, contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## The profile name is already in use. Pick a different name or rename the existing profile in Salesforce

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you receive the following error message:

> The profile name is already in use. Pick a different name or rename the existing profile in Salesforce.

### Cause

During the Salesforce server-to-server flow setup, the process creates a profile named **Sales Integration Profile** in the Salesforce organization. The error occurs if a profile with the same name already exists. This situation prevents you from creating a new profile.

### Resolution

To resolve this issue, check whether a profile with the same name already exists in the Salesforce organization. If you created the profile before you enabled the server-to-server flow, rename the existing profile, and then try again. If you didn't create the profile, contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## Required fields are missing or custom field validations fail

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you receive the following error message:

> Required fields are missing: \<FieldNames\>

> Could not provision resource due to custom fields

### Cause

During the Salesforce server-to-server flow setup, the process deploys a connected app to the Salesforce organization. The connected app associates with an integration user that the process automatically creates. This error occurs if custom validation rules for user creation prevent the integration user from being automatically created in Salesforce.

### Resolution

To resolve this issue:

1. Temporarily disable the custom validation rules for user creation. To make this change, go to **Setup** > **Object Manager** > **User** > **Validation Rules**.
1. Try again to set up the Salesforce connection in the [Sales agent admin settings](/microsoft-sales-copilot/connect-agent-datasource).
1. After the Salesforce connection is set up and the integration user is created, re-enable your validation rules.

## More information

If your problem isn't resolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
