---
title: Workflow creates large volume of system jobs and logs
description: Workflow generating large volume of system jobs and logs. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Workflow generating large volume of system jobs and logs

This article provides a resolution for the issue that an asynchronous workflow creates large volume of system jobs and logs.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4562256

## Symptoms

An asynchronous workflow gets invoked rapidly over a short time period generating a large volume of system jobs. This strains the asynchronous service causing a spike in the backlog it needs to process resulting in performance degradation that ultimately impacts all system jobs. It also causes an increase in database size because of the large number of async operations and associated workflow logs.

## Cause

When an asynchronous workflow is activated and triggered, new jobs will be queued up by Microsoft Dynamics 365 Asynchronous Service and processed based on available resources.

Under certain circumstances, an asynchronous workflow can end up being invoked several times rapidly causing a large number of system jobs to be created in a short period. This occurs either on account of a bulk operation that triggers the workflow aggressively or erroneous logic within some other workflow and/or plugin that invokes it with high frequency.

The resources available to the asynchronous service are limited and if its backlog gets filled up by such a runaway workflow, performance degradation that broadly impacts all system jobs is common. Additionally, because of the large volume of jobs generated in such a scenario, the database size will also increase.

## Resolution

In such cases the asynchronous workflow infrastructure is able to self-heal to a certain extent once the identified workflow is deactivated. Steps to achieve this are listed below:

1. Navigate to **Settings** > **Processes** and select the relevant workflow. Alternatively, find the workflow using **Advanced Find**.
2. Once selected, select **Deactivate** to disable and set the workflow to **Draft** state. Optionally if not needed, you can also delete the workflow at this point.

Once the steps above have been performed, new jobs will no longer be created. Additionally, any jobs that were already created and placed in the asynchronous queue before deactivation, **but have not been picked up for processing yet** will be canceled immediately when they are picked up for processing. This will help draining the async backlog more quickly.

The remaining jobs that are already **In Progress** will remain unaffected and will complete as expected. The backlog will drain steadily over a period of time to recover back to nominal levels.
