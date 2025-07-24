---
title: Understanding and Transitioning from Legacy to Diagnostic Settings for Activity Logs
description: Provides instructions to transition from legacy to diagnostic settings.
ms.date: 07/22/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Transition from legacy to diagnostic settings for Activity Logs

When Microsoft announced the transition from legacy solutions to diagnostic settings for forwarding activity logs in Microsoft Azure, users received notifications about necessary updates. This article provides guidance to manage this transition effectively.

We're retiring the Azure legacy solution for forwarding activity logs, and replacing it with diagnostic settings. This change is automatic. However, users who have automation that relies on the legacy API must update their configurations. This guide helps you verify your current setup and make necessary adjustments.

## Common issues and solutions

- **Issue:** You can't find existing log profiles.
  - **Solution:** Make sure that you're using the correct commands and have the necessary permissions to access log profiles.

- **Issue:** Automation scripts fail after the transition.
  - **Solution:** Double-check that all scripts are updated to use the new diagnostic settings API.

### Instructions to transition to diagnostic settings

1. To check for existing log profiles, run the **Get-AzLogProfile** command in Azure PowerShell or the **az monitor log-profiles list** command in Azure CLI. If these commands return no results, no legacy log profiles are configured, and no further action is necessary.

2. If you have automation scripts that use the legacy API, update them to use the diagnostic settings API by September 30, 2026. For more information, see [Azure Monitor documentation](/azure/azure-monitor/platform/activity-log?tabs=powershell#managing-legacy-log-profiles---retiring).

3. Manual transition to Diagnostic Settings:
   1. For users who have legacy log profiles, manually transition to diagnostic settings by following the steps that are outlined in the Azure documentation.
   1. To avoid disruptions, make sure that all configurations are updated before the retirement date.

## References

- [Azure Monitor documentation](/azure/azure-monitor/platform/activity-log?tabs=powershell#managing-legacy-log-profiles---retiring)
- [Get-AzLogProfile command](/powershell/module/az.monitor/get-azlogprofile?view=azps-14.0.0&preserve-view=true)
- [Azure CLI log profiles](/cli/azure/monitor/log-profiles?view=azure-cli-latest#az-monitor-log-profiles-list&preserve-view=true)

If the issue persists after you follow these steps, open a support case for further assistance.
