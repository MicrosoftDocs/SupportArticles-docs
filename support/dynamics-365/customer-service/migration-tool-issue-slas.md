---
title: SLA migration tool can't migrate many SLAs
description: Provides a resolution for the issue where the SLA migration tool isn't able to migrate a large number of SLAs in Dynamics 365 Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# Can't use the SLA migration tool to migrate a large number of SLAs

## Symptoms

Errors occur during the premigration checkup in the migration tool in Dynamics 365 Customer Service.

## Cause

If the number of service-level agreements (SLAs) being migrated is more than 1,000, SLAs may not pass through the premigration checkup, which processes all legacy SLAs.

## Resolution

To solve this issue, when you select **Miscellaneous** > **ARC and SLA migration** in the Customer Service admin center site map, you can use the `&flags=FCB.SkipPreMigrationCheckUp=true` flag in the URL to skip the premigration checkup.
