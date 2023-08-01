---
title: Azure RM service connection not listed for a task 
description: This article provides tips for an issue that you might encounter when a service connection is not listed for a task.
ms.date: 05/19/2023
ms.reviewer: cathmill, kirthishkt, v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Azure RM service connection not listed for task

## Symptoms

When you try to load the Azure Resource Manager (Azure RM) service connection in a pipeline task, such as Azure App service deploy or Azure App service manager, the service connection doesn't appear in the list. However, when you check the Service **Connection** tab under **Project Settings**, the service connection is available.

The **Settings / Service connections** screen shows that the Azure RM Service connection is listed.

:::image type="content" source="media/azure-rm-service-connection-not-listed-for-a-task/service-connection-not-listed-list.png" alt-text="Screenshot that shows the Service connection is listed.":::

The **Azure PowerShell task** screen shows that the Azure RM Service connection is not listed.

:::image type="content" source="media/azure-rm-service-connection-not-listed-for-a-task/service-connection-not-listed-list-powershell-script.png" alt-text="Screenshot that shows the service connection not listed.":::

## Debugging steps

1. Go to the service connection page, and then select the affected service connection.

1. Select the **Edit** button.

1. Press <kbd>F12</kbd>, and then open the network trace window. If possible, enable the  **Disable cache** check box in the panel under the **Network** tab.

1. Select the **verify** button.

   You receive the following error message:

    ```output
    Failed to obtain the Json Web Token(JWT) using service principal client ID. Exception message: AADSTS700016: **Application with identifier 'xxxxxxf9-xxxx-xxxx-xxxx-c05xxxxxxxxx' was not found in the directory 'Microsoft'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant**. You may have sent your authentication request to the wrong tenant. Trace ID: xxxxxx2c-xxxx-xxxx-xxxx-e04xxxxxxxxx Correlation ID: xxxxxx72-xxxx-xxxx-xxxx-244xxxxxxxxxx Timestamp: 2022-05-19 09:08:53Z
    ```

    You will see the following response for the POST call in the trace:

    ```output
    {"result":[],"statusCode":400,"errorMessage":"Failed to obtain the Json Web Token(JWT) using service principal client ID. Exception message: AADSTS700016: **Application with identifier 'xxxxxxf9-xxxx-xxxx-xxxx-c05xxxxxxxxx' was not found in the directory 'Microsoft'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant**. You may have sent your authentication request to the wrong tenant.\r\nTrace ID: xxxxxx31-xxxx-xxxx-xxxx-32bxxxxxxxxx\r\nCorrelation ID: xxxxxx49-xxxx-xxxx-xxxx-725xxxxxxxxx\r\nTimestamp: 2022-05-19 09:11:35Z"}
    ```

    For more information, see [Get the API response of GET endpoints](/rest/api/azure/devops/serviceendpoint/endpoints/get?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true).

    In the API response, check the `isReady` status. If the value is `false`, this indicates that the service connection is in a bad state.

## Resolution

1. Open **Project settings > Service connections**, and then select the faulty service connection.

1. Select **Manage Service Principle**.

   > [!NOTE]
   > This command redirects the connection to the Azure portal and displays the SPN (App) that was created as part of service connection creation.

1. Check whether the SPN (App) still exists. (It was likely deleted.)

1. If this is an automated service connection, create a new service connection. If this is a manual service connection, follow the steps in the [Create an Azure Resource Manager service connection](/azure/devops/pipelines/library/connect-to-azure) to update the service connection by using the new SPN (App) details.

## See related

- [Troubleshoot Azure RM service connection issues](overview-of-azure-resource-manager-service-connections.md)

- [Error when verifying the manual Azure RM service connection](create-azure-rm-service-principal-manual.md)
