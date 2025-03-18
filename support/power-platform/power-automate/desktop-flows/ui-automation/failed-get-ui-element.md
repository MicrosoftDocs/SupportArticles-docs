---
title: Failed to get UI element error
description: Provides a resolution for the issue that desktop flow actions fail to get UI elements.
ms.reviewer: pefelesk, nimoutzo, dipapa, iomavrid
ms.date: 07/28/2023
ms.custom: sap:Desktop flows\UI or browser automation
---
# Error occurs when a desktop flow action fails to get a UI element

This article describes the different causes and solutions for the error messages that may occur when a desktop flow action fails to get a UI element.

## Symptoms

The execution of a desktop flow fails with one of the following error messages:

- For UI automation actions:

  Error 1

  > Action failed (failed to get window)

  where "Action" is the respective Power Automate for desktop action.

  Error 2

  > Action failed (failed to get UI element)

  where "Action" is the respective Power Automate for desktop action.

  Error 3

  > UIAutomation.ActionFailedError

  where "Action" is the respective Power Automate for desktop action.

- For Browser automation actions:

  Error 1

  > Element with selector 'xyz' not found
  
  where "xyz" is the selector that pinpoints the element.

  Error 2

  > WebAutomation.ElementNotFoundError

## Cause for the "Action failed (failed to get window)" error

Either the screen (window) isn't available on the machine (it isn't open), or the selector of the screen isn't valid.

#### Resolution

To solve the issue, you need to:

1. Ensure the parent screen of the UI element is available on the machine. If not, the error message will indicate "Failed to get window."

1. Moreover, the "Failed to get window" error may be generated in case the selector of the parent screen is invalid. To fix this issue, see the following instructions.

## Cause for the other scenarios

Either the specific UI element isn't available on the screen (window), or its selector isn't valid.

#### Resolution

To solve the issue, take the following steps:

1. Ensure the UI element is available on the respective screen or webpage.

1. Capture the UI element again as a new UI element object and populate the erroneous action with the new UI element.

1. Navigate to the selector builder and add a new selector using the **Selector with recapture** option.

1. Manually edit the selector in the selector builder or its text editor mode.

1. Check if the selector of the UI element is dynamic. A UI element has a dynamic selector when the selector is slightly different every time the window is launched or the web page loads. To check whether a UI element has a dynamic selector:

    1. Capture the UI element.
    1. Restart the window or reload the webpage.
    1. Capture the exact same UI element.
    1. Compare the two selectors and observe if there are any differences. You can perform the comparison in Notepad.
    1. Edit the selector (one of them) manually using the operands or editing the values of the attributes.

1. Use alternative approaches for interacting with the element on the screen. You can use image automation, mouse and keyboard actions, and optical character recognition (OCR).

If you receive the "Failed to get UI element" or "Failed to get window" error when a UI automation action fails in Microsoft Power Automate, see [UI automation action fails with "Failed to get UI element" or "Failed to get window" error](ui-automation-action-fails-errors.md).

## References

- [Automate desktop applications](/power-automate/desktop-flows/desktop-automation)
- [Automate webpages](/power-automate/desktop-flows/automation-web)
- [Automate on virtual desktops](/power-automate/desktop-flows/virtual-desktops)
- [Automate using UI elements](/power-automate/desktop-flows/ui-elements)
- [Automate using images](/power-automate/desktop-flows/images)
- [Build a custom selector](/power-automate/desktop-flows/build-custom-selectors)
- [Handle errors in desktop flows](/power-automate/desktop-flows/errors)
- [Install Power Automate browser extensions](/power-automate/desktop-flows/install-browser-extensions)
- [Variable manipulation and the % notation](/power-automate/desktop-flows/variable-manipulation)
