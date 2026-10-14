---
title: Fix Failed to Get UI Element or Failed to Get Window Errors
description: Resolve the Failed to get UI element or Failed to get window error in Power Automate for desktop by testing, repairing, or recapturing UI element selectors.
ms.reviewer: chtzirtz, iomimtso, adanas, nimoutzo, v-shaywood
ms.date: 09/24/2026
ms.custom: sap:Desktop flows\UI or browser automation
ai-usage: ai-assisted
---
# UI automation action fails with "Failed to get UI element" or "Failed to get window" error

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003385

## Summary

A [UI automation action](/power-automate/desktop-flows/actions-reference/uiautomation) in Power Automate for desktop might fail with a "Failed to get UI element" or "Failed to get window" error. These errors typically occur when the target application's window name or UI element structure changes, when the UI element isn't available on the screen, when the selector is incorrect, or when the application runs with elevated rights. This article covers these causes and provides solutions including testing and repairing selectors, recapturing UI elements, and adjusting application permissions. It also explains how selector variations and combinators affect flow performance.

## Symptoms

A UI automation action fails with one of the following error messages in Power Automate:

- > Failed to get UI element
- > Failed to get window

Power Automate for desktop can interact with the element successfully when you first capture it during authoring a desktop flow. However, the error occurs during subsequent executions.

## Application's window name or UI element isn't available on the screen

### Solution

Ensure that the UI element or the screen (window) is available at the display when the action runs.

## UI element selected in the corresponding action isn't correct

### Solution

Ensure the action's UI element input parameter is populated with the correct UI element from the list.

## Application window name or element structure changed

The application window name or the underlying structure of the UI element changed. The UI selector you initially used to locate the element no longer works.

### Solution

Ensure the selector of the UI element is valid. Go to the **Selector builder** window, and then follow these steps:

1. [Test the selector](/power-automate/desktop-flows/test-selectors). 

   Power Automate enables you to test a selector and ensure that your UI automation flows are running as expected. By testing both desktop and web selectors, you can automate your application and webpage interactions quickly and efficiently.

1. Capture an additional selector for the specific UI element through the **New** button.

1. [Repair the selector](/power-automate/desktop-flows/repair-selector) of the UI element. 

   The **Repair** selector feature enables you to correct invalid selectors easily and intuitively. By automatically generating a repaired selector for the UI element that automation needs to interact with, Power Automate for desktop makes it simple to maintain automation flows.

1. If the repair feature can't fix the selector automatically, manually edit the selector to create a more robust selector. You can edit the attributes, their values, and operands used in the selector of the UI element. 

   To achieve this goal, capture the element again after the failure, and compare the new selector with the old one to identify the differences. There might be one or more different elements or attributes. Edit the selector to ensure it contains only static elements or attributes that don't change. For example, if the window name has a dynamic part at the end, modify it to "Name – Starts with - MyWindowName" instead of "Name – Equal to – MyWindowName (2)". In general, remove any dynamic values like numbers and modify the relevant operators  (**Starts with**, **Ends with**, **Contains**, and so on) accordingly. Or remove the entire element from the selector path if necessary. For more information, see [Build a custom selector](/power-automate/desktop-flows/build-custom-selectors).

1. If the UI element isn't available at execution time, consider adding a [Wait for window content](/power-automate/desktop-flows/actions-reference/uiautomation#waitforwindowcontentaction) or [Wait for web page content](/power-automate/desktop-flows/actions-reference/webautomation#waitforwebpagecontentaction) action respectively.

1. Note that something might have changed in the application (for example, a version upgrade) or in the underlying code of the web page, and the selector of the UI element might be different. In this case, recapture the UI element.

### Alternative solution

Use surface automation as an alternative way to automate the application. For best practices, see [Automate with mouse, keyboard, and OCR actions (recommended for automation in VDI)](/power-automate/desktop-flows/how-to/automate-using-mouse-keyboard-ocr).

## Selector variations and flow performance

Selector variations are backup selectors that help locate a UI element when its main selector doesn't match. This feature makes your flows more resilient to small changes in the target application.

There's a performance trade-off. At runtime, the flow tries the variations one at a time, in order, and stops as soon as one matches. Each variation that the flow tries before a match runs a fresh search of the screen or web page, which takes a little time:

- If the first selector matches, there's no extra cost. This is the typical case.
- If the first few selectors don't match, each attempt adds a small delay before the right one is found.
- If the element isn't present at all, the flow tries every variation before it gives up. This cycle can repeat while the flow waits for the element to appear.

To keep flows fast:

- Add variations only when you need the extra reliability.
- Put your most dependable selector first, so it usually matches on the first try.
- Be especially mindful of elements used inside loops or in actions that run many times, where small delays add up.
- Prefer child combinators over descendant combinators in your selectors. A child combinator (`<ParentElement> > <ChildElement>`) matches only direct children. A descendant combinator (`<AncestorElement> <DescendantElement>`) searches every level of the subtree, so it takes longer to resolve.

In short, a few well-chosen variations improve reliability with little cost, while a long list of rarely needed variations can slow things down.

## Application runs with elevated rights

The application you're interacting with runs with more elevated rights than Power Automate for desktop.

### Solution

Both the application and Power Automate for desktop should run with the same rights. To match their rights, use one of these options:

- [Run Power Automate with elevated rights](/power-automate/desktop-flows/how-to/run-power-automate-elevated-rights).

- Clear the **Run this program as an administrator** checkbox in the **Compatibility** section of the application's **Properties** window.

## Related content

- [Error occurs when a desktop flow action fails to get a UI element](failed-get-ui-element.md)
- [UIPI issues with UI and browser automation actions](uipi-issues.md)
