---
title: Wrong UI element is clicked or populated in desktop flow
description: Resolves an issue where Power Automate for desktop clicks or populates the wrong UI element instead of the captured element due to application focus handling.
ms.reviewer: nimoutzo
ms.author: iomimtso
ms.date: 2025-11-26
ms.custom: sap:Desktop flows\UI or browser automation
---
# Wrong UI element is clicked or populated in desktop flow

This article provides a resolution for an issue where Power Automate for desktop interacts with the wrong UI element instead of the element you captured during flow design even though the Test Selector tool detects the right element.

## Symptoms

When you run a desktop flow that includes UI automation actions such as **Click UI element in window** or **Populate text field in window**, the flow interacts with a different UI element than the one you originally captured.

You might observe the following:

- The action executes without errors but targets an unexpected element
- The wrong element receives the click or text input during runtime
- The **Test Selector** tool successfully identifies the correct element during design time

## Cause

This issue occurs when the target application handles focus or enable/disable events in an unexpected manner. Some applications dynamically change element focus or states, which can cause UI automation actions to interact with the wrong element.

## Resolution

To resolve this issue, use a combination of UI automation and Mouse and keyboard actions to ensure proper element targeting. Choose the appropriate method based on whether you need to click or populate text.

### Click an element using hover and mouse click

Instead of using the **Click UI element in window** action alone, use this sequence:

1. Add a **Hover mouse over UI element in window** action and select the target UI element.
2. Add a **Send mouse click** action immediately after to click the element.

This approach ensures the element receives focus through the hover action before the click is sent, preventing focus-related issues.

### Populate a text field using focus and send keys

Instead of using the **Populate text field in window** action alone, use this sequence:

1. Add a **Focus text field in window** action and select the target text field.
2. Add a **Send keys** action to input the desired text.

This approach explicitly sets focus to the correct text field before sending keystrokes, ensuring text is entered in the intended field.
