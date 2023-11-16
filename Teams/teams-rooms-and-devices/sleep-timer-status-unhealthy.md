---
title: The Sleep timer status of a Teams Rooms device is Unhealthy
description: Resolves an issue that causes the Sleep timer signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: rebenite
ms.topic: troubleshooting
ms.date: 10/30/2023
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI179889
---
# The Sleep timer status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Sleep timer** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**.

> [!NOTE]  
> Incidents that are classified as **Warning** don't affect the health status that's reported for a device.

## Cause

This issue occurs if the following power setting on the Teams Rooms device is set to a value other than 0:

**Power Options** > **Advanced settings** > **Sleep** > **Sleep after** > **Plugged in (Minutes)**

By default, this setting is explicitly disabled on Windows-based Teams Rooms devices. However, the setting might sometimes be changed by your organization in one of the following manners:

- Through a Group Policy Object (GPO)
- Through Mobile Device Management (MDM) policies
- Manually by administrators

If this setting is set to a value other than 0, it might affect how Teams Rooms responds to wakeup signals, and might also affect regular monitoring and maintenance operations. In this case, the Teams Rooms Pro agent detects and reports the status of **Sleep timer** as **Unhealthy**.

## Resolution

Microsoft Teams Rooms Pro performs an automatic remediation to fix this issue. However, if the issue persists or reoccurs, we recommend that you check whether any GPO or MDM policies are defined to change power plan settings. In these cases, use one of the following options:

- [Use the Suppress ticket functionality](/microsoftteams/rooms/managed-meeting-rooms-portal#room-detail-status-and-changes) to silence any notification about the **Sleep timer** signal.
- If your organization uses GPO, MDM policies, or other management tools such as Configuration Manager for enterprise power plan management, make sure that the power setting isn't defined.

Additionally, use one of the following methods to set the value to 0, depending on how the Teams Rooms device is configured.

### Method 1: Use a Command Prompt window

Run the following command at a command prompt:

```console
powercfg /SETACVALUEINDEX SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
```

### Method 2: Use the Control Panel

1. Select **Start**, enter *edit power plan* in the **Search** box, and then select **Edit power plan** from the results.
1. On the **Change settings for the plan** page, select **Change advanced power settings**.
1. Expand **Sleep** > **Sleep after**.
1. Set the **Plugged in (Minutes)** setting to **0**, select **Apply**, and then select **OK** to save the change.

### Method 3: Use Microsoft Intune to deploy a PowerShell script to devices

1. Save the following command as *MPState.ps1*:

   ```powershell
   powercfg /SETACVALUEINDEX SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
   ```

1. [Create a script policy (add the script to script settings), and assign the policy to groups](/mem/intune/apps/intune-management-extension#create-a-script-policy-and-assign-it).
