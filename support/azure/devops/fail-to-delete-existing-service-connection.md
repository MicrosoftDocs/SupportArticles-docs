---
title: Fail to delete an existing Azure RM service connection 
description: This article provides workaround for issues that you might encounter when you can't delete an existing Azure RM service connection. 
ms.date: 05/19/2023
ms.reviewer: cathmill, kirthishkt, v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Fail to delete existing Azure RM service connection

## Symptoms

When you try to delete an Azure RM service connection, you might experience one of several issues. For example, you may receive a "Failed to remove Azure permission 'RoldAssignmentId'... Failed to remove the service principal from Microsoft Entra ID" error message. Or the connection isn't being removed from the list of service connections, although there is no error.

## Resolution

If you experience these errors, you should still be able to delete the connection by selecting the **Delete** button. However, you must manually delete or edit the service principal by using the Active Directory app in the Azure portal.

If the **Delete** button doesn't remove the service connection, follow these steps:

1. Check whether the connection is automated or manual.
1. [Get the details for the endpoints by using the REST API.](/rest/api/azure/devops/serviceendpoint/endpoints/get-service-endpoints)
1. Make sure that you set the `includeFailed=true` parameter so that all service endpoints are captured. This should provide more information and show whether an issue affects the service connection (for example, in the `isReady` field).
1. [Try to delete the connections by using the REST API directly](/rest/api/azure/devops/serviceendpoint/endpoints/delete). Although the UI makes similar calls, it's always worth checking whether calling the API directly will create a different result.
1. If you use the API from the previous step by using the default parameters, and this still doesn't work, you can set the `deep` value to `false`. This setting causes the program to skip any checks and attempts that are part of the usual process to delete the underlying SPN.

You must manually delete or edit the service principal by using the Active Directory App in the Azure portal.

## See related

- [Azure RM service connection not listed for a task](azure-rm-service-connection-not-listed-for-a-task.md)

- [Troubleshoot service connections for Azure RM service principal (manual)](create-azure-rm-service-principal-manual.md)

- ["Failed to get Azure DevOps Service access token" error](failed-to-get-azure-devops-service-access-token.md)
