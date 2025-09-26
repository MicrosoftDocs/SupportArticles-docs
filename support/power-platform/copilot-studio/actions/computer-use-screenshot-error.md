---
title: Troubleshoot FailedToTakeScreenshot Errors During Computer Use Actions
description: Learn how to resolve a "FailedToTakeScreenshot" error that occurs during computer use actions in Microsoft Copilot Studio.
ms.date: 09/22/2025
ms.reviewer: guco, v-shaywood
ms.custom: sap:Actions\AI actions

#customer intent: As a developer, I want to resolve FailedToTakeScreenshot errors that occur during computer use actions. These errors are preventing me from using computer use actions with my Copilot agents.
---

# "FailedToTakeScreenshot" error during computer use action

This article provides troubleshooting guidance for "FailedToTakeScreenshot" errors that occur during [computer use actions](/microsoft-copilot-studio/computer-use) for Microsoft Copilot Studio agents. The computer use model requires screenshots to interact with the desktop. If the screenshot process fails, a "FailedToTakeScreenshot" error is returned, and the computer use action ends.

## Symptoms

During a computer use action, a "FailedToTakeScreenshot" error occurs, and the screenshot capture action fails.

## Cause 1: a UAC prompt is displayed

If Windows displays a [User Account Control](/windows/security/application-security/application-control/user-account-control/) (UAC) prompt, the prompt blocks the desktop, and the system or application can't capture a screen image.

### Solution

- Make sure that a UAC prompt isn't displayed when you open a new Remote Desktop session to another computer.
- Verify that the [UAC level](https://support.microsoft.com/windows/user-account-control-settings-d5b2046b-dcb8-54eb-f732-059f321afe18) isn't set to **Always notify**. That setting can cause UAC prompts to be displayed during session startup.

## Cause 2: the Windows OOBE experience is displayed

The first time that a user logs on to the remote computer, Windows starts the [Out Of Box Experience](/windows-hardware/customize/desktop/customize-oobe-in-windows-11) (OOBE). At startup, the OOBE typically displays the message, "Getting things ready." If the OOBE image is displayed during the computer use action, the screen capture action fails.

### Solution

The OOBE is displayed only the first time that a new user logs on to the remote computer. Make sure that you manually log the user on at least one time before they use a computer use action.

## Cause 3: the Remote Desktop session isn't displayed

A screen capture fails if the Remote Desktop session isn't displayed. This issue might occur in the following situations:

- If you use an existing Remote Desktop session in a web browser (for example, when you connect to a Power Automate-hosted computer), screen capturing fails if the Remote Desktop tab isn't focused.
- If you use a Remote Desktop session in [Windows App](/windows-app/overview), screen capturing fails if the application window is minimized.

### Solution

Before you start a computer use action, make sure that the Remote Desktop session is focused and visible on the screen.

## Related content

- [Hosted machines](/power-automate/desktop-flows/hosted-machines)
- [Automate web and desktop apps with computer use](/microsoft-copilot-studio/computer-use)
