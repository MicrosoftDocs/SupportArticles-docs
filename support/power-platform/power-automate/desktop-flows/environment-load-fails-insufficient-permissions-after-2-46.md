---
title: Environment load fails with insufficient permissions in version 2.46 or later
description: Resolves the insufficient permissions error in a v2 schema-enabled environment in Power Automate for desktop version 2.46 or later.
ms.reviewer: iomavrid
ms.date: 10/25/2024
ms.custom: sap:Desktop flows\Administration issues
---
# Environment load fails with an "insufficient permissions" error in the v2 schema

This article helps resolve the "insufficient permissions" error that occurs when you try to open an environment that has the [v2 schema](/power-automate/desktop-flows/schema) enabled in Power Automate for desktop version 2.46 or later.

## Symptoms

When you start or open a v2 schema-enabled environment in Power Automate for desktop (version 2.46 or later), the following error message occurs:

> You aren't permitted to view or create flows in this environment. Contact your administrator or switch to the default environment, or an environment, where you have sufficient permissions.

:::image type="content" source="media/environment-load-fails-insufficient-permissions-after-2.46/pad-insufficient-permissions.png" alt-text="Screenshot that shows the Insufficient permissions error.":::

## Cause

This issue occurs when you have a custom role assigned or the default permissions of a built-in role are modified. The error occurs due to an issue with the permissions of the API that retrieves the installed environment solutions.

## Resolution

To fix this issue, follow these steps:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select **Environments** in the navigation pane, and then select an environment where you want to manage the **Solution** entity.
1. In the left-hand menu, select **Dataverse**.
1. Under **Dataverse**, select **Tables**.
1. Search for the **Solution** entity in the list of tables.
1. Open the **Solution** entity and navigate to the **Permissions** tab.
1. Assign the "prvReadSolution" privilege to the relevant user or role. In other words, **Read** access must be provided to the respective security role in the **Solution** entity in Dataverse.

## More information

[Security roles and privileges](/power-platform/admin/security-roles-privileges)
