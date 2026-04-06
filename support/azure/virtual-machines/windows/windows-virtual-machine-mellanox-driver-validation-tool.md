---
title: Azure VM Mellanox Driver Validation Tool
description: Use the Windows Mellanox Driver Validation Run Command script to detect outdated Mellanox mlx5 drivers and DRIVER_IRQL_NOT_LESS_OR_EQUAL crash events on Azure Windows VMs.
ms.service: azure-virtual-machines
ms.date: 03/26/2026
ms.custom: sap:My VM is not booting
ms.reviewer: jdickson, scotro, azurevmcptcic
---
# Azure VM Mellanox Driver Validation Tool

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

Azure Windows VMs with Accelerated Networking that use Mellanox/NVIDIA ConnectX adapters can crash or become unstable because of an outdated Mellanox mlx5 driver. This issue often appears as bug check **DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)**.

Microsoft provides a script-based diagnostic tool that helps you confirm whether an outdated Mellanox mlx5 driver is the root cause.

## Purpose

The **Windows Mellanox Driver Validation** script detects:

- Whether a Mellanox/NVIDIA ConnectX network adapter is present in the VM
- The installed Mellanox mlx5 driver version and date
- Any recent `DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)` bugcheck events in the Windows Event Log
- Current adapter link status

The script is **detection only**. It doesn't make changes to the system.

- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)

## Key features

- Detects Mellanox/NVIDIA ConnectX network adapters
- Reports driver version and flags adapters with drivers older than 12 months
- Scans Windows Event Log for `0xD1` bugcheck events over the last 30 days
- Reports adapter link status (Up/Error)
- Formats output for the Azure portal Run Command viewer

For more information, see:

- [Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs](./windows-virtual-machine-mellanox-driver-crash-troubleshooting.md)
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)

## How to run the tool

You can run the tool in any of the following ways:

### Use Azure RunCommand (recommended)

1. Navigate to your VM in the **Azure portal**.
2. Select **Operations** > **Run Command** > **RunPowerShellScript**.
3. Paste the contents of [Windows_Mellanox_Driver_Validation.ps1](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation) into the script pane.
4. Select **Run** and wait for output.

> [!NOTE]
> You can also run Run Command by using Azure CLI, Azure PowerShell, or an ARM template.

### Download and run manually inside the VM

1. Connect to the VM via RDP or Azure Bastion.
2. Download the script from GitHub:
   [Windows_Mellanox_Driver_Validation.ps1](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
3. Run from an elevated PowerShell session:

   ```powershell
   Set-ExecutionPolicy Bypass -Force
   .\Windows_Mellanox_Driver_Validation.ps1
   ```

### Use prepackaged Run Command scripts

For more information on how to use RunCommand, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **[Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)** to check adapter presence, driver version, and recent crash events.
2. Review the output. If the driver is flagged as outdated or `0xD1` events are found, follow the resolution steps in the troubleshooting article.
3. Update the driver following the guidance in [Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs](./windows-virtual-machine-mellanox-driver-crash-troubleshooting.md).
4. Rerun the script after the driver update to confirm the issue is resolved.

## Additional resources

- [Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs](./windows-virtual-machine-mellanox-driver-crash-troubleshooting.md)
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
- [Accelerated Networking overview](/azure/virtual-network/accelerated-networking-overview)
- [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
