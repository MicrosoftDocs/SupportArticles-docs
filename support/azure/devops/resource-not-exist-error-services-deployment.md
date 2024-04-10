---
title: Resource doesn't exist error with Azure Web App deployment
description: Provides a solution for an error Resource doesn't exist with Azure Web App deployment.
ms.date: 05/10/2023
ms.custom: sap:Pipelines
ms.reviewer: dmittal, cathmill, v-sidong
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Resource doesn't exist error with Azure Web App deployment

## Symptoms

The following scenarios may cause your Azure Web App deployment to fail with the error `Error: Resource '<ResourceName>' doesn't exist. Resource should exist before deployment`:

- The resource was created as part of the same pipeline.

- The resource was created by another tool just before executing the pipeline.

- The resource was created before deployment.

> [!NOTE]
> This error may occur with any task, such as Azure Web App tasks, Azure Resource Manager (ARM) Web deployment tasks, Azure Function App tasks, ARM template deployment, and more.

## Cause

This error may occur for one of the following reasons:

- The task uses the API, which depends on Azure data in the cache. This means that the recently created app resources aren't available for the task because the cache hasn't been updated yet.

- An actual ARM cache or replication issue occurred.

## Solution

To solve this error, add a delay to the pipeline before using the Azure task. If this action doesn't resolve the error, create a support ticket for the respective Azure services team.

## See related

- [Troubleshoot Azure Web App tasks and deployment issues](troubleshoot-azure-web-apps-tasks-deployments.md)
- [Azure Web App and services related issues](azure-web-app-services-related-issues.md)
- [Issues with the service connection in the task](issues-service-connection-task.md)
- [Failure scenarios related to Azure Web App tasks](failure-scenarios-related-azure-web-app-tasks.md)
