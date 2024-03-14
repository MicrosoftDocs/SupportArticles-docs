---
title: The CPU performance limited status of a Teams Rooms device is Unhealthy
description: Resolves an issue that causes the CPU performance limited signal of a Microsoft Teams Rooms device to appear as Unhealthy.
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
ms.custom: 
  - CI177322
---
# The CPU performance limited status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **CPU performance limited** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**.

> [!NOTE]  
> Incidents that are classified as **Warning** don't affect the health status that's reported for a device.

## Cause

This issue occurs if the following power setting on the Teams Rooms device is set to a value that's less than 100 percent:

**Power Options** > **Advanced settings** > **Processor power management** > **Maximum processor state** > **Plugged in**

Every Teams Rooms device includes a Windows configuration that specifies whether to limit the processor's maximum performance state. By default, this setting is set to **100%**. This means that no limit is applied. However, the setting might sometimes be changed by your organization in one of the following ways:

- Through Group Policy Objects (GPO)
- Through Mobile Device Management (MDM) policies
- Manually by administrators

If this setting is set to a value that's less than 100 percent, it might affect overall processor performance during peak hours and also affect the ability of Teams Rooms to handle the full processing load. In this case, the Teams Rooms Pro agent detects and reports the status of **CPU performance limited** as **Unhealthy**.

## Resolution

Microsoft Teams Rooms Pro performs an automatic remediation to fix this issue. However, if the issue persists or reoccurs, we recommend that you check whether any GPO or MDM policies are defined to change power plan settings. In these cases, use one of the following options:

- [Use the Suppress ticket functionality](/microsoftteams/rooms/managed-meeting-rooms-portal#room-detail-status-and-changes) to silence any notification about the **CPU performance limited** signal.
- If your organization uses GPO, MDM policies, or other management tools such as Configuration Manager for enterprise power plan management, make sure that the power setting isn't changed to a value that's less than 100 percent.

Additionally, use one of the following methods to set the value to 100 percent, depending on how the Teams Rooms device is configured.

### Method 1: Use a Command Prompt window

Run the following command at a command prompt:

```console
powercfg /SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
```

### Method 2: Use the Control Panel

1. Select **Start**, enter *edit power plan* in the **Search** box, and then select **Edit power plan** from the results.
1. On the **Change settings for the plan** page, select **Change advanced power settings**.
1. Expand **Processor power management** > **Maximum processor state**.
1. Set the **Plugged in** setting to **100%**, select **Apply**, and then select **OK** to save the change.

### Method 3: Use Microsoft Intune to deploy a PowerShell script to devices

1. Save the following command as *MPState.ps1*:

   ```powershell
   powercfg /SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
   ```

1. [Create a script policy (add the script to script settings), and assign the policy to groups](/mem/intune/apps/intune-management-extension#create-a-script-policy-and-assign-it).
