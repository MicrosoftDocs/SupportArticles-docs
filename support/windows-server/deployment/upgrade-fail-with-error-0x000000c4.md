---
title: Upgrade fails with error 0x000000C4
description: Provides a solution to fix the error 0x000000C4 that occurs when you upgrade a Windows Server computer.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# Windows Server 2012 upgrade may fail with error 0x000000C4

This article provides a solution to fix the error 0x000000C4 that occurs when you upgrade a Windows Server computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2901606

## Symptoms

When you try to upgrade Windows Server 2008 R2 to Windows Server 2012, setup may fail on VMware ESXi virtual machines (VMs) with the following Error message:

> Your PC needs to restart. Please hold down the power button. Error Code: 0x000000C4

## Cause

Windows Server 2012 and Window 8 require processors that support PAE/NX/SSE2. ESXi has a feature known as CPU Identification Masking that hides the NX/XD flag from guest. Masking the AMD No eXecute (NX) and the Intel eXecute Disable (XD) bits prevents the virtual machine from using these features.

Even though PAE/NX/SSE2 are enabled at host hardware level, if they are masked at hypervisor level, VMs cannot use these processor features. This will cause the windows setup to fail.

This issue occurs only when WinPE 4.0 or 5.0 is involved in the upgrade/installation process.

## Resolution

To resolve this issue, you need to "Expose the NX/XD flag to guest" by using vSphere Client virtual machine settings under CPUID Mask.

## More information

This issue is normally not noticed when you create a new VM and select Window Server 2012 during VM creating as it seems to enable "Expose the NX/XD flag to guest" setting for that VM. 

Because the issue is noticed with WinPE 4.0 and 5.0, this issue is also noticed when you deploy OS by using System Center 2012 Configuration Manager.

Step-by-step information on how to change these settings on vSphere client is documented in [VMware document](https://pubs.vmware.com/vsphere-4-esx-vcenter/index.jsp?topic=/com.vmware.vsphere.vmadmin.doc_41/vsp_vm_guide/configuring_virtual_machines/t_change_cpuid_mask_virtual_machine_settings.html).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
