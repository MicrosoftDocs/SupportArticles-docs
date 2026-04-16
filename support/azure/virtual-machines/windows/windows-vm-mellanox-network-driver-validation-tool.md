---
title: Use the Azure VM Mellanox Driver Validation tool
description: Use the Windows Mellanox Driver Validation tool to find outdated mlx5 drivers and 0xD1 events in Azure Windows VMs. Run the tool to verify the cause of the events.
ms.service: azure-virtual-machines
ms.date: 03/26/2026
ms.custom: sap:My VM is not booting
ms.reviewer: jdickson, scotro, azurevmcptcic
---
# Use the Azure VM Mellanox Driver Validation tool

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

Use the Windows Mellanox Driver Validation tool to determine whether an outdated NVIDIA Mellanox mlx5 driver is causing failures or instability in Azure Windows VMs that use Accelerated Networking and NVIDIA Mellanox ConnectX adapters. The tool helps you identify "DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)" events so that you can verify the root cause.

Microsoft provides a script-based diagnostic tool that helps you verify whether an outdated Mellanox mlx5 driver is the root cause of the problem.

## Purpose

The **Windows Mellanox Driver Validation** script detects:

- Whether a Mellanox/NVIDIA ConnectX network adapter is present in the VM
- The installed Mellanox mlx5 driver version and date
- Any recent `DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)` stop error events in the Windows event log
- The current adapter link status

The script is **detection only**. It doesn't make changes to the system.

## Key features

- Detects NVIDIA Mellanox ConnectX network adapters.
- Reports driver version and flags adapters that have drivers that are older than 12 months.
- Scans the Windows event log for `0xD1` stop error events over the past 30 days.
- Reports the adapter link status (Up or Error).
- Formats output for the Azure portal Run Command viewer.

For more information, see:

- [Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs](troubleshoot-windows-vm-mellanox-network-driver-crash.md).
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation).

## How to run the tool

Run the tool in any of the following manners.

### Use Azure Run Command (recommended)

1. Go to your VM in the **Azure portal**.
1. Select **Operations** > **Run Command** > **RunPowerShellScript**.
1. Paste the contents of [Windows_Mellanox_Driver_Validation.ps1](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation) into the script pane.
1. Select **Run** and wait for output.

> [!NOTE]
> You can also run Run Command by using Azure CLI, Azure PowerShell, or an ARM template.

### Download and run manually inside the VM

1. Connect to the VM via RDP or Azure Bastion.
1. Download the script from GitHub:
   [Windows_Mellanox_Driver_Validation.ps1](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
1. Run the script from an elevated PowerShell session:

   ```powershell
   Set-ExecutionPolicy Bypass -Force
   .\Windows_Mellanox_Driver_Validation.ps1
   ```

### Use prepackaged Run Command scripts

For more information about Run command, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **[Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)** to check adapter presence, driver version, and recent failure events.
1. Review the output. If the driver is flagged as outdated, or if `0xD1` events are found, follow the resolution steps in the troubleshooting article.
1. Update the driver by following the guidance in [Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs](troubleshoot-windows-vm-mellanox-network-driver-crash.md).
1. Rerun the script after the driver update to verify that the issue is resolved.

## Additional resources

- [Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs](troubleshoot-windows-vm-mellanox-network-driver-crash.md).
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation).
- [Accelerated Networking overview](/azure/virtual-network/accelerated-networking-overview)
- [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
