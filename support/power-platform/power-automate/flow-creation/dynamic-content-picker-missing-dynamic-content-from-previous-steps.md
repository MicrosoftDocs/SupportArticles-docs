---
title: Dynamic content picker missing dynamic content from previous steps
description: No dynamic content available in dynamic content picker. Provides a resolution.
ms.reviewer: mehgupta
ms.date: 10/08/2024
ms.custom: sap:Flow creation\Dynamic content
---
# Dynamic content picker missing dynamic content from previous steps

This article can help you understand and resolve issues when dynamic content from previous steps isn't available in a Power Automate flow.

> [!NOTE]
> The screenshots in this article are for the classic designer user interface. Although the cloud flows designer is visually different, the same concepts and procedures apply to both.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4552004

## Symptoms

You experience the following issues when you try to add dynamic content to a Power Automate flow:

- You can't see the dynamic content from previous steps.
- The "No Dynamic Content Available" message appears in the dynamic content picker.

  :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/no-dynamic-content-available.png" alt-text="Screenshot shows there's no dynamic content automatically available when using the Microsoft Forms card.":::

## Cause 1: Use a trigger that supports the "Split On" option and the option is turned on

This issue might occur when you use a trigger that supports **Split On** (such as **When a new response is submitted**) and the option is turned on.

### Resolution

Turn off the **Split On** option for the trigger card by taking the following steps. After you complete the steps, the dynamic content should be available in the dynamic content picker.

1. On the trigger card, select the three dots (...).

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/three-dots-on-trigger-card.png" alt-text="Screenshot that shows the three dots icon on the trigger card.":::

2. Select **Settings**.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/settings.png" alt-text="Screenshot to select the Settings item in the options.":::

3. Turn off the **Split on** setting and select **Done**.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/split-on-is-off.png" alt-text="Screenshot to turn off the Split on setting and select the Done option.":::

## Cause 2: The data type of the dynamic content differs from the data type of the parameter

The default behavior is that the dynamic content picker filters the dynamic content based on the data type of the parameter. For instance, the dynamic content picker for a string parameter will only show a filtered list of dynamic content that are of type string.

In this example, the parameter is a number, which isn't visible in the dynamic content picker.

:::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/dynamic-content-picker.png" alt-text="Screenshot shows the dynamic content picker filters the dynamic content based on the data type of the parameter.":::

### Workaround

Use one of the following workarounds:

- Search for the dynamic content in the dynamic content picker. This will override the data type filtering.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/search-in-token-picker.png" alt-text="Screenshot to search for the dynamic content in the dynamic content picker.":::

- Use the **Compose** action card. The output of the **Compose** action, namely **Outputs**, will appear in the dynamic content picker, and you can select it to use in the flow.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/compose-action-card.png" alt-text="Screenshot to use the Compose action card, which will produce an output of type any.":::
