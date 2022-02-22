---
title: Guidance of troubleshooting Live Migration
description: Introduces general guidance of troubleshooting scenarios related to Live Migration.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:live-migration, csstroubleshoot
ms.technology: hyper-v
---
# Live Migration troubleshooting guidance

This article is designed to get you started on troubleshooting issues encountered during Live Migration.

## Troubleshooting checklist

- Check the hosts are at the same level of patching and whether they can update to the latest rollup.
- Update the BIOS, firmware and third party drivers.
- Check whether the virtual machines have the latest matching integration services.
- Check whether the migration is authorized on each side.
- Check whether the protocol used is identical on each side.
- Check whether the TCP Port 6600 and 3343 (for clustering) are listening on both sides.
- Check compatibilities issues by running a `Compare-VM` command. Provide the name of the VM and the destination host. For example:

  ```powershell
  Compare-VM -Name <vm_name> -DestinationHost <host_name>
  ```

- Check whether any group policy object is preventing the migration from occurring. Verify that the following policy have at least the default settings.
  - Open *GPEDIT.MSC* and navigate to **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment**.  
    Open **Create symbolic links** and check whether the following user accounts are listed:  
    - Administrators  
    - NT VIRTUAL MACHINE\Virtual Machines  
    - Log on as a service  
    - NT SERVICE\ALL SERVICES  
    - NT VIRTUAL MACHINE\Virtual Machines

- Check for the antivirus exclusions. For more information, see [Recommended antivirus exclusions for Hyper-V hosts](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/antivirus-exclusions-for-hyper-v-hosts).
- Check the corruption of the *Registry.pol* file:  
  Run notepad and open *C:\\Windows\\System32\\GroupPolicy\\Machine\\Registry.pol*. The file must start with the **PReg** signature.
- Compare permissions on the folders containing the virtual machines files with a working host with the same operating system level.

## Common issues and solutions

### Event ID 20413

[Live migration fails at 90%~100%, and quick migration fails during virtual machine configuration online](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-20413)

### Event ID 20417

[The Virtual Machine Management service successfully completed the live migration of virtual machine "VM" with an unexpectedly long blackout time of 63.1 seconds](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-20417)

### Event ID 21024

[Both live migration and quick migration succeeds, but virtual machine loses network connectivity after migration](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21024)

### Event ID 21125

[Configuration setup for live migration failed on the destination node](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21125)

### Event ID 21501

[Live migration of "VM" failed. Virtual machine migration operation for "VM" failed at migration source "Host5."](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21501)

### Event ID 21502

Various reason why this event occurs. For details, see [Information regarding Event ID 21502](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21502)

### Event ID 20413

[Live migration fails at 90%~100%, and quick migration fails during virtual machine configuration online](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-20413)

### Event ID 20417

[The Virtual Machine Management service successfully completed the live migration of virtual machine "VM" with an unexpectedly long blackout time of 63.1 seconds](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-20417)

### Event ID 21024

[Both live migration and quick migration succeeds, but virtual machine loses network connectivity after migration](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21024)

### Event ID 21125

[Configuration setup for live migration failed on the destination node](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21125)

### Event ID 21501

[Live migration of "VM" failed. Virtual machine migration operation for "VM" failed at migration source "Host5."](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#event-id-21501)

### Event ID 21502

- [Live migration of VM failed. VM failed to live migrate because a virtual switch used by the VM doesn't exist on the destination node "Host2"](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-because-a-virtual-switch-used-by-the-vm-doesnt-exist-on-the-destination-node-host2)

- [Live migration failed because the action "Move" didn't complete. Error Code: 0x80071398](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-because-the-action-move-didnt-complete-error-code-0x80071398)

- [Failed to get the network address for the destination node "Host2": A cluster Network isn't available for this operation. (0x000013AB)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-get-the-network-address-for-the-destination-node-host2-a-cluster-network-isnt-available-for-this-operation-0x000013ab)

- [Live migration failed with error code (0x8007271D)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-with-error-code-0x8007271d)

- [Failed to create partition: Insufficient system resources exist to complete the requested service. (0x800705AA)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-create-partition-insufficient-system-resources-exist-to-complete-the-requested-service-0x800705aa)

- [Failed to restore with Error "A virtual disk support provider for the specified file was not found." (0xC03A0014)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-restore-with-error--a-virtual-disk-support-provider-for-the-specified-file-was-not-found-0xc03a0014)

- [Live migration failed because "Test" failed at migration source](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-because-test-failed-at-migration-source-host3)

- [Live migration failed because the hardware on the destination computer isn't compatible with the hardware requirements of this virtual machine](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-because-the-hardware-on-the-destination-computer-isnt-compatible-with-the-hardware-requirements-of-this-virtual-machine)

- [Failed live migrate because "Virtual Machine Name" is using processor-specific features not supported on host "Node 1."](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-live-migrate-because-virtual-machine-name-is-using-processor-specific-features-not-supported-on-host-node-1)

- [Live migration failed because "Virtual Machine Name" failed at migration source "Source Host Name"](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-because-virtual-machine-name-failed-at-migration-source-source-host-name)

- [Live migration failed because "vm1" couldn't initialize memory: Ran out of memory (0x8007000E)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#live-migration-failed-because-vm1-couldnt-initialize-memory-ran-out-of-memory-0x8007000e)

- [Failed to establish a connection with host computer name: No credentials are available in the security package 0x8009030E](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-establish-a-connection-with-host-computer-name-no-credentials-are-available-in-the-security-package-0x8009030e)

- [Failed to establish a connection with host "DESTINATION-SERVER": The credentials supplied to the package were not recognized (0x8009030D)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-establish-a-connection-with-host-destination-server-the-credentials-supplied-to-the-package-were-not-recognized-0x8009030d)

- [Failed to create Planned Virtual Machine at migration destination: Logon failure](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-create-planned-virtual-machine-at-migration-destination-logon-failure)

- [Failed to establish a connection for a Virtual Machine migration with host "HOST3": A connection attempt failed](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-to-establish-a-connection-for-a-virtual-machine-migration-with-host-host3-a-connection-attempt-failed)

- [Fail to live migrate because the target principal name is incorrect. (0x80090322)](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#fail-to-live-migrate-because-the-target-principal-name-is-incorrect-0x80090322)

- [Fail to live migrate because virtual machine migration operation for "VM01" failed at migration source "Node3"](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#fail-to-live-migrate-because-virtual-machine-migration-operation-for-vm01-failed-at-migration-source-node3)

- [Failed live migration of 'Virtual Machine VM1' at migration source 'CLU8N1' with error codes 80042001 and 8007000D](https://docs.microsoft.com/troubleshoot/windows-server/virtualization/troubleshoot-live-migration-issues#failed-live-migration-of-virtual-machine-vm1-at-migration-source-clu8n1-with-error-codes-80042001-and-8007000d)
