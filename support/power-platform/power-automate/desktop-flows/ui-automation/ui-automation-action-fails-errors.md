---
title: Failed to get UI element or Failed to get window error
description: Provides solutions to the error messages that you receive when a UI automation action fails in Power Automate.
ms.reviewer: chtzirtz, iomimtso, adanas, nimoutzo, v-shaywood
ms.date: 04/03/2026
ms.custom: sap:Desktop flows\UI or browser automation
---
# UI automation action fails with "Failed to get UI element" or "Failed to get window" error

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003385

## Summary

A [UI automation action](/power-automate/desktop-flows/actions-reference/uiautomation) in Power Automate for desktop might fail with a "Failed to get UI element" or "Failed to get window" error. These errors typically occur when the target application's window name or UI element structure has changed, when the UI element isn't available on the screen, when the selector is incorrect, or when the application runs with elevated rights. This article covers these causes and provides solutions including testing and repairing selectors, recapturing UI elements, and adjusting application permissions.

## Symptoms

A UI automation action fails with one of the following error messages in Power Automate:

- > Failed to get UI element
- > Failed to get window

Power Automate for desktop is able to interact with the element successfully when it's first captured during authoring a desktop flow. However, the error occurs during subsequent executions.

## Application's window name or UI element isn't available on the screen

#### Solution

Ensure that the UI element or the screen (window) is available at the display at the execution of the action.

## UI element selected in the corresponding action isn't correct

#### Solution

Ensure the action's UI element input parameter is populated with the correct UI element from the list.

## Application's window name or element's underlying structure has changed

Either the window name of the application or the underlying structure of the UI element has changed. Therefore, the UI selector initially used to locate the element is no longer applicable.

#### Solution

To solve this issue, ensure that the selector of the UI element is valid. To do this, navigate to the **Selector builder** window, and then follow these steps:

1. [Test the selector](/power-automate/desktop-flows/test-selectors). 

   Power Automate enables you to test a selector and ensure that your UI automation flows are running as expected. With the ability to test both desktop and web selectors, you can automate your application and webpage interactions quickly and efficiently.

2. Capture an additional selector for the specific UI element through the **New** button.

3. [Repair the selector](/power-automate/desktop-flows/repair-selector) of the UI element. 

   The **Repair** selector is a powerful feature that enables you to correct invalid selectors easily and intuitively. By automatically generating a repaired selector for the UI element that automation needs to interact with, Power Automate for desktop makes it simple to maintain automation flows.

4. If the repair feature can't fix the selector automatically, you need to manually edit the selector to create a more robust selector. You can edit the attributes, their values, and operands used in the selector of the UI element. 

   To achieve this goal, capture the element again after the failure, and compare the new selector with the old one to identify the differences. There may be one or more different elements or attributes. Edit the selector to make sure that it contains only static elements or attributes that won't change. For example, if the window name has a dynamic part at the end, you can modify it to "Name – Starts with - MyWindowName" instead of "Name – Equal to – MyWindowName (2)". In general, remove any dynamic values like numbers and modify the relevant operators  (**Starts with**, **Ends with**, **Contains**, and so on) accordingly. Or remove the entire element from the selector path if necessary. For more information, see [Build a custom selector](/power-automate/desktop-flows/build-custom-selectors).

5. If the UI element isn't available at the execution time, consider adding a [Wait for window content](/power-automate/desktop-flows/actions-reference/uiautomation#waitforwindowcontentaction) or [Wait for web page content](/power-automate/desktop-flows/actions-reference/webautomation#waitforwebpagecontentaction) action respectively.

6. Note that something may have changed in the application (for example, a version upgrade) or on the web page underline code, and the selector of the UI element might be different. In this case, you must recapture the UI element.

#### Alternative solution

You can use surface automation as an alternative way to automate the application. For best practices, see [Automate with mouse, keyboard, and OCR actions (recommended for automation in VDI)](/power-automate/desktop-flows/how-to/automate-using-mouse-keyboard-ocr).

## Application to interact with runs with elevated rights

The application you're interacting with runs with more elevated rights than Power Automate for desktop.

#### Solution

Both the application and Power Automate for desktop should run with the same rights. To achieve this, use one of these options:

- [Run Power Automate with elevated rights](/power-automate/desktop-flows/how-to/run-power-automate-elevated-rights).

- Clear the **Run this program as an administrator** checkbox in the **Compatibility** section of the application's **Properties** window.

## Related content

- [Error occurs when a desktop flow action fails to get a UI element](failed-get-ui-element.md)
- [UIPI issues with UI and browser automation actions](uipi-issues.md)
