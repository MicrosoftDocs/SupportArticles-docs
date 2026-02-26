---
title: Error 0x8007000d at Startup After You Install a Windows Update
description: Discusses how to fix the 0x8007000d (ERROR_INVALID_DATA) error when the system restarts after you install Windows updates.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ai.usage: ai-assisted
ms.topic: troubleshooting
ms.reviewer: kaushika, hamansoor, jdickson, v-lianna, dougking, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Azure Virtual Machines</a>
---
# Error 0x8007000d at startup after you install a Windows update

This article helps you resolve an issue that occurs when the computer restarts after you install a Windows update.

## Symptoms

You install a Windows update. The update appears to install successfully. However, when the computer restarts, the installation rolls back, and you receive a "0x8007000d (ERROR_INVALID_DATA)" error message.

## Cause

Typically, this issue has one of the following causes:

- **File corruption or registry corruption** - An old update is reported, and the related file or registry key locations are corrupted. This corruption can prevent the system from verifying the validity of catalog files.

- **Incorrect driver version** - Driver updates fail because of incorrect versioning. This issue causes the Windows update to fail during a restart.

## Resolution

> [!IMPORTANT]  
>
> - If the affected computer is a Windows virtual machine (VM) that can't restart correctly or that you can't access by using SSH, make sure that you can use the Azure Serial Console to access the VM.
> - Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

The most reliable way to fix this issue is to perform an in-place upgrade on the affected computer.

> [!NOTE]  
> For more information about how to upgrade VMs, see one of the following articles:
>
> - [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
> - [In-place upgrade for supported VMs running Windows in Azure (Windows client)](../../azure/virtual-machines/windows/in-place-system-upgrade.md)

If the issue persists, contact Microsoft Support. In the support request, include data from the CBS log that helps describe the issue. For information about how to identify this information, see the next section.

## More information

Entries in the Component-Based Servicing (CBS) log file might provide more details about how the error actually occurred. This log is typically located at C:\Windows\Logs\CBS. To track down the issue, open the log file in a text editor, and search for `ERROR_INVALID_DATA`. To identify the context in which the error occurred, review the log entries that precede and follow the error.

The following sections show examples of log entries that document this error.

### Case 1: Catalog file errors

In this example, `ERROR_INVALID_DATA` occurs when the system tries to validate C:/WINDOWS/Servicing/Packages/Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat.

```output
20xx-xx-06 xx:51:15, Info CBS Exec: Installing Package: Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0, Update: 4584642-1_neutral, InstallDeployment: amd64_771d1f434ef835536dafe93d6811f766_31bf3856ad364e35_10.0.17763.1549_none_e4d395cdb7886270
20xx-xx-06 xx:51:15, Error CSI 00000034@20xx/xx/5:23:51:15.422 (F) onecore\base\wcp\rtllib\win32lib\catalog.cpp(633): Error NTSTATUS_FROM_WIN32(ERROR_INVALID_DATA) originated in function CCatalog::Create expression: CertCreateCTLContext
[gle=0x80004005]
20xx-xx-06 xx:51:15, Error CSI 00000035 (F) NTSTATUS_FROM_WIN32(ERROR_INVALID_DATA) #6317935# from CCSDirectTransaction::OperateEnding at index 0 of 1 operations, disposition 0[gle=0xd007000d]
20xx-xx-06 xx:51:15, Error CSI 00000036 (F) HRESULT_FROM_WIN32(ERROR_INVALID_DATA) #6317715# from Windows::COM::CComponentStore::InternalTransact(...)[gle=0x8007000d]
20xx-xx-06 xx:51:15, Error CSI 00000037 (F) HRESULT_FROM_WIN32(ERROR_INVALID_DATA) #6317714# from Windows::ServicingAPI::CCSITransaction::AddCatalog(Flags = 1, CatalogPath = '[file://%3f/C:/WINDOWS/Servicing/Packages/Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat')%5bgle=0x8007000d]\\?\C:\WINDOWS\Servicing\Packages\Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat')[gle=0x8007000d]
20xx-xx-06 xx:51:15, Error CSI 00000038 (F) HRESULT_FROM_WIN32(ERROR_INVALID_DATA) #6317713# from Windows::ServicingAPI::CCSITransaction::ICSITransaction_InstallDeployment(Flags = 0, a = 771d1f434ef835536dafe93d6811f766, version 10.0.17763.1549, arch amd64, nonSxS, pkt {l:8 b:31bf3856ad364e35}, cb = (null), s = (null), rid = 'Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.4584642-1_neutral', rah = (null), manpath = (null), catpath = '[file://%3f/C:/WINDOWS/Servicing/Packages/Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat%5bgle=0x8007000d]\\?\C:\WINDOWS\Servicing\Packages\Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat[gle=0x8007000d]
20xx-xx-06 xx:51:15, Error CSI ', disp = 0)[gle=0x8007000d]
20xx-xx-06 xx:51:15, Error CBS Failed to verify if catalog file [C:/WINDOWS/Servicing/Packages/Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat]\\?\C:\WINDOWS\Servicing\Packages\Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat is valid. [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-06 xx:51:15, Info CBS Failed to verify manifest against catalog, mark store as corrupt. [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-06 xx:51:15, Info CBS Failed to begin deployment installation for Update: 4584642-1_neutral [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
```

The system can't validate the .cat (catalog) file. This indicates that the package is probably corrupted.

### Case 2: Registry errors

In this example, `ERROR_INVALID_DATA` occurs when the system determines that a registry value uses the wrong data type.

```output
20xx-xx-24 05:13:10, Info CBS Registry value for Package_7762_for_KB5001347~31bf3856ad364e35~amd64~~10.0.1.4 is not a dword type. [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate values in store object. [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate all component versions for component detect: amd64_windows-application..egistrationverifier_31bf3856ad364e35_0.0.0.0_none_06e8f842c597e59b [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate store versions on component: amd64_windows-application..egistrationverifier_31bf3856ad364e35_10.0.14393.4169_none_fcb27d831f9fb942 [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate related component versions on component: amd64_windows-application..egistrationverifier_31bf3856ad364e35_10.0.14393.4169_none_fcb27d831f9fb942 [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to load current component state [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to find or add the component family [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
```

### Case 3: Driver installation failure

In this example, `ERROR_INVALID_DATA` occurs when the system tries to install drivers during the restart process.

```output
20xx-xx-18 15:21:14, Info CBS Perf: Doqe: Critical install started.
20xx-xx-18 15:21:14, Info CBS Doqe: [Forward] Installing driver updates, Count 2
20xx-xx-18 15:21:14, Info CBS INSTALL index: 53, phase: 1, result 0, inf: machine.inf
20xx-xx-18 15:21:14, Info CBS INSTALL index: 194, phase: 1, result 0, inf: mshdc.inf
20xx-xx-18 15:21:14, Info CBS INSTALL index: 246, phase: 2, result 0, inf: machine.inf
20xx-xx-18 15:21:14, Info CBS INSTALL index: 194, phase: 2, result 13, inf: mshdc.inf
20xx-xx-18 15:21:14, Info CBS Doqe: Recording result: 0x8007000d, for Inf: mshdc.inf
20xx-xx-18 15:21:14, Info CBS DriverUpdateInstallUpdates failed [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-18 15:21:14, Info CBS Doqe: Failed installing driver updates [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-18 15:21:14, Info CBS Perf: Doqe: Critical install ended.
20xx-xx-18 15:21:14, Info CBS Failed installing driver updates [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-18 15:21:14, Error CBS Startup: Failed executing critical driver operations queue [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-18 15:21:14, Info CBS Startup: Rolling back KTM, because drivers failed.
20xx-xx-18 15:22:46, Info CBS Retrieved original failure status: 0x8007000d, last forward execute state: CbsExecuteStatePrimitives
20xx-xx-18 15:22:52, Info CBS WER: Generating failure report for package: Package_for_RollupFix~31bf3856ad364e35~amd64~~14393.4889.1.2, status: 0x8007000d, failure source: DOQ, start state: Staged, target state: Installed, client id: WindowsUpdateAgent
```

The mshdc.inf driver doesn't install correctly. This issue triggers the rollback process.

The SetupAPI log (typically in C:\Windows\INF\setupapapi.dev) also records driver installations. In this example, the following excerpt from Setupapapi.dev.log provides additional information about Mshdc.inf, including the names and versions of the driver packages.

```output
sto: {Unstage Driver Package: C:\Windows\System32\DriverStore\FileRepository\mshdc.inf_amd64_b0b5572axx95167b\mshdc.inf} 15:21:14.3xx
sto: {DRIVERSTORE DELETE BEGIN} 15:21:14.3xx
sto: {DRIVERSTORE DELETE BEGIN: exit(0x00000000)} 15:21:14.3xx
idb: {Unregister Driver Package: C:\Windows\System32\DriverStore\FileRepository\mshdc.inf_amd64_b0b5572axx95167b\mshdc.inf} 15:21:14.3xx
idb: Unregistered driver package 'mshdc.inf_amd64_b0b5572axx95167b' from 'mshdc.inf'.
idb: Deleted driver package object 'mshdc.inf_amd64_b0b5572axx95167b' from SYSTEM database node.
idb: Driver packages registered to 'mshdc.inf':
idb: mshdc.inf_amd64_79f38c21b894a1c1
idb: {Unregister Driver Package: exit(0x00000000)} 15:21:14.3xx
```
