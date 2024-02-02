---
title: Troubleshooting tips for problems while verifying Azure RM service connection
description: This article explains about the problems that might occur when users verify the automatic Azure RM service connection.
ms.date: 05/19/2023
ms.reviewer: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# "Failed to get Azure DevOps Service access token" error

## Symptoms

When you try to verify the automatic Azure RM service connection, you may receive the following error message:

> Failed to get Azure DevOps Service access token, cache value is invalid.

:::image type="content" source="media/failed-to-get-azure-devops-service-access-token/edit-service-connection-azurerm.png" alt-text="Screenshot that shows verification of the automatic Azure RM connection.":::

## Debugging steps

Capture an [F12/Fiddler trace](overview-of-azure-resource-manager-service-connections.md#tools-used-for-troubleshooting-azure-rm-service-connection-scenarios) while you reproduce the issue.

You will see following response for the POST call in the trace:

`{"authorization":{"parameters":{"tenantid":"xxxxxx49-XXXXcexxxxxx","serviceprincipalid":"xxxxxx7e-XXXX-027xxxxxxxxx","authenticationType":"spnKey","serviceprincipalkey":null,"**accesstoken":null**},"scheme":"ServicePrincipal"},"created}`

## Cause

When you run a service connection update call from the UI, the body of the `PUT` request contains an `accesstoken = null` entry. If we compare the `PUT` payload against the working service connections at either end of the operation, we don't see this entry. If the `AccessToken` property is present in the service connection UI object, it should have valid value (such as a GUID). It shouldn't be empty or **null**.

## Resolution

1. Go to the service connection page, and then select the affected service connection.
1. Select **Edit**.
1. Press <kbd>F12</kbd>, and then open the network trace window. If possible, select the **Disable cache** option in the panel under the **Network** tab.
1. Update the description.
1. Select the **Save** button.
1. If you are prompted for authorization, enter the required credentials.
   In network trace, you can now see the PUT call to update the service connection that failed.
1. Open the PUT call details, and copy the **Request Payload** by selecting **Payload > view source > Select the content and copy the content**.
1. In the request body, remove the **accesstoken: null** (or **accesstoken:''**) property under the authorization header.
1. Copy the updated **Request payload**, and make a service connection update PATCH API call by using Postman (or any other REST tool) by running the following API.

   `PATCH - https://dev.azure.com/{organization}/_apis/serviceendpoint/endpoints/{endpointId}?api-version=6.0-preview.4`

For more information, see [Endpoints - Update Service Endpoint](/rest/api/azure/devops/serviceendpoint/endpoints/update-service-endpoint?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true).

## See related

- [Azure RM service connection not listed for a task](azure-rm-service-connection-not-listed-for-a-task.md)

- [Fail to delete existing Azure RM service connection](fail-to-delete-existing-service-connection.md)

- [Troubleshoot Azure RM service connection issues](overview-of-azure-resource-manager-service-connections.md)
