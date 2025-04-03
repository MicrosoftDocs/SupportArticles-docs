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

This resolution requires Power Automate for desktop version 2.49 or later. If you don't have MFA enabled for the account used by the desktop flows connection, you can set up Microsoft Entra authentication using a username and password instead.

1. Open the Registry Editor (regedit) with administrative privileges. Navigate to the following registry path, create a new DWORD-32 value with the name `UseRdsAadAuthentication`, and then set the value of `UseRdsAadAuthentication` to **1**.

    |Registry path|Registry key| DWORD-32 value|
    |-------------|------------|---------------|
    |Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Service|`UseRdsAadAuthentication`|**1**|

2. [Hide the consent prompt dialog for a target device group](/power-automate/desktop-flows/run-unattended-desktop-flows#admin-consent-for-unattended-runs-using-cba-or-sign-in-credentials-with-nla-preview).

3. Restart the Power Automate service.

4. Use a Microsoft Entra ID connection with username and password credentials. Note that an MFA exception is required for this account.

## Resolution 3: Disable fPromptForPassword

To solve this issue, check the group policy setting on your machine.

1. Press the Windows key+<kbd>R</kbd> to open the **Run** dialog.
1. Type **gpedit.msc** and press <kbd>Enter</kbd> to open the Local Group Policy Editor.
1. Navigate to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Security**.
1. Look for the **Always prompt for password upon connection** setting.

   - If the setting is enabled, work with your IT department to disable the policy for that machine.

     > [!NOTE]
     > This value is also reflected in the registry at **Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services**. If the **fPromptForPassword** DWORD value for the **Terminal Services** key is set to **1**, the setting is enabled, and you need to work with your IT department to disable it (simply changing the registry value is generally not sufficient, as it might be reverted.)

   - If the **Always prompt for password upon connection** setting isn't enabled but you receive the error code, type **regedit** in the **Run** dialog to open the Registry Editor. In the Registry Editor, navigate to the **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp** registry key. Then, look for the **fPromptForPassword** DWORD and set it to **0**. If the DWORD doesn't exist, create it and set its value to **0**.
