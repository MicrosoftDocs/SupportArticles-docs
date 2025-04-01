---
title: UIPI Issues with UI and Browser Automation Actions
description: Solves issues caused by User Interface Privacy Isolation (UIPI) that prevent the UI or Browser automation actions to execute successfully.
ms.date: 04/01/2025
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: andreas-mitrou
---
# UIPI issues with UI and browser automation actions

This article provides guidance for resolving issues caused by User Interface Privacy Isolation (UIPI), a security feature in Windows, which might prevent UI or browser automation actions from executing successfully. UIPI blocks certain interactions between processes running at different integrity levels, which can interfere with automation tools or scripts. As these issues might occur due to multiple potential causes, we recommend reviewing each cause listed to ensure your system settings are properly configured for successful automation.

## Symptoms

Actions performing UI or browser automation may fail with an error message similar to the following:

> System.Exception: Some simulated input commands were not sent successfully. The most common reason for this happening are the security features of Windows including User Interface Privacy Isolation (UIPI). Your application can only send commands to applications of the same or lower elevation. Similarly certain commands are restricted to Accessibility/UIAutomation applications. Refer to the project home page and the code samples for more information

## Cause 1: The desktop is locked during execution

**Solution**: Unlock the desktop to allow the automation process to proceed.

## Cause 2: A UAC dialog is open during execution

**Solution**: Ensure that User Account Control (UAC) dialogs don't appear during automation. If necessary, temporarily adjust UAC settings:

1. Open the Control Panel.
1. Navigate to **System and Security** > **Change User Account Control settings**.
1. Adjust the slider to a lower setting temporarily to prevent UAC interruptions during automation.
1. Restore the original settings after completing the automation process.

## Cause 3: The RDP window is minimized during execution

**Solution**: Modify the system registry to prevent issues with minimized RDP sessions:

[!INCLUDE [Third-party disclaimer](../../../../includes/registry-important-alert.md)]

1. Close active Remote Desktop sessions.
1. Press <kbd>Win</kbd>+<kbd>R</kbd>, type _regedit_, and press <kbd>Enter</kbd> to open the Registry Editor.
1. Navigate to the following key:

   **HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Terminal Server Client**

1. Right-click inside the right panel and select **New** > **DWORD (32-bit) Value**.
1. Name the new registry entry **RemoteDesktop_SuppressWhenMinimized**.

1. Double-click the entry to open the **Edit DWORD (32-bit) Value** window.
1. Set the **Value data** field to **2**.
1. Select **OK** to save changes and close the Registry Editor.

## Cause 4: The application under automation is running in elevated mode

**Solution**: Ensure that the application being automated is not running with elevated privileges. If the application is set to run as an administrator, adjust its execution settings:

1. Right-click the application shortcut and select **Properties**.
1. Go to the **Compatibility** tab.
1. Uncheck the **Run this program as an administrator** option.
1. Select **OK** to save changes.

## Cause 5: The desktop screen saver is enabled

**Solution**: Disable the screen saver to prevent interruptions during automation:

1. Open the Control Panel.
1. Navigate to **Appearance and Personalization** > **Change screen saver**.
1. Set the **Screen saver** option to **None**.
1. Select **Apply** and then **OK**.

## Cause 6: Windows Server Manager auto-starts on login, triggering UAC

**Solution**: Disable the auto-starting feature for Server Manager to prevent UAC prompts:

1. Open Server Manager.
1. Go to **Manage** > **Server Manager Properties**.
1. Select the **Do not start Server Manager automatically at logon** checkbox.
1. Select **OK** to save changes.

## Cause 7: Windows update or system configuration changes

**Solution**: Review recent Windows updates or system changes and revert them if necessary to resolve the issue.

## More information

- For web automation actions such as [Click link on web page](/power-automate/desktop-flows/actions-reference/webautomation#clickbase) and [Populate text field on webpage](/power-automate/desktop-flows/actions-reference/webautomation#populatetextfieldbase), ensure that physical interaction options are disabled in the action parameters.

  - "Populate text field on web page": Disable the **Populate text using physical keystrokes** option.
  - "Click link on web page": Disable the **Send physical click** option.

- For UI automation, enable the [Simulate action](/power-platform/release-plan/2023wave2/power-automate/ui-automation--simulate-actions) parameter for eligible UI Automation actions and UI elements.
