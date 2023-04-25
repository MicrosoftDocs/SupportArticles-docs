---
title: Resource doesn't exist error with services deployment
description: Provides a solution for a issue where resource doesn't exist error with services deployment.
ms.date: 04/24/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.topic: article
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Resource doesn't exist error with services deployment

## Symptoms

There are some scenarios like:

1. The resource was created as part of the same pipeline.

1. The resource was created by another tool just before executing the pipeline.

1. The resource was created earlier, but the task still causes an error.

**Error: Resource 'xxxxxxxx' doesn't exist. Resource should exist before deployment.**

> [!NOTE]
> This error may occur with any task such as Azure Web App tasks, Azure RM (Resource Manager) Web deployment tasks, Azure Function App tasks, Azure Resource Manager (ARM) template deployment, and more.

## Cause


1. The task uses the API, which depends on Azure data in cache. This means that the recently created app resources aren't available for the task, because the cache hasn't been updated yet.

1. An actual Azure RM cache or replication issue occurred.

## Solution

To solve this issue, add a delay to the pipeline before using the Azure task. If the issue wasn't resolved, create a support ticket for the respective Azure services team.
