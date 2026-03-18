---
title: Fix solution upgrade or solution uninstall errors
description: Learn how to fix solution upgrade or uninstall errors in Copilot Studio. Resolve SQL constraint issues, managed property conflicts, and unexpected deletion errors.
ms.date: 03/18/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Lifecycle Management
ms.collection: CEnSKM-ai-copilot
---

# Fix solution upgrade or solution uninstall errors

This article addresses common errors you encounter when upgrading or uninstalling managed solutions in Copilot Studio.

## Symptoms

You might see errors when upgrading or uninstalling your managed solution. These errors can also occur when you try to update, remove, or delete a managed component, such as a bot or bot component.

The following errors can occur:

### SQL constraint errors

Sql error: Statement conflicted with a constraint. The DELETE statement conflicted with the REFERENCE constraint "botcomponent_parent_bot"

### Managed property evaluation errors

The evaluation of the current component(name=bot, id="botid") in the current operation (Update) failed during managed property evaluation of condition: Managed Property Name: iscustomizableanddeletable; Component Name: bot; Attribute Name: iscustomizable

### Unexpected component deletion errors

`Not Found` errors

## Cause for SQL constraint errors

The target managed environment contains active customizations. Remove active customizations in the target environment in the agent and the component shown in the constraint. For example, agent component, workflow, or environment variable.

To view all the customized components, refer to the following steps:

1. In Copilot Studio, go to **Solutions**, and then open the agent's source solution.
1. In the **Objects** pane, select **All**.
1. Sort the **Managed** column alphabetically to view all of the managed agents (**Yes**).
1. Sort the **Customized** column alphabetically to view all of the customized agents (**Yes**).
1. For each agent that is managed and customized, open the commands menu (**⋮**), select **Advanced**, and then select **Remove active customizations**.

## Solution for SQL constraint errors

For SQL constraint errors either during solution upgrade or uninstallation, follow these steps:

1. Remove active customizations in the target environment.
1. Perform the upgrade or uninstall action again.

## Cause for managed property evaluation errors

This problem occurs when you initially configure solution components as customizable and apply customizations. If you later disable this option in upgrades, or if there are conflicts or deletions within managed layers, components might malfunction or become inaccessible. You can't remove active customizations on these components.

## Solution for managed property evaluation errors

For managed property evaluation errors during removal of active customizations, follow these steps:

1. Set the component as customizable in the source solution.
1. Reimport the solution in the target environment.
1. Retry the removal of the active customization.

Learn more at [View and edit managed properties in solutions](/power-platform/alm/managed-properties-alm#view-and-edit-table-managed-properties).

## Raise a support case with Microsoft Support

If you continue facing the same issue after following the preceding steps, [raise a support case with Microsoft Support in the Power Platform Admin Center](/microsoft-copilot-studio/fundamentals-support#microsoft-support).

When creating a support case, make sure to include the following information:

- A network trace that captures the error you're facing.
- The complete error details. Download the complete error shown during the upgrade or uninstall.
- Screenshots of the following views:
  - Solution layers view.
  - Agent Dependencies.
  - Customize column showing conflicts (if applicable).
- Details of the mitigation steps you've attempted.
- If possible, include the solution ZIP file.

## Related content

- [Solution layers in Power Platform](/power-apps/maker/data-platform/solution-layers)
- [Create and manage custom solutions](/microsoft-copilot-studio/authoring-solutions-overview)
- [Export and import agents using solutions](/microsoft-copilot-studio/authoring-solutions-import-export#add-components-to-an-agent-in-a-custom-solution)
