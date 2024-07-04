---
title: Troubleshooting dynamic group processing in Microsoft Entra ID
description: Learn how to troubleshoot dynamic group processing using PowerShell
author: barclan
ms.author: barclayn
ms.date: 07/01/2024
ms.service: entra-id
ms.custom: sap:Users
---

# Troubleshooting dynamic group processing in Microsoft Entra ID

After making changes that require reevaluation of dynamic group membership, you might experience issues such as:

- Slow membership update
- Unexpected group membership updates

These problems can be caused by: 

- An unintended membership rule change
- A significant change is rolled out. For example, updates pushed to a large number of devices at the same time may require some group membership rules to be reevaluated.

This article provides sample PowerShell scripts to pause and resume dynamic group updates. Pausing dynamic group processing can stop rule processing and prevent unintended membership updates. Resuming dynamic group processing can restore normal group functionality.

## Prerequisites

- An account on an Azure tenant with `microsoft.directory/groups/allProperties/update` permission is required to pause or resume dynamic group processing.
- Applications need `Group.ReadWrite.All` permission.
- A copy of the sample [dynamic group management scripts](https://github.com/barclayn/samples-dynamic-group/tree/main).

## Dynamic group management script

We provide four scripts to manage dynamic group processing using PowerShell:

- **Pause All Groups:** This script pauses all dynamic group processing in your tenant.
- **Pause Specific Groups:** This script pauses dynamic group processing for specific groups you specify in the script.
- **Pause All Groups Except Some:** This script pauses dynamic group processing for all groups in your tenant except those you specify in the script.
- **UnPauseSpecificCritical:** This script resumes dynamic group processing for specific groups you specify in the script.
- **UnPauseNonCritical:** This script allows you to unpause non-critical groups with dynamic membership, 100 at a time.

Follow the instructions in the scripts to modify them according to your needs, and run them with the Microsoft Entra ID PowerShell module.

>[!IMPORTANT]
> Validate all steps in a test environment before making any changes in your production environment.

## FAQ

### When to use the Pause All groups script?

Use the Pause All Groups script when you suspect an unintended change or encounter delays in widespread dynamic membership updates affecting many groups.

### When to use the Pause Specific Groups or Pause All Groups Except Some script?

Use these scripts when you need to pause dynamic group processing for specific groups or all groups except certain ones.

### How to know when it is safe to resume dynamic group processing?

Currently, Microsoft Entra doesn't offer observability for you to monitor the status of dynamic group processing. It is recommended to wait at least 12 hours before resuming to allow the service to recover from any issues.

>[!NOTE]
> Microsoft Entra Support can assist with dynamic group processing only after resuming all dynamic groups and waiting 12 hours. 

### How to resume dynamic group processing?

Use the `unPauseSpecificCritical.ps1` to resume rule processing for specific Groups after you wait at least 12 hours. To prevent widespread delays from occurring again, start by resuming dynamic group processing for critical groups to prevent widespread delays, followed by the remaining dynamic groups in batches.

## Related content

- [Dynamic group processing sample scripts](https://github.com/barclayn/samples-dynamic-group/tree/main)
