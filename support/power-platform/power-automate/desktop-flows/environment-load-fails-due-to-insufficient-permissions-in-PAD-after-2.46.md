---
title: Environment load fails due to insufficient permissions in PAD after 2.46
description: Provides a resolution when the user has insufficient permissions in their environment
ms.reviewer: iomavrid
ms.date: 10/12/2024
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Environment load in schema v2 fails due to insufficient permissions in Power Automate fdr desktop after 2.46

This article provides a resolution when the user has insufficient permissions in their schema v2 environment in Power Automate for desktop.

## Symptoms

When you launch or open Power Automate for desktop, the following error message appears:

> You aren't permitted to view or create flows in this environment. Contact your administrator or switch to the default environment, or an environment, where you have sufficient permissions.

![Screenshot of insuffient permissions in Power Automate](media/environment-load-fails-due-to-insufficient-permissions-in-PAD-after-2.46/pad-no-read-permissions-to-solution-entity.png)

The user has a custom role assigned or the default permissions for a built-in role have been modified.

## Cause

When Power Automate for desktop fails to load the environment, there is probably an issue with the permission of the API that retrieves the installed environment solutions. This issue applies to all versions on and after 2.46.

## Resolution

To fix this issue, assign the missing "prvReadSolution" privilege to the relevant user or role. In other words, **Read** access is required to be provided to the respective security role on the **Solution** entity in Dataverse.
