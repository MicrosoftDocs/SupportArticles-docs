---
title: Troubleshoot connection issues in Azure Resource Manager service connection
description: Provides an overview of Azure RM service connection, types of connection modes, and lists the tools used to troubleshoot various scenarios.
ms.date: 04/25/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Troubleshoot connection issues in Azure Resource Manager service connection

There are various causes for connectivity issues in Azure Resource Manager service connection. This article series helps you troubleshoot various service connection problems and describes the tools and methods you can use for troubleshooting.

## Introduction to Azure RM service connection

An Azure Resource Manager service connection is used to connect to a Microsoft Azure subscription or Azure resources by using Service Principal Authentication (SPA) or an Azure-Managed Service Identity.

The **Connections** dialog box offers two main connection modes.

- **Automated subscription detection**: In this mode, Azure Pipelines queries Azure for all the subscriptions and instances to which you have access. These subscriptions use the credentials that you currently use to sign in to Azure Pipelines (including Microsoft accounts and School or Work accounts).

If you don't see the subscription that you want to use, sign out of Azure Pipelines, and then sign in again by using the appropriate account credentials.

- **Manual subscription pipeline**: In this mode, you must specify the service principal that you want to use to connect to Azure. The service principal specifies the resources and the access levels that are available over the connection.

Use this approach when you have to connect to an Azure account by using credentials that differ from the credentials that you currently use to sign in to Azure Pipelines. This is an useful method to maximize security and limit access. Service principals are valid for two years.

## Common connection issues

Use the following list to navigate to the appropriate article or section for detailed troubleshooting steps:

**Subscription related connection issues**

- [Loading subscriptions window shows spinning wheel when trying to create a service connection](troubleshoot-subscription-related-scenarios.md#loading-subscriptions-window-shows-spinning-wheel-when-trying-to-create-a-service-connection)

- [Subscription isn't listed when creating a service connection](troubleshoot-subscription-related-scenarios.md#subscription-isnt-listed-when-creating-a-service-connection)

- [There is no active Azure subscription](troubleshoot-subscription-related-scenarios.md)


- ["Failed to set Azure permission" error when trying to save a service connection](troubleshoot-azure-rm-scenarios-while-creating-service-connections.md#failed-to-set-azure-permission-error-when-trying-to-save-a-service-connection)

- [Error when verifying the manual Azure RM service connection](troubleshoot-azure-rm-scenarios-while-creating-service-connections.md#error-when-verifying-the-manual-azure-rm-service-connection)

- [Azure RM Service connection not listed for a task](troubleshoot-azure-rm-scenarios-while-editing-updating-service-connections.md#azure-rm-service-connection-not-listed-for-a-task)

- [User is not able to delete an existing Azure RM service connection](troubleshoot-azure-rm-scenarios-while-editing-updating-service-connections.md#user-is-not-able-to-delete-an-existing-azure-rm-service-connection)

## See also

["Azure Resource Manager service connection"](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml&preserve-view=true) section of [Manage service connections](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&preserve-view=true&tabs=yaml)
[Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true)
