---
title: Troubleshoot Windows 365 for Agents provisioning errors
description: Describes the most common provisioning issues for Cloud PCs in Windows 365 for Agents, and provides instructions for resolving those issues.
ms.date: 06/02/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: sezhen
ms.custom:
- pcy:
- sap:
---
# Troubleshoot Windows 365 for Agents provisioning errors

## Summary

When you provision Cloud PCs in Windows 365 for Agents, provisioning errors can cause a Cloud PC pool status to show as **Failed** or **Available with warning**. This article describes the most common provisioning issues and how to resolve them.

## Provisioning issues

### Invalid billing plan

The selected billing plan for the provisioning policy (agents) is invalid. Until the provisioning policy has a valid billing plan, you can't provision Cloud PCs, and all pool updates fail.

To resolve this issue, update the billing plan, and then try again to provision the Cloud PCs.

### Can't reprovision Cloud PC

Review the pool configuration, and edit it as necessary. Then, try to reprovision the Cloud PC.

### Other failures or warnings

If an update doesn't install, try again to install the update.
