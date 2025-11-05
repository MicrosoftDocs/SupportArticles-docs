---
title: UI element picker or Recorder cannot view UI elements in desktop applications
description: Learn how to resolve issues when Power Automate for desktop cannot view or interact with specific UI elements in desktop applications.
ms.date: 11/05/2025
ms.custom: sap:Desktop flows\UI automation
ms.reviewer: nimoutzo
ms.author: iomimtso
---

This article provides solutions for situations where Power Automate for desktop cannot view or interact with specific UI elements in a desktop application.

## Symptoms

When using Power Automate for desktop, the element picker tool cannot detect or "see" certain UI elements within desktop applications. This issue prevents you from selecting elements for automation tasks.

## Cause

Some desktop applications use custom UI frameworks or rendering methods that aren't compatible with standard accessibility APIs that Power Automate for desktop relies on. This can make certain elements invisible to the element picker.

## Resolution

Use one of the following workarounds to interact with UI elements that cannot be detected by the element picker.

### Solution 1: Use Move mouse to image action

1. Add a **Move mouse to image** action to your flow.
2. Capture an image of the UI element you want to interact with.
3. Enable the **Send a click after moving mouse** option.
4. Configure any additional settings as needed.

The action moves the mouse to the first occurrence of the specified image and sends a left click.

### Solution 2: Use Move mouse to text on screen (OCR) action

1. Add a **Move mouse to text on screen (OCR)** action to your flow.
2. Specify the text that appears on or near the UI element you want to interact with.
3. Enable the **Send a click after moving mouse** option.
4. Configure OCR settings and click options as needed.

The action uses Optical Character Recognition (OCR) to locate text on the screen or foreground window and sends a mouse click to that location.

### Solution 3: Use the recorder with coordinates

1. Open Power Automate for desktop and create a new flow.
2. Select **Recorder** from the toolbar.
3. Start recording and perform the click action on the desired UI element in your desktop application.
4. Stop the recording.

The recorder creates a **Click UI element in window** action with coordinate-based input parameters populated with the respective values from your click action.

### Solution 4: Use Move mouse and Send mouse click actions

1. Add a **Move mouse** action to your flow.
2. Configure the action to move the mouse to the specific coordinates of the target element.
3. Add a **Send mouse click** action immediately after the Move mouse action.
4. Configure the Send mouse click action to perform the desired click (left, right, or double-click).

## Important considerations

> [!IMPORTANT]
> For coordinate-based solutions (Solutions 3 and 4) to work reliably:
>
> - The screen configuration (resolution, DPI settings, scaling) must remain static at runtime and match the configuration used during development.
> - Changes to the application's user interface structure may affect the effectiveness of these workarounds.
> - Test your flows thoroughly when deploying to different machines or environments.

## See also

- [UI automation in Power Automate for desktop](/power-automate/desktop-flows/ui-elements)
- [Use the recorder in Power Automate for desktop](/power-automate/desktop-flows/recording-flow)
- [Mouse and keyboard actions](/power-automate/desktop-flows/actions-reference/mouseandkeyboard)
- [OCR actions in Power Automate for desktop](/power-automate/desktop-flows/actions-reference/ocr)
- 