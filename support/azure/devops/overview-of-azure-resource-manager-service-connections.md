---
title: Introduction to Azure RM service connection
description: Provides an overview of common connectivity issues in Azure Devops and describes the tools to troubleshoot the issues.
ms.date: 04/21/2023
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Introduction to Azure RM service connection

An Azure Resource Manager service connection is used to connect to a Microsoft Azure subscription or Azure resources by using Service Principal Authentication (SPA) or an Azure-Managed Service Identity.

The connection dialog box offers two main connection modes.

- **Automated subscription detection**: In this mode, Azure Pipelines queries Azure for all the subscriptions and instances to which you have access. These subscriptions use the credentials that you currently use to sign in to Azure Pipelines (including Microsoft accounts and School or Work accounts).

If you don't see the subscription that you want to use, sign out of Azure Pipelines, and then sign in again by using the appropriate account credentials.

- **Manual subscription pipeline**: In this mode, you must specify the service principal that you want to use to connect to Azure. The service principal specifies the resources and the access levels that are available over the connection.

Use this approach when you have to connect to an Azure account by using credentials that differ from the credentials that you currently use to sign in to Azure Pipelines. This is a useful method to maximize security and limit access. Service principals are valid for two years.

## See also

["Azure Resource Manager service connection"](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml) section of [Manage service connections](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)
[Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops)
