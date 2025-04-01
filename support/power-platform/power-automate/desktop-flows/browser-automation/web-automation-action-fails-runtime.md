---
title: Web automation action fails during runtime
description: Provides a resolution for the issue that a web automation action can't interact with a web element on runtime in Power Automate. 
ms.reviewer: pefelesk
ms.date: 04/01/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Can't interact with a web element on runtime

This article provides a resolution to an issue where a web automation action can't interact with a web element during runtime in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4599079

## Symptoms

A web automation action (for example, "Click Link", "Populate text field", or "Get details of element") fails during runtime in Microsoft Power Automate.

## Verifying issue

During the initial development of the desktop flow, you can capture and interact with the web element.

## Cause

Some web pages change their underlying HTML structure dynamically. Therefore, the CSS selector initially used to locate the element is no longer applicable.

## Resolution 1

To solve this issue, you can try to [repair the CSS selector](/power-automate/desktop-flows/repair-selector).

## Resolution 2

To solve this issue, you can manually create a new robust CSS selector. It will be able to locate the element of interest even though the HTML structure changes.

To achieve that, capture again the web element after the failure, and compare the new CSS selector with the old one.
CSS selectors can be reviewed and edited through the **Selector builder** window:

:::image type="content" source="media/web-automation-action-fails-runtime/selector-builder.png" alt-text="The Selector builder page that you can use to review and edit CSS selectors." lightbox="media/web-automation-action-fails-runtime/selector-builder.png":::

Notice the differences between the two selectors – there may be one or more elements or attributes that are different.

Edit the selector to contain only the static parts that aren't prone to change. Some of the below methods could be followed:

1. Remove any dynamic values such as numbers and modify the relevant Operators accordingly ("Starts with", "Ends with", "Contains" and so on.)
2. Remove an entire element from the selector path if necessary.
3. Locate the element that uses its text that is visible on the webpage by using the "Contains" selector.

Examples:

- The selector contains an element that has a class that is dynamic, such as `div[class="some_class123"]`. This can be modified to `div[class^="some_class"]` ("Starts with" operator).
- The selector contains an element that has many dynamic attributes such as `div[class="some_class123"][id="some_id123"] > a[id="some_id"]`. This can be modified to `a[id="some_id"]` (omitting the first part completely).
- The element of interest has some static text - the selector can be modified to include only that text. For example, `div[class="some_class123"][id="some_id123"] > a[id="some_id"]` could be modified to `a:contains("the_text_we_see_on_the_webpage")`.

For more information, see [Build a custom selector](/power-automate/desktop-flows/build-custom-selectors).