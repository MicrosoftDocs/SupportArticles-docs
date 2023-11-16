---
title: Can't import solution with active SLAs and SLAs are deactivated when a solution is imported
description: Provides a resolution for the issue where you can't import a solution with active SLAs, and SLAs are deactivated when a solution is imported in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Can't import solution with active SLAs and SLAs are deactivated when a solution is imported

This article provides a resolution for the issue where you're unable to import a solution with active service-level agreements (SLAs), and SLAs are deactivated when a solution is imported in Dynamics 365 Customer Service.

## Symptoms

SLA solutions can be imported or exported from **Customizations** > **Solutions**. If an SLA solution is already present and you import an upgraded version of the same solution, the following issues occur:

- During a solution upgrade, if you select **Maintain Customizations**, the import fails.
- During a solution upgrade, if you select **Overwrite Customizations**, the import succeeds, but the SLAs are deactivated.

## Cause

Solution export isn't intended to export data and is only intended to export configurations. So, if the solution is imported with the **Maintain Customizations** option enabled, and SLAs are already present and active in the target org, the import will fail.  

If the *customizations.xml* file has the SLAs and you select the **Overwrite Customizations** option, the state of the SLAs will be set to **Draft** and deactivated.

### Resolution

To resolve this issue,

- If you want to explicitly import a solution with SLAs defined, you must deactivate the SLAs and then proceed with the import. The SLAs can then be reactivated.
- If you want to import other customizations in the solution, the SLAs don't need to be reimported. You can remove them from the *customizations.xml* file.
