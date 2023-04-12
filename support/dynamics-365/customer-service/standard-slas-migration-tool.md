---
title: Standard SLAs aren't showing up in the migration tool
description: Provides a solution for when standard SLAs aren't available in the migration tool in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Standard SLAs aren't showing up in the migration tool

## Symptom

The migration tool doesn't show standard SLAs for migration.

## Cause

Legacy SLAs consist of standard SLAs and enhanced SLAs. The migration tool supports only enhanced SLAs. Standard SLAs have been deprecated and are no longer supported in Unified Interface, and therefore aren't supported in the migration tool.

## Resolution

Check the SLA type in the legacy web client interface. Use enhanced SLAs for migration.
