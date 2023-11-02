---
title: Troubleshoot service connections for Azure RM service principal (manual)
description: This article explains about how to create service principals by using the Azure RM service principal (manual) option and also troubleshoot an error that occurs while verifying manual Azure RM service connection.
ms.date: 05/19/2023
ms.reviewer: cathmill, kirthishkt, v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Troubleshoot service connections for Azure RM service principal (manual)

## Create Azure RM service principal (manual)

Per company policy and security protocols, some Azure DevOps admins don't have permissions to manage Azure subscriptions. To create service principal names (SPNs), these admins can use the manual Azure RM service principal option.

To create SPNs, users who have permissions for Azure subscriptions and Microsoft Entra ID can follow these steps:

1. Sign in to the [Azure portal](https://ms.portal.azure.com/#home).

1. Select **Microsoft Entra ID > App registrations**.

1. Select your application on the list, and then select **Client secrets > New client secret**.

1. Provide a description and duration for the application secret (password-based authentication), and then select **Add**.

For more information, see [Create a new application secret](/azure/active-directory/develop/howto-create-service-principal-portal).

Provide this SPN Contributor role or similar RBAC permissions on the subscription. You can even provide the Reader role at the subscription level. However, make sure that you provide Contributor access on the resource and resource group that these roles would update or deploy.

To get the subscription details and create an Azure RM service connection by using the manual **Azure RM service principal** option, see [Create an Azure Resource Manager service connection with an existing service principal](/azure/devops/pipelines/library/connect-to-azure).

Subscription details include the following information:

- Subscription ID
- Subscription Name
- Service principal ID (client ID)
- Service principal key (the value of the secret that you created in step 3)
- Tenant ID (Directory ID)

To get this information, download and run this [PowerShell script](https://github.com/microsoft/azure-pipelines-extensions/blob/master/TaskModules/powershell/Azure/SPNCreation.ps1) in an Azure PowerShell window. When you are prompted, enter your subscription name, password, role (optional), and the cloud type, such as Azure Cloud (default), Azure Stack, or Azure Government Cloud.

## Error when verifying the manual Azure RM service connection

### Symptoms

After you provide the details to create a manual Azure RM service connection, select the **Verify** button, verification fails. You may receive the following error message:

```output
Failed to query service connection API: ''https://management.azure.com/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx?api-version=2016-06-01 '. Status Code: 'Forbidden', Response from server: '{"error":{"code":"AuthorizationFailed","message":"The client 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' with object id 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' does not have authorization to perform action 'Microsoft.Resources/subscriptions/read' over scope '/subscriptions/xxxxxx08-xxxx-48ec-xxxx-eadxxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials."}}'
```

:::image type="content" source="media/failed-to-get-azure-devops-service-access-token/new-service-connection-errormessage.png" alt-text="Screenshot that shows the creation of new service connection.":::

### Debugging steps

Capture [F12/Fiddler trace](overview-of-azure-resource-manager-service-connections.md#tools-used-for-troubleshooting-azure-rm-service-connection-scenarios), while reproducing the issue.

You will see the following response for the POST call in the trace:

```output
{"result":[],"statusCode":403,"errorMessage":"Failed to query service connection API: 'https://management.azure.com/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx?api-version=2016-06-01 '. Status Code: 'Forbidden', Response from server: '{"error":{"code":"AuthorizationFailed","message":"The client 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' with object id 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' does not have authorization to perform action 'Microsoft.Resources/subscriptions/read' over scope '/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials."}}'"}
```

### Resolution

Make sure that the newly created SPN (App) has the Contributor permission on the subscription.

## See related

[Troubleshoot Azure Resource Manager service connection issues](overview-of-azure-resource-manager-service-connections.md)
