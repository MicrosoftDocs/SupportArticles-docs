---
title: Azure VM cannot RDP - driver IRQL not less or equal
description: Troubleshoot Azure VM cannot RDP - driver IRQL not less or equal.
ms.date: 12/16/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---

# Azure VM cannot RDP - driver IRQL not less or equal

## Symptoms

When you pull the screenshot of the virtual machine (VM), the operating system (OS) is stopped with the error `0x000000D1` also known as `DRIVER_IRQL_NOT_LESS_OR_EQUAL:`

`Your PC ran into a problem and needs to restart. We're just collecting some error info, and then we'll restart for you.`
`(%% complete)`

`For more information on this issue and possible fixes, visit http://windows.com/stopcode. If you call a support person give them this info`

`Stop code: DRIVER_IRQL_NOT_LESS_OR_EQUAL`

`What failed: myfault.sys`

:::image type="content" source="media/azure-vm-cannot-rdp-driver-irql-not-less-equal/pc-needs-to-restart-error.png" alt-text="Screenshot of Your PC ran into a problem and needs to restart error message." border="false":::

## Cause

1. If any of the following knowledge-bases (KBs) (July 2018) were recently installed, there is a known issue where a race condition can cause this crash.

   If the VM is booting, you can install the corresponding KB listed as containing the fix.

   If the VM is not booting, proceed with the offline repair below, and rollback the KB using **DSIM**.

   |SKU|Known Issue KB|Resolved in KB|
   |---|---|---|
   |Windows 10 RS5| - |
   |Windows 10 RS4|[KB4338819](https://support.microsoft.com/help/4338819)|[KB4345421](https://support.microsoft.com/help/4345421)|
   |Windows 10 RS3|[KB4338825](https://support.microsoft.com/help/4338825)|[KB4345419](https://support.microsoft.com/help/4345419)|
   |Windows 10 RS2|[KB4338825](https://support.microsoft.com/help/4338825)|[KB4345419](https://support.microsoft.com/help/4345419)|
   |Windows 10 RS1|[KB4338814](https://support.microsoft.com/help/4338814)|[KB44345418](https://support.microsoft.com/help/4345418)|
   |WS 12 R2 (Security Only)|[KB4338824](https://support.microsoft.com/help/4338824)|[KB4345424](https://support.microsoft.com/help/4345424/)|
   |WS 12 R2 (Monthly Roll-up Only)|[KB4338830](https://support.microsoft.com/help/4338830)|[KB4338816](https://support.microsoft.com/help/4338816)|
   |Windows Server 2012 (Security Only)|[KB4338820](https://support.microsoft.com/help/4338820)|[KB4345425](https://support.microsoft.com/help/4345425/)|
   |Windows Server 2012 (Monthly Roll-up Only)|[KB44338830](https://support.microsoft.com/help/4338830)|[KB4338816](https://support.microsoft.com/help/4338816)|
   |Win7 / W2K8 R2 (Security Only)|[KB4338823](https://support.microsoft.com/help/4338823)|[KB4345459](https://support.microsoft.com/help/4345459/)|
   |Win7 / W2K8 R2 (Monthly roll-up)|[KB4338818](https://support.microsoft.com/help/4338818)|[KB4338821](https://support.microsoft.com/help/4338821)|
   |Windows Server 2008|-|[KB4345397](https://support.microsoft.com/help/4345397/)|

2. If the cause is not due to one of the above KBs having been recently installed, then a memory dump analysis will be required to determine the cause.

## Solution

### Process Overview

1. [Create and Access a Repair VM](#1)
2. [Remove the KB or collect the memory dump file](#2)
3. [Rebuild the VM](#3)

### Create and Access a Repair VM<a id="1"></a>

1. Use [steps 1-3 of the VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to prepare a Repair VM.
2. Use Remote Desktop Connection connect to the Repair VM.

### Remove the KB or collect the memory dump file<a id="2"></a>

#### Remove the KB

1. Open an elevated command prompt session (Run as administrator).

   1. Now query the patch level to get the package name so you can remove it with the DISM tool
   `dism /image:<<BROKEN DISK LETTER>>:\ /get-packages > c:\temp\Patch_level.txt`.

   2. Now open the file `c:\temp\Patch_level.txt` and read it from the bottom up, looking for the KB that was installed in this VM based on the table described on the **Symptom** section and get its **package name**.

   3. Remove the problematic packages, perform this for each of the packages:

      `dism /Image:<<BROKEN DISK LETTER>>:\ /Remove-Package /PackageName:<<PACKAGE NAME TO DELETE>>`

      Example:

      `dism /Image:e:\ /Remove-Package /PackageName:Package_for_RollupFix~31bf3856ad364e35~amd64~~14393.1944.1.3`

      > [!NOTE]
      > DISM is not a fast tool. Every time that you run it, and depending on the size of the package being removed, this operation could last quite some time, up to approximately 16 minutes. As the process continues, you will see a percentage process of the operation.

   Use [step 5 of the VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to reassemble the VM.

2. If the above fix doesn't apply, then a memory dump analysis will be required.

#### Collect the Memory Dump File

To resolve this problem, gather the memory dump file for the crash, and contact support with the memory dump file. To collect the dump file, follow these steps:

1. Locate the dump file and submit a support ticket:

   - On the repair VM, go to the Windows folder on the attached OS disk. If the driver letter that is assigned to the attached OS disk is `F`, then go to `F:\Windows`.
   - Locate the `memory.dmp` file, and [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) with the memory dump file.
   - If you are having trouble locating the memory.dmp file, you may wish to use [non-maskable interrupt (NMI) calls in serial console](/azure/virtual-machines/troubleshooting/serial-console-windows#use-the-serial-console-for-nmi-calls) instead.

   Follow the guide to [generate a crash dump file using NMI calls](/windows/client-management/generate-kernel-or-complete-crash-dump).

### Rebuild the VM<a id="3"></a>

Use [step 5 of the VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to reassemble the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
