---
title: Failed to get element or window or element or window wasn't found error
description: Provides a resolution to solve the error message that you receive when a UI automation action fails in Power Automate.
ms.reviewer: pefelesk
ms.date: 9/21/2022
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

## Cause 1: Application's window name or element's underlying structure has changed

Either the window name of the application or the underlying structure of the element has changed. Therefore, the UI selector initially used to locate the element is no longer applicable.

### Resolution

Edit the UI selector of the element to create a new more robust UI selector. It will be able to locate the element even if the window name or the underlying structure of the element is dynamic. Any parts of the selector that are dynamic should be removed.

To achieve that, capture again the element after the failure, and compare the new selector with the old one to identify the differences.

> [!NOTE]
> The selector of each UI element consists of two (2) parts. The Window selector, and the element's selector within that window.
>
> :::image type="content" source="media/ui-automation-action-fails-errors/ui-elements-window.png" alt-text="The two parts of the selector of each UI element." border="false":::

Now identify the element or attribute that has changed in either one of the above. There may be one or more elements or attributes that are different.

UI selectors can be reviewed and edited through the **Selector builder** window:

:::image type="content" source="media/ui-automation-action-fails-errors/selector-builder-window.png" alt-text="You can review and edit UI selectors in the Selector builder window.":::

Edit the selector to make sure that it contains only static elements or attributes that aren't going to change.

For example, if the window name has a dynamic part at the end, instead of "Name – Equal to – MyWindowName (2)", it could be modified to "Name – Starts with - MyWindowName".

In general, the below methods could be followed:

- Remove any dynamic values like numbers and modify the relevant Operators accordingly ("Starts with", "Ends with", "Contains" and so on.)
- Remove entire elements from the selector path if necessary.

#### Alternative resolution

Surface automation can be used as an alternative way to automate the application. For best practices, see [How to automate with Mouse, Keyboard and OCR](https://support.microsoft.com/topic/how-to-automate-with-mouse-keyboard-and-ocr-e1c09a7f-7bf6-40a9-bf83-8ebb5a2e935c).

## Cause 2: More elevated privileges are running

The application runs with more elevated privileges than Power Automate for desktop.

### Resolution

Both the application and Power Automate for desktop should run with the same privileges.

Power Automate for desktop doesn't run elevated by default. Hence, uncheck the **Run this program as an administrator** checkbox in the **Compatibility** section of the application's **Properties** window.

Another option is to set Power Automate for desktop to run as admin as well.
