---
title: Troubleshoot UI Automation Action Failures After a Block Input Action
description: Resolves an issue in which UI or web automation actions fail after a Block Input action in Power Automate for desktop. 
ms.reviewer: iomimtso, nimoutzo, jspantouris, v-shaywood
ms.date: 11/21/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# UI automation actions fail after Block Input action

This article provides solutions for an issue in which UI or web automation actions that involve mouse or keyboard input don't work as expected after you use a _Block Input_ action in Power Automate for desktop.

## Symptoms

When you run a desktop flow that includes a Block Input action by having the **Block It** parameter set to **True**, subsequent UI or web automation actions might not work as expected. The flow continues to the next actions without showing any errors, but the mouse or keyboard interactions aren't run.

The following actions might not work correctly after a Block Input action:

- Populate text field in window
- Press button in window
- Select radio button in window
- Set checkbox state in window
- Set drop-down list value in window
- Click UI element in window
- Select tab in window
- Hover mouse over UI element in window
- Click link on web page (if the **Send Physical Click** option is enabled)
- Populate text field on web page (if the **Populate text using physical keystrokes** option is enabled)
- Send keys

## Cause

The Block Input action requires elevated rights to run because of its critical functionality. If Block Input is active by having **Block It** set to **True**, the action can interfere with subsequent UI or web automation actions that require physical mouse or keyboard input.

> [!NOTE]
> The Block Input action works only when you:
>
> - Run a desktop flow through the console or debug it through the designer.
> - Run Power Automate for desktop runs by having elevated rights.
>
> For more information, see [Run Power Automate with elevated rights](/power-automate/desktop-flows/how-to/run-power-automate-elevated-rights).

## Solution 1: Don't use the Block Input action

To prevent this issue, design your flow without the Block Input action, if possible.

## Solution 2: Use alternative mouse and keyboard actions

If you have to use Block Input and perform mouse actions, use one of the following actions from the _Mouse and keyboard_ category instead of UI automation actions. For more information, see [Mouse and keyboard actions reference](/power-automate/desktop-flows/actions-reference/mouseandkeyboard).

### Alternative A: Use Move mouse and Send mouse click actions

1. Use the **Move mouse** action to move the mouse pointer to a specific position.
1. Use the **Send mouse click** action to perform the click.

The **Move mouse** action requires you to specify coordinates. Use the **Relative to** parameter to specify whether the new mouse position is relative to:

- **Current Mouse Position**
- **Active Window** (the foremost window)
- **Screen** (relative to the upper-left corner of the screen)

### Alternative B: Use Move mouse to Image action

Use the **Move mouse to Image** action by having the **Send Click after moving mouse** option enabled. This action moves the mouse to the position of a specified image on the screen, and then sends a click.

### Alternative C: Use Move mouse to Text on Screen (OCR) action

Use the **Move mouse to Text on Screen (OCR)** action by having the **Send a click after moving mouse** option enabled. This action uses optical character recognition (OCR) to locate text on the screen, moves the mouse to that position, and then sends a click.

### Solution 3: Temporarily disable Block Input

If you have to use Block Input but also have to perform actions that require physical input, use the following method:

1. If you need input blocked, use the **Block Input** action by having **Block It** set to **True**.
1. Before you run a UI or web automation action that requires mouse or keyboard input, add a **Block Input** action that has **Block It** set to **False**.
1. Run the UI or web automation action.
1. If you still have to block input after the action runs, add another **Block Input** action that has **Block It** set to **True**.

This method lets you temporarily enable physical input for specific actions and also maintains input blocking for the rest of the flow.
