---
title: Troubleshooting macOS virtual machine enrollment in Intune
description: Troubleshooting guidance to help resolve errors when you enroll macOS virutal machines in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
ms.custom: sap:Enroll Devices - macOS\Advisory
---

# Troubleshoot macOS virtual machine enrollment in Microsoft Intune

This article helps Intune administrators troubleshoot common errors when enrolling macOS virtual machines in Microsoft Intune. See [Troubleshoot device enrollment in Microsoft Intune](troubleshoot-device-enrollment-in-intune.md) for additional, general troubleshooting scenarios.  

When you try to enroll a macOS virtual machine, you might see one of the following error messages:

- It looks like you're using a virtual machine. Make sure you've fully configured your virtual machine, including serial number and hardware model. If this isn't a virtual machine, please contact support.  
- We're having trouble getting your device managed. This problem could be caused if you're using a virtual machine, have a restricted serial number, or if this device is already assigned to someone else. Learn how to resolve these problems or contact your company support.

## Cause

This message can indicate any of the following issues:

- A macOS virtual machine (VM) isn't configured correctly  
- You've enabled device restrictions that require the device to be corporate-owned or have a registered device serial number in Intune  
- The device has already been enrolled and is still assigned to someone else in Intune  

## Solution

First, check with your user to determine which of the issues affects their device. Then complete the most relevant of the following solutions:

- If the user is enrolling a VM for testing, make sure it's been fully configured so that Intune can recognize its serial number and hardware model. Learn more about how to [set up VMs](/mem/intune/enrollment/macos-enroll#enroll-virtual-macos-machines-for-testing) in Intune.
- If your organization turned on enrollment restrictions that block personal macOS devices, you must manually [add the personal device's serial number](/mem/intune/enrollment/corporate-identifiers-add#manually-enter-corporate-identifiers) to Intune.  
- If the device is still assigned to another user in Intune, its former owner did not use the Company Portal app to remove or reset it. To clean up the stale device record from Intune:  

    1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), sign in with your administrative credentials.
    2. Choose **Devices** > **All devices**.  
    3. Find the device with the enrollment problem. Search by device name or MAC/HW Address to narrow your results.
    4. Select the device > **Delete**. Delete all other entries associated with the device.  
