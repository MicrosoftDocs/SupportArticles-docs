---
title: Troubleshooting problems related to subscription based service connections
description: This article explains about common problems when creating subscription based service connections.
ms.date: 05/19/2023
ms.reviewer: cathmill, kirthishkt, v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Troubleshooting subscription related scenarios while creating service connections

This article helps to resolve problems that you might encounter while creating an subscription-based service connection.

## Loading subscriptions window shows spinning wheel when trying to create a service connection

### Symptoms

When you try to create an Azure RM automatic subscription-based service connection, the **Loading subscriptions** message window stops responding and continually shows a busy status (spinning wheel).

:::image type="content" source="media/troubleshoot-subscription-related-scenarios/new-azure-service-connection.png" alt-text="Screenshot that shows the spinning wheel when you try to create a service connection.":::

### Debugging steps

> [!NOTE]
> We query for all the subscriptions against the logged-in Azure DevOps user who is trying to create a service connection.

Check the behavior on the billing page (**Organization settings > Billing > Change billing**).

This problem occurs if a Microsoft Entra refresh token expires.

### Cause

This scenario might occur if multi-factor authentication (MFA) is enabled in the Microsoft Entra ID to which the subscription is linked. This resolution fixes the issue for MFA-enabled Microsoft Entra ID. Alternatively, as a quick workaround, you can disable MFA.

### Resolution

To resolve this issue, follow these steps:

1. Navigate to your [VS profile](https://app.vsaex.visualstudio.com/me?mkt=en-US).

1. Check whether you have many tenants.

1. Select each tenant, and reauthenticate it.

1. Try again to create a service connection to see whether the subscription loads.

:::image type="content" source="media/troubleshoot-subscription-related-scenarios/vs-profile-dropdown-list.png" alt-text="Screenshot that shows the list of available VS profiles.":::

## "Failed to set Azure permission" error when saving a service connection

### Symptoms

When you create a service connection and try to save it by selecting the **Save** button, you might receive the following error message:

```output
Failed to set Azure permission 'RoleAssignmentId: xxxxxx26-xxxx-xxxx-xxxx-8f0xxxxxxx' for the service principal 'xxxxxx06-xxxx-xxxx-xxxx-6fbxxxxxxxxx' on subscription ID 'xxxxxxb6-xxxx-xxxx-xxxx-23xxxxxxxxx': error code: Forbidden, inner error code: AuthorizationFailed, inner error message The client 'kxxxxt@micrxxxxoft.com' with object id 'xxxxxx74-xxxx-xxxx-xxxx-477xxxxxxxxx' does not have authorization to perform action 'Microsoft.Authorization/roleAssignments/write' over scope '/subscriptions/xxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials. Ensure that the user has 'Owner' or 'User Access Administrator' permissions on the Subscription.
```

### Debugging steps

1. Capture an F12 or Fiddler trace.
1. In a GET call (similar to `https://devopsdevil.visualstudio.com/xxxxfa-xxxx-xxxx-xxxx-76dxxxxxxxxx/_apis/serviceendpoint/endpoints/xxxxxxxbb-xxxx-xxxx-xxxx-df4xxxxxxxxx`), the following response is returned:

```output
 {"data":{"environment":"AzureCloud","scopeLevel":"Subscription","subscriptionId":"xxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx","subscriptionName":"SIxxxxA","resourceGroupName":"","mlWorkspaceName":"","mlWorkspaceLocation":"","managementGroupId":"","managementGroupName":"","oboAuthorization":"","creationMode":"Automatic","azureSpnRoleAssignmentId":"","azureSpnPermissions":"[{"roleAssignmentId":"xxxxxx26-xxxx-xxxx-xxxx-8f0xxxxxxxxx","resourceProvider":"Microsoft.RoleAssignment","provisioned":false}]","spnObjectId":"xxxxxx06-xxxx-xxxx-xxxx-6fbxxxxxxxxx","appObjectId":"xxxxxx01-xxxx-xxxx-xxxx-36axxxxxxxxx","resourceId":""},"id":"xxxxxxbb-xxxx-xxxx-xxxx-df4xxxxxxxxx","name":"Sixxxxda-subscription","type":"azurerm","url":https://management.azure.com/,"createdBy":{"displayName":<name>,"url":https://spsprodwus21.vssps.visualstudio.com/xxxxxx52-xxxx-xxxx-xxxx-b65xxxxxxxxx/_apis/Identities/xxxxxx71-xxxx-xxxx-xxxx-6b2xxxxxxxxx,"_links":{"avatar":{"href":https://devopsdevil.visualstudio.com/_apis/GraphProfile/MemberAvatars/aad.N2RmZxxxxxxxNi03MWUzLWJlNzItZWYzMTA5YzRjZTA3} },"id":"xxxxxx71-xxxx-xxxx-xxxxx-6b2xxxxxxxxx","uniqueName":kxxt@mixxxxxxft.com,"imageUrl":https://devopsdevil.visualstudio.com/_apis/GraphProfile/MemberAvatars/aad.N2RmZWEyNDctxxxxxi03MWUzLWJxxxxxxxxxMTA5YzRjZTA3,"descriptor":"aad.N2RmxxxxxxxxxxxxMWUzLWJlNzItZWYzMTA5YzRjZTA3" },"description":"","authorization":{"parameters":{"tenantid":"xxxxxxxbf-xxxx-xxxx-xxxx-2d7xxxxxxxxx","serviceprincipalid":"xxxxxx5d-xxxx-xxxx-xxxx-dfaxxxxxxxxx","authenticationType":"spnKey","serviceprincipalkey":null},"scheme":"ServicePrincipal"},"isShared":false,"isReady":false,"operationStatus":{"state":"Failed","statusMessage":" Failed to set Azure permission 'RoleAssignmentId: xxxxxx26-xxxx-xxxx-xxxx-8f0fxxxxxxxxx' for the service principal 'xxxxxx06-xxxx-xxxx-xxxx-6fbxxxxxxxxxx' on subscription ID 'xxxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx': error code: Forbidden, inner error code: AuthorizationFailed, inner error message The client 'kxxxxxt@micxxxxxoft.com' with object id 'xxxxxx74-xxxx-xxxx-xxxx-477xxxxxxxxx' does not have authorization to perform action 'Microsoft.Authorization/roleAssignments/write' over scope '/subscriptions/xxxxxxxb6-xxxx-xxxx-xxxx-234xxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials. Ensure that the user has 'Owner' or 'User Access Administrator' permissions on the Subscription."},"owner":"Library","serviceEndpointProjectReferences":[{"projectReference":{"id":"xxxxxxfa-xxxx-xxxx-xxxx-76dxxxxxxxxx","name":"IIS"},"name":"Sxxxxxxxda-subscription","description":""}]}
```

### Resolution

Check the user permission on the subscription. Make sure that you have the **Owner** or **User Access Administrator** permission on the subscription.

## "You don't appear to have an active Azure subscription" error

When you try to create a new Azure RM automatic subscription-based service connection, you may receive an "You don't appear to have an active Azure subscription" error message.

:::image type="content" source="media/troubleshoot-subscription-related-scenarios/subscription-new-azure-service-connection.png" alt-text="Screenshot that shows the error message.":::

### Debugging steps

Check the behavior on the billing page (**Organization settings > Billing > Change billing**).

:::image type="content" source="media/troubleshoot-subscription-related-scenarios/change-billing-subscription.png" alt-text="Screenshot that shows the Billing page.":::

### Resolution

To resolve this issue, use one of the following methods.

**Method 1**

1. Sign out of Azure DevOps and close all browsers.

1. Sign-in again, and then check whether the subscriptions are loading.

**Method 2**

1. Navigate to [VS profile](https://app.vsaex.visualstudio.com/me?mkt=en-US).
1. Check whether you have many tenants.
1. Select each tenant, and then reauthenticate.
1. Try to create a service connection, and then check whether the subscription loads.
1. If these steps don't resolve the issue, then the user data shape has to be cleaned up. Contact the Azure DevOps team to open a support request. Capture an [F12/Fiddler trace](overview-of-azure-resource-manager-service-connections.md#fiddler-trace) while you reproduce the issue from the service connection page and billing page, and include the trace in the support request.

## Subscription is not listed when creating a service connection

Consider a scenario when you try to create a new Azure RM automatic subscription-based service connection and the service connection isn't listed.

### Resolution

A maximum of 50 Azure subscriptions are listed. If the subscription isn't listed when you create a service connection, follow these steps:

1. Create a native Microsoft Entra user in the Microsoft Entra instance of your Azure subscription.

1. Set up the new Microsoft Entra user so that it has the appropriate permissions to set up billing or create service connections. For more information, see [Add a user to manage billing](/azure/devops/organizations/billing/add-backup-billing-managers).

1. Add the Microsoft Entra user to the Azure DevOps organization to have the Stakeholder access level, and then add it to the **Project Collection Administrators group (for billing)**. Or, make sure that you have sufficient permissions in the Team Project to create service connections.

1. Log in to Azure DevOps by using the new user credentials, and then set up a billing. You will see only one Azure subscription in the list.

## See related

- [Troubleshoot Azure RM service connection issues](overview-of-azure-resource-manager-service-connections.md)
