---
title: Unable to use the SLA migration tool to migrate a large number of SLAs
description: Provides a solution for SLA migration tool isn't able to migrate a large number of SLAs in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Unable to use the SLA migration tool to migrate a large number of SLAs

## Symptom

Errors appear during the premigration checkup in the migration tool.

## Cause

If the number of SLAs being migrated is more than 1,000, SLAs may not pass through the premigration checkup, which processes all legacy SLAs.

## Resolution

Skip the premigration checkup by using the following flag: use &flags=FCB.SkipPreMigrationCheckUp=true in the URL, when you select **Miscellaneous** > **ARC and SLA migration** in the Customer Service admin center site map. Perform batch migration.
