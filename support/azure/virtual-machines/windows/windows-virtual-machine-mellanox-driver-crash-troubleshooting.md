---
title: Troubleshoot Mellanox mlx5 Driver Crashes on Azure Windows VMs (DRIVER_IRQL_NOT_LESS_OR_EQUAL)
description: Learn how to troubleshoot Azure Windows VM crashes caused by an outdated Mellanox mlx5 driver that triggers bug check 0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL).
ms.service: azure-virtual-machines
ms.date: 03/26/2026
ms.custom: sap:My VM is not booting
ms.reviewer: jdickson, scotro, azurevmcptcic
---
# Troubleshoot Mellanox mlx5 Driver Crashes on Azure Windows VMs

**Applies to:** :heavy_check_mark: Windows VMs

## Symptom

A Windows Azure Virtual Machine (VM) might crash, restart unexpectedly, or become unstable. Common symptoms include:

- VM crashes with a **blue screen (BSOD)** and the bugcheck **DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)**
- VM becomes unresponsive and requires a forced restart
- VM crashes continue after restart, with no clear OS-level cause
- Crash dump analysis references the `mlx5.sys` driver module

## Cause

This issue is caused by an **outdated Mellanox mlx5 network adapter driver** in the guest VM. The `mlx5.sys` driver is used on VM SKUs with **Accelerated Networking** that rely on Mellanox/NVIDIA ConnectX adapters.

If the installed driver version is no longer compatible with host firmware or platform updates, it can trigger a kernel memory access violation. In Windows, this usually appears as bug check **0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)**.

> [!NOTE]
> This issue is **not** caused by the Azure platform or host hardware failure. It is a guest OS driver compatibility issue and requires a driver update inside the VM.

### Affected configurations

- Windows Server VMs with Accelerated Networking enabled
- VM SKUs that use Mellanox/NVIDIA ConnectX hardware (including HB, HC, ND, NDv2, HBv3, and performance-optimized N-series VMs)
- Mellanox mlx5 driver versions that have not been updated in more than 12 months

### Bugcheck signature

The following bug check commonly indicates this issue:

```
DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)
```

When you analyze a crash dump, look for `mlx5.sys` in the faulting module field.

## Diagnosis

### Step 1: Check the VM for Mellanox adapter presence

Run the following from an elevated PowerShell session inside the VM:

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

If events are returned and the timestamps match the crash incidents, this confirms the pattern.

### Step 4: Use the automated validation RunCommand

Use the **Azure VM - Windows Mellanox Driver Validation** script to run all checks in one pass by using Azure portal Run Command:

- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)

For instructions on running the tool, see [Azure VM Mellanox Driver Validation Tool](./windows-virtual-machine-mellanox-driver-validation-tool.md).

## Resolution

### Update the Mellanox mlx5 driver

To resolve this issue, update the Mellanox mlx5 driver to a supported version in the VM.

> [!IMPORTANT]
> Before you update the driver, take a snapshot of the OS disk.

#### Option A: Update via Windows Update (recommended)

1. Connect to the VM via RDP or Azure Bastion.
2. Open **Windows Update** → **Check for updates**.
3. If a Mellanox/NVIDIA driver update is available as an optional update, install it.
4. Restart the VM.

#### Option B: Manual update via Device Manager

1. Connect to the VM via RDP or Azure Bastion.
2. Open **Device Manager** → expand **Network adapters**.
3. Right-click the **Mellanox** adapter → **Update driver** → **Search automatically for drivers**.
4. If Windows finds an updated driver, install it and restart.

#### Option C: Direct download from Mellanox / NVIDIA

1. Identify the exact adapter model from Device Manager or from the diagnostic script output.
2. Download the latest Windows driver package from the [NVIDIA / Mellanox driver download portal](https://network.nvidia.com/support/mlnx-ofed-public-repository/).
3. Install the driver in the VM, and then restart.

> [!NOTE]
> Always compare the downloaded driver with the minimum supported version listed in the internal TSG before you install it.

### Verify resolution

After you update the driver and restart the VM, run the validation script again to confirm:

- Driver version is updated
- No new 0x000000D1 bugcheck events occur after the restart

## Additional resources

- [Azure VM Mellanox Driver Validation Tool](./windows-virtual-machine-mellanox-driver-validation-tool.md)
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
- [Accelerated Networking overview](/azure/virtual-network/accelerated-networking-overview)
- [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command)
- [Troubleshoot blue screen errors in Azure](/azure/virtual-machines/troubleshooting/troubleshoot-common-blue-screen-error)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
