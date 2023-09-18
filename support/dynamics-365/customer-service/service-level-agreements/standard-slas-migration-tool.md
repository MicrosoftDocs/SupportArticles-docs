---
title: Standard SLAs not showing up in the migration tool
description: Provides a resolution for an issue where the standard SLAs aren't available in the migration tool in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Standard SLAs aren't showing up in the migration tool

This article provides a resolution for an issue related to the deprecated service-level agreement (SLA) type in Dynamics 365 Customer Service.

## Symptoms

The migration tool doesn't show the standard SLAs for migration in Dynamics 365 Customer Service.

## Cause

Legacy SLAs consist of standard SLAs and enhanced SLAs. The migration tool supports only enhanced SLAs. Standard SLAs have been deprecated and are no longer supported in Unified Interface. Therefore, they aren't supported in the migration tool.

## Resolution

You need to check the SLA type in the legacy web client interface and use enhanced SLAs for migration.
