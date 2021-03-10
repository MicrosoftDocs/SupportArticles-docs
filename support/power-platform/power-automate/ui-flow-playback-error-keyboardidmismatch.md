---
title: UI flow playback KeyboardIdMismatch
description: Troubleshooting playback error for UI flow with KeyboardIdMismatch error.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Troubleshoot UI flow playback error KeyboardIdMismatch

This article provides steps to solve the **KeyboardIdMismatch** error that occurs when running a UI flow during Test run or Flow run.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555907

## Symptoms

When trying to run a UI flow during Test run or Flow run, the user gets one of the two following errors:

> KeyboardIdMismatch. The keyboard on the machine '0x0000040c040c' does not match the keyboardLayout in the script '0x000004090409'.

:::image type="content" source="media/ui-flow-playback-error-keyboardidmismatch/keyboardIdmismatch.png" alt-text="KeyboardMismatch error" border="false":::

The error is visible in the UI flow Test Page or See detail page of the UI flow run instance.

## Verifying issue

Check the Windows language on the machine when recording is same on the machine where playing back.

## Solving steps

- Change the Windows display language on the machine when playing back to the same display language used for recording.

  Windows 10: [Manage the input and display language settings in Windows 10](https://support.microsoft.com/windows/manage-the-input-and-display-language-settings-in-windows-10-12a10cb4-8626-9b77-0ccb-5013e0c7c7a2#display_language)
  Windows Server 2016: [Change The Display Language (Windows Server 2016)](https://www.hostwinds.com/guide/change-the-display-language-windows-server-2016/)
- Go to the Test step in UI flow to test again.
