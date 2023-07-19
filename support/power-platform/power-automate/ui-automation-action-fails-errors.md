---
title: Failed to get element or window or element or window wasn't found error
description: Provides a resolution to solve the error message that you receive when a UI automation action fails in Power Automate.
ms.reviewer: pefelesk, nimoutzo
ms.date: 07/19/2023
ms.subservice: power-automate-desktop-flows
---
# UI automation action fails with "Failed to get element/window" or "Element/Window wasn't found" error

This article provides a resolution on solving the error message that you may receive when a UI automation action fails in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003385

## Symptoms

A UI automation action fails with one of the following error messages in Microsoft Power Automate:

- Failed to get element
- Failed to get window
- Element wasn't found
- Window wasn't found

## Verifying issue

The first time that the element was captured during authoring of the desktop flow, Power Automate for desktop was able to interact with the element successfully.

## Cause 1: Application's window name or UI element is not available in the screen

### Resolution

Ensure that the UI element or the screen (window) is available at the display at the execution of the action.

## Cause 2: UI element selected in respective action is not the correct

### Resolution

Ensure the action's UI element input parameter is populated with the correct UI element from the list.

## Cause 3: Application's window name or element's underlying structure has changed

Either the window name of the application or the underlying structure of the UI element has changed. Therefore, the UI selector initially used to locate the element is no longer applicable.

### Resolution

Ensure that the selector of the UI element is valid. You should navigate to the Selector builder window, where you may: 
1. Test the selector. Power Automate enables you to test a selector and ensure that your UI automation flows are running as expected. With the ability to test both desktop and web selectors, you can quickly and efficiently automate your application and webpage interactions. Learn more [here](https://learn.microsoft.com/power-automate/desktop-flows/test-selectors).
1. Capture an additional selector for the specific UI element through the 'New' button.
1. Repair the selector of the UI element, by clicking on the Repair option and follow the steps. Repair selector is a powerful feature that enables you to easily and intuitively correct invalid selectors. By automatically generating a repaired selector for the UI element that automation needs to interact with, Power Automate for desktop makes it simple to maintain automation flows.  Learn more [here](https://learn.microsoft.com/power-automate/desktop-flows/repair-selector).
1. If repair feature cannot fix the selector automatically, then you should manually edit the selector and create a more robust selector by editing the attributes, their values and the operands used in the selector of the UI element. To achieve that, capture again the element after the failure, and compare the new selector with the old one to identify the differences. There may be one or more elements or attributes that are different. Edit the selector to make sure that it contains only static elements or attributes that aren't going to change. For example, if the window name has a dynamic part at the end, instead of "Name – Equal to – MyWindowName (2)", it could be modified to "Name – Starts with - MyWindowName". In general, you should remove any dynamic values like numbers and modify the relevant Operators accordingly ("Starts with", "Ends with", "Contains" and so on.) or remove entire elements from the selector path if necessary. Learn more [here](https://learn.microsoft.com/power-automate/desktop-flows/build-custom-selectors).
1. The UI element may not be available at the execution. Consider adding a 'Wait for window content' action or a 'Wait for web page content' action respectively.
1. Note that something may have changed in the application (e.g., its version is upgraded) or on the web page underline code, and the selector of UI element could be different. In this case, you must recapture the UI element.

#### Alternative resolution

Surface automation can be used as an alternative way to automate the application. For best practices, see [How to automate with Mouse, Keyboard and OCR](https://support.microsoft.com/topic/how-to-automate-with-mouse-keyboard-and-ocr-e1c09a7f-7bf6-40a9-bf83-8ebb5a2e935c).

## Cause 4: More elevated privileges are running

The application runs with more elevated privileges than Power Automate for desktop.

### Resolution

Both the application and Power Automate for desktop should run with the same privileges.

Power Automate for desktop doesn't run elevated by default. Hence, uncheck the **Run this program as an administrator** checkbox in the **Compatibility** section of the application's **Properties** window.

Another option is to set Power Automate for desktop to run as admin as well.

Learn more [here](https://learn.microsoft.com/power-automate/desktop-flows/how-to/run-power-automate-elevated-rights).

## More information

To solve the other error messages that you may receive when a UI automation action fails, see [Error occurs when a desktop flow action fails to get a UI element](failed-get-ui-element.md).
