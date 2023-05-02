---
title: Troubleshooting tips for problems while verifying Azure RM service connection
description: This article explains about the problems that might occur when users verify the automatic Azure RM service connection.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Troubleshoot issues related to verifying Azure Resource Manager service connections

## "Failed to get Azure DevOps Service access token" error

### Symptoms

When users try to verify the automatic Azure RM service connection, they receive the following error message:

> Failed to get Azure DevOps Service access token, cache value is invalid.

:::image type="content" source="media/fail-to-verify-service-connection/edit-service-connection-azurerm.png" alt-text="Screenshot that shows verification of the automatic Azure RM connection.":::

### Debugging steps

Capture an F12/Fiddler trace while you reproduce the issue.

You will see following response for the POST call in the trace:

`{"authorization":{"parameters":{"tenantid":"xxxxxx49-XXXXcexxxxxx","serviceprincipalid":"xxxxxx7e-XXXX-027xxxxxxxxx","authenticationType":"spnKey","serviceprincipalkey":null,"accesstoken":null},"scheme":"ServicePrincipal"},"created}`

### Cause

When you run a service connection update call from the UI, the body of the `PUT` request contains an `accesstoken = null` entry. If we compare the `PUT` payload against the working service connections at either end of the operation, we don't see this entry. If the `AccessToken` property is present in the service connection UI object, it should have valid value (such as a GUID). It shouldn't be empty or null.

### Resolution

1. Go to the **Service Connection** page, and then select the affected service connection.
1. Select **Edit**.
1. Press **F12**, and then open the network trace window. If possible, select the **Disable cache** option in the panel under the **Network** tab.
1. Update the description.
1. Select the **Save** button.
1. If you are prompted for authorization, enter the required credentials.
   In network trace, you can now see the PUT call to update the service connection that failed.
1. Open the PUT call details, and copy the **Request Payload** by selecting **Payload > view source > Select the content and copy the content**.
1. In the request body, remove the **accesstoken: null** (or **accesstoken:''**) property under the authorization header.
1. Copy the updated **Request payload**, and make a service connection update PATCH API call by using Postman (or any other REST tool) by running the following API.

   `PATCH - https://dev.azure.com/{organization}/_apis/serviceendpoint/endpoints/{endpointId}?api-version=6.0-preview.4`

For more information, see [Endpoints - Update Service Endpoint](/rest/api/azure/devops/serviceendpoint/endpoints/update-service-endpoint?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true).

## Error when verifying the manual Azure RM service connection

### Symptoms

After users provide the details to create a manual Azure RM service connection, and then they select the **Verify** button, verification fails, and users receive the following error message:

```output
Failed to query service connection API: 'https://management.azure.com/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx?api-version=2016-06-01 '. Status Code: 'Forbidden', Response from server: '{"error":{"code":"AuthorizationFailed","message":"The client 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' with object id 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' does not have authorization to perform action 'Microsoft.Resources/subscriptions/read' over scope '/subscriptions/xxxxxx08-xxxx-48ec-xxxx-eadxxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials."}}'
```

:::image type="content" source="media/fail-to-verify-service-connection/new-service-connection-errormessage.png" alt-text="Screenshot that shows the creation of new service connection.":::

### Debugging steps

Capture F12/Fiddler trace, while reproducing the issue.

You will see the following response for the POST call in the trace:

```output
{"result":[],"statusCode":403,"errorMessage":"Failed to query service connection API: 'https://management.azure.com/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx?api-version=2016-06-01 '. Status Code: 'Forbidden', Response from server: '{"error":{"code":"AuthorizationFailed","message":"The client 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' with object id 'xxxxxxaf-xxxx-xxxx-xxxx-6bexxxxxxxxx' does not have authorization to perform action 'Microsoft.Resources/subscriptions/read' over scope '/subscriptions/xxxxxx08-xxxx-xxxx-xxxx-eadxxxxxxxxx' or the scope is invalid. If access was recently granted, please refresh your credentials."}}'"}
```

### Resolution

Make sure that the newly created SPN (App) has the Contributor and Reader permissions on the subscription.

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