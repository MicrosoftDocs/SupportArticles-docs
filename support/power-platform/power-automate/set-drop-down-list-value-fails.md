---
title: Set drop-down list value action fails because the list value can't be found
description: Provides a resolution for an issue where the "Set drop-down list value" action fails because the list value can't be found.
ms.reviewer: nimoutzo
ms.date: 08/09/2023
ms.subservice: power-automate-desktop-flows
---
# The list value specified in the "Set drop-down list value" action can't be found at runtime

This article provides a resolution for an issue where the "Set drop-down list value" action fails with the "UIAutomation.SelectOptionInDropDownError" error code because the list value can't be found.

_Applies to:_ &nbsp; Power Automate

## Symptom 1

The "Set drop-down list value" action fails with the following error message:

> Failed to perform the requested operation on the drop-down list. Drop down list was not found.

#### Cause

The selector of the drop-down element fails to locate it successfully. The element's selector might not be correct.

#### Resolution

You can use the test selector feature in the selector builder window to check if the element selector of the drop-down element is correct. If the selector is invalid, use the repair selector feature to fix it. This resolution applies to both actions of the UI automation and Browser automation groups.

## Symptom 2

The "Set drop-down list value" action runs successfully but the option element isn't selected, and no error occurs during runtime.

#### Cause

The "Set drop-down list value" action fails to select the option element from the drop-down list.

#### Resolution

- For actions of the UI automation and Browser automation groups,
  
  1. If you have set the **Operation** input parameter with the **Select option(s) by name** value, try to use the **Select options by index** value by providing a specific index of the element in the drop-down list.
  2. If the above step doesn't fix the issue, replace the "Set drop-down list value" action with two successive "Click element in window" or "Click link on web page" actions. 
      - The first "Click element in window" (UI automation) or "Click link on web page" (Browser automation) should use an element (usually an arrow button) that can expand the list of options.
      - The second "Click element in window" (UI automation) or "Click link on web page" (Browser automation) should use an option element that needs to be selected.
  3. If the above steps don't fix the issue, and the drop-down list has filter functionality, you can type text or part of text in the drop-down list to get some suggestions for selection. 
      - Use the "Populate text field in window" action in UI automation. Set the **Text Box** parameter using the drop-down list element, and set the **Text to fill-in** parameter using the text that's shown in the corresponding option.
      - Use the "Populate text field on web page" action in Browser automation. Set the **UI Element** parameter using the drop-down list element, and set the **Text** parameter using the text that's shown in the corresponding option.

- For the actions of the UI automation group,

  Use the "Click element in window" action to send a click to the drop-down list to get focus. Then, use the "Send Keys" action by setting the **Send keys to** option as **Foreground window** and setting the **Text to send** option using the text followed by `{Enter}` that's shown in the corresponding option.
