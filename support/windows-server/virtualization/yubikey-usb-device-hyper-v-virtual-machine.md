---
title: Using a YubiKey USB device in a Hyper-V virtual machine
description: Provides guidance on using a YubiKey USB device for hardware encryption in a Hyper-V virtual machine (VM).
ms.date: 08/14/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-lianna
ms.custom:
- sap:virtualization and hyper-v\installation and configuration of hyper-v
- pcy:WinComm Storage High Avail
---
# Using a YubiKey USB device in a Hyper-V virtual machine

This article provides guidance on using a YubiKey USB device for hardware encryption in a Hyper-V virtual machine (VM). It explains how to achieve USB passthrough in Hyper-V, a feature that is not natively supported, and provides alternative methods to enable this functionality.

## Prerequisites

Before proceeding, ensure the following:

* You have administrative access to both the Hyper-V host and the VM.
* The YubiKey USB device is connected to the Hyper-V host.
* The VM is running an operating system that supports the YubiKey.
* Remote Desktop Protocol (RDP) is enabled on the VM if using the RDP method.

## Symptoms

When using Hyper-V, you may encounter the following issue:

* The USB device (YubiKey) does not appear in the VM or cannot be accessed, even though it is connected to the Hyper-V host.

This occurs because Hyper-V does not natively support USB passthrough to virtual machines.

## Cause

Hyper-V does not include built-in support for USB passthrough. This limitation prevents USB devices connected to the host from being directly accessed by the VM. Users who are accustomed to this functionality in other virtualization platforms, such as VMware, may need clarification on how to achieve similar results in Hyper-V.

## Solution 1: Using Enhanced Session Mode

Enhanced Session Mode enables interaction between the host and the VM, allowing USB devices to be redirected to the VM.

1. Open **Hyper-V Manager** on the host.
2. Select the Hyper-V host in the left-hand pane.
3. In the right-hand pane, click **Hyper-V Settings**.
4. Under **Server**, ensure that **Enhanced Session Mode Policy** is enabled.
5. Under **User**, ensure that **Enhanced Session Mode** is enabled.
6. Start the VM you want to connect the YubiKey to.
7. Once the VM is running, open it in Enhanced Session Mode:

   * Close the VM window if it is already open.
   * Reconnect to the VM and select **Show Options**.
   * Navigate to the **Local Resources** tab.
   * Under **Local devices and resources**, click **More**.
   * Expand the **Other supported Plug and Play (PnP) devices** section and select the YubiKey device.
   * Click **OK** and reconnect to the VM.

The YubiKey should now be accessible in the VM.

## Solution 2: Using Remote Desktop Protocol (RDP)

RDP allows USB devices connected to the host to be redirected to the VM.

1. Configure the VM to allow RDP connections:

   * Log in to the VM and enable Remote Desktop in the system settings.
   * Allow the necessary firewall rules for Remote Desktop.

2. From the Hyper-V host, open the **Remote Desktop Connection** application.
3. In the RDP connection window, click **Show Options**.
4. Navigate to the **Local Resources** tab.
5. Under **Local devices and resources**, click **More**.
6. Expand the **Other supported Plug and Play (PnP) devices** section and select the YubiKey device.
7. Click **OK** and connect to the VM using RDP.

Once connected via RDP, the YubiKey will be redirected and available in the VM.

## Determine the cause of the problem

If neither solution resolves the issue, consider the following:

* Verify that the YubiKey is supported by the VM's operating system.
* Ensure that the USB device is functioning correctly on the host machine.
* Check for any additional configuration requirements specific to the YubiKey model.

By following the steps outlined in this article, you can enable the use of a YubiKey USB device in a Hyper-V virtual machine. For further assistance, consult the YubiKey documentation or contact Microsoft Support.
