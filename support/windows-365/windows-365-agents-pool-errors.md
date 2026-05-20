---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title: Troubleshoot Windows 365 for Agents provisioning errors
description: Troubleshoot provisioning errors in Windows 365 for Agents
author:      serenaz # GitHub alias
ms.author: sezhen
ms.service: windows-365
ms.topic: troubleshooting
ms.date:     05/20/2026
ms.subservice: windows-365-enterprise
---
# Troubleshoot Windows 365 for Agents provisioning errors

The following errors can appear when a Windows 365 for Agents Cloud PC pool status is **Failed** or **Available with warning**.  

## Invalid billing plan

The selected billing plan for the provisioning policy (agents) is invalid. Cloud PCs cannot be provisioned, and all pool updates fail until there's a valid billing policy.

**Suggested solution:** Update the billing plan and reprovision.

## Reprovision failed

**Suggested solution:** Edit the pool configuration, if needed, and retry reprovisioning.

## Other failures or warnings
If you encounter a failed update, then try again.
