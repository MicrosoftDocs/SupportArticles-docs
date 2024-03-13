---
title: Work with Hyper-V network virtualization and Hyper-V replicas
description: Discusses how to work with Hyper-V network virtualization and Hyper-V replicas in Virtual Machine Manager 2012.
ms.date: 03/13/2024
ms.reviewer: jchornbe, markstan, aagrawal, ruturajd
---
# How to work with Hyper-V network virtualization and Hyper-V replicas in VMM 2012

This article discusses how to work with Hyper-V network virtualization and Hyper-V replicas in Microsoft System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3034191

## Summary

Microsoft Azure Site Recovery (ASR) is the recommended product for end-to-end Hyper-V replica management. This includes network management for replica virtual machines (VM) in a System Center 2012 Virtual Machine Manager (VMM 2012) environment. However, although VMM 2012 doesn't manage Hyper-V replicas natively without ASR, you can still use Hyper-V replica PowerShell cmdlets to automate Hyper-V replica-related operations. Such operations include failing over a VM by using a Hyper-V replica but without using ASR.

This article documents the recommended approach to Hyper-V replica management. This article also provides the necessary scripts to fail over a VM by using a Hyper-V replica.

> [!NOTE]
>
> - The process applies to situations in which both primary and replica VM are on the same Hyper-V Network Virtualization (HNV) network.
> - If you don't use these scripts, the CA-PA records can become corrupted because both the primary and replica VM are concurrently attached to the same network.

In a failure recovery setup, the recommended guidance is to have separate primary and secondary HNV networks. In these networks, the primary VM should be connected to a primary HNV network, and the replica VM should be connected to the secondary VM network. If you use a single VM network for both the primary and secondary sites, the recommended guidance is to use ASR because it automates network management of replica VMs through the network mapping feature. If you don't use ASR, you must be careful about both the order in which the VMs are attached to the network and any prerequisites for making the attachments.

> [!CAUTION]
> You must follow the guidance in these sections for attachment order and prerequisite steps. Otherwise, the CA-PA records in VMM might be deleted and cause a loss of network connectivity.

The following scripts apply to a VMM 2012 (including VMM 2012 R2) management environment in which the following conditions are true:

- A single VMM 2012 configuration is used to manage both the primary and secondary sites.
- A single HNV network is used for both the primary and replica VM.

> [!NOTE]
> By using separate primary and secondary HNV networks for the primary and replica VM, you can make sure that both VMs can be connected to their networks at same time. This configuration is recommended for the following conditions:
>
> - You plan to perform a failover on the VMs.
> - The VMs have IPv4 addresses.
> - You want to maintain the IP address of the VMs after the planned failover.

## Prerequisite steps

Before you perform a failover operation, follow these steps:

1. Make sure that the virtual switch and logical switch settings are compliant in the VMM console. For more information, see [How to View Host Network Adapter Settings and Increase Compliance with Logical Switch Settings in VMM](/previous-versions/system-center/system-center-2012-R2/dn249415(v=sc.12)?redirectedfrom=MSDN).

   If the settings are not compliant, VMM operations to attach networks after the failover can fail.
2. Make sure that the primary VM is connected to an HNV network.
3. Make sure that the replica VM is not connected to any network.

    > [!IMPORTANT]
    > The replica VM must not be connected to the HNV network at the same time as the primary VM. A concurrent connection can cause incorrect states for the CA-PA records.

4. Make sure that only one IP address is assigned to each network adapter of the primary VM. To do this, run the following commands at a command prompt:

    ```powershell
    $VMOnPD = Get-SCVirtualMachine -Name "VM Name" | where {$_.IsPrimaryVM -eq $true}

    Get-SCIPAddress -GrantToObjectId $VMOnPD.VirtualNetworkAdapters[0].ID
    ```

   If there are more than one connected network adapters on the VM, run these commands for every network adapter by changing the array index.

5. Verify that the IP address that is assigned to the VM on the operating system is the same as the IP address that is mentioned in step 4. To do this, log on to the VM, and then run the following command at a command prompt:

    ```console
    ipconfig
    ```  

6. Verify that the lookup tables are set correctly on the primary and replica server. To do this, run the following command on each server, and make sure that there is an entry that corresponds to the IP address that is returned in step 4:

    ```powershell
    Get-NetVirtualizationLookupRecord
    ```  

7. Make sure that the IP address that is used is an IPv4 address and not an IPv6 address.
8. Make sure that both VMs are turned off before the scripts are run.
9. Make sure that the **Replication State** value is set to **Replication enabled** on both VMs.

## Script to fail over a VM by using a Hyper-V replica

Run the [planned failover script](/system-center/vmm/manage-vm-failover-virtual-networks#run-the-planned-failover-script) to perform the failover. This script includes an option to complete a reverse replication together with the failover.

This script takes the following arguments:

- `$VMName`: Name of the virtual machine
- `$ReverseRep`: Boolean argument to specify whether reverse replication should be performed

  If **$true** is passed, the reverse replication is started immediately, and the failover cannot be canceled afterward.

  After this script has completed successfully by having `$ReverseRep` passed as **$true**, the following conditions are true:

  - The primary VM should be in the **Prepared for planned failover** replication state.
  - The replica VM should be in the **Failover complete** replication state.

  If **$false** is passed, the reverse replication is not performed. You can run the [reverse replication/cancel script](/system-center/vmm/manage-vm-failover-virtual-networks#run-the-reverse-replicationcancel-script) in the next section to either perform a reverse replication or cancel the failover. After this script is completed successfully by having `$ReverseRep` passed as **$false**, the following conditions are true:

  - The primary VM should be in the **Prepared for planned failover** replication state.
  - The replica VM should be in the **Failover complete** replication state.

If the script does not perform one or more steps of the failover, you must manually complete the failed steps and then return to the PowerShell window. The failover steps include the following, in this order:

- Fail over the primary VM.
- Fail over the replica VM.
- Perform a reverse replication (based on the value of `$ReverseRep`).

Watch for any errors, and manually complete the failed steps in the given order. After you complete the steps, press any key in the PowerShell window. The script will continue until it is completed.

## Script to trigger reverse replication or cancel the failover

Run the [reverse replication/cancel script](/system-center/vmm/manage-vm-failover-virtual-networks#run-the-reverse-replicationcancel-script) to either trigger reverse replication or cancel the failover. This script must be run if PlannedFailOver.PS1 was run by having `$ReverseRep` passed as $false.

This script takes the following arguments:

- `$VMName`: Name of the virtual machine
- `$ReverseRep`: Boolean argument to specify whether reverse replication should be performed:

  - If **$true** is passed, reverse replication is completed on the VM.
  - If **$false** is passed, reverse replication is not performed.

- `$CancelFO`: Boolean argument to specify whether the failover should be canceled:

  - If **$true** is passed, the failover is canceled on both the primary and recovery sites.
  - If **$false** is passed, the failover is not canceled.

> [!NOTE]
> Only one instance at a time of `$ReverseRep` and `$CancelFO` can be passed as **$true**.

After this script is completed successfully, the **Replication State** value should be set to **Replication enabled** on both VMs.

## References

The following are the scripts for the procedures that are mentioned in the above sections:

- [Planned Failover in Hyper-V Replica with single HNV network](/system-center/vmm/manage-vm-failover-virtual-networks#run-the-planned-failover-script)
- [Reverse replicate in Hyper-V Replica with Single HNV network](/system-center/vmm/manage-vm-failover-virtual-networks#run-the-reverse-replicationcancel-script)
