---
title: Understanding and Transitioning from Legacy to Diagnostic Settings for Azure Activity Logs
description: Provides step-by-step instructions to transition from legacy to diagnostic settings.
ms.date: 07/09/2025
ms.reviewer: v-liuamson
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Understanding and Transitioning from Legacy to Diagnostic Settings for Azure Activity Logs

When Azure announced the transition from legacy solutions to diagnostic settings for forwarding activity logs, users received notifications about necessary updates. This article provides guidance on how to manage this transition effectively.

### Introduction
Azure is retiring the legacy solution for forwarding activity logs and replacing it with diagnostic settings. This change is automatic, but users with automation relying on the legacy API need to update their configurations. This guide will help you verify your current setup and make necessary adjustments.

### Step-by-Step Instructions to Transition to Diagnostic Settings

1. **Verify Existing Log Profiles**
   - Use the **Get-AzLogProfile** command in Azure PowerShell or the **az monitor log-profiles list** command in Azure CLI to check for existing log profiles.
   - If these commands return no results, no legacy log profiles are configured, and no action is needed.

2. **Update Automation Scripts**
   - If you have automation scripts using the legacy API, update them to use the diagnostic settings API by September 30, 2026.
   - Refer to the [Azure Monitor documentation](https://learn.microsoft.com/azure/azure-monitor/platform/activity-log?tabs=powershell#managing-legacy-log-profiles---retiring) for detailed instructions.

3. **Manual Transition to Diagnostic Settings**
   - For users with legacy log profiles, manually transition to diagnostic settings by following the steps outlined in the Azure documentation.
   - Ensure all configurations are updated before the retirement date to avoid disruptions.

### Common Issues and Solutions

- **Issue:** Unable to find existing log profiles.
  - **Solution:** Ensure you are using the correct commands and have the necessary permissions to access log profiles.

- **Issue:** Automation scripts fail after the transition.
  - **Solution:** Double-check that all scripts are updated to use the new diagnostic settings API.

### Reference

- [Azure Monitor Documentation](https://learn.microsoft.com/azure/azure-monitor/platform/activity-log?tabs=powershell#managing-legacy-log-profiles---retiring)
- [Get-AzLogProfile Command](https://learn.microsoft.com/powershell/module/az.monitor/get-azlogprofile?view=azps-14.0.0)
- [Azure CLI Log Profiles](https://learn.microsoft.com/cli/azure/monitor/log-profiles?view=azure-cli-latest#az-monitor-log-profiles-list)

If the issue persists after following the solution steps, please open a support case for further assistance.
