---
title: UI flow outputs not working
description: Troubleshooting the issue that output is not successfully captured from the field that was selected.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# UI flow outputs not working

This article provides steps to solve the issue that UI flow outputs not working issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555745

## Symptoms

Output is not successfully captured from the field that was selected.

## Verifying issue

Check [Known issues and solutions](/power-automate/desktop-flows/create-desktop#known-issues-and-solutions).

## Solving steps

- Make sure that the output text is in a readable field.
- Make sure there is not an extra click action between selecting the recorder and selecting the field.
- If it does happen, you can identify and delete the extra step in the recorder later. For more information, see [Edit Windows recorder (V1) flows](/power-automate/desktop-flows/edit-desktop).

## Best practices

- Select the field you intend to get the output from. A blue highlight will appear around it indicating focus.
- Select the **Use Output** option and follow the prompt.
- The popup should have all the text in the scope of the field that was selected.
- If the output is empty, make sure that the field is read-enabled:

  1. Stop the recording
  2. Select the output field.
  3. Press Ctrl+A to select the text in the output field.
  4. Press Ctrl+C to select the text in the output field.
  5. Paste the text by pressing Ctrl+V.
  6. If you are not able to see any text here, the field cannot be used to read text using Use Output.

- Getting started: [Use inputs and outputs in Windows recorder (V1) flows](/power-automate/desktop-flows/inputs-outputs-desktop).
