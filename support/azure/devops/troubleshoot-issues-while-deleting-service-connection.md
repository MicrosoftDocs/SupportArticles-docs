---
title: Troubleshooting tips for problems while deleting Azure RM service connection
description: This article explains about the problems that might occur when users are unable to delete the Azure RM service connection.
ms.date: 04/24/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# User is not able to delete an existing Azure RM service connection

## Symptoms

When users try to delete an Azure RM service connection, they experience one of several issues. For example, they receive a "Failed to remove Azure permission 'RoldAssignmentId'... Failed to remove the service principal from Azure Active Directory" error message. Or, the connection isn't removed from the list of service connections even though no error is reported.

:::image type="content" source="media/troubleshoot-azure-rm-scenarios-while-editing-updating-service-connections/delete-service-connection.png" alt-text="Screenshot that shows an error while deleting an existing service connection.":::

## Resolution

If users experience these errors, they should still be able to delete the connection by selecting the **Delete** button. However, they must manually delete or edit the service principal by using the Active Directory app in the Azure portal.

If the **Delete** button doesn't remove the service connection, follow these steps:

1. Check whether the connection is automated or manual.
1. [Get the details for the endpoints by using the REST API.](/rest/api/azure/devops/serviceendpoint/endpoints/get-service-endpoints?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true)
1. Make sure that you set the `includeFailed=true` parameter so that all service endpoints are captured. This should provide more information and show whether an issue affects the service connection (for example, in the `isReady` field).
1. [Try to delete the connections by using the REST API directly](/rest/api/azure/devops/serviceendpoint/endpoints/delete?view=azure-devops-rest-6.0&tabs=HTTP&preserve-view=true). Although the UI makes similar calls, it's always worth checking whether calling the API directly will create a different result.
1. If you use the API from the previous step by using the default parameters, and this still doesn't work, you can set the `deep` value to `false`. This setting causes the program to skip any checks and attempts that are part of the usual process to delete the underlying SPN.

> [!NOTE]
> The user must manually delete or edit the service principal by using the Active Directory app in the Azure portal.