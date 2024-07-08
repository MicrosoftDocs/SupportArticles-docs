---
title: Troubleshooting dynamic group processing in Microsoft Entra ID
description: Learn how to troubleshoot dynamic group processing using PowerShell
author: genlin
ms.author: genli
ms.reviewer: yuhko
ms.date: 07/01/2024
ms.service: entra-id
ms.custom: sap:Users
---

# Troubleshooting dynamic group processing in Microsoft Entra ID

After you make changes in Microsoft Entra ID that require a re-evaluation of dynamic group membership, you might experience various issues, such as:

- Slow membership update
- Unexpected group membership updates

These issues might be caused by: 

- An unintended membership rule change.
- A significant change rollout. For example, updates that are pushed to many devices at the same time might require some group membership rules to be re-evaluated.

This article provides sample Windows PowerShell scripts to pause and resume dynamic group updates. Pausing dynamic group processing can stop rule processing and prevent unintended membership updates. Resuming dynamic group processing can restore normal group functionality.

## Prerequisites

- An account on an Azure tenant that has the `microsoft.directory/groups/allProperties/update` permission
- The `Group.ReadWrite.All` permission (necessary for applications)
- A copy of the sample [dynamic group management scripts](https://github.com/barclayn/samples-dynamic-group/tree/main)

## Dynamic group management script

We provide four scripts to manage dynamic group processing by using PowerShell:

- **Pause All Groups:** This script pauses all dynamic group processing in your tenant.
- **Pause Specific Groups:** This script pauses dynamic group processing for specific groups that you specify in the script.
- **Pause All Groups Except Some:** This script pauses dynamic group processing for all groups in your tenant except those that you specify in the script.
- **UnPauseSpecificCritical:** This script resumes dynamic group processing for specific groups that you specify in the script.
- **UnPauseNonCritical:** This script enables you to resume noncritical group processing with dynamic membership, 100 at a time.

Follow the instructions within the scripts to make any changes according to your needs. Run the scripts by using the Microsoft Entra ID PowerShell module.

>[!IMPORTANT]
> Verify all steps in a test environment before you make any changes in your production environment.

## FAQ

### When to use the Pause All Groups script

Use the Pause All Groups script if you suspect that there is an unintended change or you encounter delays in widespread dynamic membership updates that affect many groups.

### When to use the Pause Specific Groups or Pause All Groups Except Some script

Use these scripts if you have to pause dynamic group processing for specific groups or for all groups except certain ones.

### How to know when it's safe to resume dynamic group processing

Currently, Microsoft Entra doesn't offer observability for you to monitor the status of dynamic group processing. We recommend that you wait at least 12 hours before you resume processing in order to allow the service to recover from any issues.

>[!NOTE]
> Microsoft Entra Support can help you to resume dynamic group processing only after you wait for the recommended 12 hours. 

### How to resume dynamic group processing

Run the `unPauseSpecificCritical.ps1` script to resume rule processing for specific groups after you wait at least 12 hours. To prevent widespread delays from occurring again, start by resuming dynamic group processing for critical groups to prevent widespread delays, and then resume processing for the remaining dynamic groups in batches.

## Related content

- [Dynamic group processing sample scripts](https://github.com/barclayn/samples-dynamic-group/tree/main)
