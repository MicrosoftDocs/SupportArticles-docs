---
title: Failed to get Azure DevOps Service access token, cache value is invalid
description: This article explains about the problem that might occur when users try to verify the  automatic Azure RM service connection.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# "Failed to get Azure DevOps Service access token" error

## Symptoms

When users try to verify the automatic Azure RM service connection, they receive the following error message:

> Failed to get Azure DevOps Service access token, cache value is invalid.

:::image type="content" source="media/troubleshoot-azure-rm-failed-access-token/edit-service-connection-azurerm.png" alt-text="Screenshot that shows verification of the automatic Azure RM connection.":::

### Debugging steps

Capture an F12/Fiddler trace while you reproduce the issue.

You will see following response for the POST call in the trace:

`{"authorization":{"parameters":{"tenantid":"xxxxxx49-XXXXcexxxxxx","serviceprincipalid":"xxxxxx7e-XXXX-027xxxxxxxxx","authenticationType":"spnKey","serviceprincipalkey":null,"accesstoken":null},"scheme":"ServicePrincipal"},"created}`

### Cause

When you run a service connection update call from the UI, the body of the `PUT` request contains an `accesstoken = null` entry. If we compare the `PUT` payload against the working service connections at either end of the operation, we don't see this entry. If the `AccessToken` property is present in the service connection UI object, it should have valid value (such as a GUID). It shouldn't be empty or null.

### Resolution

1. Go to the **Service Connection** page, and then select the affected service connection.
1. Select **Edit**.
1. Press **F12**, and then open the network trace window. If possible, select the **disable cache** option in the panel.
1. Update the description.
1. Select the **Save** button.
1. If you are prompted for authorization, enter the required credentials.
1. In network trace, you can now see the PUT call to update the service connection that failed.
1. Open the PUT call details, and copy the request body by selecting **Payload > View source > Copy the content**.
1. In the request body, remove the **accesstoken: null** (or **accesstoken:''**)property under the authorization header.
1. Copy the request body, and make a service connection update `PATCH REST` call by using Postman (or any other `REST` tool) by running the following command.

`PUT https://dev.azure.com/{organization}/_apis/serviceendpoint/endpoints/{endpointId}?api-version=6.0-preview.4`

For more information, see [Endpoints - Update Service Endpoint](/rest/api/azure/devops/serviceendpoint/endpoints/update-service-endpoint?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true).

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]