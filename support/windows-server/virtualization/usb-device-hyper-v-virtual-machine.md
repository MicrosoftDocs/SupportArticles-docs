---
title: YubiKey USB Device Doesn't Appear in a Hyper-V Virtual Machine
description: Resolves an issue where a YubiKey USB device doesn't appear in a Hyper-V VM. Provides guidance on using a YubiKey USB device for hardware encryption in a Hyper-V VM.
ms.date: 09/09/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-lianna
ms.custom:
- sap:virtualization and hyper-v\installation and configuration of hyper-v
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# YubiKey USB device doesn't appear in a Hyper-V virtual machine

This article helps resolve an issue where a YubiKey USB device doesn't appear in a Hyper-V virtual machine (VM) and provides guidance on using a YubiKey USB device for hardware encryption in a Hyper-V VM. It explains how to achieve USB passthrough in Hyper-V, a feature not natively supported, and offers alternative methods to enable this functionality.

> [!NOTE]
> Before proceeding, confirm:
>
> * You have administrative access to both the Hyper-V host and the VM.
> * The YubiKey USB device is connected to the Hyper-V host.
> * The VM is running an operating system that supports YubiKey.
> * Remote Desktop Protocol (RDP) is enabled on the VM if you use the RDP method.

When you use Hyper-V, a YubiKey USB device doesn't appear in the VM or can't be accessed, even though it's connected to the Hyper-V host.

## Hyper-V doesn't natively support USB passthrough to VMs

This issue occurs because Hyper-V doesn't include built-in support for USB passthrough. This limitation prevents VMs from being directly accessing USB devices connected to the host. If you're accustomed to this functionality on other virtualization platforms, such as VMware, you might need clarification on how to achieve similar results in Hyper-V.

## Resolution 1: Use Enhanced Session Mode

Enhanced Session Mode enables interaction between the host and the VM, allowing USB devices to be redirected to the VM. To use Enhanced Session Mode, follow these steps:

1. Open **Hyper-V Manager** on the host.
2. Select the Hyper-V host in the left-hand pane.
3. In the right-hand pane, select **Hyper-V Settings**.
4. Under **Server**, ensure that **Enhanced Session Mode Policy** is enabled.
5. Under **User**, ensure that **Enhanced Session Mode** is enabled.
6. Start the VM you want to connect the YubiKey to.
7. Once the VM is running, open it in Enhanced Session Mode:

   1. Close the VM window if it's already open.
   2. Reconnect to the VM and select **Show Options**.
   3. Navigate to the **Local Resources** tab.
   4. Under **Local devices and resources**, select **More**.
   5. Expand the **Other supported Plug and Play (PnP) devices** section and select the YubiKey device.
   6. Select **OK** and reconnect to the VM.

The YubiKey should now be accessible in the VM.

## Resolution 2: Use RDP

RDP allows USB devices connected to the host to be redirected to the VM. To use RDP, follow these steps:

1. Configure the VM to allow RDP connections:

   1. Sign in to the VM and enable Remote Desktop in the system settings.
   2. Allow the necessary firewall rules for Remote Desktop.

2. From the Hyper-V host, open the **Remote Desktop Connection** application.
3. In the RDP connection window, select **Show Options**.
4. Navigate to the **Local Resources** tab.
5. Under **Local devices and resources**, select **More**.
6. Expand the **Other supported Plug and Play (PnP) devices** section and select the YubiKey device.
7. Select **OK** and connect to the VM using RDP.

Once connected via RDP, the YubiKey will be redirected and available in the VM.

If neither solution resolves the issue, consider the following points:

* Verify that the YubiKey is supported by the VM's operating system.
* Ensure that the USB device is functioning correctly on the host machine.
* Check for any additional configuration requirements specific to the YubiKey model.

For further assistance, consult the YubiKey documentation or contact Microsoft Support.
