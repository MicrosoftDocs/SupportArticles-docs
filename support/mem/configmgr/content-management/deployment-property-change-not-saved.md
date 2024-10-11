---
title: A deployment property change isn't saved
description: This article provides a solution for the issue that a property change of a deployment isn't saved in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, mansee
ms.custom: sap:Content Management\Distribution Point Installation, Upgrade or Configuration
---
# Changing a property of a deployment doesn't appear to be saved in System Center 2012 Configuration Manager

This article provides a solution for the issue that a deployment property change doesn't appear to be saved in Microsoft System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2713465

## Symptoms

When modifying the **Deployment options** of a distribution point in the **Selected Deployment Properties** dialog box in Microsoft System Center 2012 Configuration Manager, the property change doesn't appear to have been saved.

## Cause

This happens only when you have selected **Make available to boot media and PXE** in the **Deployment Settings** tab of the **Selected Deployment Properties** dialog box.

## Resolution

This problem is only an issue with the settings that are visible in the user interface. The change is saved correctly in the database. You can run a custom report with a SQL query to verify your settings.

The below SQL query is an example that will show all task sequences with the **Access content directly from a distribution point when needed by the running task sequence** deployment option selected.

```sql
SELECT pkg.PackageID, pkg.Name, pkg.SourceSite,
    CASE WHEN (adv.RemoteClientFlags & 0x00000008) = 0 THEN 0 ELSE 1 END AS RunFromDPInFastNetwork,
    CASE WHEN (adv.RemoteClientFlags & 0x00000080) = 0 THEN 0 ELSE 1 END AS RunFromDPInSlowNetwork
FROM v_Advertisement AS adv
INNER JOIN v_Package AS pkg ON pkg.PackageID = adv.PackageID AND pkg.PackageType = 4
WHERE (adv.RemoteClientFlags & 0x00000008) <> 0 OR (adv.RemoteClientFlags & 0x00000080) <> 0
```
