---
title: Focus window can't bring a specific window to focus
description: Provides a workaround to make sure that application windows become focused in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# The Focus window action can't bring a specific window to focus

This article provides a workaround to solve the issue that the "Focus window" action fails to bring a window to focus in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5001203

## Symptoms

UI automation actions can't focus on a window. Depending on the nature of the app, a "Focus window" action may not be able to bring the window to focus. Even if the window is in the foreground, the focus may not be on the window, causing subsequent actions to fail.

## Verifying issue

To verify that the "Focus window" action can't bring the window to focus, you can send some keystrokes on the window by using the "Send keys" action. If the window isn't focused, the keystrokes won't be sent to the right place.

## Workaround

To work around this issue, you can send a click on the window. In addition to the "Focus window" action, send a click afterwards to make sure that the window becomes focused. The following actions can be used to send a click on a window:

- [Click UI element in window](/power-automate/desktop-flows/actions-reference/uiautomation#click)
- [Move mouse to image](/power-automate/desktop-flows/actions-reference/mouseandkeyboard#movemousetoimagebase) and send a click
- [Send mouse click](/power-automate/desktop-flows/actions-reference/mouseandkeyboard#sendmouseclick)
- [Move mouse to text on screen (OCR)](/power-automate/desktop-flows/actions-reference/mouseandkeyboard#movemousetotextonscreenwithocraction) and send a click
