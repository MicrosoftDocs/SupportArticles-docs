---
title: Standard SLAs not showing up in the migration tool
description: Provides a resolution for the issue where the standard SLAs aren't available in the migration tool in Dynamics 365 Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# Standard SLAs aren't showing up in the migration tool

## Symptoms

The migration tool doesn't show the standard service-level agreements (SLAs) for migration.

## Cause

Legacy SLAs consist of standard SLAs and enhanced SLAs. The migration tool supports only enhanced SLAs. Standard SLAs have been deprecated and are no longer supported in Unified Interface, and therefore aren't supported in the migration tool.

## Resolution

You need to check the SLA type in the legacy web client interface. And use enhanced SLAs for migration.
