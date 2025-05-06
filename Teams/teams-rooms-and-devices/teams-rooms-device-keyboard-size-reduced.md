---
title: On-screen keyboard size is reduced on some Teams Rooms devices
description: Provides a workaround for an issue that causes the on-screen keyboard to be reduced in size on some Teams Rooms devices. 
ms.date: 10/30/2023
author: Cloud-Writer
ms.author: meerak
ms.reviewer: travissnoozy
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Msft Teams Rooms Windows (MTRW)
  - CI176375
---
# On-screen keyboard size is reduced on some Teams Rooms devices

## Symptoms

After you upgrade to Windows 11, the on-screen keyboard is reduced to a smaller size on the following Microsoft Teams Rooms devices that have touch consoles:

- Crestron Mercury
- Crestron Mercury Mini
- Yealink MTouch II

## Cause

Design changes in Windows 11 limit the height of on-screen keyboards to no more than half the height of the screen. Therefore, the default size of the on-screen keyboard on the listed Teams Rooms devices might be reduced.

## Workaround

To increase the size of the on-screen keyboard on these devices, switch the Teams Rooms app to [Admin mode](/MicrosoftTeams/rooms/rooms-operations#switching-to-admin-mode-and-back-when-the-microsoft-teams-rooms-app-is-running), and then follow these steps:

1. Select **Start** > **Settings**.
2. Navigate to the **Personalization** tab.
3. Expand the **Text input** section.
4. Expand the **Touch keyboard** section, and then select the **Open keyboard** button.
5. Adjust the **Keyboard size** slider to your preference.
6. Open an elevated PowerShell Command Prompt window, and then run the following command to copy the updated setting for the keyboard size to the *Skype* user account:

   ```powershell
   powershell -ExecutionPolicy unrestricted c:\rigel\x64\scripts\provisioning\ScriptLaunch.ps1 ApplyCurrentDisplayScaling.ps1
   ```

Restart the device, and then verify that the keyboard size in the Teams Rooms app matches the updated setting.
