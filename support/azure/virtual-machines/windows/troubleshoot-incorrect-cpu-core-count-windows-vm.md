---
title: Windows VM reports fewer CPU cores or logical processors than expected
description: Troubleshoot a Windows VM that shows fewer CPU cores than expected. Learn how to fix msconfig processor caps and registry settings that disable hyperthreading.
services: virtual-machines
documentationcenter: ''
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson 
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 11/16/2026
ms.custom: sap:VM Performance
ai-usage: ai-assisted
---
# Windows VM reports fewer CPU cores or logical processors than expected

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

If your Windows VM shows fewer CPU cores or logical processors than the VM size's documented vCPU count, use this article to identify the cause and restore the expected count. The most common cause is an unintentional guest-OS configuration — an `msconfig` processor cap, or a registry value changed by a Group Policy Object (GPO) while applying a security mitigation — rather than a platform or hardware issue. This article walks through confirming the symptom and fixing both causes.

## Prerequisites

- Administrator access inside the Windows guest OS (RDP, Azure Bastion, serial console, or Run Command).
- The VM's documented vCPU count for its size, from the Azure portal (**Virtual machine > Size**) or the [VM sizes documentation](/azure/virtual-machines/sizes/overview).
- The VM must be able to restart — plan for a reboot as part of the fix. A guest-OS-only restart isn't enough; you restart from the Azure portal or Azure CLI/PowerShell.

## Symptoms

The Azure portal shows the VM size has a certain number of vCPUs (for example, 8), but inside the guest OS, Task Manager, Device Manager, or a command-line query shows fewer logical processors (for example, 4).

> [!NOTE]
> There's no fixed one-to-one relationship between a vCPU and a physical core in any virtualization platform. Before troubleshooting further, confirm the VM size's documented vCPU count (which already reflects whichever CPU topology that size uses) rather than assuming 1 vCPU always equals 1 physical core.

To confirm whether hyperthreading (SMT) is disabled in the guest OS:

**Windows** — open a command prompt in the guest OS and run:

```cmd
wmic CPU Get NumberOfCores,NumberOfLogicalProcessors /Format:List
```

If `NumberOfLogicalProcessors` is greater than `NumberOfCores`, hyperthreading is enabled. If they're equal, hyperthreading is disabled (or the VM size doesn't support it).

**Linux** — run:

```bash
lscpu
```

Check the **Thread(s) per core** line: `1` means SMT/hyperthreading is disabled; `2` means it's enabled. See [Expected output](#expected-output) for a full sample.

## Cause

This behavior is most commonly caused by one of two **unintentional** guest-OS-level misconfigurations:

1. A **System Configuration (`msconfig`) Boot Advanced Options** setting that caps the number of processors the guest OS uses.
1. A **registry value under `FeatureSettingsOverride`/`FeatureSettingsOverrideMask`** that changed — usually by a GPO, such as a security baseline GPO — while applying mitigations for the [speculative execution side-channel vulnerabilities (Spectre/Meltdown)](https://support.microsoft.com/en-us/servicing/os/windows-server/2019/12/kb4072698-windows-server-and-azure-stack-hci-guidance-to-protect-against-silicon-based-microarchitec). Some mitigation guidance for these CVEs disables hyperthreading (SMT) as a side effect, which is usually unnecessary and avoidable.

> [!IMPORTANT]
> This article covers *unintentional* core and logical processor reduction caused by guest-OS configuration drift. If you deliberately want to disable hyperthreading or constrain the vCPU count - for example, for per-core software licensing - don't use the steps in this article. Use the supported, documented feature instead: see [Disable Simultaneous Multi-Threading/Hyper-Threading and Configurable Constrained Cores](https://techcommunity.microsoft.com/blog/azurecompute/announcing-general-availability-of-disable-multithreading-and-configurable-const/4547908) and the VM vCPU customization documentation it links to.

## Resolution

### Option 1: Check the msconfig processor cap (Windows)

1. From the command line, run `msconfig`.
1. Select the **Boot** tab, and then select **Advanced options**.
1. Clear the **Make all boot settings permanent** checkbox, if it's selected.
1. If **Number of processors** is checked and set to a number lower than the VM size's vCPU count, clear the checkbox or set it to the maximum.
1. Select **OK**, select **Apply**, and then restart the VM from the Azure portal or Azure CLI/PowerShell.
1. **Success criterion:** After restart, rerun the `wmic` or `lscpu` check from [Symptoms](#symptoms) and confirm the logical processor count now matches the VM size's vCPU count.

### Option 2: Check and correct the FeatureSettingsOverride registry value (Windows)

1. Check the current values:

   ```cmd
   reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
   ```

1. Compare against the expected values that allow the Spectre/Meltdown mitigations without disabling hyperthreading:
   - `FeatureSettingsOverride` = `0x48` (72 decimal)
   - `FeatureSettingsOverrideMask` = `0x3`

   If either value differs — commonly `FeatureSettingsOverride` = `0x2048` (8264 decimal) — a GPO or local policy overwrote it and is disabling hyperthreading as a side effect of the CVE mitigation.

1. If you need to identify which GPO is setting the value, generate a GPO report from within the VM:

   ```cmd
   gpresult /h gpreport.html
   ```

> [!CAUTION]
> The next step changes registry values under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management`, which also controls the Spectre/Meltdown mitigation state on this VM. Back up the current values first, and only change them on a VM where you confirmed the current values in step 1 — don't apply this to a VM you didn't verify.
>
> **Back up first:**
> ```cmd
> reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" C:\MemoryManagement-backup.reg
> ```
> **To revert:** double-click the saved `.reg` file, or run `reg import C:\MemoryManagement-backup.reg`, then restart the VM from the Azure portal.

1. Correct the registry values:

   ```cmd
   reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 72 /f
   reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f
   ```

1. **Restart the VM from the Azure portal or Azure CLI/PowerShell.** A restart from inside the guest OS isn't sufficient to reset the virtual CPU topology.

1. **Success criterion:** after restart, confirm `FeatureSettingsOverride` still shows `72` (`0x48`) by rerunning the `reg query` command from step 1, and confirm the logical processor count now matches the VM size's vCPU count using the check from [Symptoms](#symptoms). If a GPO is still overwriting the value after each restart, find and remove (or scope this VM out of) the GPO identified in step 3 before the fix will persist.

1. If cores are still reported incorrectly after confirming the registry values are correct and persistent, also check the `FeatureSettings` registry value under the same key. If it isn't `0`, set it to `0` and restart the VM again from the portal.

## Expected output

**Healthy state** — hyperthreading enabled, matching the VM size's vCPU count (example: an 8-vCPU size, HT enabled, 4 physical cores):

```text
NumberOfCores=4
NumberOfLogicalProcessors=8
```

```text
CPU(s):                8
Thread(s) per core:    2
Core(s) per socket:    4
Socket(s):             1
NUMA node(s):          1
```

**Failure state** — hyperthreading unintentionally disabled (same 8-vCPU size, only 4 logical processors visible):

```text
NumberOfCores=4
NumberOfLogicalProcessors=4
```

```text
CPU(s):                8
On-line CPU(s) list:   0,2,4,6
Off-line CPU(s) list:  1,3,5,7
Thread(s) per core:    1
Core(s) per socket:    4
Socket(s):             1
NUMA node(s):          1
```

If you still see the failure-state output after completing both resolution options and confirming the fix persists across a restart, escalate with the output of the `reg query` and `wmic`/`lscpu` commands from this article attached.

## References

- [Disable Simultaneous Multi-Threading/Hyper-Threading and Configurable Constrained Cores](https://techcommunity.microsoft.com/blog/azurecompute/announcing-general-availability-of-disable-multithreading-and-configurable-const/4547908) — for customers who want to *intentionally* disable hyperthreading or constrain vCPU counts (for example, for per-core software licensing).
- [KB4072698 — Windows Server and Azure Stack HCI guidance to protect against silicon-based microarchitectural and speculative execution side-channel vulnerabilities](https://support.microsoft.com/en-us/servicing/os/windows-server/2019/12/kb4072698-windows-server-and-azure-stack-hci-guidance-to-protect-against-silicon-based-microarchitec)
- [Troubleshoot high-CPU issues on Azure Windows virtual machines](troubleshoot-high-cpu-issues-azure-windows-vm.md)
- [Azure Virtual Machines sizes overview](/azure/virtual-machines/sizes/overview)
