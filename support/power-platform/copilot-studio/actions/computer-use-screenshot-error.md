---
title: Troubleshoot FailedToTakeScreenshot Errors During Computer Use Actions
description: Learn how to resolve FailedToTakeScreenshot errors that occur during computer use actions in Microsoft Copilot Studio.
ms.date: 09/22/2025
ms.reviewer: guco, v-shaywood
ms.custom: sap:Actions\AI actions

#customer intent: As a developer, I want to resolve FailedToTakeScreenshot errors that occur during computer use actions. These errors are preventing me from using computer use actions with my Copilot agents.
---

# FailedToTakeScreenshot error during computer use action

This article provides troubleshooting guidance for "FailedToTakeScreenshot" errors that occur during [computer use actions](/microsoft-copilot-studio/computer-use) for Copilot Studio agents. The computer use model requires screenshots to interact with the desktop. If capturing a screenshot fails, a "FailedToTakeScreenshot" error is given and the computer use action ends.

## Symptoms

During a computer use action, a "FailedToTakeScreenshot" error occurs and the action ends in failure.

## Cause 1: a UAC prompt is displayed

If Windows displays a [User Account Control](/windows/security/application-security/application-control/user-account-control/) (UAC) prompt, the prompt blocks the desktop and capturing the screen fails.

### Solution

- Ensure that a UAC prompt isn't displayed when you open a new Remote Desktop session to the machine.
- Verify that the [UAC level](https://support.microsoft.com/windows/user-account-control-settings-d5b2046b-dcb8-54eb-f732-059f321afe18) isn't set to **Always notify** as that can cause UAC prompts to be displayed during session startup.

## Cause 2: the Windows OOBE experience is displayed

The first time a user logs into the machine, Windows displays the [Out Of Box Experience](/windows-hardware/customize/desktop/customize-oobe-in-windows-11) (OOBE). This experience usually starts by displaying the message "Getting things ready." If the OOBE is displayed during the computer use action, capturing the screen fails.

### Solution

The OOBE is only displayed the first time a new user logs into the machine. Make sure to manually log the user into the machine at least once before using computer use actions.

## Cause 3: the Remote Desktop session isn't displayed

Capturing the screen fails if the Remote Desktop session isn't displayed. This issue can occur in the following cases:

- When you use an existing Remote Desktop session in the browser (for example connecting to a Power Automate Hosted machine), screen capturing fails if the Remote Desktop tab isn't focused.
- When you use a Remote Desktop session in the [Windows Application](/windows-app/overview), screen capturing fails if the application window is minimized.

### Solution

Before starting a compute use action, ensure that the Remote Desktop session is focused and visible on the screen.

## Related content

- [Hosted machines](/power-automate/desktop-flows/hosted-machines)
- [Automate web and desktop apps with computer use](/microsoft-copilot-studio/computer-use)