---
title: Troubleshooting Groups with dynamic membership processing in Microsoft Entra ID
description: Learn how to troubleshoot dynamic membership processing by using pause and resume PowerShell samples for groups and administrative units.
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: yuhko, barclayn, v-weizhu
ms.date: 04/24/2025
ms.service: entra-id
ms.custom: sap:Users
ai-usage: ai-assisted
---

# Troubleshooting Groups with dynamic membership processing

After you make changes in Microsoft Entra ID that require a re-evaluation of dynamic group membership, you might experience either of the following issues:

- Slow membership update
- Unexpected group membership updates

These issues can be caused by:

- An unintended membership rule change.
- A significant change rollout. For example, updates that are pushed to many devices at the same time might require some group membership rules to be re-evaluated.

This article provides Microsoft Entra PowerShell samples to pause and resume dynamic membership processing for groups and administrative units. Pausing dynamic membership processing can stop rule processing and prevent unintended membership updates. Resuming dynamic membership processing can restore normal functionality.

> [!IMPORTANT]
> Dynamic membership group changes are usually processed within a few hours. However, processing may take more than 24 hours depending on factors such as tenant size, group size, number of attribute changes, rule complexity, and operator choice (such as using `CONTAINS`, `MATCH`, or `MemberOf`). For more information, see [Understanding and Managing Dynamic Group Processing in Microsoft Entra ID](/entra/identity/users/manage-dynamic-group).

## Get pause and resume dynamic membership processing samples

The PowerShell samples are published on Microsoft Learn. Start with [PowerShell samples for dynamic membership processing](/entra/identity/users/groups-dynamic-membership-powershell-samples).

To run the samples, ensure that you have the following prerequisites:

- PowerShell 5.1 (x64) or later.
- The [Microsoft Graph PowerShell module](/powershell/microsoftgraph/installation).
- A signed-in account that can manage the collections that you target. The groups phase needs the [Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator) Microsoft Entra role and the `Group.ReadWrite.All` Microsoft Graph scope. The administrative units phase needs the [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator) Microsoft Entra role and the `AdministrativeUnit.ReadWrite.All` scope.

## Dynamic membership management samples

We provide five PowerShell samples to manage dynamic membership processing for groups and administrative units:

- [Pause all groups and administrative units with dynamic membership](/entra/identity/users/scripts/powershell-pause-all-dynamic-membership): Pauses every group and administrative unit that has dynamic membership rules in your tenant.
- [Pause specific groups and administrative units with dynamic membership](/entra/identity/users/scripts/powershell-pause-specific-dynamic-membership): Pauses only the groups and administrative units whose IDs you supply.
- [Pause all groups and administrative units with dynamic membership except specified](/entra/identity/users/scripts/powershell-pause-all-except-dynamic-membership): Pauses every group and administrative unit with dynamic membership except the IDs you exclude.
- [Resume specific critical groups and administrative units with dynamic membership](/entra/identity/users/scripts/powershell-resume-specific-critical-dynamic-membership): Resumes processing for critical groups and administrative units that you specify.
- [Resume noncritical groups and administrative units with dynamic membership in batches](/entra/identity/users/scripts/powershell-resume-noncritical-dynamic-membership): Resumes processing for paused noncritical groups and administrative units, up to 100 of each per run.

Each sample runs in two phases: groups first, then administrative units. At the start of each phase, the script asks for confirmation. You can run the group phase, the administrative unit phase, or both.

> [!IMPORTANT]
> Verify all steps in a test environment before you make any changes in your production environment.

## FAQ

### When to use the Pause all groups and administrative units sample

Use the [Pause all groups and administrative units with dynamic membership](/entra/identity/users/scripts/powershell-pause-all-dynamic-membership) sample if you suspect that there's an unintended change or you encounter delays in widespread dynamic membership updates that affect many groups or administrative units.

### When to use the pause-specific or pause-all-except samples

Use the [pause-specific](/entra/identity/users/scripts/powershell-pause-specific-dynamic-membership) or [pause-all-except](/entra/identity/users/scripts/powershell-pause-all-except-dynamic-membership) samples if you have to pause dynamic membership processing for specific groups or administrative units, or for all dynamic membership collections except certain ones.

### How to know when it's safe to resume dynamic membership processing

Currently, Microsoft Entra doesn't offer observability for you to monitor the status of dynamic membership processing. We recommend that you wait at least 12 hours before you resume processing in order to allow the service to recover from any issues.

> [!NOTE]
> Microsoft Entra Support can help you to resume dynamic membership processing only after you wait for the recommended 12 hours.

### How to resume dynamic membership processing

Run the [resume-specific-critical](/entra/identity/users/scripts/powershell-resume-specific-critical-dynamic-membership) sample to resume rule processing for specific critical groups or administrative units after you wait at least 12 hours. To prevent widespread delays from occurring again, start by resuming processing for critical collections, and then use the [resume-noncritical](/entra/identity/users/scripts/powershell-resume-noncritical-dynamic-membership) sample to resume processing for the remaining noncritical collections in batches.

## Related content

- [PowerShell samples for dynamic membership processing](/entra/identity/users/groups-dynamic-membership-powershell-samples)
