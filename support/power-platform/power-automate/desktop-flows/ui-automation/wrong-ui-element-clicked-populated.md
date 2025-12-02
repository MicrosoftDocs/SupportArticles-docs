---
title: Troubleshoot Incorrect UI Element Clicked or Populated in Desktop Flow
description: Resolve issues with Power Automate for desktop targeting the wrong UI element during automation. Learn how to ensure accurate clicks and text population.
ms.reviewer: iomimtso, nimoutzo, v-shaywood
ms.date: 11/26/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Wrong UI element is clicked or populated in desktop flow

This article provides a solution for an issue where Power Automate for desktop interacts with the wrong UI element instead of the element you captured during flow design, even though the Test Selector tool detects the right element.

## Symptoms

When you run a desktop flow that includes UI automation actions such as _Click UI element in window_ or _Populate text field in window_, the flow interacts with a different UI element than the one you originally captured.

You might observe the following symptoms:

- The action executes without errors but targets an unexpected element
- The wrong element receives the click or text input during runtime
- The _Test Selector_ tool successfully identifies the correct element during design time

## Cause

This issue occurs when the target application handles focus, enable, or disable events in an unexpected way. Some applications dynamically change element focus or states, which can cause UI automation actions to interact with the wrong element.

## Resolution

To resolve this issue, use a combination of UI automation along with mouse and keyboard actions to ensure proper element targeting. Choose one of the following methods based on whether you need to click or populate text.

### Click an element by using hover and mouse click

Instead of using the **Click UI element in window** action, use the following steps:

1. Add a **Hover mouse over UI element in window** action and select the target UI element.
1. Add a **Send mouse click** action immediately after to click the element.

This approach ensures the element receives focus through the hover action before the click is sent, preventing focus-related issues.

### Populate a text field by using focus and send keys

Instead of using the **Populate text field in window** action, use the following steps:

1. Add a **Focus text field in window** action and select the target text field.
1. Add a **Send keys** action to input the desired text.

This approach explicitly sets focus to the correct text field before sending keystrokes, ensuring text is entered in the intended field.
