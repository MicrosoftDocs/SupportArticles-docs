---
title: Fix Solution Upgrade or Uninstall Issues in Copilot Studio
description: How to resolve upgrade and uninstall errors in Copilot Studio managed solutions. Fix SQL constraint and managed property conflicts. Learn the solutions now.
ms.date: 03/20/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Lifecycle Management
ms.collection: CEnSKM-ai-copilot
---

# Solution upgrade or uninstall errors in Copilot Studio

## Summary

When you upgrade or uninstall a managed [solution](/power-apps/maker/data-platform/solutions-overview) in [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio), you might get errors related to SQL constraints, managed property evaluation, or unexpected component deletion. Active customizations in the target environment or managed property conflicts typically cause these errors. This article helps you identify the cause and resolve the error.

## Symptoms

When you upgrade or uninstall a managed solution, or when you update, remove, or delete a managed component like an agent or agent component, you might get one of the following errors:

- SQL constraint error:

  > Sql error: Statement conflicted with a constraint. The DELETE statement conflicted with the REFERENCE constraint "botcomponent_parent_bot"

- Managed property evaluation error:

  > The evaluation of the current component (name=bot, id="botid") in the current operation (Update) failed during managed property evaluation of condition: Managed Property Name: iscustomizableanddeletable; Component Name: bot; Attribute Name: iscustomizable

- Unexpected component deletion error:

  > Not Found

## Determine the cause of the problem

Match the error message you get to one of the following causes:

- For a **SQL constraint error**, see [Cause: Active customizations in the target environment](#cause-active-customizations-in-the-target-environment).
- For a **managed property evaluation error**, see [Cause: Managed property conflicts](#cause-managed-property-conflicts).
- For a **Not Found** error, or if the other solutions in this article don't resolve your issue, see [Raise a support case with Microsoft Support](#raise-a-support-case-with-microsoft-support).

## Cause: Active customizations in the target environment

SQL constraint errors occur when the target managed environment has active customizations on the agent or component shown in the constraint (for example, an agent component, workflow, or environment variable).

### Solution: Remove active customizations

To view and remove customized components:

1. In Copilot Studio, go to **Solutions**, and then open the agent's source solution.
1. In the **Objects** pane, select **All**.
1. Sort the **Managed** column alphabetically to find all managed agents (**Yes**).
1. Sort the **Customized** column alphabetically to find all customized agents (**Yes**).
1. For each agent that's managed and customized:
   1. Open the commands menu (**⋮**).
   1. Select **Advanced**.
   1. Select **Remove active customizations**.
1. Retry the upgrade or uninstall.

## Cause: Managed property conflicts

Managed property evaluation errors occur when you initially set solution components as customizable and apply customizations but later disable this option in an upgrade. Conflicts or deletions within [managed solution layers](/power-apps/maker/data-platform/solution-layers) can also cause components to malfunction or become inaccessible, which prevents you from removing active customizations.

### Solution: Update the managed property settings

1. Set the component as customizable in the source solution. For more information, see [View and edit managed properties in solutions](/power-platform/alm/managed-properties-alm#view-and-edit-table-managed-properties).
1. Reimport the solution in the target environment.
1. Retry the removal of the active customization.

## Raise a support case with Microsoft Support

If you still get the same errors after following the previous steps, raise a support case with Microsoft Support. For more information, see [Find support and give feedback for Copilot Studio](/microsoft-copilot-studio/fundamentals-support#microsoft-support).

When you create a support case, include the following information:

- A network trace that captures the error
- The complete error details (download the full error shown during the upgrade or uninstall)
- Screenshots of the following views:
  - Solution layers view
  - Agent Dependencies
  - Customize column showing conflicts (if applicable)
- A description of the steps you already tried
- The solution ZIP file, if possible

## Related content

- [Remove dependencies from solution components](/power-platform/alm/removing-dependencies)
- [Create and manage custom solutions](/microsoft-copilot-studio/authoring-solutions-overview)
- [Export and import agents using solutions](/microsoft-copilot-studio/authoring-solutions-import-export#add-components-to-an-agent-in-a-custom-solution)
