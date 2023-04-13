---
title: Unable to import solution with active SLAs and SLAs are deactivated when a solution is imported
description: Provides a solution for the inability to import a solution with active SLAs and SLAs are deactivated when a solution is imported in Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# Unable to import solution with active SLAs and SLAs are deactivated when a solution is imported

This article provides a solution for when you're unable to import a solution with active SLAs and SLAs are deactivated when a solution is imported.

## Symptom

SLA solutions can be imported or exported from **Customizations** **> Solutions**. If an SLA solution is already present and you import an upgraded version of the same solution, then the following errors occur:

- During solution upgrade, if you select **Maintain Customizations**, the import fails.
- During solution upgrade, if you select **Overwrite Customizations**, the import succeeds, but the SLAs are deactivated.

## Cause

Solution export isn't intended to export data and only intended to export configurations. So, if the solution is imported with **Maintain Customizations** option and SLAs are already present and active in target org, the import will fail.  

If the customizations.xml file has the SLAs and you select **Overwrite Customizations**, the state of the SLAs will be set to Draft and deactivated.

### Resolution

- If you want to explicitly import a solution with SLAs defined, you must deactivate the SLAs and then proceed with the import. The SLAs can then be re-activated.

- If you want to import other customizations in the solution, the SLAs don't need to be re-imported. You can remove them from the customizations.xml file.
