---
title: Federated Knowledge Service Provisioning Error 0x80072042
description: Fix Federated Knowledge Service provisioning errors 0x80072042 and 0x80048d0b in Copilot Studio when the Block unmanaged customizations policy is enabled.
ms.date: 08/25/2026
ms.reviewer: erickinser, v-shaywood
ms.custom: sap:Lifecycle Management
ms.collection: CEnSKM-ai-copilot
ai-usage: ai-assisted
---

# Federated Knowledge Service provisioning errors when unmanaged customizations are blocked

## Summary

When you deploy a managed agent [solution](/power-apps/maker/data-platform/solutions-overview) to a target environment in Microsoft Copilot Studio, Federated Knowledge Service (FKS) provisioning might fail if the target environment has the **Block unmanaged customizations** managed environment policy enabled. FKS uses the `dvfilesearch` table in [Microsoft Dataverse](/power-apps/maker/data-platform/data-platform-intro), and the policy prevents the agent solution from creating the records that FKS needs. The result is error `0x80072042` during provisioning, error `0x80048d0b` when the agent tries to search knowledge, or both. This article helps you identify and fix these errors so that the agent's knowledge source works after import.

## Symptoms

You export an agent as a managed solution from a development environment and import it into a production environment. The agent works in the development environment but fails in the production environment after the managed solution is deployed.

You experience one or both of the following errors:

- FKS provisioning error:

  > 0x80072042: This environment doesn't allow unmanaged customizations.

- Missing entity error when the agent tries to search knowledge:

  > 0x80048d0b: MissingEntityException

## Cause

The `dvfilesearch` entity that Federated Knowledge Service uses is solution-aware which means that Dataverse tracks it as a solution component and manages it through [solution layers](/power-apps/maker/data-platform/solution-layers). When the target environment has the [Block unmanaged customizations](/power-platform/alm/block-unmanaged-customizations) policy enabled, direct API calls that create records in solution-aware entities are blocked, because those records would form an unmanaged layer. If the FKS skill component and its related records aren't included in the exported managed solution, the runtime attempts to create these records directly at agent-provisioning time, and the policy blocks the operation.

## Solution

Include the FKS skill component and its related records in the managed solution before you export it from the source environment.

1. In [Power Apps](https://make.powerapps.com), open the solution that contains the agent.
1. Select **Add existing** > **More** > **Other** > **DVFileSearch**.
1. Find and add the **UnstructuredFileSearchSkill** component. This step also adds the related records from **DVFileSearchEntity** and **DVFileSearchAttributes**.
1. [Export the solution](/power-apps/maker/data-platform/export-solutions) as managed.
1. Import the managed solution into the target environment.

After you import the updated managed solution, the FKS components are provisioned as part of the solution import rather than through direct API calls, and the **Block unmanaged customizations** policy no longer blocks provisioning.

### Prevent this problem in future deployments

To avoid repeating this problem when you deploy later versions of the agent, add the FKS components to the source solution as a standard step in your [application lifecycle management (ALM)](/power-platform/alm/overview-alm) process. For more information about which components to include, see [Add components to an agent in a custom solution](/microsoft-copilot-studio/authoring-solutions-import-export#add-components-to-an-agent-in-a-custom-solution).

## Create a support case

If you still receive the same errors after you apply the solution, contact Microsoft Support. For more information, see [Find support and give feedback for Copilot Studio](/microsoft-copilot-studio/fundamentals-support#microsoft-support).

When you create a support case, include the following information:

- A network trace that captures the error
- The complete error details (download the full error shown during the solution import or agent provisioning)
- Screenshots of the following views:
  - Solution layers view
  - Agent dependencies
  - The **DVFileSearch**, **DVFileSearchEntity**, and **DVFileSearchAttributes** components in the source solution
- A description of the steps you already tried
- The solution .zip file, if possible

## Related content

- [Block unmanaged customizations in Dataverse environments](/power-platform/alm/block-unmanaged-customizations)
- [Managed environments overview](/power-platform/admin/managed-environment-overview)
- [Export and import agents using solutions](/microsoft-copilot-studio/authoring-solutions-import-export)
- [Add knowledge to an agent](/microsoft-copilot-studio/knowledge-add-existing-copilot)
