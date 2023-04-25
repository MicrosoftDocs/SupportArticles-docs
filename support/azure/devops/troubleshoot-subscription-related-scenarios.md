---
title: Troubleshooting subscription related scenarios 
description: This article explains about common problems when creating subscription related service connections.
ms.date: 04/21/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Troubleshooting subscription related scenarios while creating service connections

This article helps to resolve problems that you might encounter while creating an subscription-based service connection.

## Loading subscriptions window shows spinning wheel when trying to create a service connection

### Symptoms

When users try to create an Azure RM automatic subscription-based service connection, the Loading subscriptions message window stops responding and continually shows a busy status (spinning wheel).

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/new-azure-service-connection.png" alt-text="Screenshot that shows the spinning wheel when you try to create a service connection.":::

Debugging steps

> [!NOTE]
> We query for all the subscriptions against the logged-in Azure DevOps user who is trying to create a service connection.

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/change-billing-subscription.png" alt-text="Screenshot that shows how to check the behavior on the billing page.":::

Check the behavior on the billing page (**Organization settings > Billing > change billing**).

This issue occurs if an AAD refresh token expires.

### Cause

This scenario might occur if multi-factor authentication (MFA) is enabled in the Azure AD directory (AAD) to which the subscription is linked. This resolution fixes the issue for MFA-enabled AAD. Alternatively, as a quick workaround, you can disable MFA.

### Resolution

To resolve this issue, follow these steps:

1. Navigate to your VS profile.

1. Check whether the user has many tenants.

1. Select each tenant, and reauthenticate it.

1. Try again to create a service connection to see whether the subscription loads.

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/vs-profile-dropdown-list.png" alt-text="Screenshot that shows the list of available VS profiles.":::

## Subscription loading issues

This section provides steps to troubleshoot two scenarios which might occur when the subscription loads.

### Scenario 1: "You don't appear to have an active Azure subscription"

When users try to create a new Azure RM automatic subscription-based service connection, they receive a "You don't appear to have an active Azure subscription" error message.

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/subscription-new-azure-service-connection.png" alt-text="Screenshot that shows the error message.":::

**Debugging steps**

Check the behavior on the billing page (**Organization settings > Billing > Change billing**).

### Resolution

To resolve this issue, use one of the following methods.

**Method 1**

1. Sign out of Azure DevOps and close all browsers.

1. Sign-in again, and then check whether the subscriptions are loading.

**Method 2**

1. Navigate to VS profile.
1. Check whether the user has many tenants.
1. Select each tenant, and then reauthenticate.
1. Try to create a service connection, and then check whether the subscription loads.
1. If these steps don't resolve the issue, then the user data shape has to be cleaned up. Contact the Azure DevOps team to open a Support Request. Capture an `F12/Fiddler` trace while you reproduce the issue from the service connection page and billing page, and include the trace in the Support Request.

### Scenario 2: Subscription isn't listed when creating a service connection

Users try to create a new Azure RM automatic subscription-based service connection, but the service connection isn't listed.

#### Resolution

Limitation: A maximum of 50 Azure subscriptions are listed.

If the subscription isn't listed when you create a service connection, follow these steps:

1. Create a native Azure AD user in the Azure AD instance of your Azure subscription.

1. Set up the new Azure AD user so that it has the appropriate permissions to set up billing or create service connections. For more information, see [Add a user to manage billing](/azure/devops/organizations/billing/add-backup-billing-managers?view=azure-devops&preserve-view=true).

1. Add the Azure AD user to the Azure DevOps organization to have the Stakeholder access level, and then add it to the **Project Collection Administrators group (for billing)**. Or, make sure that the user has sufficient permissions in the Team Project to create service connections.

1. Log in to Azure DevOps by using the new user credentials, and then set up a billing. You'll see only one Azure subscription in the list.

## See also

[Subscription isn't listed when creating a service connection](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true)

