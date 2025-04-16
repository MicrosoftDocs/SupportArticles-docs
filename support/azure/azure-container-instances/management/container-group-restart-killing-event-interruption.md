---
title: Azure container group intermittently restarts
description: Provides a solution to an issue where an Azure container group is unexpectedly stopped and restarted due to killing event interruptions.
ms.date: 06/26/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: azure-container-instances
ms.custom: sap:Management
---

# Azure container group intermittently restarts due to killing event interruptions

This article provides a solution to an issue where an Azure container group is unexpectedly stopped and restarted due to killing event interruptions.

## Symptoms

A container group intermittently restarts without clear causes. You also experience one or more of the following symptoms and receive exit code 7147, 7148, or 1:

- A portal event message "Killing container with id fc5a90a" is shown.
- Log Analytic events show the "Killing container with id dccaxxx" message.
- The container group IP address is changed.

## Cause

Container group killing events can happen due to platform maintenance (which is an expected behavior) or user application errors.

## Solution

Exit codes 7147 and 7148 indicate that the container group is stopped due to platform maintenance, which is an expected behavior.

Exit code 0 means that an error occurs in the user's application and the container group is stopped. To resolve this error, the user needs to fix the application.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
