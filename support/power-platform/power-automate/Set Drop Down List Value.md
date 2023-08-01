---
title: Set Drop Down List Value action fails as list value cannot be found
description: Provides a resolution when Set Drop Down List Value action fails because list value cannot be found.
ms.reviewer: nimoutzo
ms.date: 08/01/2023
ms.subservice: power-automate-desktop-flows
---
# List value specified in the Set drop-down list value action cannot be found at runtime

This article provides a resolution when Set Drop Down List Value action fails because list value cannot be found.

_Applies to:_ &nbsp; Power Automate

## Symptoms
1. The action Set drop-down list value is failing with an error message "Failed to perform the requested operation on the drop-down list. Drop down list was not found”.
2. The action runs successfully but the option is not getting selected, and no error is generated during runtime
## Error code
UIAutomation.SelectOptionInDropDownError

## Cause
- Symptom 1: The selector of the drop-down element fails to locate it successfully (the element's selector might not be correct)
- Symptom 2: For an unspecified reason the action fails to select the option element from the drop down.

## Resolution
- Symptom 1:

Check if the element selector of the drop-down element is correct. You can use the "Test Selector" in Selector Builder to verify this. If the selector is not valid you can use the Repair Selector  to fix the selector Repair Selector. (Applies both actions of the UI automation and Browser automation groups.)
- Symptom 2:

1. If you have set the input parameter ‘Operation’ with the value "Select options by name", try using the "Select options by index" by providing the specific index of the element in the drop-down list (Applies both actions of the UI automation and Browser automation groups).
2. If the above is not fixing the issue, please replace the Set drop-down list value with two successive "Click Element In Window" or “Click link on web page“ actions (Applies for actions of the UI automation and Browser automation groups).
    - The first "Click Element In Window" (UI Automation) or "Click link on web page" (Browser Automation) should use the element that expands the list of options (usually an arrow button)
    - The second "Click Element In Window"(UI Automation) or "Click link on web page" (Browser Automation) should use as element the option that needs to be selected
3. If the above is not fixing the issue, and the drop-down list has filter functionality e.g: we can type text or part of text on the dropdown and suggestions for selection appear (Applies for actions of the UI automation and Browser automation groups).
    - When using UI automation, use the "Populate text field in window" and set in the Text Box parameter the drop-down list element and in the Text To fill-in parameter the text that is shown in the corresponding option.
    - When using Browser automation, use the “Populate text field on web page” set in the UI Element parameter the drop-down list element and in the Text parameter the text that is shown in the corresponding option
4. Use "Click Element In Window" to send a click on the drop down in order to get focus and then "Send Keys" with option Send Keys to: Foreground Window and Text to send the text that is show in the corresponding option followed by {Enter}. (Applies for actions of the UI automation group)
