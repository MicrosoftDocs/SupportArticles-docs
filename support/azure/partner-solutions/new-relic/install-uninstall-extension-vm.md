---
title: Can't Install or Uninstall an Extension on a Virtual Machine
description: Resolve issues with installing or uninstalling extensions on a virtual machine. 
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/18/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve issues with installing or uninstalling extensions on virtual machines so that I can install or uninstall an extension.

---

# Can't install or uninstall an extension on a virtual machine

This article explains how to resolve the issue where the Install Extension or Uninstall Extension button is disabled (greyed out) when selecting virtual machines in the Azure portal for the New Relic VM extension.

Use this article when you select virtual machines and the Install Extension or Uninstall Extension action remains unavailable.

## Prerequisites

- An Azure account with permissions to manage VM extensions (Contributor or Owner on the subscription or resource group, or a role with explicit extension management permissions).
- The target virtual machines must be visible in the Azure portal under Virtual machines.

## Symptoms

- The Install Extension button is disabled (greyed out) after selecting one or more VMs.
- The Uninstall Extension button is disabled (greyed out) after selecting one or more VMs.
- Selecting VMs does not enable either action even though you expect one to be available.

## Cause

The portal enables the Install Extension or Uninstall Extension button only when the entire selection of VMs matches the required state for that action:

- Install Extension: enabled only when every selected VM does not currently have the New Relic agent installed.
- Uninstall Extension: enabled only when every selected VM already has the New Relic agent installed.

The Azure portal surface displays the agent/extension state in the Agent Status column:

- VMs that have the New Relic agent installed typically show "Running" or "Shutdown".
- VMs that do not have the New Relic agent installed show "Not Installed".

If your selection mixes VMs in different states (some with the agent and some without), neither Install nor Uninstall will be active.

## Solution 1

1. In the Azure portal, go to Virtual machines and open the list or blade that includes the New Relic extension controls.
2. Inspect the Agent Status column for each VM you plan to modify.
3. To install the New Relic extension:
   1. Select only VMs that show Agent Status "Not Installed".
   2. Deselect any VMs that show "Running" or "Shutdown" (these already have the agent).
   3. Confirm the Install Extension button becomes active and then proceed.
4. To uninstall the New Relic extension:
   1. Select only VMs that show Agent Status "Running" or "Shutdown" (these have the agent installed).
   2. Deselect any VMs that show "Not Installed".
   3. Confirm the Uninstall Extension button becomes active and then proceed.
5. After the operation completes, verify extension state in the VM's Extensions + applications blade or re-check the Agent Status column.

## Determine the cause of the problem

If the appropriate button remains disabled after following Solution 1, use the checks below to determine the underlying cause:

- Portal state is stale. Refresh the page or sign out and back in to the portal.
- Insufficient permissions. Confirm your RBAC role grants permission to manage extensions on the target VM or resource group.
- VM Agent issue. The Azure VM Agent might be missing, outdated, or unresponsive on the VM.
- Unsupported VM state or OS. The VM may be in a state (deallocated, failed) or running an unsupported OS that prevents extension management.

### Troubleshooting steps

- Refresh the portal and re-check the Agent Status column.
- Verify RBAC permissions (Contributor or Owner) for the subscription/resource group or the specific VM.
- Use Azure CLI or PowerShell to check extension and agent state:
  - Azure CLI:

    az vm extension list --resource-group {resource-group} --vm-name {vm-name} --output table

  - PowerShell (Az module):

    Get-AzVMExtension -ResourceGroupName {resource-group} -VMName {vm-name}

- Check the Activity Log for extension install/uninstall attempts and related errors.
- Test from an incognito/private browser window or clear browser cache to rule out UI caching issues.
- If the VM agent is missing or unresponsive, follow guidance to install or repair the Azure VM Agent for the VM's OS.
- If you still can't resolve the issue, collect VM names, resource group, timestamps, and Activity Log entries and open a support request.

## Verify

- After selecting only the correct set of VMs (all without agent for install, or all with agent for uninstall), the corresponding button should become active.
- Confirm the extension status in the VM's Extensions + applications blade and that the Agent Status column updates to reflect the change.

## Related content

- [Manage extensions on Azure virtual machines](https://learn.microsoft.com/azure/virtual-machines/extensions)
- [Troubleshoot VM Agent issues](https://learn.microsoft.com/azure/virtual-machines/troubleshooting-vm-agent)
- [New Relic Azure integration overview](https://docs.newrelic.com/docs/integrations/azure-integrations)