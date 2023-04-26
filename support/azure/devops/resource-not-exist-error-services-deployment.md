---
title: Resource doesn't exist error with services deployment
description: Provides a solution for an error where resource doesn't exist error with services deployment.
ms.date: 04/24/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.topic: article
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Resource doesn't exist error with services deployment

## Symptoms

Your tasks may cause error `Error: Resource 'xxxxxxxx' doesn't exist. Resource should exist before deployment` in the following scenarios:

- The resource was created as part of the same pipeline.

- The resource was created by another tool just before executing the pipeline.

- The resource was created before deployment.

> [!NOTE]
> This error may occur with any task such as Azure Web App tasks, Azure RM (Resource Manager) Web deployment tasks, Azure Function App tasks, Azure Resource Manager (ARM) template deployment, and more.

## Cause

This error may occur for one of the following reasons:

- The task uses the API, which depends on Azure data in cache. This means that the recently created app resources aren't available for the task, because the cache hasn't been updated yet.

- An actual Azure RM cache or replication issue occurred.

## Solution

To solve this error, add a delay to the pipeline before using the Azure task. If the error wasn't resolved, create a support ticket for the respective Azure services team.
