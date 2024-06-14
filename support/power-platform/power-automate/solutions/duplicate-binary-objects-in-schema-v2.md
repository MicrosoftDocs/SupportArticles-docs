---
title: Duplicate binary objects in v2 schema desktop flow solutions
description: Provides workarounds for issues related to v2 schema desktop flows when dealing with solutions and having duplicate binaries.
ms.reviewer: iomavrid
ms.date: 06/14/2024
ms.custom: sap:Solutions\Adding flows into solutions
---
# Duplicate binary objects in the v2 schema desktop flow solution

This article provides workarounds for issues related to desktop flows in the v2 schema when dealing with solutions and having duplicate binaries.

## Symptoms

When you use [Power Automate v2 schema](/power-automate/desktop-flows/schema) with a managed or unmanaged solution and try to run your desktop flow [locally](/power-automate/desktop-flows/run-desktop-flows-url-shortcuts) or [through the cloud](/power-automate/desktop-flows/trigger-desktop-flows), you might receive the following error in the logs:

> DesktopFlowBinaryReferenceCollisionException

## Cause

Briefly, this issue occurs due to the way Dataverse layering works. Assume you have desktop flows in two environments (which is achieved with solution export or import). If you update the same desktop flow in both environments, and then try to import one solution into the other environment, the process will run into errors.

This issue happens because new desktop flow binaries are created when you update the v1 schema to the v2 schema. Those binaries created in each environment have different IDs, and when importing the solution, Dataverse will see them as two separate binaries. Because only one binary of each type is expected, this will lead to duplicate binaries from the perspective of Power Automate for desktop.

## Workaround

No specific version of Power Automate for desktop will change this behavior because it's related to how the platform works. However, the issue isn't expected to persist once you apply one of the following workarounds.

### Workaround for a managed solution

1. Delete the solution in the target environment.
2. Reimport the solution into the environment as a managed solution.

### Workaround for an unmanaged solution

1. Delete the desktop flow in the target environment.
2. Reimport the solution into the environment as an unmanaged solution.

## More information

The following table describes the possible cases when dealing with v1 and v2 schema desktop flows and solutions. It also provides more information on the v2 schema desktop flow behavior with managed and unmanaged solutions.

> [!NOTE]
> V2 schema desktop flows in a managed solution can't be edited in Power Automate for desktop. This is a behavior change compared to the v1 schema, where editing is allowed.

|Source desktop flow|Source solution|Target environment|Target solution|Target desktop fow|State after import|Comments|Workaround|
|---|---|---|---|---|---|---|---|
|V2 schema|Managed|V2 schema enabled|Managed|v2|Good|||
|V2 schema|Managed|V2 schema enabled|Managed|v1|Good|Importing a v2 schema solution into a schema v1 enabled environment will work without any issue.||
|V2schema|Managed|V2 schema enabled|Managed|The v1 schema is updated to v2 inside the environment by resaving the desktop flow.|Erroneous|Updating a managed desktop flow from the v1 schema to v2 creates an unmanaged layer. When you import the solution, duplicate binaries occur and prevent the desktop flow from running. We recommend not updating or changing the managed desktop flow.|Delete the managed solution in the target environment, and then reimport the managed solution into the environment. For more information, see [Manage v1 and v2 schema migrations with solutions](/power-automate/desktop-flows/alm-schema#manage-v1-and-v2-schema-migrations-with-solutions).|
|V2 schema|Unmanaged|V2 schema enabled|Unmanaged|v2|Good|||
|V2 Schema v2|Unmanaged|V2 schema enabled|Unmanaged|v1|Good|Importing a v2 schema solution into a schema v1 enabled environment will work without any issue.||
|V2 Schema v2|Unmanaged|V2 schema enabled|Unmanaged|The v1 schema is updated to v2 inside the environment by resaving the desktop flow.|Erroneous|Updating an unmanaged flow creates new binaries. When you import a desktop flow from another environment, the binaries won't have the same IDs and will be duplicated.|Delete the desktop flow from the target environment (deleting the unmanaged solution isn't sufficient because it doesn't delete the desktop flow), and then reimport the unmanaged solution into the environment. For more information, see [Manage v1 and v2 schema migrations with solutions](/power-automate/desktop-flows/alm-schema#manage-v1-and-v2-schema-migrations-with-solutions).|
