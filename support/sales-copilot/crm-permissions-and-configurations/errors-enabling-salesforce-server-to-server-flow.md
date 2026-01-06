---
title: Errors When Enabling Salesforce in Server-to-Server Flow
description: Troubleshoot errors that occur when you try to enable Salesforce in a server-to-server flow in the Sales app.
ms.date: 12/16/2025
ms.reviewer: marrabi, shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Errors occur when enabling Salesforce in a server-to-server flow

This article helps you troubleshoot errors that occur when you try to enable Salesforce in a server-to-server flow in the Sales app.

## Who is affected?

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

When you try to enable Salesforce in a server-to-server flow, you receive the following error message:

> Couldn't assign permission set because the integration user is inactive in Salesforce.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that's created automatically. A permission set is then assigned to the integration user. The error occurs if the integration user is inactive in Salesforce. The error occurs because a permission set can't be assigned to an inactive user.

### Resolution

To resolve this issue:

1. In Salesforce, search for the **Sales Integration User** user.
1. Check whether the user is active.
1. If the user is inactive, set the user status to active. If you can't activate the user, contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## Couldn't create user because Salesforce integration license limit reached

### Symptoms

When you try to enable Salesforce in a server-to-server flow, you receive the following error message:

> Couldn't create user because Salesforce integration license limit reached.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that's created automatically. A Salesforce Integration user license is assigned to this integration user. The error occurs if the maximum number of Salesforce Integration user licenses is reached.

### Resolution

To resolve this issue, check whether you reached the maximum number of Salesforce Integration user licenses. If you reached the maximum, reassign existing integration users to other licenses, or purchase more licenses.

To check the number of integration user licenses available in your Salesforce organization:

1. Sign in to Salesforce as an administrator.

1. Go to **Setup** > **Company Settings** > **Company Information**.

1. Under **User Licenses**, check the number of available **Salesforce Integration** licenses in the **Remaining Licenses** column. If the number is **0**, deactivate existing integration users or change their licenses to other types. You can also purchase more licenses.

## Errors when enabling Salesforce in a server-to-server flow

### Symptoms

When you try to enable Salesforce in a server-to-server flow, you receive one of the following error messages:

> Couldn't get deployment status due to incorrect ID format.

> Couldn't find the connected app.

> Couldn't get user license ID is missing to create connection user.

> Couldn't fully remove connection data from Dataverse. Contact Sales support to request manual cleanup.

> Couldn't complete the connected app or permission set deployment to Salesforce. Try again.

> Couldn't complete the connected app deployment to Salesforce. Try again.

> Couldn't complete the permission set deployment to Salesforce. Try again.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that's created automatically. A permission set is then assigned to the integration user. During this process, errors occur.

### Resolution

To resolve this issue, retry the operation. If the problem continues, gather the error details, and contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## No changes were made

### Symptoms

When you try to enable Salesforce in a server-to-server flow, you receive the following error message:

> No changes were made.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that's created automatically. A permission set is then assigned to the integration user. The error occurs if the same permission set is already assigned to the user.

### Resolution

To resolve this problem, check for any manual changes to the connected app or profiles that have the `CopilotForSales` prefix. If you find unintentional changes, revert them. Otherwise, retry the operation. If the problem continues, contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## The profile name is already in use. Pick a different name or rename the existing profile in Salesforce

### Symptoms

When you try to enable Salesforce in a server-to-server flow, you receive the following error message:

> The profile name is already in use. Pick a different name or rename the existing profile in Salesforce.

### Cause

During the Salesforce server-to-server flow setup, the process creates a profile that's named **Sales Integration Profile** in the Salesforce organization. The error occurs if a profile that has the same name already exists. This situation prevents you from creating a new profile.

### Resolution

To resolve this issue, check whether a profile that has the same name already exists in the Salesforce organization. If you created the profile before you enabled the server-to-server flow, rename the existing profile, and then try again. If you didn't create the profile, contact [Microsoft Support](/microsoft-sales-copilot/get-support).

## Required fields are missing

### Symptoms

When you try to enable Salesforce in a server-to-server flow, you receive the following error message:

> Required fields are missing: \<FieldNames\>

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that's created automatically. This error occurs if custom validation rules for user creation prevent the integration user from being automatically created in Salesforce.

### Resolution

To resolve this issue:

1. Temporarily disable the custom validation rules for user creation. To make this change, go to **Setup** > **Object Manager** > **User** > **Validation Rules**.
1. Try again to set up the Salesforce connection in the [Sales admin settings](/dynamics365/sales/admin-settings-overview).
1. After the Salesforce connection is set up and the integration user is created, re-enable your validation rules.

## More information

If your problem isn't resolved, go to the [Sales in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
