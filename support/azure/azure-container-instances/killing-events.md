---
title: Container killing event interruptions cause unexpected stops
description: Provides a solution to container group killing events
ms.date: 02/07/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: container-instances
---
# Azure container instance continues to run after the stop or delete command

This article provides a solution to an issue where an Azure container instance continues to run even after the `stop` or `delete` command has been executed.

## Symptoms

- Intermittent container group restarts without any clear indication of cause.
- Killing events in SubscriptionDeploymentEvents kusto table.
- Portal event showing 'Killing container with id fc5a90a'
- Log Analytic events showing 'Killing container with id dccaxxx'
- IP Address get change

## Cause
Container Group killing events can happen due to platform maintenance which is expected behavior or customer application error.

## Solution

Exit Code 7147 and Exit Code 7148 are codes that indicate the container group was stopped due to platform maintenance, which is expected behavior.
Exit Code 0 is an error that means the user application has had an error and the container group stopped and requires the user to fix their application.

## Next Steps

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
