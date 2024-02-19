---
title: Use Driver Verifier to identify issues
description: This article introduces how to use Driver Verifier to identify issues.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Using Driver Verifier to identify issues with Windows drivers for advanced users

The Driver Verifier tool is included in every version of Windows since Windows 2000. It's used to detect and troubleshoot many driver issues that are known to cause system corruption, failures, or other unpredictable behavior. This article describes how to use Driver Verifier to isolate and troubleshoot a driver in the system.

_Applies to:_ &nbsp; Windows Server 2012 Foundation, Windows Server 2012 Essentials, Windows Server 2012 Standard, Windows Server 2012 Datacenter  
_Original KB number:_ &nbsp; 244617

## Driver Verifier capabilities

To use Driver Verifier, run Verifier.exe, and then restart your computer. You don't have to make any other changes to begin analyzing drivers in the system. Your user account requires Administrator privileges to run Verifier.exe.

Driver Verifier can check many different aspects of a driver's behavior. These capabilities are grouped into options or settings that are enabled by the use of flags. (The terms options, settings, and flags are typically interchangeable in Driver Verifier documentation. They represent similar concepts.)

For detailed information about each flag, see [Driver Verifier options and rule classes](/windows-hardware/drivers/devtest/driver-verifier-options).

## Standard Options

The following options together represent the rules that all drivers in the system shouldn't violate. These options are enabled when you choose to enable standard settings in the Driver Verifier GUI or you specify the `/standard` switch when you configure Driver Verifier by using the command line.

### Automatic Checks

These checks are always done on a driver that's being verified, no matter what options have been selected.

Examples of Automatic Checks:

- IRQL Checks
  - A raised IRQL (meaning that the current IRQL is less than the target IRQL).
  - A lowered IRQL (meaning that the current IRQL is more than the target IRQL).
- SpinLocks:
  - Double release of a spin lock.
  - Spin lock acquisitions/releases are made at the appropriate IRQL.
- Memory Allocations:
  - Paged pool allocations/frees are made at the correct IRQL (APC_LEVEL or below).
  - Non-paged pool allocations/frees are made at the correct IRQL (DISPATCH_LEVEL or below).
  - No random (uninitialized) values are specified to these application programming interfaces (APIs).
  - Freed allocations aren't pointing to active timer objects.
- Driver unload checking:
  - Verifies that the driver doesn't have pending operations while unloading, such as pending DPCs or worker threads.
- Other Driver behaviors:
  - Improperly switching thread stacks.
  - Trying to call KeWaitXxx at IRQL >= DISPATCH_LEVEL.
  - Dereferencing an object that already has a reference count of 0.

### Special Pool

When this option is active, Driver Verifier allocates most of the driver's memory requests from a special pool. This special pool is monitored for memory overruns, memory underruns, and memory that's accessed after it's freed.

### Force IRQL Checking

When this option is active, Driver Verifier places extreme memory pressure on the driver by invalidating pageable code. If the driver attempts to access paged memory at the wrong IRQL or while holding a spin lock, Driver Verifier detects this behavior.

### Pool Tracking

When this option is active, Driver Verifier checks to see if the driver has freed all its memory allocations when it's unloaded. It reveals memory leaks.

### I/O Verification

When this option is active, Driver Verifier allocates the driver's IRPs from a special pool, and monitors the driver's I/O handling. It detects illegal or inconsistent use of I/O routines.

When I/O Verifier is enabled:

- All IRPs allocated through IoAllocateIrp are allocated from special pool, if available.
- Checks are made in IoCallDriver, IoCompleteRequest, and IoFreeIrp to catch driver error messages.
- All I/O Verifier failures bug check with the code DRIVER_VERIFIER_IOMANAGER_VIOLATION (0xC9).

> [!NOTE]
> In Windows 7 and later versions of the Windows operating system, all the features of Enhanced I/O Verification are included as part of I/O Verification and it is no longer available nor necessary to select the Enhanced I/O Verification option in Driver Verifier Manager or from the command line.

### Deadlock Detection

When this option is active, Driver Verifier monitors the driver's use of spin locks, mutexes, and fast mutexes. It detects if the driver's code has the potential for causing a deadlock at some point.

### Enhanced I/O Verification

When this option is active, Driver Verifier monitors the calls of several I/O Manager routines and performs stress testing of PnP IRPs, power IRPs and WMI IRPs.

> [!NOTE]
> In Windows 7 and later versions, all the features of Enhanced I/O Verification are included as part of I/O Verification. This option is no longer available or required in Driver Verifier Manager or from a command line.

### DMA Verification

When this option is active, Driver Verifier monitors the driver's use of DMA routines. It detects improper use of DMA buffers, adapters, and map registers.

### Security Checks

When this option is active, Driver Verifier looks for common errors that can result in security vulnerabilities, such as a reference to user-mode addresses by kernel-mode routines.

### Miscellaneous Checks

When this option is active, Driver Verifier looks for common causes of driver crashes, such as the mishandling of freed memory.

### DDI compliance checking

When this option is active, Driver Verifier applies a set of device driver interface (DDI) rules that check for the proper interaction between a driver and the kernel interface of the operating system.

The DDI compliance checking option is implemented by using a Kernel-mode library, called VerifierExt.sys. If a violation of one of the DDI Compliance Checking rules is found, VerifierExt.sys will be the module that called for the system bug check to occur.

### Additional options

These options are designed for specific scenario testing, or are options that will inject failures or delays into certain DDI routines to simulate extreme stress conditions.

## Driver Verifier requirements

The only requirement is that you must install Windows Server 2012. You can enable Driver Verifier on both retail and checked versions of Windows. If Norton Antivirus is installed, don't enable Driver Verifier's Deadlock Detection.

## Enable Driver Verifier

You can enable Driver Verifier by using Verifier.exe. Verifier.exe is included with every copy of Windows. It's automatically installed into the System32 folder. Verifier.exe has both command-line and graphical user interface (GUI) interfaces, so you can specify drivers and appropriate levels of verification. You can also see Driver Verifier statistics in real time. For more information, see the [Driver Verifier Manager (Verifier.exe)](#driver-verifier-manager-verifierexe) section.

## Debug Driver Verifier violations

Should Driver Verifier detect a violation, the standard behavior is to bug check the system as to provide the most information possible about debugging the issue. A system connected to a debugger will stop once a bug check has occurred.

All Driver Verifier violations result in bug checks, the most common ones (although not necessarily all of them) are:

- 0xC1: SPECIAL_POOL_DETECTED_MEMORY_CORRUPTION
- 0xC4: DRIVER_VERIFIER_DETECTED_VIOLATION
- 0xC6: DRIVER_CAUGHT_MODIFYING_FREED_POOL
- 0xC9: DRIVER_VERIFIER_IOMANAGER_VIOLATION
- 0xD6: DRIVER_PAGE_FAULT_BEYOND_END_OF_ALLOCATION
- 0xE6: DRIVER_VERIFIER_DMA_VIOLATION

`!analyze -v` is the best command to use when starting a new debug session. This command will return useful information and attempt to pinpoint the faulting driver.

Debugger extensions that are specific to Driver Verifier:

- `!verifier` will dump captured Driver Verifier statistics. `!verifier -?` will show all of the available options.
- `!deadlock` dumps information related to locks or objects tracked by the Deadlock detection. `!deadlock -?` will show all of the available options.
- `!iovirp [address]` will dump information related to an IRP tracked by I/O Verifier.
- `!ruleinfo [RuleID]` will dump information related to the DDI Compliance Checking rule that was violated (RuleID is always the first argument to the bug check, all DDI Compliance Checking rule IDs are in the form 0x200nn).

## Driver Verifier and graphics drivers

Windows kernel-mode graphics drivers, such as printer and display driver DLLs, are restricted from calling the pool entry point directly. Pool allocations are performed indirectly using graphics device driver interface (DDI) callbacks to Win32k.sys. For example, EngAllocMem is the callback that a graphics driver calls to explicitly allocate pool memory. Other specialized callbacks, such as EngCreatePalette and EngCreateBitmap, also return pool memory.

To provide the same automated testing for the graphics drivers, support for some of the Driver Verifier functions is incorporated into Win32k.sys. Because graphics drivers are more restricted than other kernel-mode drivers, they require only a subset of the Driver Verifier functionality. Specifically, IRQL checking and I/O verification aren't needed. The other functionality, namely using special pool, random failure of pool allocations, and pool tracking, are supported to varying degrees in the different graphics DDI callbacks.

Random failures are supported for the following graphics DDI callback functions:

- EngAllocMem
- EngAllocUserMem
- EngCreateBitmap
- EngCreateDeviceSurface
- EngCreateDeviceBitmap
- EngCreatePalette
- EngCreateClip
- EngCreatePath
- EngCreateWnd
- EngCreateDriverObj
- BRUSHOBJ_pvAllocRbrush
- CLIPOBJ_ppoGetPath

Also, the use of special pool and pool tracking is supported for EngAllocMem.

Enabling Driver Verifier for the graphics drivers is identical to the other drivers. For more information, see the [Enable Driver Verifier](#enable-driver-verifier) section. Unsupported flags such as IRQL checking are ignored. In addition, you can use the `!gdikdx.verifier` kernel-debugger command to examine current Driver Verifier state and pool traces for graphics drivers.

> [!NOTE]
> You should only use the random allocation failure setting for robustness testing. Use of this setting may cause rendering error messages, so you should not use this setting with verification tests to check the correctness of the graphics driver's implementation (for example, by comparing the graphics driver output to a reference image).

## Driver Verifier Manager (Verifier.exe)

The Driver Verifier Manager tool (Verifier.exe) is the preferred way to create and modify Driver Verifier settings and to gather statistics from Driver Verifier. Verifier.exe is located in the %WinDir%\System32 folder for every Windows installation.

Driver Verifier Manager is the GUI included with Windows to configure Driver Verifier. Start the Driver Verifier Manager by using verifier.exe without any other command-line switches. Whenever switches are included, the command-line based version of the utility is used.

For help with configuring Driver Verifier, run `verifier.exe /?` from an Administrator CMD window.

### Driver status

The Driver Status property page gives you an image of the current status of Driver Verifier. You can see what drivers the verifier detects. The status can be one of the following values:

- Loaded: The driver is currently loaded and verified.
- Unloaded: The driver isn't currently loaded, but it was loaded at least once since you restarted the computer.
- Never Loaded: The driver was never loaded. This status can indicate that the driver's image file is corrupted or that you specified a driver name that is missing from the system.

Select the list header to sort the list by driver names or status. In the upper-right area of the dialog box, you can view the current types of the verification that are in effect. The status of the drivers is updated automatically if you don't switch to manual refresh mode. You can modify the refresh rate using the radio buttons in the lower-left area of the dialog box. To force an update of the status, select **Update Now**.

If you enable the Special Pool flag, and less than 95 percent of the pool allocations went to the special pool, a warning message is displayed on this page. It means that you need to select a smaller set of drivers to verify, or add more physical memory to the computer to obtain better coverage of the pool allocations verification.

## Global Counters

This property page shows the current value of some counters maintained by Driver Verifier. A zero value for a counter can indicate that the associated Driver Verifier flag isn't enabled. For example, a value of **0** for the Other/Faults counter indicates that the low resource simulation flag isn't enabled. You can monitor the activity of the verifier because the values of the counters are updated automatically by default. You can change the refresh rate, switch to manual refresh, or force a refresh using the group of controls in the lower-left area of the dialog box.

## Pool Tracking

This property page shows more statistics gathered from Driver Verifier. All of the counters shown on this page are related to the Pool Tracking flag of the verifier. Most of them are per-driver counters, such as current allocations, current allocated bytes, and so on. You must select a driver name from the top combination box to view the counters for that specific driver.

## Settings

You can use this page to create and modify Driver Verifier settings. The settings are saved in the registry and you must restart the computer for the settings to take effect. You can use the list to view the currently installed drivers. Each driver can be in one of the following states:

- Verify Enabled: The driver is currently verified.
- Verify Disabled: The driver isn't currently verified.
- Verify Enabled (Reboot Needed): The driver is verified only after the next restart.
- Verify Disabled (Reboot Needed): The driver is currently verified but isn't verified after the next restart.

You can select one or several drivers from the list and switch the status using the two buttons under the list. You can also right-click a driver name to display the context menu, which lets you perform state toggling.

In the bottom of the dialog box, you can specify more drivers (separated by spaces) that you want verified after the next restart. You typically use this edit control when you want to install a new driver that is not already loaded.

If the radio button group on the top of the list is set to **Verify all drivers**, the list and the Verify and Don't Verify buttons and the edit control are unavailable. It means that after the next restart, all the drivers in the system are verified.

You can set the verification type using the check boxes in the upper-right area of the dialog box. You can enable I/O Verification at level 1 or at level 2. Level 2 verification is stronger than level 1.

Save any modification to the settings by selecting **Apply**. There are two more buttons in this page:

- Preferred Settings: It selects some commonly used settings (with all drivers verified).
- Reset All: It clears all the Driver Verifier settings so that no drivers are verified.

After you select **Apply**, you must restart the computer for the changes to take effect.

## Volatile settings

You can use this property page to change the Driver Verifier flags immediately. You can only toggle the state of some of the Driver Verifier flags. And you can't change the list of the drivers that are being verified. After you change the status of some check boxes, select **Apply** for the changes to take effect. The changes take effect immediately. And they last until you make additional changes, or until you restart the computer.

## The command-line interface

You can also run Verifier.exe from a command line (for more information, type *verifier.exe /?* at a command prompt). Multiple switches can be used on the command line, for example:

```console
Verifier.exe /flags 0x209BB /driver MyDriver1.sys MyFilterDriver1.sys
```

The following list shows the most commonly used command-line flags:

### Configure options (flags)

- verifier.exe /flags *value*

  *Value* is a hex number (a *0x* prefix is required) that represents the collective value of flags to be enabled. The value for each flag is shown in the `verifier /?` output.

  Standard Flags:

  0x00000000: Automatic Checks  
  0x00000001: Special pool  
  0x00000002: Force IRQL Checking  
  0x00000008: Pool Tracking  
  0x00000010: I/O verification  
  0x00000020: Deadlock detection  
  0x00000080: DMA checking  
  0x00000100: Security checks  
  0x00000800: Miscellaneous checks  
  0x00020000: DDI compliance checking

  More Flags:

  0x00000004: Randomized low resources simulation  
  0x00000040: Enhanced I/O verification (Vista only)  
  0x00000200: Force pending I/O requests  
  0x00000400: IRP Logging  
  0x00002000: Invariant MDL checking for stack  
 0x00004000: Invariant MDL checking for driver0x00008000: Power framework delay fuzzing

  For example, to enable only the Special Pool, I/O Verification, and Miscellaneous checks:

  ```console
  verifier.exe /flags 0x811
  ```

  To enable all standard settings (either example works):

  ```console
  verifier.exe /standard
  ```

  ```console
  verifier.exe /flags 0x209BB
  ```

- Configure Drivers to verify

  ```console
  verifier.exe /driver driver1.sys [driver2.sys driver3.sys ...]
  ```

  This command specifies the specific driver or drivers to verify. Provide additional drivers in a space-separated list.

  ```console
  verifier.exe /all
  ```

  This command verifies all the drivers in the system.

- Configure using Volatile mode

  ```console
  verifier.exe /volatile /flags *value /adddriver MyDriver1.sys*
  ```

  This command changes verifier flags immediately, and adds MyDriver1.sys for verification.

- Query current Verifier statistics

  ```console
  verifier /query
  ```

  Dump the current Driver Verifier status and counters to the standard output.

- Query current Verifier settings

  ```console
  verifier /querysettings
  ```

  Dump the current Driver Verifier settings to the standard output.

- Clear Verifier settings
  
  ```console
  verifier.exe /reset
  ```

  This command erases all current Driver Verifier settings.

## Additional information for Driver developers

The sections that follow describe more details about driver verifier settings that may be of interest to driver developers. These settings aren't generally required by IT professionals.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To enable Driver Verifier by editing the registry, follow these steps:

1. Start Registry Editor (Regedt32).
2. Locate the following registry key:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\VerifyDrivers`

3. Edit the `REG_SZ` key.

Set the `REG_SZ` key to the case-insensitive names of the drivers that you want to test. You can specify multiple drivers, but only use one driver. By doing so, you can make sure that available system resources aren't prematurely exhausted. Premature exhaustion of resources doesn't cause any system reliability problems, but it can cause some driver checking to be bypassed.

The following list shows examples of values for the `REG_SZ` key:

- Ntfs.sys
- Win32k.sys ftdisk.sys
- *.sys

You can specify the level of driver verification in the following registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\VerifyDriverLevel`

The value of the key is a DWORD representing the collection of all flags enabled.
