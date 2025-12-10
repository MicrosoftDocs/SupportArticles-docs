---
title: Troubleshoot UI Automation and Element Detection in Power Automate for Desktop
description: Troubleshoot UI automation issues in Power Automate for desktop. Learn how to fix problems with the element picker or recorder not detecting UI elements.
ms.date: 12/02/2025
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: iomimtso, nimoutzo, v-shaywood
ms.author: iomimtso
---

# UI automation fails and element picker or recorder can't see UI elements

This article provides troubleshooting guidance for issues where Power Automate for desktop can't view or interact with specific UI elements in a desktop application.

## Symptoms

When you try to use UI automation in Power Automate for desktop, you might experience the following issues:

- _During design time_: The element picker or recorder doesn't show any UI elements when you try to capture elements for automation.
- _During runtime_: UI automation actions fail to execute correctly in both attended and unattended desktop flow runs.

## Cause 1: Interfering background processes

Some background processes interfere with UI automation functionality in Power Automate for desktop. Specifically, the **Microsoft Accessory Center** or **DesktopBridge** processes prevent UI automation from working correctly.

### Solution: Terminate interfering processes

To resolve this issue, terminate the interfering processes and disable them from running in the future.

## Cause 2: Incompatible UI frameworks

Some desktop applications use custom UI frameworks or rendering methods that aren't compatible with the standard accessibility APIs that Power Automate for desktop relies on. This incompatibility makes certain elements invisible to the element picker.

> [!IMPORTANT]
> For coordinate-based solutions (Solutions [3](#solution-3-use-the-recorder-with-coordinates) and [4](#solution-4-use-move-mouse-and-send-mouse-click-actions)) to work reliably:
>
> - The screen configuration (resolution, DPI settings, scaling) must remain static at runtime and match the configuration used during development.
> - Changes to the application's user interface structure might affect the effectiveness of these workarounds.
> - Test your flows thoroughly when deploying to different machines or environments.

### Solution 1: Use Move mouse to image action

1. Add a **Move mouse to image** action to your flow.
1. Capture an image of the UI element you want to interact with.
1. Enable the **Send a click after moving mouse** option.
1. Configure any additional settings as needed.

This action moves the mouse to the first occurrence of the specified image and sends a left click.

### Solution 2: Use Move mouse to text on screen (OCR) action

1. Add a **Move mouse to text on screen (OCR)** action to your flow.
1. Specify the text that appears on or near the UI element you want to interact with.
1. Enable the **Send a click after moving mouse** option.
1. Configure OCR settings and click options as needed.

This action uses Optical Character Recognition (OCR) to locate text on the screen or foreground window and sends a mouse click to that location.

### Solution 3: Use the recorder with coordinates

1. Open Power Automate for desktop and create a new flow.
1. Select **Recorder** from the toolbar.
1. Start recording and perform the click action on the desired UI element in your desktop application.
1. Stop the recording.

The recorder creates a **Click UI element in window** action with coordinate-based input parameters populated by using the respective values from your click action.

### Solution 4: Use Move mouse and Send mouse click actions

1. Add a **Move mouse** action to your flow.
1. Configure the action to move the mouse to the specific coordinates of the target element.
1. Add a **Send mouse click** action immediately after the Move mouse action.
1. Configure the Send mouse click action to perform the desired click (left, right, or double-click).

## Related content

- [UI automation in Power Automate for desktop](/power-automate/desktop-flows/ui-elements)
- [Use the recorder in Power Automate for desktop](/power-automate/desktop-flows/recording-flow)
- [Mouse and keyboard actions](/power-automate/desktop-flows/actions-reference/mouseandkeyboard)
- [OCR actions in Power Automate for desktop](/power-automate/desktop-flows/actions-reference/ocr)
