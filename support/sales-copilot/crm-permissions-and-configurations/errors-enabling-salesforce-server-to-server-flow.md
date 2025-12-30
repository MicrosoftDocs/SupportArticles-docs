---
title: Errors When Enabling Salesforce with Server-to-Server Flow
description: Troubleshoot errors that might occur when enabling Salesforce with a server-to-server flow in Sales app.
ms.date: 12/16/2025
ms.reviewer: marrabi, shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Errors that occur when enabling Salesforce with server-to-server flow

This article helps you troubleshoot errors that might occur when you try to enable Salesforce with a server-to-server flow in Sales app.

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

When you try to enable Salesforce with a server-to-server flow, the following error message might occur:

> Couldn't assign permission set because the integration user is inactive in Salesforce.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. The error occurs when the integration user is inactive in Salesforce. The permission set can't be assigned to an inactive user.

### Resolution

To resolve this issue:

1. In Salesforce, search for the **Sales Integration User** user.

1. Confirm the user is active.  
   - If inactive, set the user status to active.
   - If you can't activate the user, contact [Microsoft support](/microsoft-sales-copilot/get-support).

## Couldn't create user because Salesforce integration license limit reached

### Symptoms

When you try to enable Salesforce with a server-to-server flow, the following error message might occur:

> Couldn't create user because Salesforce integration license limit reached.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A Salesforce Integration user license is assigned to this integration user. The error occurs when the maximum number of Salesforce Integration user licenses is reached.

### Resolution

To resolve this issue, check if you reached the maximum number of Salesforce Integration user licenses. If you reached the maximum, reassign existing integration users to other licenses or purchase more licenses.

To check the number of integration user licenses available in your Salesforce organization:

1. Sign in to Salesforce as an administrator.

1. Go to **Setup** > **Company Settings** > **Company Information**.

1. Under **User Licenses**, check the number of available **Salesforce Integration** licenses under the **Remaining Licenses** column. If the number is **0**, deactivate existing integration users or change their licenses to other types. You can also purchase more licenses.

## Unexpected errors when enabling Salesforce with a server-to-server flow

### Symptoms

When you try to enable Salesforce with a server-to-server flow, you might receive one of the following error messages:

- > Couldn't get deployment status due to incorrect ID format.
- > Couldn't find the connected app.
- > Couldn't get user license ID is missing to create connection user.
- > Couldn't fully remove connection data from Dataverse. Contact Sales support to request manual cleanup.
- > Couldn't complete the connected app or permission set deployment to Salesforce. Try again.
- > Couldn't complete the connected app deployment to Salesforce. Try again.
- > Couldn't complete the permission set deployment to Salesforce. Try again.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. In this process, some unexpected errors might occur.

### Resolution

To resolve this issue, retry the operation. If the problem continues, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

> [!NOTE]
> You might encounter an error message that's not listed above. This issue can happen for several reasons. For example, your Salesforce organization might have a validation rule that requires specific values for user records. If this prevents the integration user from being created, try temporarily disabling the validation rule. Once the integration user is created, you can re-enable the rule.

## No changes were made

### Symptoms

When you try to enable Salesforce with a server-to-server flow, the following error message might occur:

> No changes were made.

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. The error occurs when the same permission set is already assigned to the user.

### Resolution

To resolve this problem, check for any manual changes to the connected app or profiles with the `CopilotForSales` prefix. If you find unintentional changes, revert them. Otherwise, retry the operation. If the problem continues, contact [Microsoft support](/microsoft-sales-copilot/get-support).

## The profile name is already in use. Pick a different name or rename the existing profile in Salesforce

### Symptoms

When you try to enable Salesforce with a server-to-server flow, the following error message might occur:

> The profile name is already in use. Pick a different name or rename the existing profile in Salesforce.

### Cause

During the Salesforce server-to-server flow setup, the process creates a profile named **Sales Integration Profile** in the Salesforce organization. The error occurs when a profile with the same name already exists, which prevents the creation process.

### Resolution

To resolve this issue, check if a profile with the same name already exists in the Salesforce organization. If you created the profile before enabling the server-to-server flow, rename the existing profile and try again. If you didn't create the profile, contact [Microsoft support](/microsoft-sales-copilot/get-support).

## Required fields are missing

### Symptoms

When you try to enable Salesforce with a server-to-server flow, the following error message might occur:

> Required fields are missing: [field_name]

### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. This error occurs when there are custom validation rules for user creation that prevent the integration user from being automatically created in Salesforce.

### Resolution

To resolve this issue:

1. Temporarily disable the custom validation rules for user creation by going to **Setup** > **Object Manager** > **User** > **Validation Rules**.
1. Create the integration user manually and provide the Salesforce user ID to [Microsoft support](/microsoft-sales-copilot/get-support) so the user can be added to the backend allow list. Microsoft then creates the user, bypassing the validation rules.

## More information

If your issue isn't resolved, go to the [Sales in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
