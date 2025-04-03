---
title: Take screenshot action fails in unattended mode
description: Resolves an error that occurs in the action 'Take screenshot', when you run an unattended desktop flow in Microsoft Power Automate for desktop.
ms.author: yiannismavridis
ms.reviewer: 
ms.custom: sap:Desktop flows\Unattended flow runtime errors
ms.date: 04/03/2025

---
# An unattended desktop flow run fails with an error in the action 'Take screenshot'

This article provides a resolution for an error that occurs in the action 'Take screenshot', when you run an unattended desktop flow in Microsoft Power Automate for desktop.

## Symptoms

Using the **Take screenshot** action fails with error:

```
Microsoft.PowerPlatform.PowerAutomate.Desktop.Actions.SDK.ActionException: Failed to take screenshot. ---> System.ComponentModel.Win32Exception: The handle is invalid
   at System.Drawing.Graphics.CopyFromScreen(Int32 sourceX, Int32 sourceY, Int32 destinationX, Int32 destinationY, Size blockRegionSize, CopyPixelOperation copyPixelOperation)
   at System.Drawing.Graphics.CopyFromScreen(Int32 sourceX, Int32 sourceY, Int32 destinationX, Int32 destinationY, Size blockRegionSize)
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.SystemActions.TakeScreenShot(Variant fileName, Variant screenToCapture, Int32 screenCaptureOption, Boolean copyToClipboard, Int32 fileFormat)
   --- End of inner exception stack trace ---
   at Microsoft.Flow.RPA.Desktop.Modules.System.Actions.TakeScreenshotBase.Execute(ActionContext context)
   at Microsoft.Flow.RPA.Desktop.Robin.Engine.Execution.ActionRunner.Run(IActionStatement statement, Dictionary`2 inputArguments, Dictionary`2 outputArguments)
```

### Applies to
- All versions

### Modes
- Unattended

## Detection

While using the **Take screenshot** action, the above error is thrown when a specific security policy is in place.

## Cause

The security policy refers to the way a UAC window (for admin privileges) is prompted and does not allow the flow to retrieve the screen and capture the screenshot.

## Resolution 1: Locate and allow binaries except for non-Windows ones to run without elevation prompt

:::image type="content" source="media/msentramachinealwayspromptingforpassword-error/msentramachinealwayspromptingforpassword.png" alt-text="Screenshot of the error code shown in the Body section of the Run a flow built with Power Automate for desktop page.":::

## Resolution 2: Change the registry key below

Hive: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System**

Key: **ConsentPromptBehaviorAdmin** DWORD, setting it to 5

Options:

- **0** = Elevate without prompting
- **1** = Prompt for credentials on the secure desktop
- **2** = Prompt for consent on the secure desktop
- **3** = Prompt for credentials
- **4** = Prompt for consent
- **5** = Prompt for consent for non-Windows binaries (default) <- Set option to this
