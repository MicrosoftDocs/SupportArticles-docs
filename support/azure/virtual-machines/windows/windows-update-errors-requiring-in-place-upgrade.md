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

# Troubleshoot Windows upgrade errors that require in-place upgrades for Azure VMs

> [!IMPORTANT]
> This article covers the Windows Server upgrade process for Microsoft Azure servers and virtual machines (VMs) only. To upgrade an instance of Windows Server that isn't running on an Azure VM, see [In-place upgrade for VMs not running Windows Server in Azure](/windows-server/get-started/perform-in-place-upgrade).
> [!IMPORTANT]
> This article doesn't cover Windows Client scenarios.

For Virtual Machines (VMs) that are running on Azure, certain Windows Update errors require an in-place upgrade of the OS to restore the servicing stack to a healthy condition in which updates can be installed. Other options, such as WinRE, are available to possibly mitigate this issue. However, such processes aren't possible unless the VM is connected to a nested virtualization environment, as described in [Troubleshoot a faulty Azure VM by using nested virtualization in Azure](/troubleshoot/azure/virtual-machines/windows/troubleshoot-vm-by-use-nested-virtualization). Although you'll do an in-place upgrade, you'll use the installation media of the current OS to reinstall the system. This article provides the steps to identify the specific upgrade errors that require this action.

## Prerequisites

Make sure that you have administrative access to perform in-place upgrades.

## How to identify the errors

To identify upgrade errors, check the `C:\Windows\Logs\CBS` file path for **CBS.log**, **CbsPersist_XXXXXXXXXXXXXX.log**, or the **CbsPersist_XXXXXXXXXXXXXX.cab** file for one of the following error entries.

| Error code | Symbolic name                          | Description / Notes                                                           |
|------------|----------------------------------------|-------------------------------------------------------------------------------|
| 8007000D   | ERROR_INVALID_DATA                     | The data is invalid. Typically caused by corrupted Windows Update metadata.   |
| 800705B9   | ERROR_XML_PARSE_ERROR                  | XML parsing error. Can be related to servicing stack corruption.              |
| 800736B3   | ERROR_SXS_ASSEMBLY_NOT_FOUND           | Assembly not found. Commonly caused by component store corruption.            |
| 80073701   | ERROR_SXS_ASSEMBLY_MISSING             | A component is missing. Typical for servicing or component store errors.      |
| 80073712   | ERROR_SXS_COMPONENT_STORE_CORRUPT      | Component store is corrupted.                                                 |
| 800F080D   | CBS_E_MANIFEST_INVALID_ITEM            | Invalid CBS manifest. Points to component corruption.                         |
| 800F081F   | CBS_E_SOURCE_MISSING                   | Missing source files. Windows can't find the files to complete the update.    |
| 800F0830   | CBS_E_IMAGE_UNSERVICEABLE              | Image unserviceable. Often requires a repair or IPU.                          |
| 800F0831   | CBS_E_STORE_CORRUPTION                 | Update package corruption (particularly in the component store).              |
| 800F0900   | CBS_E_XML_PARSER_FAILURE               | Generic XML parsing failure. Might indicate serious servicing issues.         |
| 800F0904   | CBS_E_MORE_THAN_ONE_ACTIVE_EDITION     | Invalid configuration in update metadata.                                     |
| 800F0982   | PSFX_E_MATCHING_COMPONENT_NOT_FOUND    | Often associated with cumulative update failures.                             |
| 800F0984   | PSFX_E_MATCHING_BINARY_MISSING         | Matching component directory exists but binary is missing.                    |
| 800F0985   | PSFX_E_APPLY_REVERSE_DELTA_FAILED      | Possibly related to missing manifests or payloads.                            |
| 800F0986   | PSFX_E_APPLY_FORWARD_DELTA_FAILED      | Often requires servicing stack repair or IPU.                                 |
| 800F0987   | PSFX_E_NULL_DELTA_HYDRATION_FAILED     | Package corruption or integration failure.                                    |
| 800F0988   | PSFX_E_INVALID_DELTA_COMBINATION       | Possibly related to specific update branch or delta patch issues.             |
| 800F0989   | PSFX_E_REVERSE_DELTA_MISSING           | Seen during cumulative update failures. IPU might be the only resolution.     |
| 800F0922   | CBS_E_INSTALLERS_FAILED                | Processing advanced installers and generic commands failed.                   |
| 800F0805   | CBS_E_INVALID_PACKAGE                  | Package is invalid. Typically a download or metadata corruption issue.        |
| 800F0991   | PSFX_E_MISSING_PAYLOAD_FILE            | Associated with update sequencing or dependency errors.                       |
| 800F0905   | CBS_E_NO_ACTIVE_EDITION                | E_DO_INHERITANCE_CONTEXT_NEEDE                                                |
| 8007371B   | ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE | Servicing operation is incomplete or aborted.                               |
| 80242016   | WU_E_UH_POSTREBOOTUNEXPECTEDSTATE      | The state of the update after its post-reboot operation was completed is unexpected. |
| 800F0911  | CBS_E_SOURCE_MODIFIED                   | The package sources were modified or moved in a previous session and must be redownloaded. |
| 80071AB1  | ERROR_LOG_GROWTH_FAILED                 | An attempt to create space in the transactional resource manager's log failed. |

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

### Cause

The Azure VM is experiencing internal corruption in the Windows servicing stack. This stack is responsible for managing updates and system components. When it becomes damaged because of missing files, an invalid configuration, or corrupted metadata, Windows can no longer apply updates or service the OS correctly.

## Resolution for Azure VMs

To resolve this issue, we recommend that you perform an in-place upgrade of Windows Server within the Azure VM. This process reinstalls the OS while preserving your data, apps, and settings.

### Instructions for troubleshooting

1. Review the prerequisites:
   1. Make sure that you have administrative access to the VM.
   1. Verify that the VM is running on Azure.

2. Back up the VM. Use Azure Backup or take a snapshot to make sure that you can restore the VM, if it's necessary.

3. Review the following logs for known error codes:
   - `CBS.log`
   - `CbsPersist_*.log`
   - `CbsPersist_*.cab`

4. Follow the guidance in [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade).

5. Run the upgrade:
    1. At an elevated command prompt, change to **drive with ISO**.
    1. Enter setup.exe /auto upgrade /dynamicupdate disable.
    1. When you're prompted, select **Keep personal files and apps**.
    1. To complete the upgrade, follow the on-screen instructions.

6. Post-upgrade checks
   1. Verify system functionality.
   1. Reapply any custom configurations or policies as necessary.
   1. Re-enable any services, such as **Azure Backup** or **monitoring agents**, if they were paused.

## References

1. [In-place upgrade for VMs not running Windows Server in Azure](/windows-server/get-started/perform-in-place-upgrade)
1. [Troubleshoot a faulty Azure VM by using nested virtualization in Azure](/troubleshoot/azure/virtual-machines/windows/troubleshoot-vm-by-use-nested-virtualization)
1. [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
