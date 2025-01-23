---
title: Cannot find UI element
description: Solves a runtime error when UI element cannot be found
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/20/2025
---
# Cannot find UI element

## Symptoms

Error generates at runtime because UI element cannot be found

## Detection

- Click failed (failed to get UI element)
- Failed to press button (button wasn't found)
- Failed to write in textbox (textbox wasn't found)
- Extraction failed (failed to get window)
- Failed to find element with selector '...'
- Tab selection failed (tab UI element wasn't found)
- Failed to click radio button (radio button wasn't found)

All the errors can occur also with internal message 'Window wasn't found' when Window as a UI element is not found at runtime.
Example: Click failed (failed to get window).

Also in Windows actions, the following error may occur when Window UI element is not found.

- Window wasn't found

## Causes

### Action failed (failed to get window)

The screen (window) isn't available on the machine (it isn't open), or the selector of the screen isn't valid.

### Other scenarios

The specific UI element isn't available on the screen (window) or its selector isn't valid.

## Resolution

### Use test/repair selector (Recommended)

#### Test selector

Starting from version 2.31, Power Automate for desktop (PAD) includes the "Test selector" feature.

Users can test the selector in the Selector builder window and verify that UI element can be found successfully in the screen.

#### Repair selector

Starting from version 2.32, Power Automate for desktop (PAD) includes the "Repair selector" feature.

Power Automate for desktop can automatically fix cases with dynamic selectors with the use of this feature. Users should just recapture the UI element and the application will generate the selector.

### Modify selectors manually

### Action failed (failed to get window)

- Ensure the parent screen of the UI element is available on the machine. If not, the error message will indicate "Failed to get window."
- Moreover, the "Failed to get window" error may be generated in case the selector of the parent screen is invalid. To fix this  issue, see the following instructions.

### Other scenarios

- Ensure the UI element is available on the respective screen or webpage.
- Capture the UI element again as a new UI element object and populate the erroneous action with the new UI element.
- Navigate to the selector builder and add a new selector using the Selector with recapture option.
- Manually edit the selector in the selector builder or its text editor mode.
- Check if the selector of the UI element is dynamic. A UI element has a dynamic selector when the selector is slightly different every time the window is launched or the web page loads. To check whether a UI element has a dynamic selector:
  - Capture the UI element.
  - Restart the window.
  - Capture the exact same UI element.
  - Compare the two selectors and observe if there are any differences. You can perform the comparison in Notepad.
  - Edit the selector (one of them) manually using the operands or editing the values of the attributes.
- Use alternative approaches for interacting with the element on the screen. You can use image automation, mouse and keyboard
actions, and optical character recognition (OCR).

## Resources

- [UI automation action fails with "Failed to get UI element" or "Failed to get window" error](/troubleshoot/power-platform/power-automate/ui-automation-action-fails-errors)
