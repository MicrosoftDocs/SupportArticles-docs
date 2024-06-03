---
title: Duplicate binary objects in desktop flow schema v2 solution
description: Provides workarounds for issues related to desktop flow schema v2, when dealing with solutions and having duplicate binaries.
ms.reviewer: iomavrid
ms.date: 05/31/2024
ms.custom: sap:Desktop flows\Schema v2 issues
---

# Duplicate binary objects in dekstop flow schema v2 solution

This article provides workarounds for issues related to desktop flows in schema v2, when dealing with solutions and having duplicate binaries.

## Symptoms

Users who are using v2 schema with managed or unmanaged solution could see a 'DesktopFlowBinaryReferenceCollisionException' error while trying to run locally or through the cloud their desktop flow.

## Detection

We can see in logs the following error: 'DesktopFlowBinaryReferenceCollisionException'.

## Cause

Briefly, due to how Dataverse layering works, if you have a desktop flow in two environments (which is achieved with solution export/import) and update the same desktop flow in two environments, then try to import one solution into the other environment, it will run into errors.

This happens because when updating v1 to v2, new desktop flow binaries are created. Those binaries created in each environment will have different IDs and when importing the solution, Dataverse will see them as two separated binaries. As only one binary of each type is expected, this will lead to duplicate binaries from the point of view of Power Automate for desktop.

## Resolution

There is no specific version of Power Automate for desktop in which this behavior will change, as it is tied to how the Platform works - however this issue is not expected to persist, once the below workaround is applied.

## Workaround

### Workaround 1: Managed solution

* Delete the solution on the target environment.
* Re-import the solution as managed into the environment.

### Workaround 2: Unmanaged solution

* Delete the desktop flow in the target environment.
* Re-import the solution as unmanaged in the environment.

## Resources

Below you will find more information on desktop flow schema v2 behavior with managed and unmanaged solutions.

> [!NOTE]
> Desktop flow v2 in a managed solution cannot be edited in Power Automate for desktop. This is a change of behavior compared to v1 where it was allowed.

The below table tries to resume the different possible cases when dealing with v1 and v2 desktop flows and solutions.

|Source Desktop Flow|Source Solution|Target Environment|Target Solution|Target Desktop Flow|State after import|Comments|Fix|
|---|---|---|---|---|---|---|---|
|v2|Managed|v2 enabled|Managed|v2|Good|||
|v2|Managed|v2 enabled|Managed|v1|Good|Import a v2 into an environment with v1 will work without any issue.||
|v2|Managed|v2 enabled|Managed|v1 updated into v2 inside the environment (by re-saving the desktop flow)|Erroneous|Updating a managed desktop flow v1 into v2 will create an unmanaged layer, when importing the solution, so there will be duplicate binaries which prevents the desktop flow from running. Useful recommendation is to not update or change a managed desktop flow.|Delete the managed solution on the target environment and re-import the solution.|
|v2|Unmanaged|v2 enabled|Unmanaged|v2|Good|||
|v2|Unmanaged|v2 enabled|Unmanaged|v1|Good|Import a v2 into an environment with v1 will work without any issue.||
|v2|Unmanaged|v2 enabled|Unmanaged|v1 updated into v2 inside the environment (by re-saving the desktop flow)|Erroneous|Updating the unmanaged flows will create new binaries, when importing the desktop flow from another environment, so the binaries won't have the same IDs and will be duplicated|Delete the desktop flow from the target environment (deleting an unmanaged solution is not sufficient as it doesn't delete the desktop flow), then re-import the unmanaged solution.|
