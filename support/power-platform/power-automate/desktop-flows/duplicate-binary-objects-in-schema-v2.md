---
title: Duplicate binary objects in desktop flow schema v2 solution
description: Provides workarounds for issues related to desktop flow schema v2, when dealing with solutions and having duplicate binaries.
ms.reviewer: iomavrid
ms.date: 06/04/2024
ms.custom: sap:Desktop flows\Schema v2 issues
---
# Duplicate binary objects in desktop flow schema v2 solution

This article provides workarounds for issues related to desktop flows in schema v2, when dealing with solutions and having duplicate binaries.

## Symptoms

When you use [Power Automate v2 schema](/power-automate/desktop-flows/schema) with a managed or unmanaged solution and try to run your desktop flow [locally](/power-automate/desktop-flows/run-desktop-flows-url-shortcuts) or [through the cloud](/power-automate/desktop-flows/trigger-desktop-flows), you might receive the following error in logs:

> DesktopFlowBinaryReferenceCollisionException

## Cause

Briefly, this issue occurs due to how Dataverse layering works. If you have a desktop flow in two environments (which is achieved with solution export or import) and update the same desktop flow in two environments, and then try to import one solution into the other environment, the process will run into errors.

This issue happens because when you update schema v1 to v2, new desktop flow binaries are created. Those binaries created in each environment will have different IDs and when importing the solution, Dataverse will see them as two separated binaries. Because only one binary of each type is expected, this will lead to duplicate binaries from the point of view of Power Automate for desktop.

## Workaround

There's no specific version of Power Automate for desktop in which this behavior will change, because it's related to how the Platform work. However, the issue isn't expected to persist once you apply one of the following workarounds.

### Workaround for a managed solution

1. Delete the solution on the target environment.
2. Reimport the solution as managed into the environment.

### Workaround for an unmanaged solution

1. Delete the desktop flow in the target environment.
2. Reimport the solution as unmanaged into the environment.

## More information

The following table tries to resume the different possible cases when dealing with schema v1 and v2 desktop flows and solutions. It also provides more information on desktop flow schema v2 behavior with managed and unmanaged solutions.

> [!NOTE]
> Desktop flow schema v2 in a managed solution can't be edited in Power Automate for desktop. This is a change of behavior compared to schema v1 where it was allowed.

|Source Desktop Flow|Source Solution|Target Environment|Target Solution|Target Desktop Flow|State after import|Comments|Workaround|
|---|---|---|---|---|---|---|---|
|schema v2|Managed|schema v2 is enabled|Managed|v2|Good|||
|schema v2|Managed|schema v2 is enabled|Managed|v1|Good|Importing a schema v2 solution into an environment that has schema v1 enabled will work without any issue.||
|schema v2|Managed|schema v2 is enabled|Managed|Schema v1 is updated to v2 inside the environment by resaving the desktop flow.|Erroneous|Updating a managed desktop flow from schema v1 to v2 creates an unmanaged layer. When you import the solution, duplicate binaries occur and prevent the desktop flow from running. You're recommended not updating or changing a managed desktop flow.|Delete the managed solution on the target environment and reimport the solution as managed into the environment. For more information, see [Manage v1 and v2 schema migrations with solutions](/power-automate/desktop-flows/alm-schema#manage-v1-and-v2-schema-migrations-with-solutions).|
|schema v2|Unmanaged|schema v2 is enabled|Unmanaged|v2|Good|||
|schema v2|Unmanaged|schema v2 is enabled|Unmanaged|v1|Good|Importing a schema v2 solution into an environment that has schema v1 enabled will work without any issue.||
|schema v2|Unmanaged|schema v2 is enabled|Unmanaged|Schema v1 is updated to v2 inside the environment by resaving the desktop flow.|Erroneous|Updating the unmanaged flows creates new binaries. When you import the desktop flow from another environment, the binaries won't have the same IDs and will be duplicated.|Delete the desktop flow from the target environment (deleting an unmanaged solution isn't sufficient because it doesn't delete the desktop flow), then reimport the unmanaged solution into the environment. For more information, see [Manage v1 and v2 schema migrations with solutions](/power-automate/desktop-flows/alm-schema#manage-v1-and-v2-schema-migrations-with-solutions).|
