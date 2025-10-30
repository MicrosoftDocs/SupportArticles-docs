---
title: ERROR_INVALID_DATA Error After Installing Windows Updates
description: Helps resolve the 0x8007000d (ERROR_INVALID_DATA) error at system startup after you install Windows updates.
ms.date: 05/23/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, hamansoor, jdickson, v-lianna, dougking
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Azure Virtual Machines</a>
---
# Error 0x8007000d at startup after installing updates

This article helps you resolve an issue that occurs at system startup after you install Windows updates. After you install the updates and restart the system, the system performs a rollback, and you receive a "0x8007000d (ERROR_INVALID_DATA)" error message.

> [!IMPORTANT]
> This article covers the Windows Server upgrade process for non-Azure servers and virtual machines (VMs) only. To do an upgrade of Windows Server running in an Azure VM, see [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade).

## Symptoms

When this issue occurs, you might experience any of the following symptoms.

### Symptom 1: Catalog file errors

Entries in the Component-Based Servicing (CBS) log file indicate issues that affect a catalog file. This log is typically located at *C:\Windows\Logs\CBS*. You see a log entry that resembles the following output:

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
In this situation, the error occurs because the system can't determine whether the following catalog file is valid:

    C:/WINDOWS/Servicing/Packages/Package_1_for_KB4584642~31bf3856ad364e35~amd64~~10.0.1.0.cat

This symptom indicates that the package is likely corrupted. 

### Symptom 2: Registry errors

In the CBS log file, you see the following entry or something similar that indicates registry issues:

```output
20xx-xx-24 05:13:10, Info CBS Registry value for Package_7762_for_KB5001347~31bf3856ad364e35~amd64~~10.0.1.4 is not a dword type. [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate values in store object. [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate all component versions for component detect: amd64_windows-application..egistrationverifier_31bf3856ad364e35_0.0.0.0_none_06e8f842c597e59b [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate store versions on component: amd64_windows-application..egistrationverifier_31bf3856ad364e35_10.0.14393.4169_none_fcb27d831f9fb942 [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to enumerate related component versions on component: amd64_windows-application..egistrationverifier_31bf3856ad364e35_10.0.14393.4169_none_fcb27d831f9fb942 [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to load current component state [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
20xx-xx-24 05:13:10, Info CBS Failed to find or add the component family [HRESULT = 0x8007000d - ERROR_INVALID_DATA]
```

### Symptom 3: Driver update failure

In the CBS log file, you see the following entry or something similar that indicates driver update failures during restart:

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

This entry shows that the driver updates failed. This issue caused the Windows update to also fail.

To verify that this condition is true, go to *C:\Windows\INF\setupapapi.dev*, locate the log, and examine the entries for the driver failure. In this case, it's mshdc.inf.

**setupapapi.dev.log**

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

Make sure that you note the driver packages.

## Cause

This issue occurs either because the database of performance counters is corrupted or the driver version is incorrect. 

### File corruption or registry corruption

An old update might be reported, and the related file or registry key locations might be corrupted. This corruption can prevent the system from verifying the validity of catalog files.

### Incorrect driver version

Driver updates might fail because of incorrect versioning. This issue causes the Windows update to fail during a restart.

## Resolution

> [!NOTE]
> Before you proceed, [back up the OS disk](/azure/backup/about-azure-vm-restore).

The most reliable solution for this problem is to perform an [in-place upgrade (IPU) on the Windows virtual machine (VM)](/azure/virtual-machines/windows-in-place-upgrade).
