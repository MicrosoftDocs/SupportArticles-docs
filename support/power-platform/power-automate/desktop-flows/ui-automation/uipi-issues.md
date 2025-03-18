---
title: UIPI Issues with UI and Browser automation actions
description: Provides solutions to issues caused by UIPI that prevent the UI or Browser automation actions to execute sucessfully.
ms.date: 03/18/2025
ms.custom: sap:Desktop flows\UI or browser automation
---

# UIPI Issues with UI and Browser automation actions

This article refers to issues caused by UIPI that prevent the UI or Browser automation actions to execute sucessfully.

## Symptoms

Actions that are performing UI / Browser Automation when executed might fail with an error.
An example of the error received is the following:

#### System.Exception: Some simulated input commands were not sent successfully. The most common reason for this happening are the security features of Windows including User Interface Privacy Isolation (UIPI). Your application can only send commands to applications of the same or lower elevation. Similarly certain commands are restricted to Accessibility/UIAutomation applications. Refer to the project home page and the code samples for more information

## Causes

1. The desktop is locked while execution
2. UAC dialog is open while execution
3. When the execution targets an RDP, when the RDP window is minimized.
4. The application that is under automation is running in Elevated mode.
5. Screen saver on desktop is enabled.
6. Windows Server manager is auto starting on login and UAC is prompted because of policies
7. A Windows update or system configuration has been applied that might cause the issue.

## Resolution

1. The desktop is locked while execution. 

         Unlock desktop

2. UAC dialog is open while execution. 

        Make sure the dialog doesn't show.

3. When the execution targets an RDP, when the RDP window is minimized.

        1. Close any opened Remote Desktop sessions. 

        2. Press Win + R, type “regedit”, and press Enter. The Registry Editor window is displayed.

        3. Navigate to the following Registry key: HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Terminal Server Client

        4. Right-click inside the right panel of the Registry Editor window.

        5. Select New >Select DWORD (32-bit) Value. A new registry is added to the right panel.

        6. Change the default name to RemoteDesktop_SuppressWhenMinimized.

        7. Double-click RemoteDesktop_SuppressWhenMinimized. The Edit DWORD (32-bit) Value window is displayed.

        8. Write 2 in the Value data field.

        9. Press OK to save changes.

        10. Close the Registry Editor window.

4. The application that is under automation is running in Elevated mode.

           Make sure that the application under automation is not running as elevated.

5. Screen saver on desktop is enabled.

           Make sure that screen saver is not activated.

6. Windows Server manager is auto starting on login and UAC is prompted because UAC of policies.

           Disable auto start of the Server Manager

When the issue happens in the web automation actions **Click link on web page** and **Populate text field on webpage**.

           Make sure in the action parameters, any physical interactions options are disabled. 
           These options are:
           Populate text field on web page: Populate text using physical keystrokes
           Click link on web page: Send physical click.

In UI automation, try enabling the Simulate action parameter for eligible UI Automation actions and UI Elements:
[UI automation - Simulate actions | Microsoft Learn](https://learn.microsoft.com/power-platform/release-plan/2023wave2/power-automate/ui-automation--simulate-actions)