---
title: Troubleshoot Windows Update failures on Azure VMs
description: Learn how to diagnose and resolve Windows Update failures on Azure virtual machines, including error codes, WSUS configuration issues, component store corruption, and network connectivity problems.
author: scotro
ms.author: scotro
ms.reviewer: jarrettr, macla, glimoli, azurevmcptcic
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.date: 07/13/2026
ms.custom:
- sap:Windows Update and OS Upgrades
- pcy:WinComm Devices Deploy
---

# Troubleshoot Windows Update failures on Azure VMs

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you diagnose and resolve Windows Update failures on Azure virtual machines (VMs). Windows Update failures on Azure VMs can appear as installation errors, scan failures, or VMs that become unresponsive during the update process. Use the decision tree in this article to identify your issue category, and then follow the linked article for detailed troubleshooting steps.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Prerequisites

- Administrative access to the Azure VM (via Remote Desktop Protocol (RDP), serial console, or Run Command).
- A recent backup of the VM. For more information, see [About Azure VM backup](/azure/backup/backup-azure-vms-introduction).

## Identify the issue

Use the following decision tree to determine which category matches your Windows Update problem. Start by checking whether Azure Update Manager is involved, and then narrow down the Windows Update issue.

### Step 1: Check whether Azure Update Manager is managing this VM

Before you troubleshoot the Windows Update engine on the VM, determine whether [Azure Update Manager](/azure/update-manager/overview) is orchestrating updates for this VM. If Azure Update Manager is involved, the problem might be at the orchestration layer rather than within the VM's update engine.

Check for Azure Update Manager involvement:

1. In the [Azure portal](https://portal.azure.com), go to your VM and select **Updates** under **Operations**.
1. If the **Updates** pane shows assessment results, patch schedules, or an **Azure Update Manager** configuration, the VM is managed by Azure Update Manager.
1. If you see errors related to periodic assessment, scheduled patching, or the `Microsoft.CPlat.Core.WindowsPatchExtension` extension, troubleshoot Azure Update Manager first. See [Troubleshoot known issues with Azure Update Manager](/azure/update-manager/troubleshoot).

If Azure Update Manager isn't involved, continue to the next step. If Azure Update Manager is managing the VM but the errors point to the Windows Update engine on the VM (for example, CBS corruption codes like `0x80073712`), troubleshoot the Windows Update engine by continuing to the next step — Azure Update Manager can't resolve issues within the VM's servicing stack.

### Step 2: Determine the Windows Update failure category

#### Updates fail with a specific error code

If Windows Update fails and you see a specific error code (for example, `0x80073712`, `0x800F0831`, or `0x80070002`), use the following workflow:

1. Run the [Azure VM Windows Update Error Detection Tool](windows-vm-ipu-tool.md) to scan CBS logs for known servicing errors.
1. Check whether your error code appears in the [error code reference table](#common-windows-update-error-codes).
1. Try the quick fixes in [Reset Windows Update components](#reset-windows-update-components).
1. If the error persists after the reset, follow the resolution for your error category:
   - **Component store corruption** (0x80073712, 0x800F0831, 0x80073701): See [Troubleshoot CBS and component store corruption on Azure VMs](troubleshoot-cbs-component-store-corruption-azure-vm.md).
   - **Errors that require an in-place upgrade** (IPU): See [Troubleshoot Windows Update errors that require in-place upgrades for Azure VMs](windows-update-errors-requiring-in-place-upgrade.md).

#### Updates aren't offered or won't download

If Windows Update scans but finds no updates, or updates are detected but won't download, the problem is typically a configuration or connectivity issue:

1. **Check the update source configuration.** Azure VMs can receive updates from Windows Update or Windows Server Update Services (WSUS). Misconfigured Group Policy or registry settings can redirect the VM to the wrong source. See [Configure Windows Update settings](/azure/update-manager/configure-wu-agent).
1. **Verify network connectivity.** Azure VMs must reach Windows Update endpoints. Network Security Group (NSG) rules, User Defined Routes (UDRs), or firewall appliances can block the required connections. See [Troubleshoot network and proxy issues blocking Windows Update on Azure VMs](troubleshoot-windows-update-network-proxy-azure-vm.md).

#### VM is unresponsive during or after an update

If the VM stops responding during the update installation or after a restart:

1. Use [Boot diagnostics](/azure/virtual-machines/boot-diagnostics) to check the VM's screen state.
1. If you see **"Getting Windows ready. Don't turn off your computer"**, see [VM startup is stuck on "Getting Windows ready"](troubleshoot-vm-boot-configure-update.md).
1. If you see **error C01A001D**, see:
   - [Troubleshoot OS startup – Windows Update installation capacity](windows-update-installation-capacity.md) (disk space issue).
   - [VM is unresponsive with C01A001D after applying Windows Update](unresponsive-vm-apply-windows-update.md) (Windows Server 2016 specific).
1. If the VM doesn't boot at all after an update, see [Troubleshoot Azure VM boot errors](boot-error-troubleshoot.md).

#### Hotpatch failures

If you use [hotpatching](/windows-server/get-started/hotpatch) on Azure Edition VMs and a hotpatch fails to apply or the VM unexpectedly reboots, see [Troubleshoot hotpatch failures on Azure VMs](troubleshoot-hotpatch-failures-azure-vm.md).

## Reset Windows Update components

For many Windows Update failures, resetting the servicing stack resolves the issue without further troubleshooting. Use the [Azure VM Windows Update Reset Tool](windows-vm-wureset-tool.md) to automate this process.

The reset tool stops the `wuauserv`, `cryptsvc`, and Background Intelligent Transfer Service (`BITS`) services, renames the `SoftwareDistribution` and `catroot2` folders, re-registers Windows Update DLLs, and restarts the stopped services.

After the reset completes, retry Windows Update. If the update installs successfully and no error code appears, the issue is resolved. If the error persists, follow the category-specific troubleshooting from [Identify the issue](#identify-the-issue) — each spoke article has deeper resolution steps including DISM repair, CBS.log analysis, and in-place upgrade assessment.

## Common Windows Update error codes

The following table lists common Windows Update error codes and their categories. Use this table to quickly identify the type of issue and the recommended first action.

| Error code | Name | Category | First action |
|---|---|---|---|
| 0x80073712 | ERROR_SXS_COMPONENT_STORE_CORRUPT | Component store corruption | [CBS spoke: DISM repair](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-2-run-dism-to-scan-and-repair-the-component-store) |
| 0x800F0831 | CBS_E_STORE_CORRUPTION | Component store corruption | [CBS spoke: DISM repair](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-2-run-dism-to-scan-and-repair-the-component-store) |
| 0x80073701 | ERROR_SXS_ASSEMBLY_MISSING | Component store corruption | [CBS spoke: DISM repair](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-2-run-dism-to-scan-and-repair-the-component-store) |
| 0x800F081F | CBS_E_SOURCE_MISSING | Missing source files | [CBS spoke: DISM with source](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-4-run-dism-with-a-known-good-source) |
| 0x8007000D | ERROR_INVALID_DATA | Corrupted metadata | [WU Reset](#reset-windows-update-components), then [CBS spoke](troubleshoot-cbs-component-store-corruption-azure-vm.md) |
| 0x800705B9 | ERROR_XML_PARSE_ERROR | Servicing stack corruption | [CBS spoke: DISM repair](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-2-run-dism-to-scan-and-repair-the-component-store) |
| 0x800F0922 | CBS_E_INSTALLERS_FAILED | Advanced installer failure | [WU Reset](#reset-windows-update-components) |
| 0x80072F8F | WININET_E_DECODING_FAILED | SSL/TLS or clock issue | [Network spoke: TLS and certificates](troubleshoot-windows-update-network-proxy-azure-vm.md#step-5-fix-tls-and-certificate-issues) |
| 0x80240439 | WU_E_SETUP_HANDLER_EXEC_FAILURE | Setup handler failure | [WU Reset](#reset-windows-update-components) |
| 0x800F0984 | PSFX_E_MATCHING_BINARY_MISSING | Delta update corruption | [CBS spoke: In-place upgrade](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-5-perform-an-in-place-upgrade) |
| 0x800F0986 | PSFX_E_APPLY_FORWARD_DELTA_FAILED | Delta update failure | [CBS spoke: In-place upgrade](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-5-perform-an-in-place-upgrade) |
| 0x800F0830 | CBS_E_IMAGE_UNSERVICEABLE | Image unserviceable | [CBS spoke: In-place upgrade](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-5-perform-an-in-place-upgrade) |
| 0x80070002 | ERROR_FILE_NOT_FOUND | Missing system file | [WU Reset](#reset-windows-update-components), then [CBS spoke](troubleshoot-cbs-component-store-corruption-azure-vm.md) |
| 0x80242016 | WU_E_UH_POSTREBOOTUNEXPECTEDSTATE | Post-reboot failure | [CBS spoke: In-place upgrade](troubleshoot-cbs-component-store-corruption-azure-vm.md#step-5-perform-an-in-place-upgrade) |
| 0x80071AB1 | ERROR_LOG_GROWTH_FAILED | Transaction log full | Free disk space, then [WU Reset](#reset-windows-update-components) |
| 0xC01A001D | STATUS_LOG_FULL | Disk space exhaustion | [Installation capacity article](windows-update-installation-capacity.md) |

If your error code isn't listed in this table, the issue might be related to network connectivity or proxy configuration. See [Updates aren't offered or won't download](#updates-arent-offered-or-wont-download), or check the error code table in [Troubleshoot network and proxy issues blocking Windows Update on Azure VMs](troubleshoot-windows-update-network-proxy-azure-vm.md).

For a complete list of error codes that require an in-place upgrade, see [Troubleshoot Windows Update errors that require in-place upgrades for Azure VMs](windows-update-errors-requiring-in-place-upgrade.md).

## Collect logs for further investigation

If you can't resolve the issue by using the steps in this article, collect the following logs before you contact Azure support:

1. **Component-Based Servicing (CBS) logs:** Located at `C:\Windows\Logs\CBS\CBS.log` and archived `.cab` files in the same folder.
1. **WindowsUpdate.log:** On modern Windows versions, generate this log by running the following command in an elevated PowerShell session:

   ```powershell
   Get-WindowsUpdateLog
   ```

   On Windows Server 2012 R2 and earlier, the log is located at `C:\Windows\WindowsUpdate.log`.

1. **ReportingEvents.log:** Located at `C:\Windows\SoftwareDistribution\ReportingEvents.log`.
1. **DISM log:** Located at `C:\Windows\Logs\DISM\dism.log`.

## References

- [Troubleshoot CBS and component store corruption on Azure VMs](troubleshoot-cbs-component-store-corruption-azure-vm.md)
- [Troubleshoot network and proxy issues blocking Windows Update on Azure VMs](troubleshoot-windows-update-network-proxy-azure-vm.md)
- [Troubleshoot hotpatch failures on Azure VMs](troubleshoot-hotpatch-failures-azure-vm.md)
- [Troubleshoot Windows Update errors that require in-place upgrades for Azure VMs](windows-update-errors-requiring-in-place-upgrade.md)
- [Fix Windows Update corruptions and installation failures](/troubleshoot/windows-server/installing-updates-features-roles/fix-windows-update-errors)
- [Azure VM Windows Update Reset Tool](windows-vm-wureset-tool.md)
- [Azure VM Windows Update Error Detection Tool](windows-vm-ipu-tool.md)
- [Azure VM Windows OS Upgrade Assessment Tool](windows-vm-osupgradeassessment-tool.md)
- [Configure Windows Update settings for Azure Update Manager](/azure/update-manager/configure-wu-agent)
- [Troubleshoot known issues with Azure Update Manager](/azure/update-manager/troubleshoot)
- [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
