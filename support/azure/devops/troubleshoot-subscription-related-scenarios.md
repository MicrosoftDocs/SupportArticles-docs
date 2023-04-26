---
title: Troubleshooting subscription related scenarios  while creating service connections
description: This article explains about common problems when creating subscription related service connections.
ms.date: 04/26/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Troubleshooting subscription related scenarios while creating service connections

This article helps to resolve problems that you might encounter while creating an subscription-based service connection.

## Loading subscriptions window shows spinning wheel when trying to create a service connection

### Symptoms

When users try to create an Azure RM automatic subscription-based service connection, the **Loading subscriptions** message window stops responding and continually shows a busy status (spinning wheel).

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/new-azure-service-connection.png" alt-text="Screenshot that shows the spinning wheel when you try to create a service connection.":::

### Debugging steps

> [!NOTE]
> We query for all the subscriptions against the logged-in Azure DevOps user who is trying to create a service connection.

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/change-billing-subscription.png" alt-text="Screenshot that shows how to check the behavior on the billing page.":::

Check the behavior on the billing page (**Organization settings > Billing > change billing**).

This problem occurs if an AAD refresh token expires.

### Cause

This scenario might occur if multi-factor authentication (MFA) is enabled in the Azure AD directory (AAD) to which the subscription is linked. This resolution fixes the issue for MFA-enabled AAD. Alternatively, as a quick workaround, you can disable MFA.

### Resolution

To resolve this issue, follow these steps:

1. Navigate to your VS profile.

1. Check whether the user has many tenants.

1. Select each tenant, and reauthenticate it.

1. Try again to create a service connection to see whether the subscription loads.

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/vs-profile-dropdown-list.png" alt-text="Screenshot that shows the list of available VS profiles.":::

## "You don't appear to have an active Azure subscription" error

When users try to create a new Azure RM automatic subscription-based service connection, they receive a "You don't appear to have an active Azure subscription" error message.

:::image type="content" source="media/troubleshooting-subscription-related-scenarios/subscription-new-azure-service-connection.png" alt-text="Screenshot that shows the error message.":::

### Debugging steps

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

## Subscription is not listed when creating a service connection

Users try to create a new Azure RM automatic subscription-based service connection, but the service connection isn't listed.

### Resolution

A maximum of 50 Azure subscriptions are listed. If the subscription isn't listed when you create a service connection, follow these steps:

1. Create a native Azure AD user in the Azure AD instance of your Azure subscription.

1. Set up the new Azure AD user so that it has the appropriate permissions to set up billing or create service connections. For more information, see [Add a user to manage billing](/azure/devops/organizations/billing/add-backup-billing-managers?view=azure-devops&preserve-view=true).

1. Add the Azure AD user to the Azure DevOps organization to have the Stakeholder access level, and then add it to the **Project Collection Administrators group (for billing)**. Or, make sure that the user has sufficient permissions in the Team Project to create service connections.

1. Log in to Azure DevOps by using the new user credentials, and then set up a billing. You will see only one Azure subscription in the list.

## Create Azure RM service principal (manual)

Per company policy and security protocols, some Azure DevOps admins don't have permissions to manage Azure subscriptions. To create service principal names (SPNs), these admins can use the manual Azure RM service principal option.

To create SPNs, users who have permissions for Azure subscriptions and Azure Active Directory (Azure AD) can follow these steps:

1. Sign in to the [Azure portal](https://ms.portal.azure.com/#home).

1. Select **Azure Active Directory > App registrations**.

1. Select your application on the list, and then select **Client secrets > New client secret**.

1. Provide a description and duration for the application secret (password-based authentication), and then select **Add**.

For more information, see [Create a new application secret](/azure/active-directory/develop/howto-create-service-principal-portal).

Provide this SPN Contributor role or similar RBAC permissions on the subscription. You can even provide the Reader role at the subscription level. However, make sure that you provide Contributor access on the resource and resource group that these roles would update or deploy.

To get the subscription details and create an ARM service connection by using the manual **Azure RM service principal** option, see [Create an Azure Resource Manager service connection with an existing service principal](/azure/devops/pipelines/library/connect-to-azure?view=azure-devops&preserve-view=true).

Subscription details include the following information:

- Subscription ID
- Subscription Name
- Service principal ID (client ID)
- Service principal key (the value of the secret that you created in step 3)
- Tenant ID (Directory ID)**

To get this information, download and run this [PowerShell script](https://github.com/microsoft/azure-pipelines-extensions/blob/master/TaskModules/powershell/Azure/SPNCreation.ps1) in an Azure PowerShell window. When you are prompted, enter your subscription name, password, role (optional), and the cloud type, such as Azure Cloud (default), Azure Stack, or Azure Government Cloud.

## See also

[Subscription isn't listed when creating a service connection](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true)

