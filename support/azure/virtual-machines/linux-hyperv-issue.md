---
title: "Troubleshoot Linux VM boot and network issues due to Hyper-V driver errors"
description: "Discusses multiple linux boot scenarios associated with Hyper-V drivers and NIC MAC address mismatch"
author: "saimsh-msft"
ms.author: "saimsh"
ms.reviewer: divargas
ms.topic: troubleshooting
ms.date: 10/05/2022
ms.service: virtual-machines
ms.collection: linux
---

# Troubleshoot Linux virtual machine boot and network issues due to Hyper-v driver associated errors

Azure runs on the Hyper-V hypervisor and linux systems requires certain Hyper-v kernel modules to run on Azure. These kernel modules are bundled into the Linux Integration Services (LIS) drivers for Hyper-V and Azure that Microsoft contributes directly to the upstream linux kernel.

This article discusses multiple conditions where one or more disabled Hyper-V drivers could lead to linux virtual machine boot and networking issues.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## <a id="identify-hyperv-drivers-disabled-boot-issue"></a>How to identify missing Hyper-V driver issue?

Use the Azure portal to view the serial console log output of the VM in the boot diagnostics blade, serial console blade, or [AZ CLI](/cli/azure/serial-console#az-serial-console-connect) to identify if your VM is failing to boot due to missing hyper-v drivers.

You can find the sample outputs of failures, in each of the corresponding sections below.

## Before you troubleshoot

To troubleshoot [Scenario 1: Network Hyper-V driver disabled](#network-hyperv-disabled) and [Scenario 2: NIC mac address has changed or doesn't match](#macaddress-issue)

* You'll need [serial console](./serial-console-linux.md) access for your linux virtual machine.
* If you do not have serial console access, follow the [offline approach](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to access the contents of the problematic OS disk from a rescue virtual machine. Access to Azure CLI or [Azure Cloud Shell](https://shell.azure.com) is required for offline approach.

To troubleshoot [Scenario 3: Other Hyper-V drivers disabled](#hyperv-drivers-disabled) offline approach is the only option to resolve the issue.

## <a id="network-hyperv-disabled"></a> Scenario 1: Network Hyper-V driver disabled

If you're unable to SSH to a virtual machine and observe the following types of errors in the serial console or latest serial log within the [Boot Diagnostics](./boot-diagnostics.md) blade in the Azure portal, you've most likely landed to a network Hyper-V driver (hv_netvsc) associated issue:

```output
 cloud-init[807]: Cloud-init v. 19.4 running 'init-local' at Tue, xx Aug 20XX 20:41:53 +0000. Up 5.83 seconds.
 cloud-init[807]: 20XX-08-XX 20:41:54,231 - stages.py[WARNING]: Failed to rename devices: [nic not present] Cannot rename mac=xx:xx:xx:xx:xx:xx to eth0, not available.
[  OK  ] Started Initial cloud-init job (pre-networking).
----
[FAILED] Failed to start LSB: Bring up/down networking.
See 'systemctl status network.service' for details.
```

OR 

```output
 cloud-init[799]: 2022-XX-XX 19:04:06,267 - azure.py[WARNING]: Interface not found for DHCP
 cloud-init[799]: 2022-XX-XX 19:04:07,269 - azure.py[WARNING]: Interface not found for DHCP
 cloud-init[799]: 2022-XX-XX 19:04:10,274 - azure.py[WARNING]: Interface not found for DHCP
 cloud-init[799]: 2022-XX-2XX 19:04:10,277 - azure.py[WARNING]: IMDS network metadata has incomplete configuration: None
```

### Symptom

You won't be able SSH as the networking services are unavailable. You should still be able to log in via [serial console](./serial-console-overview.md) from the azure portal.

### <a id="reenable-hv_netvsc-online"></a>**Enable the Hyper-V network driver using the Serial Console method**

Follow the steps below to resolve the issue:

1. Access the serial console of the vm. The networking should be down but login prompt should still be available.
2. Log in to the vm with correct credentials.
3. Switch to the root account or use account with sudo access.
4. Go to `/etc/modprobe.d` directory and look for any line that might be disabling the `hv_netvsc` driver.

    1. Execute the following command to identify the file(s) that are disabling the `hv_netvsc` driver and the corresponding line number(s).

    ```bash
    grep -nr "hv_netvsc" /etc/modprobe.d/
    ```

    2. Modify the corresponding file and comment out or delete the hv_netvsc entries. The entries will most commonly be any of the following (or both):

          :::image type="content" source="media/linux-hyperv-issue/hv_netvsc_disabled-01.png" alt-text="Image shows the possible configuration file contents used to disable network drivers.":::

    ```bash
    vi /etc/modprobe.d/disable.conf
    ```

>[!IMPORTANT]
> Please beware those are reserved words used to disable drivers, defined by the Linux Operating System, not by Microsoft.

>[!NOTE]
> Replace **_disable.conf_** with the corresponding file name where hv_netvsc is being disabled.

5.  Rebuild the initial ramdisk image for the currently loaded kernel:

    * For RHEL/SLES based images

    ```bash
    # dracut -f -v
    ```
    
    * For Ubuntu/Debian based images

    ```bash
    # mkinitramfs -k -o /boot/initrd.img-$(uname -r)
    ```

6. Reboot

> [!NOTE]
> Always take a backup of the original initial ramdisk image as a best practice to facilitate the rollback when needed.
>  ```bash
>   RHEL:
>   # cp /boot/initramfs-<kernelVersion>.img /boot/initramfs-<kernelVersion>.img.bak
>    
>   SLES:
>   # cp /boot/initrd-<kernelVersion> /boot/initrd-<kernelVersion>.bak
>
>   Ubuntu/Debian:
>   # cp /boot/initrd.img-<kernelVersion> /boot/initrd.img-<kernelVersion>.bak
>   ```


### <a id="reenable-hv_netvsc-offline"></a>**Enable the Hyper-V network driver using the Offline method**

Follow the steps below to resolve the issue using offline method:

1. Follow the [az vm repair](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) documentation to access the contents of the affected OS disk from a rescue virtual machine.
2. In order to correctly mount and chroot to the file systems of the attached OS disk in a rescue VM, follow the detailed [chroot instructions](./chroot-environment-linux.md) document.
3. Once the content of the affected OS disk is accessed, follow the steps 4 and 5 from[previous section](#reenable-hv_netvsc-offline) to reenable the drivers and rebuild the initial ramdisk image. Switching to chroot environment is necessary before rebuilding the initial ramdisk image. The full path of the image must be provided.

4. Once the changes are applied, `az vm repair restore` command can be used to perform automatic OS disk swap with the original VM and reboot the system.

## <a id="macaddress-issue"></a>Scenario 2: NIC MAC address has changed or doesn't match

Similar error logs can also be presented if the Network Interface Card MAC address has changed or doesn't match within the OS configuration. 

### Symptom

The symptoms are also identical. You won't be able SSH as the networking services are unavailable. You should still be able to log in via [serial console](./serial-console-overview.md) from the azure portal.

If the Hyper-V network driver is not disabled and the issue still persists, follow the steps below to validate the OS NIC configuration and resolve the issue:

### <a id="macaddress-mismatch-online"></a>**Fixing the NIC MAC address mismatch using the Serial Console method**

1. Access the serial console of the vm. The networking should be down but login prompt should still be available.
2. Log in to the vm with correct credentials.
3. Switch to the root account or use account with sudo access.
4. Go to `/etc/cloud/cloud.cfg.d` directory.
5. Considering [Linux partner images](/azure/virtual-machines/linux/endorsed-distros) are being used, open and edit the following files:
    * `91-azure_datasource.cfg` for RHEL based distribution.
    * `90_dpkg.cfg` for Debian and Ubuntu based distribution.
6. Set the `apply_network_config` parameter to `true`, if set to false. If nothing is specified, the default value it set to `true`. This setting will ensure that the new MAC address is applied to the networking config on the next reboot.
7. Generally, a NIC mac address would only change if there is NIC deletion/addition by the administrator or a NIC update in the backend. If network configuration via cloud-init is not desired and the `apply_network_config` parameter needs to be set to `false`, delete the `/var/lib/cloud/instance/obj.pkl` file and reboot the system.

```bash
# rm /var/lib/cloud/instance/obj.pkl
```

8. Once the changes are applied, restart the system.

### **Fixing the NIC MAC address mismatch using the Offline method**

Follow the steps below to resolve the issue using offline method:

1. Follow the [az vm repair](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) documentation to access the contents of the affected OS disk from a rescue virtual machine.
2. In order to correctly mount and chroot to the file systems of the attached OS disk in a rescue VM, follow the detailed [chroot instructions](./chroot-environment-linux.md) document.
3. Once the content of the copy of the affected OS disk is accessed, follow the steps 4 to 7 from the [serial console method](#macaddress-mismatch-online) section to make networking changes or clear the `obj.pkl` file.
4. Once the changes are applied, `az vm repair restore` command can be used to perform automatic OS disk swap with the original VM and reboot the system.

## <a id="hyperv-drivers-disabled"></a>Scenario 3: Other Hyper-V drivers disabled

If you're unable to SSH to a virtual machine and observe the following errors in the serial console or latest serial log within the [Boot Diagnostics](./boot-diagnostics.md) blade in the Azure portal, you've likely landed to other Hyper-V driver (hv_vmbus, hv_storvsc, hv_utils, etc.) associated issues:

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

OR

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

### Symptom:
You won't be able SSH as the networking services are unavailable. You'll also be dropped to a dracut shell. This can be viewed via [serial console](./serial-console-overview.md) from the azure portal.

### Enabling Hyper-V drivers

If the VM is inaccessible due to other Hyper-V drivers being disabled, an offline approach is required to reenable the drivers as the initramfs can't be loaded.
Follow the steps below to reenable the required drivers and resolve the issue:

1. Follow the [az vm repair](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md) documentation to access the contents of the problematic OS disk from a rescue virtual machine.
2. In order to correctly mount and chroot to the file systems of the attached OS disk in a rescue VM, follow the detailed [chroot instructions](./chroot-environment-linux.md) document.
3. After entering the chroot environment, to `/etc/modprobe.d` directory and look for any line that might be disabling the `hv_utils`, `hv_vmbus`, `hv_storvsc` and/or `hv_netvsc` drivers.
    1. Execute the following command to identify the file(s) that are disabling the `hv_utils`, `hv_vmbus`, `hv_storvsc` and/or `hv_netvsc` drivers, and the corresponding line number(s).

    ```bash
    egrep -nr "hv_utils|hv_vmbus|hv_storvsc|hv_netvsc" /etc/modprobe.d/
    ```

    2. Modify the corresponding file and comment out or delete the `hv_utils`, `hv_vmbus`, `hv_storvsc` and/or `hv_netvsc` entries. The entries will most commonly be any of the following (or both):

        :::image type="content" source="media/linux-hyperv-issue/hv_disabled-01.png" alt-text="Image shows the possible configuration file contents used to disable kernel modules/drivers using the install option.":::

        :::image type="content" source="media/linux-hyperv-issue/hv_disabled-02.png" alt-text="Image shows the possible configuration file contents used to disable kernel modules/drivers.":::

    ```bash
    vi /etc/modprobe.d/disable.conf
    ```

>[!IMPORTANT]
> Please beware those are reserved words used to disable drivers, defined by the Linux Operating System, not by Microsoft.

>[!NOTE]
> Replace **_disable.conf_** with the corresponding file name where the hyper-v drivers are being disabled.

4. Rebuild the initial ramdisk image for the currently loaded kernel:

    * For RHEL/SLES based images

    ```bash
    # dracut -f -v
    ```

    * For Ubuntu/Debian based images

    ```bash
    # mkinitramfs -k -o /boot/initrd.img-$(uname -r)
    ```

5. Once the changes are applied, `az vm repair restore` command can be used to perform automatic OS disk swap with the original VM and reboot the system.

> [!IMPORTANT]
> Always take a backup of the original initial ramdisk image as a best practice to facilitate the rollback if needed.

> [!NOTE]
> If the issue is still not resolved, follow the _How to recover an Azure Linux virtual machine getting stuck at dracut_ documentation to further investigate the cause and solution for dracut errors.
<!-- This article is in the process of getting published as well within few days, we will come back and add the link to the document when ready (PR)-->

## Next steps

In case the specific boot error isn't a GRUB rescue issue, refer to the [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
