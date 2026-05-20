---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      serenaz # GitHub alias
ms.author:    # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     05/20/2026
---
# Troubleshoot Windows 365 for Agents provisioning errors

The following errors can appear when a Windows 365 for Agents Cloud PC pool status is **Failed** or **Available with warning**.  

## Invalid billing plan

The selected billing plan for the provisioning policy (agents) is invalid. Cloud PCs will not be provisioned, and all updates will fail until there is a valid billing policy.

**Suggested solution:** Update the billing plan and reprovision.

## Reprovision failed

**Suggested solution:** Edit the pool configuration, if needed, and retry reprovisioning.

## Other failures or warnings
If you encounter a failed update, then please try again.
