---
title: Kiosk mode issues troubleshooting
description: Learn how to troubleshoot single-app and multi-app kiosk configurations, as well as common problems like sign-in issues.
ms.date: 01/15/2025
manager: dcscontentpm
ms.topic: troubleshooting
ms.custom:
- sap:windows desktop and shell experience\kiosk mode
- pcy:WinComm User Experience
ms.reviewer: sybruckm, paoloma
audience: itpro
---
# Troubleshoot kiosk mode issues

_Applies to:_ &nbsp; Windows 10, Windows 11

## Single-app kiosk issues

> [!TIP]
> We recommend that you [enable logging for kiosk issues](/windows/configuration/assigned-access/recommendations#troubleshooting-and-logs). For some failures, events are only captured once. If you enable logging after an issue occurs with your kiosk, the logs may not capture those one-time events.

### Sign-in issues

1. Verify that User Account Control (UAC) is turned on.
2. Check the Event Viewer logs for sign-in issues under *Applications and Services Logs\\Microsoft\\Windows\\Authentication User Interface\\Operational*.

### Automatic logon issues

Check the Event Viewer logs for auto logon issues under *Applications and Services Logs\\Microsoft\\Windows\\Authentication User Interface\\Operational*.

## Multi-app kiosk issues

### Unexpected results

For example:

- Start isn't launched in full-screen
- Blocked hotkeys are allowed
- Task Manager, Cortana, or Settings can be launched
- Start layout has more apps than expected

#### Troubleshooting steps

1. [Verify that the provisioning package is applied successfully](/windows/configuration/kiosk-validate).
2. Verify that the account (config) is mapped to a profile in the configuration XML file.
3. Verify that the configuration XML file is authored and formatted correctly. Correct any configuration errors, then create and apply a new provisioning package. Sign out and sign in again to check the new configuration.
4. Additional logs about configuration and runtime issues can be obtained by enabling the *Applications and Services Logs\\Microsoft\\Windows\\AssignedAccess\\Operational* channel, which is disabled by default.

:::image type="content" source="media/kiosk-mode-issues-troubleshooting/enable-assigned-access-log.png" alt-text="Screenshot of Event Viewer with Enable Log selected on the menu, which shows by right-clicking Operational." border="false":::

### Automatic logon issues

Check the Event Viewer logs for auto logon issues under *Applications and Services Logs\\Microsoft\\Windows\\Authentication User Interface\\Operational*.

### Apps configured in AllowedList are blocked

1. Ensure the account is mapped to the correct profile and that the apps are specific for that profile.
2. Check the EventViewer logs for Applocker and AppxDeployment (under *Application and Services Logs\\Microsoft\\Windows*).

### Start layout not as expected

- Make sure the Start layout is authored correctly. Ensure that the attributes **Size**, **Row**, and **Column** are specified for each application and are valid.
- Check if the apps included in the Start layout are installed for the assigned access user.
- Check if the shortcut exists on the target device, if a desktop app is missing on Start.

