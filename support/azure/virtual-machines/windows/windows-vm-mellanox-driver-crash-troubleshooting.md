---
title: Troubleshooting - Mellanox mlx5 Driver Crash on Azure Windows VMs (DRIVER_IRQL_NOT_LESS_OR_EQUAL)
description: Learn how to troubleshoot Azure Windows VM crashes caused by an outdated Mellanox mlx5 driver, identified by bugcheck 0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL).
ms.service: azure-virtual-machines
ms.date: 03/26/2026
ms.custom: sap:My VM is not booting
ms.reviewer: jdickson, scotro, azurevmcptcic
---
# Troubleshooting: Mellanox mlx5 Driver Crash on Azure Windows VMs

**Applies to:** :heavy_check_mark: Windows VMs

## Symptom

An Azure Virtual Machine (VM) running Windows experiences unexpected crashes, restarts, or instability. The following symptoms may be observed:

- VM crashes with a **blue screen (BSOD)** and the bugcheck **DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)**
- VM becomes unresponsive and requires a forced restart
- VM crashes recur after each restart without a clear OS-level explanation
- Crash dump analysis references the `mlx5.sys` driver module

## Cause

The root cause is an **outdated Mellanox mlx5 network adapter driver** installed in the guest VM. The Mellanox mlx5 driver (`mlx5.sys`) is used by VM SKUs with **Accelerated Networking** that use Mellanox / NVIDIA ConnectX-family adapters.

When the installed driver version is no longer compatible with the host firmware or platform updates, the driver can trigger a kernel memory access violation — surfaced as bugcheck **0x000000D1 (DRIVER_IRQL_NOT_LESS_OR_EQUAL)**.

> [!NOTE]
> This issue is **not** caused by the Azure platform or a host hardware failure. It is a guest OS driver compatibility issue that requires a driver update within the VM.

### Affected configurations

- Windows Server VMs with Accelerated Networking enabled
- VM SKUs that use Mellanox / NVIDIA ConnectX hardware (including HB, HC, ND, NDv2, HBv3, and performance-optimized N-series VMs)
- Mellanox mlx5 driver versions that have not been updated in more than 12 months

### Bugcheck signature

The following bugcheck is a commonly observed indicator of this issue:

```
DRIVER_IRQL_NOT_LESS_OR_EQUAL (0x000000D1)
```

When analyzing a crash dump, look for references to `mlx5.sys` in the faulting module field.

## Diagnosis

### Step 1: Check the VM for Mellanox adapter presence

Run the following from an elevated PowerShell session inside the VM:

```powershell
Get-PnpDevice -Class Net | Where-Object { $_.FriendlyName -match 'Mellanox|ConnectX|mlx5' }
```

If output is returned, a Mellanox adapter is present and this TSG applies.

### Step 2: Check the installed driver version

```powershell
Get-WmiObject Win32_PnPSignedDriver | 
    Where-Object { $_.DeviceName -match 'Mellanox|ConnectX|mlx5' } | 
    Select-Object DeviceName, DriverVersion, DriverDate
```

Record the **DriverVersion** and **DriverDate** values. Compare against the minimum supported version published in the internal TSG.

### Step 3: Check for recent 0x000000D1 bugcheck events

```powershell
Get-WinEvent -FilterHashtable @{ LogName = 'Application'; Id = 1001; StartTime = (Get-Date).AddDays(-30) } |
    Where-Object { $_.Message -match '0x000000d1|DRIVER_IRQL_NOT_LESS_OR_EQUAL' }
```

If events are returned with timestamps that correlate with the crash incidents, this confirms the pattern.

### Step 4: Use the automated validation RunCommand

Use the **Azure VM - Windows Mellanox Driver Validation** script to perform all checks in one pass via Azure portal RunCommand:

- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)

For instructions on running the tool, see [Azure VM Mellanox Driver Validation Tool](./windows-vm-mellanox-driver-validation-tool.md).

## Resolution

### Update the Mellanox mlx5 driver

The resolution is to update the Mellanox mlx5 driver to a supported version inside the VM.

> [!IMPORTANT]
> Before updating the driver, take a snapshot of the OS disk as a backup.

#### Option A: Update via Windows Update (recommended)

1. Connect to the VM via RDP or Azure Bastion.
2. Open **Windows Update** → **Check for updates**.
3. If a Mellanox / NVIDIA driver update is available as an optional update, install it.
4. Restart the VM.

#### Option B: Manual update via Device Manager

1. Connect to the VM via RDP or Azure Bastion.
2. Open **Device Manager** → expand **Network adapters**.
3. Right-click the **Mellanox** adapter → **Update driver** → **Search automatically for drivers**.
4. If Windows finds an updated driver, install it and restart.

#### Option C: Direct download from Mellanox / NVIDIA

1. Identify the exact adapter model from Device Manager or from the diagnostic script output.
2. Download the latest Windows driver package from the [NVIDIA / Mellanox driver download portal](https://network.nvidia.com/support/mlnx-ofed-public-repository/).
3. Install the driver inside the VM and restart.

> [!NOTE]
> Always validate the downloaded driver against the minimum supported version listed in the internal TSG before installing.

### Verify resolution

After the driver update and restart, rerun the validation script to confirm:

- Driver version is updated
- No new 0x000000D1 bugcheck events occur after the restart

## Additional resources

- [Azure VM Mellanox Driver Validation Tool](./windows-vm-mellanox-driver-validation-tool.md)
- [Azure VM - Windows Mellanox Driver Validation Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_Mellanox_Driver_Validation)
- [Accelerated Networking overview](/azure/virtual-network/accelerated-networking-overview)
- [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command)
- [Troubleshoot blue screen errors in Azure](/azure/virtual-machines/troubleshooting/troubleshoot-common-blue-screen-error)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
