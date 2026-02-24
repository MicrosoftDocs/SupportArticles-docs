---
title: Error 0x800719e4 (ERROR_LOG_FULL) When Windows Update Fails
description: Discusses how to fix Windows Update failures related to error code `0x800719e4 (ERROR_LOG_FULL)`--typically on Azure-hosted Windows virtual machines.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ai.usage: ai-generated
ms.topic: troubleshooting
ms.reviewer: kaushika, dougking, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Azure Virtual Machines</a>
---
# Error 0x800719e4 (ERROR_LOG_FULL) when Windows Update fails

## Summary

This article explains how to fix Windows Update error `0x800719e4 (ERROR_LOG_FULL)` when updates fail on supported Windows Server, Windows client, and Azure virtual machines. It describes common causes such as full or corrupted transaction logs, ghosted network adapters or drivers, and misconfigured update orchestration and provides step-by-step guidance to restore successful Windows Update operations.

## Symptoms

When you try to install a Windows update, the installation fails and returns error code `0x800719e4 (ERROR_LOG_FULL)`. The update might appear to install. However, after the computer restarts at the end of installation, the installation rolls back. The Windows Update history might list repeated failed installations.

When this issue occurs, the System log and Component-Based Servicing (CBS) log might include any of the following error messages:

- `Failed uninstalling driver updates [HRESULT = 0x800719e4 - ERROR_LOG_FULL]`
- `Startup: Failed while processing non-critical driver operations queue`
- `patch not applicable` or `patch not reflecting after restart`
- `0x80070002 (ERROR_FILE_NOT_FOUND)`
- `0x800f0991 (PSFX_E_MISSING_PAYLOAD_FILE)`
- `0x800f0982 (PSFX_E_MATCHING_COMPONENT_NOT_FOUND)`
- `0x800F0920 (CBS_E_HANG_DETECTED)`

## Cause

Typically, this issue occurs during the installation or uninstallation of cumulative or driver-related updates. This issue has various possible causes:

- **Transaction log exhaustion, corruption, or improper cleanup**. Windows transaction logs (.blf files and .regtrans-ms files in \Windows\System32\Config\TxR) become full or corrupted, and then block update processes. Improper cleaning of the transaction logs can cause further system corruption and startup failures.
- **"Ghosted" network adapters or drivers**. VMs that are frequently deallocated and reallocated in Azure can accumulate "ghosted" or hidden device entries that remain in the system registry but are no longer physically present. This behavior is observed in Mellanox devices. When this behavior occurs, driver update queues increase in size, and logs eventually overflow.
- **Misconfigured update orchestration**. Incorrect settings for update orchestration (such as not using the **Customer Managed** option) can contribute to update failures.

## Resolution

> [!IMPORTANT]  
>
> - If the affected computer is a Windows VM that can't restart correctly or that you can't access by using SSH, make sure that you can use the Azure Serial Console to access the VM.
> - Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).
> - Use administrative permissions to run all the commands and scripts that are provided in these steps.

### Step 1: Check the system health

To check the system health and make any necessary repairs, open an administrative Command Prompt window, and then run the following commands:

```console
DISM /Online /Cleanup-Image /RestoreHealth
SFC /SCANNOW
```

Review the output for errors or corruption. If these commands make repairs, try again to install the update.

### Step 2: Clean up the transaction logs

> [!IMPORTANT]  
> Cleaning up transaction incorrectly logs can cause more issues to occur.

Follow these steps:

1. If the affected computer is a VM that can't start, create a rescue VM. Then move the operating system disk from the affected VM to the rescue VM.
1. On the rescue VM or the affected physical computer, open an administrative command prompt window, and then change the working directory to \<drive>:\Windows\System32\Config\TxR.
1. To remove the system and hidden attributes from the transaction log files, run the following command:

   ```console
   attrib -h -s *
   ```

1. To delete the transaction log files, run the following commands:

   ```console
   del *.blf
   del *.regtrans-ms
   ```

1. If you're using a rescue VM, move the operating system disk back to the original VM.

1. Start the VM (or restart the physical computer), and then try again to install the update.

### Step 3: Check for ghosted network adapters or drivers

For more information about this issue, see [Azure VM Ghosted Nic Validation and Cleanup Tools](../../azure/virtual-machines/windows/windows-vm-ghostednic-tool.md).

> [!NOTE]  
> A computer that accumulates ghosted network adapters or drivers might continue to behave in this manner. Consider checking for this issue periodically as part of regular maintenance.

1. Download the following scripts:

- [Windows_GhostedNIC_Detection.ps1](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_GhostedNIC_Detection.ps1)
- [Windows_GhostedNIC_Removal.ps1](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_GhostedNIC_Removal.ps1)

1. To detect any ghosted network adapters or drivers, open an administrative Windows PowerShell Command Prompt window, and then run the following commands:

   ```powershell
   Set-ExecutionPolicy Bypass -Force
   .\Windows_GhostedNIC_Detection.ps1
   ```

1. If the script detects ghosted network adapters or drivers, run the following commands:

   ```powershell
   Set-ExecutionPolicy Bypass -Force
   .\Windows_GhostedNIC_Removal.ps1
   ```

1. If the affected computer has a Mellanox adapter or driver, run the following commands:

   ```powershell
   Get-PnpDevice | Where-Object { $_.FriendlyName -like "*Mellanox*" }
   pnputil /remove-device <InstanceID>
   ```

   > [!NOTE]  
   > In this command, \<InstanceID> represents the instance ID number of the device.

1. Restart the computer, and then try again to install the update.

## Data collection

If issues persist, consider contacting Microsoft Support. Before you contact Microsoft Support for assistance, use the Trouble Shooting Script (TSS) diagnostic scripts to collect data, as described in [Collect data to analyze and troubleshoot Windows servicing, Updates, and Features on Demand scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-windows-servicing-scenarios.md?context=%2Ftroubleshoot%2Fwindows-server%2Fcontext%2Fcontext#scenario-failures-to-install-windows-updates-or-features-on-demand). Attach this information to your support request.

## References

- [Ghosted NIC Detection & Removal Scripts](https://github.com/Azure/azure-support-scripts)
- [Introduction to TroubleShootingScript toolset (TSS)](../../windows-client/windows-tss/introduction-to-troubleshootingscript-toolset-tss.md)
