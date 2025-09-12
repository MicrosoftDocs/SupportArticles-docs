---
title: Set drop-down list value in window/on web page action fails because the list value can't be found
description: Provides a resolution for an issue where the Set drop-down list value in window/on web page action fails because the list value can't be found in Microsoft Power Automate.
ms.reviewer: nimoutzo
ms.date: 08/22/2023
ms.custom: sap:Desktop flows\UI or browser automation
---
# The list value specified in the "Set drop-down list value in window/on web page" action can't be found at runtime

This article provides a resolution for an issue where the [Set drop-down list value in window](/power-automate/desktop-flows/actions-reference/uiautomation#setdropdownlistvalueinwindow) action fails with the "UIAutomation.SelectOptionInDropDownError" error code or the [Set drop-down list value on web page](/power-automate/desktop-flows/automation-web#enter-data-on-webpages) action fails with the "WebAutomation.SetDropDownListValueError" error code because the list value in both actions can't be found.

_Applies to:_ &nbsp; Power Automate

## Symptom 1

The **Set drop-down list value on web page** or **Set drop-down list value in window** action fails with the following error message:

> Failed to perform the requested operation on the drop-down list. Drop down list was not found.

#### Cause

The selector of the drop-down element fails to locate the drop-down UI element successfully. The element's selector might be incorrect.

#### Resolution

Use [Test selector](/power-automate/desktop-flows/test-selectors) in the selector builder window to check if the element selector of the drop-down element is correct. If the selector is invalid, use the [Repair](/power-automate/desktop-flows/repair-selector) option to fix it. This resolution applies to both the UI automation and Browser automation group actions.

## Symptom 2

The **Set drop-down list value on web page** or **Set drop-down list value in window** action runs successfully, but the option element isn't selected, and no error occurs during runtime.

#### Cause

The **Set drop-down list value on web page** or **Set drop-down list value in window** action fails to select the option element from the drop-down list.

#### Resolution

- For the actions of the UI automation and Browser automation groups, try the following options in order:

  Option 1: If you've set the **Operation** input parameter with the **Select option(s) by name** value, try to use the **Select options by index** value by providing a specific index of the element in the drop-down list.

  Option 2: If option 1 doesn't fix the issue, replace the **Set drop-down list value on web page** action with two successive [Click UI element in window](/power-automate/desktop-flows/actions-reference/uiautomation#click) or [Click link on web page](/power-automate/desktop-flows/actions-reference/webautomation#clickbase) actions.

  - The first **Click UI element in window** (UI automation) or **Click link on web page** (Browser automation) should use an element (usually an arrow button) that can expand the list of options.
  - The second **Click UI element in window** (UI automation) or **Click link on web page** (Browser automation) should use an option element that needs to be selected.

  Option 3: If the above two options don't fix the issue, and the drop-down list has filter functionality, you can type text or part of the text in the drop-down list to get some suggestions for selection.

  - Use the **Populate text field in window** action in UI automation. Set the **Text Box** parameter using the drop-down list element, and set the **Text to fill-in** parameter using the text shown in the corresponding option.
  - Use the **Populate text field on web page** action in Browser automation. Set the **UI Element** parameter using the drop-down list element, and set the **Text** parameter using the text shown in the corresponding option.

- For the actions of the UI automation group, try these steps:

  1. Use the **Click UI element in window** action to send a click to the drop-down list to get focus.
  2. Use the [Send Keys](/power-automate/desktop-flows/actions-reference/mouseandkeyboard#sendkeys) action. Set the **Send keys to** option as the **Foreground window**, and use the text shown in the corresponding option to set the **Text to send** option, followed by `{Enter}`.
