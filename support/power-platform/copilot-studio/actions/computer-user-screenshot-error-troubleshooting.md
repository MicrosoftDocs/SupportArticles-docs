---
title: Troubleshoot 'FailedToTakeScreenshot' error during computer use actions (preview)
description: Understand and resolve 'FailedToTakeScreenshot' errors that occur during computer use runs.
ms.date: 09/22/2025
ms.topic: troubleshooting
ms.author: guco
ms.custom:
  - guidance
---

# Why does the 'FailedToTakeScreenshot' error occur?

To interact with the Windows desktop, the computer use model requires screenshots. When capturing the screen isn't possible, this error is surfaced and the computer use session ends in failure.

Screen capture usually fails when the Windows desktop isn't displayed. The following are frequent reasons this may happen.

## A UAC prompt is displayed

When Windows displays a [User Account Control](https://learn.microsoft.com/windows/security/application-security/application-control/user-account-control/) (UAC) prompt, the desktop is dimmed and screen capturing will fail.

When opening a new Remote Desktop session to the machine, make sure that not UAC prompt is displayed. Setting the UAC level to "Always notify" can cause UAC prompts to be displayed during session startup.

## The Windows OOBE experience is displayed

When opening a Windows session for the first time with a specific user account on a machine, Windows will display the [Out Of Box Experience](https://learn.microsoft.com/windows-hardware/customize/desktop/customize-oobe-in-windows-11) (OOBE), typically displaying the "Getting things ready" message.

This experience can last for a few minutes and is only displayed the first time a particular user logs into a machine. Always make sure to log into your machines at least once before using them for computer use actions.

## Remote desktop window or tab isn't displayed

When using the computer use tool on an already open Remote Desktop session in the browser (for instance to a Power Automate Hosted machine), screen capturing will fail if the Remote Desktop tab is not focused in the browser.

When connecting to a machine using the Windows Application, minimizing the Windows Application window will also cause screen capture to fail.