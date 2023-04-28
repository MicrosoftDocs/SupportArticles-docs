---
title: Tasks documentation and logs to capture for further debugging
description: This article provides the documentation for tasks and describes steps to capture debug logs for a deeper investigation of the tasks.
ms.date: 04/27/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Tasks documentation and logs to capture for further debugging

## Azure Web App tasks and deployments

This article can help you with issues related to the usage of the following tasks in Azure Pipelines.

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

## Capture logs for further debugging of the tasks

To capture debug logs for a deeper investigation of the tasks, follow these steps:

1. Enable debug logs by setting [system.debug](/azure/devops/pipelines/build/variables#systemdebug) to **True** in the pipeline.

1. If possible, enable verbose logging from the Azure service side.

1. Review details related to Azure services, like networking, to see if it's restricted for public network access, if IPs are open for public network access, or if other network configurations may impact the issue. Also, verify the resource group name and region of the service.

1. If you noticed that the issue started happening suddenly, review the success and failure logs to check for any changes to the task or agent versions.

1. If you're using the Microsoft-hosted agent, check the [runner-images](https://github.com/actions/runner-images) documentation for any recent updates related to the Azure module that might have broken the pipeline.

1. Check the [Azure DevOps status history](https://status.dev.azure.com/_history) and the [Azure status history](https://status.azure.com/status/history/) to find out if there are any outages.

## See related

- [Failure scenarios related to Azure web app tasks](failure-scenarios-related-azure-web-app-tasks.md)
- [Initial debugging for Azure Web App and services related issues](initial-debugging-azure-web-app-services.md)
- [Issues with the service connection in the task](issues-service-connection-task.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
