---
title: The USB Peripheral Power Drain status of a Teams Rooms device is Unhealthy
description: Resolves an issue that causes the USB Peripheral Power Drain signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: rebenite
ms.topic: troubleshooting
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI171525
---
# The USB Peripheral Power Drain status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **USB Peripheral Power Drain** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**. Additionally, users might experience the following issue:

When the Teams Rooms device goes to sleep and is woken up, USB devices that are connected to it become unresponsive or disconnected.

> [!NOTE]  
> Incidents that are classified as **Warning** don't affect the health status that's reported for a device.

## Cause

This issue occurs if the **Stop devices when my screen is off to help save battery** setting is enabled on the Teams Rooms device.

Every new Teams Rooms device includes a Windows configuration that specifies whether to stop the connected USB devices when the screen is off. By default, this setting is set to disabled. However, it might sometimes be changed.

When Windows goes into a lower power state while the *Stop devices when my screen is off* setting is enabled, it will keep track of any persistent USB communications. In this situation, if Windows sees that one or more USB peripherals have been idle for a long time, preventing the device from entering a deeper power state (a condition in which a USB peripheral drains the device's battery), Windows will issue a USB device reset. While this behavior shouldn't apply to any Teams Rooms devices that are always plugged into AC power, it's known to cause issues in the past, such as unexpected USB disconnections that cause the device's firmware or mishandled drivers to become unresponsive. Therefore, if this setting is enabled, the Teams Rooms Pro agent detects and reports the status of **USB Peripheral Power Drain** as **Unhealthy**.

## Resolution

Microsoft Teams Rooms Pro performs an automatic remediation to fix this issue. However, if the issue persists, use one of the following methods, depending on how the Teams Rooms device is configured.

### Method 1: Use Windows PowerShell

Run the following command in Windows PowerShell:

```powershell
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\USB\AutomaticSurpriseRemoval' -Name AttemptRecoveryFromUsbPowerDrain -Value 0 -ErrorAction Stop
```

### Method 2: Use Registry Editor

1. Open Registry Editor.
1. Locate the following subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\USB\AutomaticSurpriseRemoval`
1. Right-click **AttemptRecoveryFromUsbPowerDrain**, select **Modify**, change **Value data** to **0**, and then select **OK**.


### Method 3: Use Microsoft Intune to deploy a PowerShell script to devices

1. Save the following command as *USBREM.ps1*:

   ```powershell
   Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\USB\AutomaticSurpriseRemoval' -Name AttemptRecoveryFromUsbPowerDrain -Value 0 -ErrorAction Stop
   ```

1. [Create a script policy (add the script to script settings), and assign the policy to groups](/mem/intune/apps/intune-management-extension#create-a-script-policy-and-assign-it).
