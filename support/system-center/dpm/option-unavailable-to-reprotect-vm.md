---
title: Option isn't available to reprotect VMware VMs
description: The option to reprotect VMware VMs on a new DPM or MABS server isn't available.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Option isn't available to reprotect VMware VMs on a new DPM or MABS server

This article helps you resolve an issue in which the option to reprotect VMware virtual machines (VMs) on a new Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS) server isn't available.

_Original product version:_ &nbsp; System Center 2012 R2 Data Protection Manager, System Center Data Protection Manager version 1801  
_Original KB number:_ &nbsp; 4020519

## Symptom

When you are using DPM or MABS to protect VMware VMs, there may be a need to move protection of a VMware VM from one DPM/MABS server to another. After you stop protection, you try to add VMware VMs to a different DPM/MAB server, but no check box is available to enable this option. In addition, you may see the following **tool tip** message:

> This item is already protected by DPM Server: \<*DPMServerName*>

## Cause

VCenter has a custom attribute called **DPMServer** that's used to specify the name of the DPM or MABS server that's currently protecting that VM. This prevents other DPM or MABS servers from protecting the already-protected VM. The VMware VM's `DPMServer` attribute contains the original DPM or MABS server name.

## Resolution 1: Use VMware vCenter console

1. Open VMware vCenter (SC-VMM equivalent) and locate the VM that you want to reprotect.
1. Select the **Summary** tab, and then click the **edit** link in the **Annotations** section.
1. In the **Edit Annotations** dialog box, locate the attribute `DPMServer`. Move your cursor over the value to display the fully qualified domain name (FQDN) of the DPM server that owns protection of the VM.
1. Clear the server name from the **Value** to allow another DPM Server to provide protection. Don't remove the entire attribute, or all scale-out tracking will be lost.

    To clear the value, click the **Value** box that contains the DPM server name and remove the entry, leaving the box empty. Now, another DPM server can protect that VM. And when it does, the relevant FQDN name will be entered in that box.

1. On the new DPM or MABS server, modify or make a new protection group. Use the **Refresh** button to enumerate the VMs. A check box should be available to add the VM of interest to protection.
1. Add the VM to protection and validate that **Initial Replica** job starts moving data.

   > [!NOTE]
   > Modifications of custom attributes on vCenter are not immediately committed in vCenter. A new backup or consistency check must be run against any guest that's under protection to commit attribute changes.

1. On the VCenter server, refresh the VM to show the new custom attributes. They should show the new DPM or MABS server name.

The following example shows the properties of a virtual machine called *ir-dr-cc-1disk*. The `DPMserver` attribute shows the name of the current DPM server owner.

:::image type="content" source="media/option-unavailable-to-reprotect-vm/properties.png" alt-text="An example shows the properties of a virtual machine and the DPMserver attribute shows the name of the current DPM server owner.":::

## Resolution 2: Use VMware PowerCli

Use one the following VMware cmdlets to overcome the issue via VMwares' PowerCli.

- Reset the value on single object (folder)

    ```console
    Connect-VIServer -Server 10.10.10.10 -Protocol https -User admin -Password pass
    $f = Get-Folder -Name "Folder_name"
    Set-Annotation -Entity $f -CustomAttribute "DPMServer" -Value ""
    ```

- Reset the value on single object (VM)

    ```console
    Connect-VIServer -Server 10.10.10.10 -Protocol https -User admin -Password pass
    $f = Get-VM -Name "VM_Name"
    Set-Annotation -Entity $f -CustomAttribute "DPMServer" -Value ""
    ```
