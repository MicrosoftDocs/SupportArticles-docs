---
title: Azure Serial Console Proactive GRUB Configuration
description: Configure GRUB across various distributions to enable single user and recovery mode access in Azure virtual machines.
services: virtual-machines
documentationcenter: ''
author: mimckitt
manager: dcscontentpm
tags: azure-resource-manager
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.service: azure-virtual-machines
ms.collection: linux
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure-services
ms.date: 07/10/2019
ms.author: mimckitt
---

# How to configure GRUB and SysRq across multiple Azure VMs

**Applies to:** :heavy_check_mark: Linux VMs

You can improve the recovery times of your IaaS Linux virtual machine (VM) in most cases by having access to the Serial Console and the Grand Unified Bootloader (GRUB). GRUB offers faster recovery of your VM than other options can provide.

You might have to perform a VM recovery for any of the following reasons:

- Corrupted file system, kernel, or MBR (Master Boot Record)
- Failed kernel upgrades
- Incorrect GRUB kernel parameters
- Incorrect fstab configuration
- Firewall configuration
- Lost password
- Mangled sshd configurations files
- Networking configuration

Many other scenarios as detailed [here](./serial-console-linux.md#common-scenarios-for-accessing-the-serial-console).

Verify that you can access GRUB and the Serial Console on your VMs that are deployed in Azure.

If you're a new user of the Serial Console, refer to [this article](./serial-console-linux.md).

> [!TIP]
> Back up your files before you make changes.

The following video demonstrates how you can quickly recover your Linux VM after you have access to GRUB.

[Recover Linux VM Video](https://youtu.be/KevOc3d_SG4)

There are several methods to improve recovery of Linux VMs. In a Cloud environment, this process has been challenging. We're continually updating our tooling and program features to improving the recovery time for services.

By using the Azure Serial Console, you can interact with your Linux VM as if you were at a system's console. You can manipulate many configuration files and processes, including how the kernel starts up.

The more experienced Linux or Unix sysstem admins will appreciate the **single user** and  **emergency** modes that are accessible through the Azure Serial Console. These features make Disk Swap and VM deletion operations redundant for many recovery scenarios.

The method of recovery depends on the problem that you experience. For example, a lost or misplaced password can be reset through Azure portal options by using **Reset Password**. The **Reset Password** feature is known as an *extension*. The feature communicates with the Linux Guest agent.

Other extensions, such as Custom Script, are available. However, these options require that the Linux **waagent** is running and in a healthy state.

:::image type="content" source="media/serial-console-grub-proactive-configuration/agent-status.png" alt-text="Screenshot of the Agent status in the Properties page in Azure portal.":::

If you have access to the Azure Serial Console and GRUB, you can manage a password change or fix an incorrect configuration in minutes instead of hours. In the scenario in which your primary kernel becomes corrupted, you could even force the VM to start from an alternative kernel, if you have multiple kernels on the disk.

:::image type="content" source="media/serial-console-grub-proactive-configuration/more-kernel.png" alt-text="Screenshot of the selected OS startup screen in GRUB showing multiple kernels that can be chosen.":::

## Suggested order of recovery methods

- Azure Serial Console

- [Disk Swap](/azure/virtual-machines/windows/os-disk-swap)

- Legacy Method

## Disk swap video

If you don't have access to GRUB, watch [this video](https://youtu.be/m5t0GZ5oGAc) to see how you can easily automate the disk swap procedure to recover your VM.

## Challenges

By default, not all Linux Azure VMs are configured for GRUB access or to be interrupted by the SysRq commands. Some older distros, such as LES 11, aren't configured to display a sign-in prompt in the Azure Serial Console. The following sections review various Linux distributions and discuss configurations that make GRUB available.

## How to configure Linux VM to accept SysRq keys

By default, the SysRq key is enabled on some newer Linux distros. On other distros, it might be configured for accepting values only for certain SysRq functions.
On older distros, it might be disabled completely.

The SysRq feature is useful for rebooting a crashed or non-responding VM directly from the Azure Serial Console. It's also helpful to gain access to the GRUB menu. Aalternatively restarting a VM from another portal window or SSH session might drop your current console connection and end GRUB time-outs that used to display the GRUB menu.

The VM must be configured to accept a value of **1** for the kernel parameter. This setting enables all functions of SysRq or 128, which enables restart and power off processes.

[Enable SysRq video](https://youtu.be/0doqFRrHz_Mc)

To configure the VM to accept a restart through a SysRq commands on the Azure portal, you have to set a value of **1** for the kernel parameter, kernel.sysrq. For this configuration to persist a restart, add an entry to the **Sysctl.conf** file:

`echo kernel.sysrq = 1 >> /etc/sysctl.conf`

To configure the kernel parameter dynamically, run the following command:

`sysctl -w kernel.sysrq=1`

If you don't have **root** access, or if sudo is broken, you can't configure SysRq from a shell prompt. In this case, you can enable SysRq by using the Azure portal feature, **Operations** > **Run Command** > **RunShellScript**. This method can be beneficial if the **sudoers.d/waagent** file is broken or was deleted. This feature requires that the waagent process is healthy. You can inject this command to enable SysRq, as follows:

`sysctl -w kernel.sysrq=1 ; echo kernel.sysrq = 1 >> /etc/sysctl.conf`

The following screenshot shows this command in use.

:::image type="content" source="media/serial-console-grub-proactive-configuration/run-command-script.png" alt-text="Screenshot of the RunShellScript window when you inject the command.":::

If you then try to access **sysrq**, you should see that a restart is possible.

:::image type="content" source="media/serial-console-grub-proactive-configuration/send-sysrq-command.png" alt-text="Screenshot of the Send SysRq Command option under the keyboard icon in the button bar.":::

Select **Reboot** and **Send SysRq** Command

:::image type="content" source="media/serial-console-grub-proactive-configuration/reboot.png" alt-text="Screenshot of the Reboot option in the Send SysRq Command to Guest dialog.":::

The system should log a reset message that resembles the message in the following screenshot.

:::image type="content" source="media/serial-console-grub-proactive-configuration/retting-log.png" alt-text="Screenshot of the reset message log in the command-line interface.":::

## Ubuntu GRUB configuration

By default, you should be able to access GRUB by holding the **Esc** key during the VM restart. If the GRUB menu doesn't appear, you can force the GRUB menu to appear and stay on screen in the Azure Serial Console by using one of the following options.

**Option 1:** Forces GRUB to be displayed on screen

Update the file /etc/default/grub.d/50-cloudimg-settings.cfg to keep the GRUB menu on screen for the specified TIMEOUT period. You aren't required to press Esc because GRUB is displayed immediately.

```console
GRUB_TIMEOUT=5
GRUB_TIMEOUT_STYLE=menu
```

**Option 2**: Enable Esc to be pressed before a restart

You can experience similar behavior by making changes to the /etc/default/grub file, and then observing a three-second timeout before you press Esc. Comment out these two lines:

```console
#GRUB_HIDDEN_TIMEOUT=0
#GRUB_HIDDEN_TIMEOUT_QUIET=true
```

Then, add the following line:

```console
GRUB_TIMEOUT_STYLE=countdown
```

## Ubuntu 12\.04

Ubuntu 12.04 allows access to the serial console but doesn't offer the ability to interact. A **login:** prompt isn't displayed.

For Ubuntu 12.04 to obtain a **login:** prompt, follow these steps:

1. Create a file that's named /etc/init/ttyS0.conf and that contains the following text:

    ```console
    # ttyS0 - getty
    #
    # This service maintains a getty on ttyS0 from the point the system is
    # started until it is shut down again.
    start on stopped rc RUNLEVEL=[12345]
    stop on runlevel [!12345]
    
    respawn
    exec /sbin/getty -L 115200 ttyS0 vt102
    ```  

2. Ask upstart to start the getty:

    ```console
    sudo start ttyS0
    ```

For the required settings that you need to configure the serial console for Ubuntu versions, see the [SerialConsoleHowto](https://help.ubuntu.com/community/SerialConsoleHowto) Ubuntu documentation.

## Ubuntu Recovery mode

Additional recovery and clean-up options are available for Ubuntu through GRUB. However, these settings are accessible only if you configure kernel parameters accordingly.
If you don't configure the kernel boot parameter, the Recovery menu is automatically sent to the Azure Diagnostics component and not to the Azure Serial Console. To get access to the Ubuntu Recovery menu, follow these steps:

1. Interrupt the startup process, and access the GRUB menu.

1. Select **Advanced Options for Ubuntu**, and press Enter.

:::image type="content" source="media/serial-console-grub-proactive-configuration/advanced-option-ubuntu.png" alt-text="Screenshot of the Serial console that shows Advanced options for Ubuntu selected.":::

1. Select the line that displays *(recovery mode)*, and press the E key (not Enter).

:::image type="content" source="media/serial-console-grub-proactive-configuration/recovery-mode-ubuntu.png" alt-text="Screenshot that shows the Serial console and a recovery mode version selected.":::

1. Locate the line that loads the kernel. Replace the last parameter, **nomodeset**, with the destination, as **console=ttyS0**:

```console
linux /boot/vmlinuz-4.15.0-1023-azure root=UUID=21b294f1-25bd-4265-9c4e-d6e4aeb57e97 ro recovery nomodeset

change to

linux /boot/vmlinuz-4.15.0-1023-azure root=UUID=21b294f1-25bd-4265-9c4e-d6e4aeb57e97 ro recovery console=ttyS0
```

:::image type="content" source="media/serial-console-grub-proactive-configuration/change-value-ubuntu.png" alt-text="Screenshot that shows the Serial console and the changed value.":::

1. To start and load the kernel, Press **Ctrl-x**.

If all goes well, the Recovery menu now displays additional options that can help you perform other recovery options.

:::image type="content" source="media/serial-console-grub-proactive-configuration/additional-recovery-options-ubuntu.png" alt-text="Screenshot that shows the Serial console at the Recovery menu that offers additional recovery options.":::

## Red Hat GRUB configuration

### Red Hat 7\.4\+ GRUB configuration

The default /etc/default/grub configuration on these versions is adequately configured

```console
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL="serial console"
GRUB_SERIAL_COMMAND="serial"
GRUB_CMDLINE_LINUX="console=tty1 console=ttyS0 earlyprintk=ttyS0"
GRUB_DISABLE_RECOVERY="true"
```

Enable the SysRq key

```console
sysctl -w kernel.sysrq=1;echo kernel.sysrq = 1 >> /etc/sysctl.conf;sysctl -a | grep -i sysrq
```

### Red Hat 7\.2 and 7\.3 GRUB configuration

The file to modify is /etc/default/grub – a default config looks like this example:

```console
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="console=tty1 console=ttyS0 earlyprintk=ttyS0"
GRUB_DISABLE_RECOVERY="true"
```

Change the following lines in /etc/default/grub

```console
GRUB_TIMEOUT=1 

to

GRUB_TIMEOUT=5
```

```console
GRUB_TERMINAL_OUTPUT="console"

to

GRUB_TERMINAL="serial console"
```

Also add this line:

```console
GRUB_SERIAL_COMMAND="serial –speed=115200 –unit=0 –word=8 –parity=no –stop=1″
```

/etc/default/grub should now look similar to this example:

```console
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL="serial console"
GRUB_CMDLINE_LINUX="console=tty1 console=ttyS0 earlyprintk=ttyS0"
GRUB_DISABLE_RECOVERY="true"
```

Complete and update grub configuration using

`grub2-mkconfig -o /boot/grub2/grub.cfg`

Set the SysRq kernel parameter:

`sysctl -w kernel.sysrq = 1;echo kernel.sysrq = 1 >> /etc/sysctl.conf;sysctl -a | grep -i sysrq`

Alternatively, you can configure GRUB and SysRq by using a single line, either in the shell or through the Run Command. Back up your files before you run this command:

`cp /etc/default/grub /etc/default/grub.bak; sed -i 's/GRUB_TIMEOUT=1/GRUB_TIMEOUT=5/g' /etc/default/grub; sed -i 's/GRUB_TERMINAL_OUTPUT="console"/GRUB_TERMINAL="serial console"/g' /etc/default/grub; echo "GRUB_SERIAL_COMMAND=\"serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1\"" >> /etc/default/grub;grub2-mkconfig -o /boot/grub2/grub.cfg;sysctl -w kernel.sysrq=1;echo kernel.sysrq = 1 /etc/sysctl.conf;sysctl -a | grep -i sysrq`

### Red Hat 6\.x GRUB configuration

The file to modify is /boot/grub/grub.conf. The `timeout` value will determine how long GRUB is shown for.

```console
#boot=/dev/vda
default=0
timeout=15
splashimage=(hd0,0)/grub/splash.xpm.gz
#hiddenmenu
serial --unit=0 --speed=9600
terminal serial
terminal --timeout=5 serial console
```

The last line  *terminal –-timeout=5 serial console* will further increase **GRUB** timeout by adding a prompt of 5 seconds displaying **Press any key to continue.**

:::image type="content" source="media/serial-console-grub-proactive-configuration/press-any-key-to-continue.png" alt-text="Screenshot shows a console with output.":::

GRUB menu should appear on-screen for the configured timeout=15 without the need to press Esc. Make sure to click in the Console in the Browser to make active the menu and select the required kernel.

:::image type="content" source="media/serial-console-grub-proactive-configuration/select-kernel.png" alt-text="Screenshot shows a console with two Linux options.":::

## SuSE

### SLES 12 sp1

Either use YaST bootloader as per the official [docs](./serial-console-grub-single-user-mode.md#grub-access-in-suse-sles)

Or add/change to /etc/default/grub the following parameters:

```console
GRUB_TERMINAL=serial
GRUB_TIMEOUT=5
GRUB_SERIAL_COMMAND="serial --unit=0 --speed=9600 --parity=no"

```console
Verify that ttys0 is used in the GRUB_CMDLINE_LINUX or GRUB_CMDLINE_LINUX_DEFAULT

```console
GRUB_CMDLINE_LINUX_DEFAULT="console=ttyS0,9600n"
```

Recreate the grub.cfg

`grub2-mkconfig -o /boot/grub2/grub.cfg`

### SLES 11 SP4

The Serial Console appears and displays boot messages but doesn't display a **login:** prompt

Open an ssh session into the VM and update the file **/etc/inittab** by un-commenting this line:

```console
#S0:12345:respawn:/sbin/agetty -L 9600 ttyS0 vt102
```

Next run the command

`telinit q`

To enable GRUB, the following changes should be made to /boot/grub/menu.lst

```console
timeout 5
serial --unit=0 --speed=9600 --parity=no
terminal --timeout=5 serial console

root (hd0,0)
kernel /boot/vmlinuz-3.0.101-108.74-default root=/dev/disk/by-uuid/ab6b62bb--
1a8c-45eb-96b1-1fbc535b9265 disk=/dev/sda  USE_BY_UUID_DEVICE_NAMES=1 earlyprinttk=ttyS0 console=ttyS0 showopts vga=0x314
```

 This configuration will enable the message **Press any key to continue** to appear on the console for 5 seconds

It will then display the GRUB menu for an additional 5 seconds - by pressing the down arrow you will interrupt the counter and  select a kernel you want to boot either append the keyword **single** for single user mode that requires root password to be set.

Appending the command **init=/bin/bash** will load the kernel but ensures that the init program is replaced by a bash shell.

You will gain access to a shell without having to enter a password. You can then proceed to update password for Linux accounts or make other configuration changes.

## Force the kernel to a bash prompt

Having access to GRUB allows you to interrupt the initialization process this interaction is useful for many recovery procedures.
If you don't have root password and single user requires you to have a root password, you can boot the kernel replacing the init program with a bash prompt – this interrupt can be achieved by appending init=/bin/bash to the kernel boot line

:::image type="content" source="media/serial-console-grub-proactive-configuration/bash-kernel-boot.png" alt-text="Screenshot shows a console with the updated boot line.":::

Remount your / (root) file system RW using the command

`mount -o remount,rw /`

:::image type="content" source="media/serial-console-grub-proactive-configuration/bash-remount.png" alt-text="Screenshot shows a console with a re-mount action.":::

Now you can perform a root password change or other Linux configuration change.

:::image type="content" source="media/serial-console-grub-proactive-configuration/bash-change-password.png" alt-text="Screenshot shows a console where you can change root password and other configuration.":::

Restart the VM by running the following command:

`/sbin/reboot -f`

## Single User mode

Alternatively, you might have to access the VM in Single User or Emergency mode. Select the kernel that you want to start or interrupt by using the arrow keys. Enter the desired mode by appending the keyword **single** or **1** to the kernel boot line. On RHEL systems, you can also append **rd.break**.

For more information about how to access Single User mode, see [Use Serial Console to access GRUB and single-user mode](./serial-console-grub-single-user-mode.md#general-single-user-mode-access)

:::image type="content" source="media/serial-console-grub-proactive-configuration/single-user-ubuntu.png" alt-text="Screenshot of the *Ubuntu entry in the boot the selected OS screen in GRUB.":::

## Next steps

Learn more about [Azure Serial Console](./serial-console-linux.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
