---
title: Troubleshoot Incorrect UI Element Clicked or Populated in Desktop Flow
description: Resolve issues in Power Automate of desktop targeting the wrong UI element during automation. Learn how to ensure accurate clicks and text population.
ms.reviewer: iomimtso, nimoutzo, v-shaywood
ms.date: 11/26/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Wrong UI element is clicked or populated in desktop flow

This article resolves an issue in which Power Automate for desktop interacts with the wrong UI element instead of the element that you captured during flow design. This issue occurs even though the [Test Selector](/power-automate/desktop-flows/test-selectors) tool detects the right element.

## Symptoms

When you run a desktop flow that includes UI automation actions such as [Click UI element in window](/power-automate/desktop-flows/actions-reference/uiautomation#click) or [Populate text field in window](/power-automate/desktop-flows/actions-reference/uiautomation#populatetextfield), the flow interacts with a different UI element than the one that you originally captured.

You might observe the following symptoms:

- The action runs without errors but targets an unexpected element.
- The wrong element receives the click or text input during runtime.
- The [Test Selector](/power-automate/desktop-flows/test-selectors) tool successfully identifies the correct element during design time.

## Cause

This issue occurs because the target application handles focus, enable, or disable events in an unexpected way. Some applications dynamically change element focus or states. This functionality can cause UI automation actions to interact with the wrong element.

## Solution

To resolve this issue, use a combination of UI automation and mouse and keyboard actions to ensure proper element targeting. Use one of the following methods based on whether you have to click or populate text.

### Click an element by using hover and mouse click

Instead of using the [Click UI element in window](/power-automate/desktop-flows/actions-reference/uiautomation#click) action, follow these steps:

1. Add a [Hover mouse over UI element in window](/power-automate/desktop-flows/actions-reference/uiautomation#hoveronelement) action, and select the target UI element.
1. Add a [Send mouse click](/power-automate/desktop-flows/actions-reference/mouseandkeyboard#sendmouseclick) action, placed immediately after the hover action, to click the element.

To prevent focus-related issues, this approach makes sure that the element receives focus through the hover action before the click is sent.

### Populate a text field by using focus and send keys

Instead of using the [Populate text field in window](/power-automate/desktop-flows/actions-reference/uiautomation#populatetextfield) action, follow these steps:

1. Add a [Focus text field in window](/power-automate/desktop-flows/actions-reference/uiautomation#focustextfield) action, and select the target text field.
1. Add a [Send keys](/power-automate/desktop-flows/actions-reference/mouseandkeyboard#sendkeys) action to input the desired text.

To make sure that text is entered in the intended field, this approach explicitly sets the focus to the correct text field before the keystrokes are sent.
