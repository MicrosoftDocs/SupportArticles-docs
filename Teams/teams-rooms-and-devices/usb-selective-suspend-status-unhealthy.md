---
title: The USB Selective Suspend status of a Teams Rooms device is Unhealthy
description: Resolves an issue that causes the USB Selective Suspend signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: rebenite
ms.topic: troubleshooting
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI171350
---
# The USB Selective Suspend status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **USB Selective Suspend** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**. Additionally, users might experience the following issue:

When the Teams Rooms device goes to sleep and is woken up, USB devices that are connected to it become unresponsive or disconnected.

> [!NOTE]  
> Incidents that are classified as **Warning** don't affect the health status that's reported for a device.

## Cause

This issue occurs if USB selective suspend is enabled on the Teams Rooms device.

Every new Teams Rooms device includes a Windows configuration to specify the power plan and how the connected USB devices are to behave, depending on the power supply (AC or DC). By default, USB selective suspend is disabled. However, it might sometimes be changed. In this case, the Teams Rooms Pro agent detects and reports the status of **USB Selective Suspend** as **Unhealthy**.

## Resolution

Teams Rooms Pro performs an automatic remediation to fix this issue. However, if the issue persists, use one of the following methods, depending on how the Teams Rooms device is configured.

### Method 1: Use a Command Prompt window

Run the following command at a command prompt:

```console
powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
```

### Method 2: Use the Control Panel

1. Select the **Start** icon, type *edit power plan* in the Search box, and then select **Edit power plan** from the results.
2. On the **Change settings for the plan** page, select **Change advanced power settings**.
3. Expand **USB settings** > **USB selective suspend setting**.
4. Set the **Plugged in** setting to **Disabled**, select **Apply**, and then select **OK** to save the change.

### Method 3: Use Microsoft Intune to deploy a PowerShell script to devices

1. Save the following command as *USBREM.ps1*:

   ```powershell
   powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
   ```

1. [Create a script policy (add the script to script settings), and assign the policy to groups](/mem/intune/apps/intune-management-extension#create-a-script-policy-and-assign-it).
