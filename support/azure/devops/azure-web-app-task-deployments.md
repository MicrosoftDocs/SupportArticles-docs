---
title: Azure Web App tasks and deployments
description: This guided troubleshooter can help you with issues related to the usage of tasks in Azure Pipelines.
ms.date: 04/26/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Azure Web App tasks and deployments

This guided troubleshooter can help you with issues related to the usage of the following tasks in Azure Pipelines.

As a first step, we recommend you walk through the documentation for the following tasks and ensure that all the parameters are correctly defined in the tasks used in the pipelines.

- [Azure RM Web App deployment V4](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureRmWebAppDeploymentV4)
- [Azure Web App V1](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureWebAppV1): Preferably use this task for App Services deployment. For more complicated scenarios like XML transformation, use [Azure RM Web App deployment V4](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureRmWebAppDeploymentV4).
- [Azure Function App](/azure/devops/pipelines/tasks/reference/azure-function-app-v1): Consider using this task for Function App deployments.
- [Azure File Copy](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureFileCopyV5)
- [Azure PowerShell](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzurePowerShellV5)
- [Azure Key Vault](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureKeyVaultV2)
- [Azure SQL deployment](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/SqlServerDacpacDeployment)

Also, refer to the *readme.doc* in the GitHub repo and this [Deploy to Azure](/azure/devops/pipelines/overview-azure) article for details about the usage of these tasks.

Refer to the next steps if the task configuration looks fine.
