---
title: Troubleshoot Mellanox mlx5 driver crashes on Azure Windows virtual machines (DRIVER_IRQL_NOT_LESS_OR_EQUAL)
description: Troubleshoot Mellanox mlx5 driver failures on Azure Windows VMs causing DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1), and restore VM stability now.
ms.service: azure-virtual-machines
ms.date: 03/26/2026
ms.custom: sap:My VM is not booting
ms.reviewer: jdickson, scotro, azurevmcptcic
---
# Troubleshoot Mellanox mlx5 driver failures on Azure Windows virtual machines

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article provides guidance to troubleshoot Microsoft Azure Windows virtual machine (VM) failures that are caused by an outdated Mellanox mlx5 network adapter driver. An outdated driver can trigger the **0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)** stop error.

## Symptoms

A Windows Azure VM might stop responding, restart unexpectedly, or become unstable. Common signs include:

- The VM fails and generates a **blue screen (BSOD)** error and **DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)** stop error.
- The VM becomes unresponsive and requires a forced restart.
- The problem continues after a restart. There is no clear OS-level cause.
- A crash dump file analysis references the `mlx5.sys` driver module.

## Cause

This problem occurs if the guest VM uses an outdated Mellanox mlx5 network adapter driver. The `mlx5.sys` driver is used on VM versions that use **Accelerated Networking** that rely on Mellanox/NVIDIA ConnectX adapters.

If the installed driver version is no longer compatible with host firmware or platform updates, the driver can trigger a kernel memory access violation. In Windows, this error usually appears as the **0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)** stop error.

> [!NOTE]
> This problem isn't caused by the Azure platform or host hardware failure. It's a guest OS driver compatibility problem that requires a driver update inside the VM.

### Affected configurations

- Windows Server VMs that have **Accelerated Networking** enabled
- VM SKUs that use Mellanox or NVIDIA ConnectX hardware, including HB, HC, ND, NDv2, HBv3, and performance-optimized N-series VMs
- Mellanox mlx5 driver versions that aren't updated for at least 12 months

### Stop error signature

The following stop error commonly indicates this problem:

```
DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)
```

When you analyze a crash dump file, look for `mlx5.sys` in the faulting module field.

## Diagnosis

### Step 1: Check the VM for Mellanox adapter presence

Run the following command in an elevated PowerShell session in the VM:

```powershell
Get-PnpDevice -Class Net | Where-Object { $_.FriendlyName -match 'Mellanox|ConnectX|mlx5' }
```

If the command returns output, a Mellanox adapter is present and this article applies.

### Step 2: Check the installed driver version

```powershell
Get-WmiObject Win32_PnPSignedDriver | 
    Where-Object { $_.DeviceName -match 'Mellanox|ConnectX|mlx5' } | 
    Select-Object DeviceName, DriverVersion, DriverDate
```

Record the **DriverVersion** and **DriverDate** values. Compare them with the minimum supported version listed in the internal TSG.

### Step 3: Check for recent 0x000000D1 bugcheck events

```powershell
Get-WinEvent -FilterHashtable @{ LogName = 'Application'; Id = 1001; StartTime = (Get-Date).AddDays(-30) } |
    Where-Object { $_.Message -match '0x000000d1|DRIVER_IRQL_NOT_LESS_OR_EQUAL' }
```

If the command returns events, and the timestamps match the failure incidents, you verify the pattern.

### Step 4: Use the automated validation Run Command

Use the **Azure VM - Windows Mellanox Driver Validation** script to run all checks in one pass by using the Azure portal Run Command:

- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)

For instructions to run the tool, see [Azure VM Mellanox Driver Validation Tool](./windows-vm-mellanox-network-driver-validation-tool.md).

## Resolution

### Update the Mellanox mlx5 driver

To resolve this problem, update the Mellanox mlx5 driver to a supported version in the VM.

> [!IMPORTANT]
> Before you update the driver, take a snapshot of the OS disk.

#### Option A: Update using Windows Update (recommended)

1. Connect to the VM by using Remote Desktop Protocol (RDP) or Azure Bastion.
1. Open **Windows Update** > **Check for updates**.
1. If a Mellanox/NVIDIA driver update is available as an optional update, install it.
1. Restart the VM.

#### Option B: Manual update using Device Manager

1. Connect to the VM by using RDP or Azure Bastion.
1. Open **Device Manager**, and then expand **Network adapters**.
1. Right-click the **Mellanox** adapter, select **Update driver**, and then select **Search automatically for drivers**.
1. If Windows finds an updated driver, install it, and then restart.

#### Option C: Direct download from Mellanox / NVIDIA

1. Identify the exact adapter model from Device Manager or from the diagnostic script output.
1. Download the latest Windows driver package from the [NVIDIA / Mellanox driver download portal](https://network.nvidia.com/support/mlnx-ofed-public-repository/).
1. Install the driver in the VM, and then restart.

> [!NOTE]
> Always compare the downloaded driver with the minimum supported version that's listed in the internal TSG before you install the driver.

### Verify resolution

After you update the driver and restart the VM, run the validation script again to verify that:

- The driver version is updated.
- No new **0x000000D1** stop error events occur after the restart.

## References

- [Azure VM Mellanox Driver Validation Tool](./windows-vm-mellanox-network-driver-validation-tool.md)
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
- [Accelerated Networking overview](/azure/virtual-network/accelerated-networking-overview)
- [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command)
- [Troubleshoot blue screen errors in Azure](/azure/virtual-machines/troubleshooting/troubleshoot-common-blue-screen-error)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
