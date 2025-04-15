---
title: Take screenshot action fails in unattended mode
description: Resolves an error that occurs in the action 'Take screenshot', when you run an unattended desktop flow in Microsoft Power Automate for desktop.
ms.author: iomavrid
author: yiannismavridis
ms.custom: sap:Desktop flows\Unattended flow runtime errors
ms.date: 04/15/2025
---
# Unattended desktop flow run fails with the "Failed to take screenshot" error

This article provides a resolution for an error that occurs in the [Take screenshot](/power-automate/desktop-flows/actions-reference/workstation#takescreenshotbase) action when running an unattended desktop flow in Microsoft Power Automate for desktop.

## Symptoms

The **Take screenshot** action fails with the following error message:

```output
Microsoft.PowerPlatform.PowerAutomate.Desktop.Actions.SDK.ActionException: Failed to take screenshot. ---> System.ComponentModel.Win32Exception: The handle is invalid
   at System.Drawing.Graphics.CopyFromScreen(Int32 sourceX, Int32 sourceY, Int32 destinationX, Int32 destinationY, Size blockRegionSize, CopyPixelOperation copyPixelOperation)
   at System.Drawing.Graphics.CopyFromScreen(Int32 sourceX, Int32 sourceY, Int32 destinationX, Int32 destinationY, Size blockRegionSize)
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.SystemActions.TakeScreenShot(Variant fileName, Variant screenToCapture, Int32 screenCaptureOption, Boolean copyToClipboard, Int32 fileFormat)
   --- End of inner exception stack trace ---
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.TakeScreenshotBase.Execute(ActionContext context)
   at Microsoft.Flow.RPA.Desktop.Robin.Engine.Execution.ActionRunner.Run(IActionStatement statement, Dictionary`2 inputArguments, Dictionary`2 outputArguments)
```

## Cause

The issue occurs due to a specific security policy that impacts how a User Account Control (UAC) window (for administrative privileges) is prompted. This policy prevents the flow from accessing the screen and capturing the screenshot.

## Resolution 1: Locate and allow binaries except for non-Windows ones to run without elevation prompt

Configure the [User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/user-account-control-behavior-of-the-elevation-prompt-for-administrators-in-admin-approval-mode) security policy setting.

:::image type="content" source="media/take-screenshot-action-fails-in-unattended-mode/local-security-policy.png" alt-text="Screenshot of the User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode setting in the Local Security Policy window." lightbox="media/take-screenshot-action-fails-in-unattended-mode/local-security-policy.png":::

## Resolution 2: Change the registry key below

Modify the registry key to adjust the UAC behavior:

- Hive: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System**
- Registry key name: [ConsentPromptBehaviorAdmin](/windows/security/application-security/application-control/user-account-control/settings-and-configuration?tabs=reg#user-account-control-configuration)
- Type: DWORD
- Value: **5**

Options for the **ConsentPromptBehaviorAdmin** key:

- **0** = Elevate without prompting
- **1** = Prompt for credentials on the secure desktop
- **2** = Prompt for consent on the secure desktop
- **3** = Prompt for credentials
- **4** = Prompt for consent
- **5** (Default) = Prompt for consent for non-Windows binaries. Set the registry key to this value.

## More information

[User Account Control settings and configuration](/windows/security/application-security/application-control/user-account-control/settings-and-configuration)
