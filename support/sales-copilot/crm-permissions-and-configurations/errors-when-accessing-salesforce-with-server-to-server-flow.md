---
title: Errors When Accessing Salesforce with Server-to-Server Flow
description: Troubleshoot and resolve errors that occur when accessing Salesforce with server-to-server flow or during setup in Microsoft Copilot for Sales.
ms.date: 05/29/2025
author: sbmjais
ms.author: shjais
ms.reviewer: marrabi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Errors that occur when accessing Salesforce with server-to-server flow

This article helps you troubleshoot and resolve errors that might occur when a user tries to access Salesforce with a server-to-server flow or when an administrator sets up the server-to-server flow for Salesforce in Microsoft Copilot for Sales.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | All users or administrators   |

## Access denied for this user

### Symptoms

When a user tries to access Salesforce with the server-to-server flow, the following error message occurs:

> Access denied for this user.

You might also see the following message:

> User doesn't have admin permission to access the connected app.

### Cause

This error occurs when the integration user isn't approved to access the connected app in Salesforce. During the server-to-server flow setup, a connected app is deployed and associated with an integration user. If the integration user lacks the necessary permissions, access is denied.

### Resolution

To resolve this issue, update the connected app configuration in Salesforce:

1. Sign in to Salesforce CRM as an administrator.

1. Go to **Setup** > **Platform Tools** > **Apps** > **Connected Apps** > **Managed Connected Apps**.

1. On the **Connected Apps** page, select **Copilot for Sales Connected App**.

1. Under **Custom Connected App Handler**, ensure that the value of **Run As** is set to **Copilot for Sales Integration User**.

1. Go to **Administration** > **Users** > **Users** and confirm that the profile of the integration user is **CopilotForSalesIntegrationProfile**.

In addition, check if any unintended changes are made to the connected app configuration. If yes, revert the changes to the original configuration.

## Server-to-server authentication failed

### Symptoms

When a user tries to access Salesforce with the server-to-server flow, the following error message occurs:

> Server-to-server authentication failed.

You might also see one of the following messages:

- > Client credentials flow is disabled in Salesforce.
- > Couldn't get access token for client credentials flow in Salesforce.

### Cause

This error occurs when the connected app or the integration user is misconfigured. During the server-to-server flow setup, a connected app is deployed to the Salesforce organization and associated with an integration user. An access token is retrieved using the credentials of the connected app. If the configuration is incorrect, authentication fails.

### Resolution

To resolve this issue, ensure that the connected app and integration user configuration are correct.

1. Sign in to Salesforce CRM as an administrator.

1. Go to **Setup** > **Platform Tools** > **Apps** > **App Manager**.

1. On **Copilot for Sales Connected App** row, select the down arrow, and then select **Edit**.

1. Under **API (Enable OAuth Settings)**, ensure that **Enable Client Credentials Flow** is selected.

1. Go to **Apps** > **Connected Apps** > **Managed Connected Apps**.

1. On the **Connected Apps** page, select **Copilot for Sales Connected App**.

1. Under **Custom Connected App Handler**, ensure that the value of **Run As** is set to **Copilot for Sales Integration User**.

1. Open user details for the **Copilot for Sales Integration User** user and confirm the following:

    1. The profile of the integration user is **CopilotForSalesIntegrationProfile**.
    1. The user is associated with the **Copilot for Sales connected app permission set**.
    1. The user is associated with the **Salesforce API Integration** permission set license assignments.

In addition, check if any unintended changes are made to the connected app or integration user configuration. If yes, revert the changes to the original configuration.

## Server-to-server authorization failed

### Symptoms

When a user tries to access Salesforce with the server-to-server flow, the following error message occurs:

> Server-to-server authorization failed.

You might also see one of the following messages:

#### Error 1: Couldn't get client credentials to access Salesforce

##### Cause

During the Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user. An access token is retrieved with the client ID and the secret of the connected app. The error occurs when the secret is invalid.

##### Resolution

To resolve this issue, contact [Microsoft support](/microsoft-sales-copilot/get-support) and provide the following information:

- Whether the "Copilot for Sales Connected App" connected app is updated accidentally.
- If the connected app is still available, provide its ID.

#### Error 2: Session ID isn't allowed for use REST API access at Salesforce

##### Cause

This error occurs if the appropriate OAuth scope isn't set for the connected app during the Salesforce server-to-server flow setup.

##### Resolution

To resolve this issue, contact your administrator to set the appropriate OAuth scope for the connected app and confirm that the connection is still active in admin settings.

1. Sign in to Salesforce CRM as an administrator.

1. Go to **Setup** > **Platform Tools** > **Apps** > **App Manager**.

1. On **Copilot for Sales Connected App** row, select the down arrow, and then select **Edit**.

1. Under **API (Enable OAuth Settings)**, ensure the **Manage user data via APIs (api)** is selected in the **Selected OAuth Scopes** list. If it's not selected, check if the setting is changed manually by mistake. If yes, revert the changes.

   > [!NOTE]
   > If the **Manage user data via APIs (api)** isn't selected, the connected app can't access Salesforce data.

## Trouble connecting to Salesforce

### Symptoms

When a user tries to access Salesforce with the server-to-server flow, the following error message occurs:

> Trouble connecting to Salesforce.

You might also see the following message:

> Couldn't get Client ID for access token retrieval from Salesforce. The connected app might be misconfigured.

### Cause

This error occurs when the client ID of the Salesforce connected app is invalid. During the server-to-server flow setup, a connected app is deployed in Salesforce and linked to an integration user. The access token is retrieved using the client ID and secret of this app. If the client ID is missing or incorrect, authentication fails.

### Resolution

To resolve this issue, contact [Microsoft support](/microsoft-sales-copilot/get-support) and provide the following information:

- Whether the "Copilot for Sales Connected App" connected app is deleted accidentally.
- If the connected app is still available, provide its ID.

## Try again

### Symptoms

As an administrator, when you try to set up the server-to-server flow for Salesforce, you might receive one of the following error messages:

- > Try again.
- > This might be a temporary error. Try again. If it doesn't work, check back in 5-10 minutes.

### Cause

When you set up the server-to-server flow for Salesforce, the system attempts to establish a connection with Salesforce. During the setup, you might run into a few temporary issues.

### Resolution

To resolve this issue, wait for a few minutes and then try again. If the issue persists, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## Unauthorized access denied

### Symptoms

When a user tries to access Salesforce with the server-to-server flow, the following error message occurs:

> Unauthorized access denied.

You might also see the following message:

> Access token expired or invalid. Try saving again to refresh it.

### Cause

The access token used for authentication is expired or invalid.

### Resolution

To resolve this issue, try again after 10 to 15 minutes. If this issue persists, check with your administrator to confirm if the connection is still active.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
