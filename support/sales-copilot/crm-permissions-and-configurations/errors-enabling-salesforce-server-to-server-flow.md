---
title: Errors When Enabling Salesforce With Server-to-server Flow
description: Resolves errors that might occur when enabling Salesforce with server-to-server flow in Microsoft Copilot for Sales.
ms.date: 05/26/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.reviewer: marrabi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Errors that occur when enabling Salesforce with server-to-server flow

This article helps you troubleshoot errors that might occur when you try to enable Salesforce with server-to-server flow in Microsoft Copilot for Sales.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrator  |

## Couldn't assign permission set because the integration user is inactive in Salesforce

### Symptoms

When you try to enable Salesforce with server-to-server flow，the following error message might occur:

> Couldn't assign permission set because the integration user is inactive in Salesforce.

### Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. The error occurs when the integration user is inactive in Salesforce. The permission set can't be assigned to an inactive user.

### Resolution

To resolve this issue,

1. In Salesforce, search for a user with the `copilotforsalesintegrationuser` prefix in the username.

2. Confirm the user is active.  
   - If inactive, set the user status to active.
   - If you can't activate the user, contact [Microsoft support](/microsoft-sales-copilot/get-support).

## Couldn't create user because Salesforce integration license limit reached

### Symptoms

When you try to enable Salesforce with server-to-server flow，the following error message might occur:

> Couldn't create user because Salesforce integration license limit reached.

### Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. Salesforce Integration user license is assigned to this integration user. The error occurs when the maximum allowed number of Salesforce Integration user licenses has already been reached.

### Resolution

To resolve this issue, check if the maximum allowed number of Salesforce Integration user licenses has been reached. If so, you need to either reassign existing integration users to other licenses or purchase more licenses.

To check the number of integration user licenses available in your Salesforce organization:

1. Sign in to Salesforce as an administrator.

2. Go to **Setup** > **Company Settings** > **Company Information**.

3. Under **User Licenses**, check the number of **Salesforce Integration** licenses available under the **Remaining Licenses** column. If the number is 0, you need to either deactivate existing integration users or change their licenses to other types. You can also purchase more licenses.

## Unexpected errors when enabling Salesforce with server-to-server flow

### Symptoms

When you try to enable Salesforce with server-to-server flow, you might receive one of the following error messages:

- > Couldn't get deployment status due to incorrect ID format.
- > Couldn't find the connected app.
- > Couldn't get user license ID is missing to create connection user.
- > Couldn't fully remove connection data from Dataverse. Contact Sales support to request manual cleanup.
- > Couldn't complete the connected app or permission set deployment to Salesforce. Try again.
- > Couldn't complete the connected app deployment to Salesforce. Try again.
- > Couldn't complete the permission set deployment to Salesforce. Try again.

### Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. In this process, some unexpected errors might occur.

### Resolution

To resolve this issue, retry the operation. If the issue persists, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## No changes were made

### Symptoms

When you try to enable Salesforce with server-to-server flow，the following error message might occur:

> No changes were made.

### Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. The error occurs when the same permission set has already been assigned to the user.

### Resolution

To resolve this issue, check for any manual changes to the connected app or profiles with the `CopilotForSales` prefix. If the changes were unintentional, revert them. Otherwise, retry the operation. If the issue continues, contact [Microsoft support](/microsoft-sales-copilot/get-support).

## The profile name is already in use. Pick a different name or rename the existing profile in Salesforce

### Symptoms

When you try to enable Salesforce with server-to-server flow，the following error message might occur:

> The profile name is already in use. Pick a different name or rename the existing profile in Salesforce.

### Cause

During Salesforce server-to-server flow setup, a profile named **Copilot For Sales Integration Profile** is created in the Salesforce organization. The error occurs when a profile with the same name already exists, thereby preventing the creation process.

### Resolution

To resolve this issue, check if a profile with the same name already exists in the Salesforce organization. If it was created before enabling the server-to-server flow, rename the existing profile and try again. If the profile wasn't created previously, contact [Microsoft support](/microsoft-sales-copilot/get-support).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
