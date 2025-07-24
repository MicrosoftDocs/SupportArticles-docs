---
title: Troubleshoot Windows Update Errors That Require In-Place Upgrades for Azure Virtual Machines
description: Learn how to resolve Windows update errors that require in-place upgrades for Azure Virtual Machines.
ms.date: 07/24/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro, jdickson, v-liuamson, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---

# Troubleshoot Windows update error that require in-place upgrades for Azure Virtual Machines

> [!IMPORTANT]
> This article covers the Windows Server upgrade process for Azure servers and virtual machines (VMs) only. To do an upgrade of Windows Server not running in an Azure VM, see [In-place upgrade for VMs not running Windows Server in Azure](/windows-server/get-started/perform-in-place-upgrade).
> [!IMPORTANT]
> This article does not cover Windows Client scenarios at this time.

For Virtual Machines running in Azure, certain Windows Update errors will require an in-place upgrade of the OS to restore the servicing stack to a healthy condition so that updates can then be installed. While other options like WinRE are available to possibly mitigate this issue, this isn't possible unless the VM is connected to a nested virtualization environment as described in [Troubleshoot a faulty Azure VM by using nested virtualization in Azure](/troubleshoot/azure/virtual-machines/windows/troubleshoot-vm-by-use-nested-virtualization). While the document instructs you to do an in-place upgrade, you will be using the media installation of the current OS and reinstalling the OS. This article provides steps to identify those specific errors requiring this action and resolve this issue.

## Prerequisites

Ensure that you have administrative access to perform in-place upgrades.

## How to identify the errors

To identify the errors, check under the `C:\Windows\Logs\CBS` file path for  **CBS.log**, **CbsPersist_XXXXXXXXXXXXXX.log**, or the **CbsPersist_XXXXXXXXXXXXXX.cab** file for one of the following errors:

| Error Code | Symbolic Name                          | Description / Notes                                                           |
|------------|----------------------------------------|-------------------------------------------------------------------------------|
| 8007000D   | ERROR_INVALID_DATA                     | The data is invalid – often occurs with corrupted Windows Update metadata.    |
| 800705B9   | ERROR_XML_PARSE_ERROR                  | XML parsing error – can be related to servicing stack corruption.             |
| 800736B3   | ERROR_SXS_ASSEMBLY_NOT_FOUND           | Assembly not found – commonly due to component store corruption.              |
| 80073701   | ERROR_SXS_ASSEMBLY_MISSING             | A component is missing – typical for servicing/component store errors.        |
| 80073712   | ERROR_SXS_COMPONENT_STORE_CORRUPT      | Component store has been corrupted.                                           |
| 800F080D   | CBS_E_MANIFEST_INVALID_ITEM            | Invalid CBS manifest – points to component corruption.                        |
| 800F081F   | CBS_E_SOURCE_MISSING                   | Missing source files – Windows can't find files to complete the update.       |
| 800F0830   | CBS_E_IMAGE_UNSERVICEABLE              | Image unserviceable – often requires a repair or IPU.                         |
| 800F0831   | CBS_E_STORE_CORRUPTION                 | Update package corruption – particularly in the component store.              |
| 800F0900   | CBS_E_XML_PARSER_FAILURE               | Generic XML parsing failure – may indicate serious servicing issues.          |
| 800F0904   | CBS_E_MORE_THAN_ONE_ACTIVE_EDITION     | Invalid configuration in update metadata.                                     |
| 800F0982   | PSFX_E_MATCHING_COMPONENT_NOT_FOUND    | Often appears with cumulative update failures.                                |
| 800F0984   | PSFX_E_MATCHING_BINARY_MISSING         | Matching component directory exists but binary is missing.                    |
| 800F0985   | PSFX_E_APPLY_REVERSE_DELTA_FAILED      | May relate to missing manifests or payloads.                                  |
| 800F0986   | PSFX_E_APPLY_FORWARD_DELTA_FAILED      | Often requires servicing stack repair or IPU.                                 |
| 800F0987   | PSFX_E_NULL_DELTA_HYDRATION_FAILED     | Package corruption or integration failure.                                    |
| 800F0988   | PSFX_E_INVALID_DELTA_COMBINATION       | May be tied to specific update branch or delta patch issues.                  |
| 800F0989   | PSFX_E_REVERSE_DELTA_MISSING           | Seen during cumulative update failures – IPU may be the only resolution.      |
| 800F0922   | CBS_E_INSTALLERS_FAILED                | Processing advanced installers and generic commands failed.                   |
| 800F0805   | CBS_E_INVALID_PACKAGE                  | Package is invalid – commonly a download or metadata corruption issue.        |
| 800F0991   | PSFX_E_MISSING_PAYLOAD_FILE            | Associated with update sequencing or dependency errors.                       |
| 800F0905   | CBS_E_NO_ACTIVE_EDITION                | E_DO_INHERITANCE_CONTEXT_NEEDE |
| 8007371B   | ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE | Servicing operation incomplete or aborted.                                  |
| 80242016   | WU_E_UH_POSTREBOOTUNEXPECTEDSTATE      | The state of the update after its post-reboot operation has completed is unexpected. |
| 800F0911  | CBS_E_SOURCE_MODIFIED                   | The package sources have been modified/moved in a previous session and will need to be re-downloaded.   |
| 80071AB1  | ERROR_LOG_GROWTH_FAILED                 | An attempt to create space in the transactional resource manager's log failed.          |

```output
Example of error 0x80073712 - ERROR_SXS_COMPONENT_STORE_CORRUPT

2025-02-27 08:58:35, Error                 CSI    0000000a@2025/2/27:11:58:35.891 (F) Attempting to mark store corrupt with category [l:21 ml:22]'CorruptComponentValue'[gle=0x80004005]
2025-02-27 08:58:35, Error                 CSI    0000000b (F) STATUS_SXS_COMPONENT_STORE_CORRUPT #62038# from CCSDirectTransaction::OperateEnding at index 0 of 1 operations, disposition 0[gle=0xd015001a]
2025-02-27 08:58:35, Error                 CSI    0000000c (F) HRESULT_FROM_WIN32(14098) #61875# from Windows::ServicingAPI::CCSITransaction::ICSITransaction2_AddComponents(Flags = 1, a = @0x29dd79f20d0, mp = @0x29dd79f28d0, disp = 0)[gle=0x80073712]
2025-02-27 08:58:35, Info                  CBS    Failed to add one or more deployment [HRESULT = 0x80073712 - ERROR_SXS_COMPONENT_STORE_CORRUPT]
2025-02-27 08:58:35, Info                  CBS    Failed to bulk stage deployment manifest and pin deployment for package:Wrapper-DDDA51604A99B1668F4E7D804F8F81E7558D0FEB4EA0DE087D6BF2DE607411F0~31bf3856ad364e35~amd64~~10.0.20348.3081 [HRESULT = 0x80073712 - ERROR_SXS_COMPONENT_STORE_CORRUPT]
2025-02-27 08:58:35, Info                  CBS    CommitPackagesState: Started persisting state of packages
2025-02-27 08:58:35, Info                  CBS    CommitPackagesState: Completed persisting state of packages
2025-02-27 08:58:35, Info                  CSI    0000000d@2025/2/27:11:58:35.891 CSI Transaction @0x29dd717d150 destroyed
2025-02-27 08:58:35, Info                  CBS    Perf: Resolve chain complete.
2025-02-27 08:58:35, Info                  CBS    Failed to resolve execution chain. [HRESULT = 0x80073712 - ERROR_SXS_COMPONENT_STORE_CORRUPT]
2025-02-27 08:58:35, Error                 CBS    Failed to process single phase execution. [HRESULT = 0x80073712 - ERROR_SXS_COMPONENT_STORE_CORRUPT]
2025-02-27 08:58:35, Info                  CBS    WER: Generating failure report for package: Package_for_ServicingStack_3081~31bf3856ad364e35~amd64~~20348.3081.1.1, status: 0x80073712, failure source: Resolve, start state: Installed, target state: Installed, client id: WindowsUpdateAgent
2025-02-27 08:58:35, Info                  CBS    Not able to query DisableWerReporting flag.  Assuming not set... [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]
```

### Root Cause

Your Azure virtual machine (VM) is experiencing internal corruption in the Windows servicing stack. This stack is responsible for managing updates and system components. When it becomes damaged due to missing files, invalid configurations, or corrupted metadata, Windows can no longer apply updates or service the OS properly.

## Resolution for Azure VMs

To resolve this issue, Microsoft recommends performing an **in-place upgrade** of the Windows Server OS within the Azure VM. This process reinstalls the OS while preserving your data, apps, and settings.

### Instructions for how to troubleshoot

1. **Review the prerequisites**
   1. Ensure you have **Administrative Access** to the VM.
   1. Confirm the VM is running in Azure.

2. **Back up your VM**
   1. Use **Azure Backup** or take a **snapshot** to ensure you can restore the VM if needed.

3. **Check for Errors**
   1. Review the following logs for known error codes:
        1. `CBS.log`
        1. `CbsPersist_*.log`
        1. `CbsPersist_*.cab`

4. **Perform an OS upgrade**
    1. Follow the [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade) guidance.

5. **Run the Upgrade**
    1. From the elevated command prompt, change to **drive with ISO**.
    1. Type setup.exe /auto upgrade /dynamicupdate disable without quotes
    Choose **Keep personal files and apps** when prompted.
    Follow the on-screen instructions to complete the upgrade.

6. **Post-Upgrade Checks**
   1. Verify system functionality.
   1. Reapply any custom configurations or policies if needed.
   1. Re-enable services like **Azure Backup** or **monitoring agents** if they were paused.

## References

1. [In-place upgrade for VMs not running Windows Server in Azure](/windows-server/get-started/perform-in-place-upgrade)
1. [Troubleshoot a faulty Azure VM by using nested virtualization in Azure](/troubleshoot/azure/virtual-machines/windows/troubleshoot-vm-by-use-nested-virtualization)
1. [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
