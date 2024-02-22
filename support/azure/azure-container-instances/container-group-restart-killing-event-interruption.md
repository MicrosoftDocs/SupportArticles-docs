---
title: Container group intermittently restarts
description: Provides a solution to an issue where an Azure container group is unexpectedly stopped and restarted due to killing event interruptions.
ms.date: 02/22/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: container-instances
---

# Azure container group intermittently restarts due to killing event interruptions

This article provides a solution to an issue where an Azure container group is unexpectedly stopped and restarted due to killing event interruptions.

## Symptoms

- Container groups intermittently restart without clear causes.
- Events of type `Killing` are shown in the `SubscriptionDeploymentEvents` kusto table.
- An portal event message "Killing container with id fc5a90a" is shown.
- Log Analytic events show the "Killing container with id dccaxxx" message.
- The container group IP address is changed.

## Cause

Container group killing events can happen due to platform maintenance, which is an expected behavior, or user application errors.

## Solution

Exit code 7147 and 7148 indicates that the container group is stopped due to platform maintenance, which is an expected behavior.

Exit code 0 means that an error occurs in the user's application and the container group is stopped. To resolve this error, the user needs to fix the application.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
