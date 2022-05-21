---
title: Azure Serial Console for Linux | Microsoft Docs
description: Bi-Directional Serial Console for Azure Virtual Machines and Virtual Machine Scale Sets using a Linux example.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: linux
ms.topic: article
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure-services
ms.date: 5/1/2019
ms.author: genli
---

# Azure Serial Console for Linux

The Serial Console in the Azure portal provides access to a text-based console for Linux virtual machines (VMs) and virtual machine scale set instances. This serial connection connects to the ttys0 serial port of the VM or virtual machine scale set instance, providing access to it independent of the network or operating system state. The serial console can only be accessed by using the Azure portal and is allowed only for those users who have an access role of Contributor or higher to the VM or virtual machine scale set.

Serial Console works in the same manner for VMs and virtual machine scale set instances. In this doc, all mentions to VMs will implicitly include virtual machine scale set instances unless otherwise stated.

Serial Console is generally available in global Azure regions and in public preview in Azure Government. It is not yet available in the Azure China cloud.

For Serial Console documentation for Windows, see [Serial Console for Windows](./serial-console-windows.md).

> [!NOTE]
> Serial Console is currently incompatible with a managed boot diagnostics storage account. To use Serial Console, ensure that you are using a custom storage account.

## Prerequisites

- Your VM or virtual machine scale set instance must use the resource management deployment model. Classic deployments aren't supported.

- Your account that uses serial console must have the [Virtual Machine Contributor role](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) for the VM and the [boot diagnostics](boot-diagnostics.md) storage account

- Your VM or virtual machine scale set instance must have a password-based user. You can create one with the [reset password](/azure/virtual-machines/extensions/vmaccess#reset-password) function of the VM access extension. Select **Reset password** from the **Help** section.

- Your VM or virtual machine scale set instance must have [boot diagnostics](boot-diagnostics.md) enabled.

    :::image type="content" source="media/serial-console-linux/diagnostics-settings.png" alt-text="Screenshot of the Diagnostics settings page in Azure portal. The Boot diagnostics option is enabled.":::

- For settings specific to Linux distributions, see [Serial console Linux distribution availability](#serial-console-linux-distribution-availability).

- Your VM or virtual machine scale set instance must be configured for serial output on `ttys0`. This is the default for Azure images, but you will want to double check this on custom images. Details [below](#custom-linux-images).

> [!NOTE]
> The serial console requires a local user with a configured password. VMs or virtual machine scale sets configured only with an SSH public key won't be able to sign in to the serial console. To create a local user with a password, use the [VMAccess Extension](/azure/virtual-machines/extensions/vmaccess), which is available in the portal by selecting **Reset password** in the Azure portal, and create a local user with a password.
> You can also reset the administrator password in your account by [using GRUB to boot into single user mode](./serial-console-grub-single-user-mode.md).

## Serial Console Linux distribution availability

For the serial console to function properly, the guest operating system must be configured to read and write console messages to the serial port. Most [Endorsed Azure Linux distributions](/azure/virtual-machines/linux/endorsed-distros) have the serial console configured by default. Selecting **Serial console** in the **Help** section of the Azure portal provides access to the serial console.

> [!NOTE]
> If you are not seeing anything in the serial console, make sure that boot diagnostics is enabled on your VM. Hitting **Enter** will often fix issues where nothing is showing up in the serial console.

Distribution      | Serial console access
:-----------|:---------------------
Red Hat Enterprise Linux    | Serial console access enabled by default.
CentOS      | Serial console access enabled by default.
Debian      | Serial console access enabled by default.
Ubuntu      | Serial console access enabled by default.
CoreOS      | Serial console access enabled by default.
SUSE        | Newer SLES images available on Azure have serial console access enabled by default. If you're using older versions (10 or earlier) of SLES on Azure, see the [KB article](https://www.novell.com/support/kb/doc.php?id=3456486) to enable serial console.
Oracle Linux        | Serial console access enabled by default.

### Custom Linux images

To enable the serial console for your custom Linux VM image, enable console access in the file */etc/inittab* to run a terminal on `ttyS0`. For example: `S0:12345:respawn:/sbin/agetty -L 115200 console vt102`. You may also need to spawn a getty on ttyS0. This can be done with `systemctl start serial-getty@ttyS0.service`.

You will also want to add ttys0 as the destination for serial output. For more information on configuring a custom image to work with the serial console, see the general system requirements at [Create and upload a Linux VHD in Azure](/azure/virtual-machines/linux/create-upload-generic#general-linux-system-requirements).

If you're building a custom kernel, consider enabling these kernel flags: `CONFIG_SERIAL_8250=y` and `CONFIG_MAGIC_SYSRQ_SERIAL=y`. The configuration file is typically located in the */boot/* path.

## Common scenarios for accessing the Serial Console

Scenario          | Actions in the Serial Console
:------------------|:-----------------------------------------
Broken *FSTAB* file | Press the **Enter** key to continue and use a text editor to fix the *FSTAB* file. You might need to be in single user mode to do so. For more information, see the serial console section of [How to fix fstab issues](https://support.microsoft.com/help/3206699/azure-linux-vm-cannot-start-because-of-fstab-errors) and [Use serial console to access GRUB and single user mode](serial-console-grub-single-user-mode.md).
Incorrect firewall rules |  If you have configured iptables to block SSH connectivity, you can use serial console to interact with your VM without needing SSH. More details can be found at the [iptables man page](https://linux.die.net/man/8/iptables).<br>Similarly, if your firewalld is blocking SSH access, you can access the VM through serial console and reconfigure firewalld. More details can be found in the [firewalld documentation](https://firewalld.org/documentation/).
Filesystem corruption/check | Please see the serial console section of [Azure Linux VM cannot start because of file system errors](https://support.microsoft.com/en-us/help/3213321/linux-recovery-cannot-ssh-to-linux-vm-due-to-file-system-errors-fsck) for more details on troubleshooting corrupted file systems using serial console.
SSH configuration issues | Access the serial console and change the settings. Serial console can be used regardless of the SSH configuration of a VM as it does not require the VM to have network connectivity to work. A troubleshooting guide is available at [Troubleshoot SSH connections to an Azure Linux VM that fails, errors out, or is refused](./troubleshoot-ssh-connection.md). More details are available at [Detailed SSH troubleshooting steps for issues connecting to a Linux VM in Azure](./detailed-troubleshoot-ssh-connection.md)
Interacting with bootloader | Restart your VM from within the serial console blade to access GRUB on your Linux VM. For more details and distro-specific information, see [Use serial console to access GRUB and single user mode](serial-console-grub-single-user-mode.md).

## Disable the Serial Console

By default, all subscriptions have serial console access enabled. You can disable the serial console at either the subscription level or VM/virtual machine scale set level. For detailed instructions, visit [Enable and disable the Azure Serial Console](./serial-console-enable-disable.md).

## Serial console security

### Access security

Access to the serial console is limited to users who have an access role of [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) or higher to the virtual machine. If your Azure Active Directory tenant requires multi-factor authentication (MFA), then access to the serial console will also need MFA because the serial console's access is through the [Azure portal](https://portal.azure.com).

### Channel security

All data that is sent back and forth is encrypted on the wire.

### Data Storage and Encryption

Azure Serial Console does not review, inspect, or store any of the content which is transmitted in and out of the virtual machine serial port.  No data is stored, therefore there is no data to encrypt.  Additionally, [host-based encryption](/azure/virtual-machines/disk-encryption#encryption-at-host---end-to-end-encryption-for-your-vm-data) is used to ensure that any in-memory data paged to disk by virtual machines that run the service is also encrypted. This host-based encryption occurs for all Azure Serial Console connections and is enabled by default.

### Audit logs

All access to the serial console is currently logged in the [boot diagnostics](./boot-diagnostics.md) logs of the virtual machine. Access to these logs are owned and controlled by the Azure virtual machine administrator.

> [!CAUTION]
> No access passwords for the console are logged. However, if commands run within the console contain or output passwords, secrets, user names, or any other form of personally identifiable information (PII), those will be written to the VM boot diagnostics logs. They will be written along with all other visible text, as part of the implementation of the serial console's scroll back function. These logs are circular and only individuals with read permissions to the diagnostics storage account have access to them. If you are inputting any data or commands that contain secrets or PII, we would recommend using SSH unless serial console is absolutely necessary.

### Concurrent usage

If a user is connected to the serial console and another user successfully requests access to that same virtual machine, the first user will be disconnected and the second user connected to the same session.

> [!CAUTION]
> This means that a user who's disconnected won't be logged out. The ability to enforce a logout upon disconnect (by using SIGHUP or similar mechanism) is still on the roadmap. For Windows there is an automatic timeout enabled in Special Administrative Console (SAC); however, for Linux you can configure the terminal timeout setting. To do so, add `export TMOUT=600` in your *.bash_profile* or *.profile* file for the user you use to sign in to the console. This setting will time out the session after 10 minutes.

## Accessibility

Accessibility is a key focus for the Azure Serial Console. To that end, we've ensured that the serial console is fully accessible.

### Keyboard navigation

Use the **Tab** key on your keyboard to navigate in the serial console interface from the Azure portal. Your location will be highlighted on screen. To leave the focus of the serial console window, press **Ctrl**+**F6** on your keyboard.

### Use Serial Console with a screen reader

The serial console has screen reader support built in. Navigating around with a screen reader turned on will allow the alt text for the currently selected button to be read aloud by the screen reader.

## Known issues

We're aware of some issues with the serial console and the VM's operating system. Here's a list of these issues and steps for mitigation for Linux VMs. These issues and mitigations apply for both VMs and virtual machine scale set instances. If these don't match the error you're seeing, see the common serial console service errors at [Common Serial Console errors](./serial-console-errors.md).

Issue                           |   Mitigation
:---------------------------------|:--------------------------------------------|
Pressing **Enter** after the connection banner does not cause a sign-in prompt to be displayed. | GRUB may not be configured correctly. Run the following commands: `grub2-mkconfig -o /etc/grub2-efi.cfg` and/or `grub2-mkconfig -o /etc/grub2.cfg`. For more information, see [Hitting enter does nothing](https://github.com/Microsoft/azserialconsole/blob/master/Known_Issues/Hitting_enter_does_nothing.md). This issue can occur if you're running a custom VM, hardened appliance, or GRUB config that causes Linux to fail to connect to the serial port.
Serial console text only takes up a portion of the screen size (often after using a text editor). | Serial consoles do not support negotiating about window size ([RFC 1073](https://www.ietf.org/rfc/rfc1073.txt)), which means that there will be no SIGWINCH signal sent to update screen size and the VM will have no knowledge of your terminal's size. Install xterm or a similar utility to provide you with the `resize` command, and then run `resize`.
Pasting long strings doesn't work. | The serial console limits the length of strings pasted into the terminal to 2048 characters to prevent overloading the serial port bandwidth.
Erratic keyboard input in SLES BYOS images. Keyboard input is only sporadically recognized. | This is an issue with the Plymouth package. Plymouth should not be run in Azure as you don't need a splash screen and Plymouth interferes with the platform ability to use Serial Console. Remove Plymouth with `sudo zypper remove plymouth` and then reboot. Alternatively, modify the kernel line of your GRUB config by appending `plymouth.enable=0` to the end of the line. You can do this by [editing the boot entry at boot time](./serial-console-grub-single-user-mode.md#single-user-mode-in-suse-sles), or by editing the GRUB_CMDLINE_LINUX line in `/etc/default/grub`, rebuilding GRUB with `grub2-mkconfig -o /boot/grub2/grub.cfg`,  and then rebooting.

## Frequently asked questions

**Q. How can I send feedback?**

A. Provide feedback by creating a GitHub issue at  <https://aka.ms/serialconsolefeedback>. Alternatively (less preferred), you can send feedback via azserialhelp@microsoft.com or in the virtual machine category of <https://feedback.azure.com>.

**Q. Does the serial console support copy/paste?**

A. Yes. Use **Ctrl**+**Shift**+**C** and **Ctrl**+**Shift**+**V** to copy and paste into the terminal.

**Q. Can I use serial console instead of an SSH connection?**

A. While this usage may seem technically possible, the serial console is intended to be used primarily as a troubleshooting tool in situations where connectivity via SSH isn't possible. We recommend against using the serial console as an SSH replacement for the following reasons:

- The serial console doesn't have as much bandwidth as SSH. Because it's a text-only connection, more GUI-heavy interactions are difficult.
- Serial console access is currently possible only by using a username and password. Because SSH keys are far more secure than username/password combinations, from a sign-in security perspective, we recommend SSH over serial console.

**Q. Who can enable or disable serial console for my subscription?**

A. To enable or disable the serial console at a subscription-wide level, you must have write permissions to the subscription. Roles that have write permission include administrator or owner roles. Custom roles can also have write permissions.

**Q. Who can access the serial console for my VM/virtual machine scale set?**

A. You must have the Virtual Machine Contributor role or higher for a VM or virtual machine scale set to access the serial console.

**Q. My serial console isn't displaying anything, what do I do?**

A. Your image is likely misconfigured for serial console access. For information about configuring your image to enable the serial console, see [Serial console Linux distribution availability](#serial-console-linux-distribution-availability).

**Q. Is the serial console available for virtual machine scale sets?**

A. Yes, it is! See [Serial Console for Virtual Machine Scale Sets](serial-console-overview.md#serial-console-for-virtual-machine-scale-sets)

**Q. If I set up my VM or virtual machine scale set by using only SSH key authentication, can I still use the serial console to connect to my VM/virtual machine scale set instance?**

A. Yes. Because the serial console doesn't require SSH keys, you only need to set up a username/password combination. You can do so by selecting **Reset password** in the Azure portal and using those credentials to sign in to the serial console.

## Next steps

- Use the serial console to [access GRUB and single user mode](serial-console-grub-single-user-mode.md).
- Use the serial console for [NMI and SysRq calls](serial-console-nmi-sysrq.md).
- Learn how to use the serial console to [enable GRUB in various distros](serial-console-grub-proactive-configuration.md)
- The serial console is also available for [Windows VMs](./serial-console-windows.md).
- Learn more about [boot diagnostics](boot-diagnostics.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
