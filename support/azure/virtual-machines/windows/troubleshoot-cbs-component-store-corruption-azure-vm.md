---
title: Troubleshoot CBS and component store corruption on Azure VMs
description: Learn how to diagnose and repair Component-Based Servicing (CBS) and WinSxS component store corruption that prevents Windows Update from installing on Azure VMs.
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

# Troubleshoot CBS and component store corruption on Azure VMs

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you diagnose and repair Component-Based Servicing (CBS) and Windows Side-by-Side (WinSxS) component store corruption on Azure virtual machines (VMs). Component store corruption is one of the most common causes of Windows Update failures on Azure VMs. When the component store is corrupted, Windows can't verify or install updates because the metadata or binaries that the servicing stack depends on are damaged or missing.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Symptoms

Component store corruption typically produces one of the following symptoms:

- Windows Update fails with an error code that indicates corruption. Common codes include:

  | Error code | Name | Description |
  |---|---|---|
  | 0x80073712 | ERROR_SXS_COMPONENT_STORE_CORRUPT | The component store is in an inconsistent state. |
  | 0x800F0831 | CBS_E_STORE_CORRUPTION | CBS store is corrupted. |
  | 0x80073701 | ERROR_SXS_ASSEMBLY_MISSING | A component is missing from the store. |
  | 0x800F081F | CBS_E_SOURCE_MISSING | The source for the package or file isn't found. |
  | 0x800705B9 | ERROR_XML_PARSE_ERROR | XML parsing error in servicing metadata. |
  | 0x800F0805 | CBS_E_INVALID_PACKAGE | The update package is invalid or corrupted. |
  | 0x800F080D | CBS_E_MANIFEST_INVALID_ITEM | Invalid CBS manifest entry. |
  | 0x800F0900 | CBS_E_XML_PARSER_FAILURE | Generic XML parsing failure in servicing. |

- CBS.log contains entries that resemble the following example:

  ```output
  Error  CSI  (F) STATUS_SXS_COMPONENT_STORE_CORRUPT #62038# from
  CCSDirectTransaction::OperateEnding at index 0 of 1 operations [gle=0xd015001a]
  ```

  ```output
  Error  CSI  (F) HRESULT_FROM_WIN32(14098) #61875# from
  Windows::ServicingAPI::CCSITransaction::ICSITransaction2_AddComponents
  [gle=0x80073712]
  ```

- Deployment Image Servicing and Management (DISM) `/CheckHealth` or `/ScanHealth` reports corruption.

- System File Checker (`sfc /scannow`) reports files that it can't repair.

## Cause

Component store corruption on Azure VMs is typically caused by:

- **Interrupted updates**: A VM that restarted, lost power, or was deallocated during a Windows Update installation.
- **Disk space exhaustion**: Insufficient free space on the OS disk prevented the servicing stack from completing file operations.
- **Accumulated servicing debt**: VMs that haven't been updated for extended periods can accumulate corrupted pending operations in the servicing queue.
- **Failed rollbacks**: A previous update that failed and couldn't fully roll back, leaving partial state in the component store.

## Resolution

Work through the following steps in order. Each step is progressively more intensive. If a simpler step resolves the issue, you don't need to continue to the next step.

### Step 1: Run the Azure VM Windows Update Reset Tool

The [Azure VM Windows Update Reset Tool](windows-vm-wureset-tool.md) resets the Windows Update servicing stack by stopping services, renaming the `SoftwareDistribution` and `catroot2` folders, re-registering DLLs, and restarting services.

You can run this tool by using Azure Run Command directly from the Azure portal without needing Remote Desktop Protocol (RDP) access to the VM. For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

After the reset completes, retry Windows Update. If the update still fails with a corruption error, continue to Step 2.

### Step 2: Run DISM to scan and repair the component store

DISM can detect and repair many types of component store corruption by downloading replacement files from Windows Update.

#### [Run Command (recommended)](#tab/runcommand)

Run the following commands by using [Azure Run Command](/azure/virtual-machines/windows/run-command) if you can't connect to the VM via RDP:

```powershell
# Scan the component store for corruption
DISM.exe /Online /Cleanup-Image /ScanHealth

# Repair the component store
DISM.exe /Online /Cleanup-Image /RestoreHealth
```

#### [RDP session](#tab/rdp)

Connect to the VM via RDP and open an elevated Command Prompt:

```cmd
DISM.exe /Online /Cleanup-Image /ScanHealth
```

If DISM reports corruption, run:

```cmd
DISM.exe /Online /Cleanup-Image /RestoreHealth
```

---

> [!NOTE]
> The `/RestoreHealth` command requires an internet connection to download repair files from Windows Update. If the VM can't reach Windows Update (for example, because of a network restriction), use a Windows installation source instead:
>
> ```cmd
> DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:D:\sources\install.wim /LimitAccess
> ```

After DISM completes, run a System File Checker (SFC) scan:

```cmd
sfc /scannow
```

Then retry Windows Update.

### Step 3: Check the CBS.log for specific corruption details

If DISM doesn't resolve the issue, check the CBS.log to identify the specific corrupted component.

1. Open the CBS.log file at `C:\Windows\Logs\CBS\CBS.log`.

   > [!TIP]
   > On Azure VMs, you can use [Azure Run Command](/azure/virtual-machines/windows/run-command) to retrieve the CBS.log without RDP access:
   >
   > ```powershell
   > Get-Content "C:\Windows\Logs\CBS\CBS.log" -Tail 200 | Select-String "Error|CORRUPT|MISSING"
   > ```

1. Search for lines that contain `Error`, `CORRUPT`, `MISSING`, or `HRESULT`. These entries identify the specific component or package that's failing.

1. Look for a pattern that resembles the following example:

   ```output
   Failed to bulk stage deployment manifest and pin deployment for
   package:<PackageName>~31bf3856ad364e35~amd64~~<version>
   [HRESULT = 0x80073712 - ERROR_SXS_COMPONENT_STORE_CORRUPT]
   ```

   The package name in the error identifies the specific update or component that's corrupted.

1. If you can identify the specific corrupted package, you can try to reinstall that package:

   ```cmd
   DISM.exe /Online /Remove-Package /PackageName:<package-name-from-log>
   DISM.exe /Online /Cleanup-Image /RestoreHealth
   ```

### Step 4: Run DISM with a known good source

If the online `/RestoreHealth` command fails (for example, the VM can't access Windows Update, or the corruption is too severe for automatic repair), use a Windows installation source.

1. Attach a Windows Server ISO as a data disk to the VM. Use the same OS version and build number as the VM. For more information, see [Attach a managed disk to a VM](/azure/virtual-machines/windows/attach-managed-disk-portal).

1. After the disk is attached, identify the drive letter (for example, `E:`).

1. Run DISM with the source:

   ```cmd
   DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:E:\sources\install.wim /LimitAccess
   ```

1. After DISM completes, run SFC:

   ```cmd
   sfc /scannow
   ```

1. Retry Windows Update.

### Step 5: Perform an in-place upgrade

If all previous steps fail to resolve the component store corruption, perform an in-place upgrade (IPU). An IPU reinstalls Windows while preserving your data, applications, and settings.

> [!IMPORTANT]
> Before you start an in-place upgrade, create a backup of the VM by using [Azure Backup](/azure/backup/backup-azure-vms-introduction). An IPU restarts the VM multiple times and takes 45-60 minutes to complete.

1. Run the [Azure VM Windows Update Error Detection Tool](windows-vm-ipu-tool.md) to verify that the errors require an IPU.
1. Run the [Azure VM Windows OS Upgrade Assessment Tool](windows-vm-osupgradeassessment-tool.md) to verify that the VM supports an in-place upgrade.
1. Follow the appropriate upgrade guide:
   - [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
   - [In-place upgrade for VMs running Windows in Azure (Windows client)](in-place-system-upgrade.md)

For a complete list of error codes that typically require an in-place upgrade, see [Troubleshoot Windows Update errors that require in-place upgrades for Azure VMs](windows-update-errors-requiring-in-place-upgrade.md).

## How to read CBS.log for component store issues

Understanding the CBS.log helps you assess the severity of corruption and determine the right resolution path.

### Key log entries and what they mean

| Log pattern | What it means | Severity |
|---|---|---|
| `STATUS_SXS_COMPONENT_STORE_CORRUPT` | The component store metadata is inconsistent. DISM `/RestoreHealth` usually resolves this. | Medium |
| `HRESULT_FROM_WIN32(14098)` | Same as 0x80073712. A transaction failed because of store corruption. | Medium |
| `CBS_E_SOURCE_MISSING` (0x800F081F) | Windows can't find files needed for the update. DISM with a source (Step 4) is required. | High |
| `Attempting to mark store corrupt` | CBS detected corruption and flagged the store. Automatic repair might work. | Medium |
| `CBS_E_IMAGE_UNSERVICEABLE` (0x800F0830) | The servicing stack is too damaged for repair. IPU (Step 5) is required. | Critical |
| `PSFX_E_MATCHING_BINARY_MISSING` | Delta update can't find matching binaries. IPU is typically required. | Critical |

### Where to find CBS.log

- **Current log**: `C:\Windows\Logs\CBS\CBS.log`
- **Archived logs**: `C:\Windows\Logs\CBS\CbsPersist_*.log` and `CbsPersist_*.cab`
- **DISM log**: `C:\Windows\Logs\DISM\dism.log` (for DISM-specific operations)

## Collect logs for further investigation

If you can't resolve the issue by using the steps in this article, collect the following logs before you contact Azure support:

- **CBS logs:** Located at `C:\Windows\Logs\CBS\CBS.log` and archived `CbsPersist_*.cab` files in the same folder.
- **DISM log:** Located at `C:\Windows\Logs\DISM\dism.log`.
- **SFC log:** Run `findstr /c:"[SR]" C:\Windows\Logs\CBS\CBS.log > C:\sfcdetails.txt` to extract SFC-specific entries.

## References

- [Troubleshoot Windows Update failures on Azure VMs](troubleshoot-windows-update-azure-vm.md)
- [Troubleshoot Windows Update errors that require in-place upgrades for Azure VMs](windows-update-errors-requiring-in-place-upgrade.md)
- [Fix Windows Update corruptions and installation failures](/troubleshoot/windows-server/installing-updates-features-roles/fix-windows-update-errors)
- [Azure VM Windows Update Reset Tool](windows-vm-wureset-tool.md)
- [Azure VM Windows Update Error Detection Tool](windows-vm-ipu-tool.md)
- [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
