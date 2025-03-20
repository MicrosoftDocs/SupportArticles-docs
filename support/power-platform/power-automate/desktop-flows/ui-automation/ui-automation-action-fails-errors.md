---
title: Failed to get UI element or Failed to get window error
description: Provides solutions to the error messages that you receive when a UI automation action fails in Power Automate.
ms.reviewer: pefelesk, nimoutzo
ms.date: 07/27/2023
ms.custom: sap:Desktop flows\UI or browser automation
---
# UI automation action fails with "Failed to get UI element" or "Failed to get window" error

This article helps you resolve error messages that you may receive when a [UI automation action](/power-automate/desktop-flows/actions-reference/uiautomation) fails in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003385

## Symptoms

A UI automation action fails with one of the following error messages in Power Automate:

- > Failed to get UI element
- > Failed to get window

## Verifying issue

Power Automate for desktop is able to interact with the element successfully when it's first captured during authoring a desktop flow.

## Cause 1: Application's window name or UI element isn't available on the screen

#### Resolution

Ensure that the UI element or the screen (window) is available at the display at the execution of the action.

## Cause 2: UI element selected in the corresponding action isn't correct

#### Resolution

Ensure the action's UI element input parameter is populated with the correct UI element from the list.

## Cause 3: Application's window name or element's underlying structure has changed

Either the window name of the application or the underlying structure of the UI element has changed. Therefore, the UI selector initially used to locate the element is no longer applicable.

#### Resolution

To solve this issue, ensure that the selector of the UI element is valid. To do this, navigate to the **Selector builder** window, and then follow these steps:

1. [Test the selector](/power-automate/desktop-flows/test-selectors). 

   Power Automate enables you to test a selector and ensure that your UI automation flows are running as expected. With the ability to test both desktop and web selectors, you can automate your application and webpage interactions quickly and efficiently.

2. Capture an additional selector for the specific UI element through the **New** button.

3. [Repair the selector](/power-automate/desktop-flows/repair-selector) of the UI element. 

   The **Repair** selector is a powerful feature that enables you to correct invalid selectors easily and intuitively. By automatically generating a repaired selector for the UI element that automation needs to interact with, Power Automate for desktop makes it simple to maintain automation flows.

4. If the repair feature can't fix the selector automatically, you need to manually edit the selector to create a more robust selector. You can edit the attributes, their values, and operands used in the selector of the UI element. 

   To achieve that, capture the element again after the failure, and compare the new selector with the old one to identify the differences. There may be one or more different elements or attributes. Edit the selector to make sure that it contains only static elements or attributes that won't change. For example, if the window name has a dynamic part at the end, it can be modified to "Name – Starts with - MyWindowName" instead of "Name – Equal to – MyWindowName (2)". In general, you should remove any dynamic values like numbers and modify the relevant operators  (**Starts with**, **Ends with**, **Contains**, and so on) accordingly. Or you should remove the entire element from the selector path if necessary. For more information, see [Build a custom selector](/power-automate/desktop-flows/build-custom-selectors).

5. If the UI element isn't available at the execution time, consider adding a "Wait for window content" or "Wait for web page content" action respectively.

6. Note that something may have changed in the application (for example, a version upgrade) or on the web page underline code, and the selector of the UI element might be different. In this case, you must recapture the UI element.

#### Alternative resolution

Surface automation can be used as an alternative way to automate the application. For best practices, see [How to automate with Mouse, Keyboard and OCR](https://support.microsoft.com/topic/how-to-automate-with-mouse-keyboard-and-ocr-e1c09a7f-7bf6-40a9-bf83-8ebb5a2e935c).

## Cause 4: Application to interact with runs with elevated rights

The application runs with more elevated rights than Power Automate for desktop.

#### Resolution

Both the application and Power Automate for desktop should run with the same rights.

By default, Power Automate for desktop doesn't run with elevated rights. You can set Power Automate for desktop to run as administrator as well. For more information, see [Run Power Automate with elevated rights](/power-automate/desktop-flows/how-to/run-power-automate-elevated-rights).

Another option is to clear the **Run this program as an administrator** checkbox in the **Compatibility** section of the application's **Properties** window.

## More information

To solve the other error messages that you may receive when a UI automation action fails, see [Error occurs when a desktop flow action fails to get a UI element](failed-get-ui-element.md).
