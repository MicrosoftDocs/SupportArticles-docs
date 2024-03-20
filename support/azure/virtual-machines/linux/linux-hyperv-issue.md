---
title: Troubleshoot Linux VM boot and network issues due to Hyper-V driver errors
description: Discusses multiple Linux boot scenarios associated with Hyper-V drivers and NIC MAC address mismatch.
author: saimsh-msft
ms.author: saimsh
ms.reviewer: divargas
ms.topic: troubleshooting
ms.date: 10/11/2022
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
---

# Troubleshoot Linux virtual machine boot and network issues due to Hyper-V driver-associated errors

Azure runs on the Hyper-V hypervisor, and Linux systems require certain Hyper-V kernel modules to run on Azure. These kernel modules are bundled into the Linux Integration Services (LIS) drivers for Hyper-V and Azure. Microsoft contributes them directly to the upstream Linux kernel.

This article discusses multiple conditions where one or more disabled Hyper-V drivers could lead to Linux virtual machine (VM) boot and networking issues.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## <a id="identify-hyperv-drivers-disabled-boot-issue"></a>How to identify missing Hyper-V driver issue

To identify if your VM fails to boot due to missing Hyper-V drivers, use [Azure CLI](/cli/azure/serial-console#az-serial-console-connect) or the Azure portal to view the serial console log of the VM in the boot-diagnostics pane or serial console pane. The sample outputs of failures are displayed in the corresponding sections below.

## Before you troubleshoot

To troubleshoot [Scenario 1: Network Hyper-V driver is disabled](#network-hyperv-disabled) and [Scenario 2: NIC mac address is changed or doesn't match](#macaddress-issue), you need [serial console](./serial-console-linux.md) access for your Linux VM.

If you don't have serial console access, follow the [offline approach](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to access the contents of the problematic OS disk from a rescue virtual machine. Access to Azure CLI or [Azure Cloud Shell](https://shell.azure.com) is required for the offline approach.

To troubleshoot [Scenario 3: Other Hyper-V drivers are disabled](#hyperv-drivers-disabled), the offline approach is the only option to resolve the issue.

## <a id="network-hyperv-disabled"></a> Scenario 1: Network Hyper-V driver is disabled

Because the networking services are unavailable, you're unable to Secure Shell Protocol (SSH) to a virtual machine, but you still can sign in via [serial console](../virtual-machines-windows/serial-console-overview.md) from the Azure portal. You see the following types of errors in the serial console or latest serial log within the [Boot Diagnostics](../virtual-machines-windows/boot-diagnostics.md) pane in the Azure portal:

```output
 cloud-init[807]: Cloud-init v. 19.4 running 'init-local' at Tue, xx Aug 20XX 20:41:53 +0000. Up 5.83 seconds.
 cloud-init[807]: 20XX-08-XX 20:41:54,231 - stages.py[WARNING]: Failed to rename devices: [nic not present] Cannot rename mac=xx:xx:xx:xx:xx:xx to eth0, not available.
[  OK  ] Started Initial cloud-init job (pre-networking).
----
[FAILED] Failed to start LSB: Bring up/down networking.
See 'systemctl status network.service' for details.
```

Or

```output
 cloud-init[799]: 2022-XX-XX 19:04:06,267 - azure.py[WARNING]: Interface not found for DHCP
 cloud-init[799]: 2022-XX-XX 19:04:07,269 - azure.py[WARNING]: Interface not found for DHCP
 cloud-init[799]: 2022-XX-XX 19:04:10,274 - azure.py[WARNING]: Interface not found for DHCP
 cloud-init[799]: 2022-XX-2XX 19:04:10,277 - azure.py[WARNING]: IMDS network metadata has incomplete configuration: None
```

### <a id="reenable-hv_netvsc-online"></a>Solution 1: Enable Hyper-V network driver by using serial console

1. Access the serial console of the VM. The networking is down, but the login prompt is still available.
2. Sign in to the VM with the correct credentials.
3. Switch to the root account or user account with sudo access.
4. Go to the */etc/modprobe.d* directory and look for any line that disables the hv_netvsc driver.

    1. Identify the file that disables the hv_netvsc driver and the corresponding line numbers by running the following command:

        ```bash
        grep -nr "hv_netvsc" /etc/modprobe.d/
        ```

    2. Modify the corresponding file and comment out or delete the hv_netvsc entries:

          :::image type="content" source="media/linux-hyperv-issue/hv-netvsc-disabled.png" alt-text="Screenshot that shows the possible configuration file contents used to disable network drivers.":::

        ```bash
        vi /etc/modprobe.d/disable.conf
        ```

        > [!NOTE]
        >
        > - The entries that disable drivers are defined by the Linux Operating System, not by Microsoft.
        > - Replace `disable.conf` with the corresponding file name where the hv_netvsc driver is disabled.

5. Rebuild the initial RAMdisk image for the currently loaded kernel:

    - For RHEL/SLES-based images

        ```bash
        # dracut -f -v
        ```
    
    - For Ubuntu/Debian-based images

        ```bash
        # mkinitramfs -k -o /boot/initrd.img-$(uname -r)
        ```

6. Reboot the VM.

Always take a backup of the original initial RAMdisk image to facilitate the rollback when needed.

- For RHEL-based images:

    ```bash
    # cp /boot/initramfs-<kernelVersion>.img /boot/initramfs-<kernelVersion>.img.bak
    ```

- For SLES-based images:

    ```bash
    # cp /boot/initrd-<kernelVersion> /boot/initrd-<kernelVersion>.bak
    ```

- For Ubuntu/Debian-based images:

    ```bash
    # cp /boot/initrd.img-<kernelVersion> /boot/initrd.img-<kernelVersion>.bak
    ```

### <a id="reenable-hv_netvsc-offline"></a>Solution 2: Enable Hyper-V network driver offline

1. Use [az vm repair](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to access the contents of the affected OS disk from a rescue VM.

2. Mount and chroot to the file systems of the attached OS disk in the rescue VM by following [chroot instructions](./chroot-environment-linux.md).

3. Once the content of the affected OS disk is accessed, follow steps 4 and 5 in [Solution 1: Enable Hyper-V network driver by using serial console](#reenable-hv_netvsc-online) to reenable the drivers and rebuild the initial RAMdisk image.

    Before the initial RAMdisk image is rebuilt, switch to chroot environment. The full path of the image must be provided.

4. Once the changes are applied, perform an automatic OS disk swap with the original VM and reboot the system by using the `az vm repair restore` command.

## <a id="macaddress-issue"></a>Scenario 2: NIC MAC address is changed or doesn't match

If the Network Interface Card MAC address is changed or doesn't match within the OS configuration, you won't be able to SSH to the VM because the networking services are unavailable. You're still able to sign in via [serial console](../virtual-machines-windows/serial-console-overview.md) from the Azure portal. Errors that are similar to the ones in [Scenario 1: Network Hyper-V driver is disabled](#network-hyperv-disabled) are displayed.

If the issue continues even though the Hyper-V network driver is enabled, use one of the following solutions to validate the OS NIC configuration and resolve the issue.

### <a id="macaddress-mismatch-online"></a> Solution 1: Fix NIC MAC address mismatch by using serial console

1. Access the serial console of the VM. The networking is down, but the login prompt is still available.
2. Sign in to the VM with the correct credentials.
3. Switch to the root account or user account with sudo access.
4. Go to the */etc/cloud/cloud.cfg.d* directory.

5. Considering [Linux partner images](/azure/virtual-machines/linux/endorsed-distros) are used, open and edit the following files:

    - *91-azure_datasource.cfg* for RHEL-based distribution.
    - *90_dpkg.cfg* for Debian and Ubuntu-based distribution.

6. If the `apply_network_config` parameter is set to false, then set it to true. If nothing is specified, the default value is set to true. This setting will ensure that the new MAC address is applied to the networking configuration on the next reboot.

7. Generally, a NIC MAC address would only change if a NIC is deleted or added by the administrator or a NIC is updated in the backend. If network configuration via cloud-init isn't desired, and the `apply_network_config` parameter needs to be set to false, delete the */var/lib/cloud/instance/obj.pkl* file and reboot the system.

    ```bash
    # rm /var/lib/cloud/instance/obj.pkl
    ```

8. Once the changes are applied, restart the system.

### Solution 2: Fix NIC MAC address mismatch offline

1. Use the [az vm repair](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) command to access the contents of the affected OS disk from a rescue virtual machine.
2. Mount and chroot to the file systems of the attached OS disk in a rescue VM correctly by following [chroot instructions](./chroot-environment-linux.md).
3. Once the content of the copy of the affected OS disk is accessed, follow steps 4 to 7 in [Solution 1: Fix NIC MAC address mismatch by using Serial Console](#macaddress-mismatch-online) to make networking changes or clear the *obj.pkl* file.
4. Once the changes are applied, use the `az vm repair restore` command to perform an automatic OS disk swap with the original VM and reboot the system.

## <a id="hyperv-drivers-disabled"></a>Scenario 3: Other Hyper-V drivers are disabled

If you experience boot issues with other Hyper-V drivers, you're likely unable to SSH to a VM because the networking services are unavailable. You're dropped to a dracut shell. This issue can be viewed via the [serial console](../virtual-machines-windows/serial-console-overview.md) from the Azure portal. You can see the following errors in the serial console or latest serial log within the [Boot Diagnostics](../virtual-machines-windows/boot-diagnostics.md) pane in the Azure portal:

```output
 dracut-initqueue[455]: Warning: dracut-initqueue timeout - starting timeout scripts
 dracut-initqueue[455]: Warning: Could not boot.
         Starting Setup Virtual Console...
[  OK  ] Started Setup Virtual Console.
         Starting Dracut Emergency Shell...
Warning: /dev/mapper/rootvg-rootlv does not exist
Generating "/run/initramfs/rdsosreport.txt"
 
Entering emergency mode. Exit the shell to continue.
Type "journalctl" to view system logs.
You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
after mounting them and attach it to a bug report.
dracut:/#
```

Or

```output
Gave up waiting for root file system device.  Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay= (did the system wait long enough?)
 - Missing modules (cat /proc/modules; ls /dev)
ALERT!  UUID=143c811b-9b9c-48f3-b0c8-040f6e65f50aa does not exist.  Dropping to a shell!


BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.4) built-in shell (ash)
Enter 'help' for a list of built-in commands.

(initramfs)
```

### Solution: Enable Hyper-V drivers

If the VM is inaccessible due to other Hyper-V drivers being disabled, use an offline approach to reenable the drivers, as the initramfs can't be loaded.

1. Use the [az vm repair](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) command to access the contents of the problematic OS disk from a rescue virtual machine.
2. Mount and chroot to the file systems of the attached OS disk in a rescue VM correctly following [chroot instructions](./chroot-environment-linux.md).
3. Once in the chroot environment, go to the */etc/modprobe.d* directory and look for any line that might disable the hv_utils, hv_vmbus, hv_storvsc, or hv_netvsc driver.
    
    1. Run the following command to identify the file that disables the hv_utils, hv_vmbus, hv_storvsc, or hv_netvsc driver and the corresponding line number.

        ```bash
        egrep -nr "hv_utils|hv_vmbus|hv_storvsc|hv_netvsc" /etc/modprobe.d/
        ```

    2. Modify the corresponding file and comment out or delete the hv_utils, hv_vmbus, hv_storvsc, or hv_netvsc entries. The entries will most commonly be any of the following (or both):

        :::image type="content" source="media/linux-hyperv-issue/hv-disabled-example-1.png" alt-text="Screenshot that shows the possible configuration file contents used to disable kernel modules/drivers using the install option.":::

        :::image type="content" source="media/linux-hyperv-issue/hv-disabled-example-2.png" alt-text="Screenshot that shows the possible configuration file contents used to disable kernel modules/drivers.":::

        ```bash
        vi /etc/modprobe.d/disable.conf
        ```

    > [!IMPORTANT]
    >
    > - The entries that disable drivers are defined by the Linux Operating System, not by Microsoft.
    > - Replace `disable.conf` with the corresponding file name where the Hyper-V drivers are disabled.

4. Rebuild the initial RAMdisk image for the currently loaded kernel:

    - For RHEL/SLES-based images

        ```bash
        # dracut -f -v
        ```

    - For Ubuntu/Debian-based images

        ```bash
        # mkinitramfs -k -o /boot/initrd.img-$(uname -r)
        ```

5. Once the changes are applied, use the `az vm repair restore` command to perform an automatic OS disk swap with the original VM and reboot the system.

Always take a backup of the original initial RAMdisk image to facilitate the rollback if needed.

If the issue is still not resolved, refer to [Azure Linux virtual machine fails to boot and enters dracut emergency shell](linux-no-boot-dracut.md) to investigate dracut issues.

## Next steps

In case the specific boot error isn't a Hyper-V issue, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
