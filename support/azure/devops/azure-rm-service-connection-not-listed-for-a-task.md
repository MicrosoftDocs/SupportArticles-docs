---
title: Troubleshooting tips for issues while editing or updating service connections 
description: This article provides tips for issues that you might encounter while editing or updating azure RM service connections.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Azure RM Service connection not listed for a task

## Symptoms

When a user tries to load the Azure service connection in a pipeline task such as Azure App service deploy or Azure App service manage, the service connection doesn't appear in the list. However, when the user checks the **Service Connection** tab under **Project Settings**, the service connection is available.

## Debugging steps

1. From within your project, go to **Project settings > Service connections**.

1. Go to the service connection and edit it.

1. Press **F12**, and open the network trace window. If possible, select the **Disable cache** option in the panel under **Network** tab.

1. Select the **verify** button.

   You receive the following error message:

    ```output
    Failed to obtain the Json Web Token(JWT) using service principal client ID. Exception message: AADSTS700016: **Application with identifier 'xxxxxxf9-xxxx-xxxx-xxxx-c05xxxxxxxxx' was not found in the directory 'Microsoft'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant**. You may have sent your authentication request to the wrong tenant. Trace ID: xxxxxx2c-xxxx-xxxx-xxxx-e04xxxxxxxxx Correlation ID: xxxxxx72-xxxx-xxxx-xxxx-244xxxxxxxxxx Timestamp: 2022-05-19 09:08:53
    ```

    You will see the following response for the POST call in the trace:

    ```output
    {"result":[],"statusCode":400,"errorMessage":"Failed to obtain the Json Web Token(JWT) using service principal client ID. Exception message: AADSTS700016: Application with identifier 'xxxxxxf9-xxxx-xxxx-xxxx-c05xxxxxxxxx' was not found in the directory 'Microsoft'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant. You may have sent your authentication request to the wrong tenant.\r\nTrace ID: xxxxxx31-xxxx-xxxx-xxxx-32bxxxxxxxxx\r\nCorrelation ID: xxxxxx49-xxxx-xxxx-xxxx-725xxxxxxxxx\r\nTimestamp: 2022-05-19 09:11:35Z"}
    ```

    For more information, see [Get the API response of GET endpoints](/rest/api/azure/devops/serviceendpoint/endpoints/get?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true).

In the API response, check the `isReady` status. If the value is `false`, this indicates that the service connection is in a bad state.

## Resolution

1. Open **Project settings > Service connections**, and then select the faulty service connection.

1. Select **Manage Service Principle**.

   > [!NOTE]
   > This command redirects the connection to the Azure portal and displays the SPN (App) that was created as part of service connection creation.

1. Check whether the SPN (App) still exists. (It was likely deleted.)

1. If this is an automated service connection, create a new service connection. If this is a manual service connection, follow the steps in the ["Create an Azure Resource Manager service connection with an existing service principal"](/azure/devops/pipelines/library/connect-to-azure?view=azure-devops&preserve-view=true) section of [Connect to Microsoft Azure](/azure/devops/pipelines/library/connect-to-azure?view=azure-devops&viewFallbackFrom=azure-devopshttps&preserve-view=true) to update the service connection by using the new SPN (App) details.
