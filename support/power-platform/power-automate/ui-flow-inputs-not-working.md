---
title: UI flow inputs not working
description: Troubleshooting UI flow inputs not working issue.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# UI flow inputs not working

This article provides steps to solve the UI flow inputs not working issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555723

## Symptoms

Input not getting inserted into the field that was selected.

## Verifying issue

Check [Known issues and solutions](/power-automate/desktop-flows/create-desktop#known-issues-and-solutions).

## Solving steps

Make sure that the input field

- Is not a read-only field(verified by checking if you can type in it normally).
- There wasn't an extra click between selecting the field and the recorder.
- The input field can be used normally by you while not recording & there are no input restrictions imposed by the application on it.

## Best practices

- Set focus to the input field by selecting it before selecting the **Use Input** option.
- Clear the field in the recording before selecting the **Use Input** option. One way to clear an input field during recording is to:

    1. Select the input field.
    2. Press Ctrl+A key combination to select the text in the input field.
    3. Press the Backspace key to clear the input field.
- Make sure a blue highlight appears around the textbox when selecting it.
- Getting started: [Use inputs and outputs in Windows recorder (V1) flows](/power-automate/desktop-flows/inputs-outputs-desktop).
