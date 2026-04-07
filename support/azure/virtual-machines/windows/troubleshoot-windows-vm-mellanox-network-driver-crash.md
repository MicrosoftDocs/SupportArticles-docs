---
title: Troubleshoot Mellanox mlx5 driver crashes on Azure Windows VMs
description: Learn how to troubleshoot stop error "0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)" that causes Azure Windows virtual machines (VMs) to fail because of an outdated Mellanox mlx5 driver.
ms.service: azure-virtual-machines
ms.date: 03/26/2026
ms.custom: sap:My VM is not booting
ms.reviewer: jdickson, scotro, azurevmcptcic
---
# Troubleshoot Mellanox mlx5 driver failure on Azure Windows VMs

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you troubleshoot failures that occur on Azure Windows Virtual Machines (VMs) because of an outdated NVIDIA Mellanox mlx5 network adapter driver. The failures typically generate a blue screen and an error message window. The window displays stop error "0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)" and references the `mlx5.sys` driver module.

## Symptoms

A Windows Azure VM fails and restarts unexpectedly or becomes unstable. When this error occurs, common symptoms include:

- The VM fails and displays a blue screen and the following stop error message:

      DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)
- The VM becomes unresponsive and requires a forced restart.
- The VM continues to fail after a restart. No OS-level cause is apparent.
- A dump file is created that references the `mlx5.sys` driver module.

## Cause

This problem typically occurs because of an outdated Mellanox mlx5 network adapter driver in the guest VM.

The `mlx5.sys` driver is used on VM SKUs that include the Accelerated Networking fature. This feature relies on Mellanox ConnectX adapters.

If the installed driver version is no longer compatible with the host firmware or platform updates, the driver can trigger a kernel memory access violation. In Windows, this error usually appears as stop error "0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)."

> [!NOTE]
> This problem isn't caused by the Azure platform or host hardware failure. The problem occurs because of a guest OS driver compatibility issue. The resolution requires a driver update in the VM.

## Quick check

The contents of this article likely apply if both the following conditions are true:

- The error message displays "DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)."
- The error message references `mlx5.sys`.

### Affected configurations

- Windows Server VMs with Accelerated Networking enabled
- VM SKUs that use NVIDIA Mellanox ConnectX hardware (including HB, HC, ND, NDv2, HBv3, and performance-optimized N-series VMs)
- Mellanox mlx5 driver versions that weren't updated in more than 12 months

### Stop error signature

The following stop error message typically indicates this problem:

```
DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)
```

When you analyze the dump file, look for `mlx5.sys` in the faulting module field.

## Diagnosis

### Step 1: Check for a Mellanox adapter

Run the following command in an elevated PowerShell session in the VM:

```powershell
Get-PnpDevice -Class Net | Where-Object { $_.FriendlyName -match 'Mellanox|ConnectX|mlx5' }
```

If the command returns output, the VM has a Mellanox adapter.

### Step 2: Check the installed driver version

Run the following command:

```powershell
Get-WmiObject Win32_PnPSignedDriver | 
    Where-Object { $_.DeviceName -match 'Mellanox|ConnectX|mlx5' } | 
    Select-Object DeviceName, DriverVersion, DriverDate
```

Note the **DriverVersion** and **DriverDate** values. Compare these values with the minimum supported version in the internal TSG.

### Step 3: Check for recent 0x000000D1 stop error events

Run the following command:

```powershell
Get-WinEvent -FilterHashtable @{ LogName = 'Application'; Id = 1001; StartTime = (Get-Date).AddDays(-30) } |
    Where-Object { $_.Message -match '0x000000d1|DRIVER_IRQL_NOT_LESS_OR_EQUAL' }
```

If the command returns events, and the timestamps match your incidents, this condition confirms the pattern.

### Step 4: Run the automated validation script

Use the Azure portal Run command, **Azure VM - Windows Mellanox Driver Validation,** to run all checks in one pass:

[Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)

For the run steps, see [Use Azure VM Mellanox Driver Validation Tool](windows-vm-mellanox-network-driver-validation-tool.md).

## Resolution

### Update the Mellanox mlx5 driver

Update the Mellanox mlx5 driver in the VM to a supported version.

> [!IMPORTANT]
> Before you update the driver, take a snapshot of the OS disk.

#### Option A: Update through Windows Update (recommended)

1. Connect to the VM through RDP or Azure Bastion.
1. Open **Windows Update** > **Check for updates**.
1. If an NVIDIA Mellanox driver update is available as an optional update, install it.
1. Restart the VM.

#### Option B: Manual update through Device Manager

1. Connect to the VM through RDP or Azure Bastion.
1. Open **Device Manager**, and expand **Network adapters**.
1. Right-click the **Mellanox** adapter, select **Update driver**, and then select **Search automatically for drivers**.
1. If Windows finds an updated driver, install it and restart.

#### Option C: Direct download from NVIDIA

1. Identify the exact adapter model from Device Manager or from the diagnostic script output.
1. Download the latest Windows driver package from the [NVIDIA Mellanox driver download portal](https://network.nvidia.com/support/mlnx-ofed-public-repository/).
1. Install the driver in the VM, and then restart.

> [!NOTE]
> Before you run the installation, always compare the downloaded driver with the minimum supported version that's listed in the internal TSG.

### Verify the fix

After you update the driver and restart the VM, run the validation script again.

Verify that:

- The driver version is updated.
- No new 0x000000D1 bugcheck events occur after the restart.

## Additional resources

- [Use Azure VM Mellanox Driver Validation tool](windows-vm-mellanox-network-driver-validation-tool.md)
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
- [Accelerated Networking overview](/azure/virtual-network/accelerated-networking-overview)
- [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command)
- [Troubleshoot blue screen errors in Azure](/azure/virtual-machines/troubleshooting/troubleshoot-common-blue-screen-error)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
