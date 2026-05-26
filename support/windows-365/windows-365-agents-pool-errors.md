---
title: Troubleshoot Windows 365 for Agents provisioning errors
description: Troubleshoot provisioning errors in Windows 365 for Agents
ms.topic: troubleshooting
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

The following errors can appear when the status of a Windows 365 for Agents Cloud PC pool is **Failed** or **Available with warning**.  

## Invalid billing plan

The selected billing plan for the provisioning policy (agents) is invalid. Until the provisioning policy has a valid billing plan, you can't provision Cloud PCs, and all pool updates fail.

To resolve this issue, update the billing plan, and then try to provision the Cloud PCs again.

## Can't reprovision Cloud PC

Review the pool configuration, and edit it if needed. Then try to reprovision the Cloud PC.

## Other failures or warnings

If an update fails to install, try again to install the update.
