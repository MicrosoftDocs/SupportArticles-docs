---
title: Devices not working  before you log on a computer that is running Windows 10
description: Addresses an issue in which a device isn't working before a logon in Windows 10. For example, wireless doesn't connect until a user logon.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ajayps, arrenc, v-phoebh
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Devices are not working before you log on a computer that's running Windows 10

This article provides a solution to an issue in which devices are not working before you log on a computer that's running Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1709  
_Original KB number:_ &nbsp; 4057300

## Symptoms

Consider the following scenario:

- You have a computer that's running Windows 10, and the computer is joined to an Active Directory domain.
- The computer has BitLocker or device encryption enabled.
- You enable the **Disable new DMA devices when this computer is locked** policy on the computer. The **Disable new DMA devices when this computer is locked** policy locates in the following path:  
Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption

  > [!Note]
  To verify that the policy is set, you can also check the following registry key value:  
  **Path**: `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE`  
  **Value**: DisableExternalDMAUnderLock  
  **Type**: DWORD  
  The issue occurs when the value is set to **1**.

- You restart the computer.

In this scenario, Peripheral Component Interconnect (PCI) devices that have Bus Master Enabled (BME) set to **0** are not enumerated by the Operating System (OS) until a user successfully logs on. This is by design.

Additionally, after a user logs on, certain internal and external device classes may not work. These include but not limited to:

- Wired network adapters
- Wireless network adapters
- Audio devices
- Pointing devices including Touchpads

## Cause

This issue may occur in either of the following conditions:

1. The **Disable new DMA devices when this computer is locked** policy requires that the system firmware correctly set the BME bit for all internal devices during startup and disable the BME bit for all externally exposed PCI ports.

    When system firmware incorrectly clears the BME bit for internal devices during startup, those devices are blocked until a successful user logon.
2. Device drivers cannot handle the BME bit locked by the OS until a user logs on.

    The **Disable new DMA devices when this computer is locked** policy is applied intermittently on Windows 10 Version 1703 computers in specific scenarios. Windows 10, version 1709 computers consistently apply that policy, and this causes firmware or driver issues.

## More information

You may experience the following issues based on these conditions:

### When driver is correct, and firmware is correct

Internal devices work before and after startup. External PCI devices are correctly blocked until a user logs on.

### When driver is correct, and firmware is incorrect

Devices are blocked before a logon but work after a logon. Both internal and external devices that have BME set to **0** are blocked before a logon. After a logon, drivers enumerate correctly.

### When driver is incorrect, and firmware is correct

External devices might not work after a logon.

### When driver is incorrect, and firmware is incorrect

Internal devices initially blocked by firmware either don't properly enumerate or malfunction after a successful user logon.

## Resolution

To fix this issue, install [April 23, 2018-KB4093105](https://support.microsoft.com/help/4093105/windows-10-update-kb4093105) (OS Build 16299.402).

## Workaround

To work around this problem, configure the **Disable new DMA devices when this computer is locked** to **Not Configured** to disable it on affected system models before you update drivers and firmware.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
