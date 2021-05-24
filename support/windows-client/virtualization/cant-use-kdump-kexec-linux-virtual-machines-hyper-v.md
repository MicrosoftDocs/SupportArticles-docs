---
title: Can't use kdump or kexec for Linux virtual machines on Hyper-V
description: Provides a resolution for the issue that kdump or kexec cannot be used for Linux virtual machines on Hyper-V.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: abgupta, kaushika
ms.prod-support-area-path: Installation and configuration of Hyper-V
ms.technology: windows-client-hyper-v
---
# Can't use kdump or kexec for Linux virtual machines on Hyper-V

This article provides a resolution to an issue where kdump or kexec can't be used for Linux virtual machines on Hyper-V.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2858695

## Symptoms

- Pre-Windows Server 2012 R2

    Consider the following scenario:
  - You have a pre-Windows Server 2012 R2-based computer that has the Hyper-V role installed.
  - You install Linux on a Hyper-V virtual machine on the computer.
  - You configure kdump on the Linux virtual machine.

    > [!NOTE]
    > The Linux virtual machine already has the Linux Integration Services drivers. The drivers can be either prebuilt or manually installed.  

    In this scenario, if the Linux virtual machine crashes, the core dump file from the Linux kernel is not generated as expected.  

- Windows Server 2012 R2

    Consider the following scenario:
  - You have Linux virtual machines on Windows Server 2012 R2 Hyper-V host.
  - 15 or more vCPUs are attached to the Linux virtual machine.
  - You configure kdump in the Linux virtual machine.  

    In this scenario, kdump does not work, and the crash dump is not created, because the process stops responding (hangs).

## Cause

This issue occurs because Hyper-V can't host two simultaneous connections from the same synthetic driver, which is running inside a virtual machine.

When kdump is configured on a Linux virtual machine that's using the Linux Integration Services synthetic storage driver (also known as storvsc), the kexec kernel is configured to use the same driver. If the Linux virtual machine crashes, the synthetic storage driver that's hosted in the kexec kernel tries to open a connection to the Hyper-V storage provider. However, Hyper-V fails to establish the new connection because of the pre-existing connection to the same storage driver on the crashed Linux virtual machine. Therefore, the kexec kernel cannot dump the core for the crashed Linux virtual machine.

## Resolution

To resolve this issue, configure the kexec kernel by using the standard Linux storage driver. This configuration must be performed after the kdump functionality is enabled on a Linux virtual machine. The basic idea is to turn off the Linux Integration Services storage driver and then enable the standard Linux storage driver inside the kexec kernel by using the prefer_ms_hyper_v parameter in the appropriate configuration file.

The prefer_ms_hyper_v parameter can be used to control the behavior of the standard Linux storage driver. When this parameter is set to 1 and the Linux virtual machine is running on Hyper-V, the standard Linux storage driver disables itself and lets the Linux Integration Services storage driver control the storage devices. By setting the prefer_ms_hyper_v parameter to 0, the standard Linux storage driver is allowed to function. Because the standard Linux storage driver does not require a connection to Hyper-V, the kexec kernel can dump core.

Different Linux distributions have slightly different mechanisms to specify the value of prefer_ms_hyper_v. The following section describes how the parameter can be set for several popular Linux distributions.

### Red Hat Enterprise Linux (RHEL) 5.9

In RHEL 5.9, you have to pass the *prefer_ms_hyper_v* parameter through a kernel command-line argument to the ide_core module that's built into the RHEL 5.9 kernel. By default, this parameter is initialized to 1, and it causes the Linux virtual machine to avoid using the ide_core module if it's running in a Hyper-V environment. Administrators have to set the *prefer_ms_hyper_v* parameter value to 0 so that the ide_core driver becomes operational during the kexec kernel boot process. You can do this by changing the contents of /etc/kdump.conf.

To change the contents of /etc/kdump.conf, follow these steps:

1. Run the following command to configure kdump to write to a local directory:

   ```console
   path /var/crash`
   ```

2. Block list the Linux Integration Services drivers in /etc/kdump.conf, which prevents the drivers from loading in to the kexec kernel. To do so, run the following command:

   ```console
   blacklist hv_vmbus hv_storvsc hv_utils hv_netvsc hid-hyperv
   ```

3. Configure the disk time-out value by running the following command:

   ```console
   disk_timeout 100
   ```

4. After the required edits, the /etc/kdump.conf file looks like this:

   ```console
   path /var/crash  
   core_collector makedumpfile -c--message-level 1 -d 31  
   blacklist hv_vmbus hv_storvsc hv_utils hv_netvsc hid-hyperv  
   disk_timeout 100
   ```

5. Modify the contents of the /etc/sysconfig/kdump file as follows:

   - Add or modify the following line to include the prefer_ms_hyperv=0 argument:

     > KDUMP_COMMANDLINE_APPEND="irqpoll maxcpus=1 reset_devices ide_core.prefer_ms_hyperv=0 "

   - After the required edits, the /etc/sysconfig/kdump file looks like this:

     > KDUMP_COMMANDLINE=""  
    *# This variable lets us append arguments to the current kdump commandline*  
    *# As taken from either KDUMP_COMMANDLINE above, or from /proc/cmdline*  
    KDUMP_COMMANDLINE_APPEND="irqpoll maxcpus=1 reset_devices ide_core.prefer_ms_hyperv=0"

### Red Hat Enterprise Linux (RHEL) 6.4

In RHEL 6.4, you have to pass the prefer_ms_hyper_v parameter to the ata_piix driver module. You can do this by changing the contents of the /etc/kdump.conf file.

To change the contents of /etc/kdump.conf, follow these steps:

1. Configure kdump to write to a local directory:

   ```console
   path /var/crash
   ```

2. Add extra modules ata_piix,sr_mod,sd_mod:

   ```console
   extra_modules ata_piix sr_mod sd_mod
   ```

3. Block list Linux Integration Services drivers in etc/kdump.conf. This prevents the drivers from loading into the kexec kernel:

   ```console
   blacklist hv_vmbus hv_storvsc hv_utils hv_netvsc hid-hyperv
   ```

4. Add options parameter to pass the parameter to the ata_piix module:

   ```console
   options ata_piix prefer_ms_hyperv=0
   ```

5. Configure the disk time-out value so that, it does not stop responding (hang):

   ```console
   disk_timeout 100
   ```

6. After the required edits, the /etc/kdump.conf file looks like:

   ```console
   path /var/crash  
   core_collector makedumpfile -c--message-level 1 -d 31  
   extra_modules ata_piix sr_mod sd_mod  
   blacklist hv_vmbus hv_storvsc hv_utils hv_netvsc hid-hyperv  
   options ata_piix prefer_ms_hyperv=0  
   disk_timeout 100
   ```

### Ubuntu 12.04(.x)

In Ubuntu 12.04(. **x**), you have to pass the prefer_ms_hyper_v parameter to the ata_piix driver. You can do  by changing the contents of the /etc/init.d/kdump file.

To change the contents of the /etc/init.d/kdump file, append ata_piix. prefer_ms_hyper_v=0 to the kdump command-line options:

```bash
do_start {}
{
    ....  
    ....  
    APPEND="$APPEND kdump_needed maxcpus=1 irqpoll reset_devices ata_piix.prefer_ms_hyperv=0"  
    ...  
}
```

### SUSE Linux Enterprise Server (SLES) 11 SP2(x)

In SLES 11 SP2(x) distributions, you have to pass the prefer_ms_hyper_v parameter to the ata_piix driver. You can do so by modifying the contents of the /etc/sysconfig/kdump file as follows:

Append ata_piix.prefer_ms_hyper_v=0 to KDUMP_COMMANDLINE_APPEND:  
> KDUMP_COMMANDLINE_APPEND="ata_piix.prefer_ms_hyperv=0"  

After the required edits, the /etc/sysconfig/kdump file looks like this:  
> KDUMP_COMMANDLINE_APPEND="ata_piix.prefer_ms_hyperv=0"

## More information

KDUMP should be configured in the standard manner that's suggested by Linux distributions.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
