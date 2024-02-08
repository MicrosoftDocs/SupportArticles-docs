---
title: Can't interact with desktop application
description: Provides a resolution for the issue that you can't interact with the desktop application in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/20/2022
ms.subservice: power-automate-desktop-flows
---
# Can't interact with the desktop application without an error message

This article provides a resolution to an issue where you can't interact with the desktop application without an error message in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003775

## Symptoms

You may encounter the following issues:

1. Mouse clicks or keystrokes aren't sent to the target application, without an error message.
2. Desktop recorder doesn't recognize the elements of the desktop application.

## Verifying issue

You can open the Power Automate for desktop Designer and try to interact with the desktop application with one of the following actions:

- Send keys
- Send mouse click
- Move mouse to image

Additionally, open the Desktop recorder and try to capture an element within the application.

Both the above operations can't be performed without any error message.

## Cause

The application runs with more elevated privileges than Power Automate for desktop.

## Resolution

Both the application and Power Automate for desktop should run with the same privileges.

Power Automate for desktop doesn't run elevated by default. Hence, uncheck the **Run this program as an administrator** checkbox in the **Compatibility** section of the application's **Properties** window.

Another option is to set Power Automate for desktop to run as admin as well.
