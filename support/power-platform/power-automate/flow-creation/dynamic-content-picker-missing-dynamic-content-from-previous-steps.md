---
title: Dynamic content picker missing dynamic content from previous steps
description: No dynamic content available in dynamic content picker. Provides a resolution.
ms.reviewer: mehgupta
ms.date: 03/31/2021
ms.custom: sap:Flow creation\Dynamic content
---
# Dynamic content picker missing dynamic content from previous steps

This article provides a resolution for the issue that you might see **No dynamic content available** in dynamic content picker.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4552004

## Symptoms

Some users are unable to see all the dynamic content from previous steps while attempting to add dynamic content to a parameter. The dynamic content picker might show that there's **No dynamic content available**.

:::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/no-dynamic-content-available.png" alt-text="Screenshot shows there's no dynamic content automatically available when using the Microsoft Forms card.":::

## Cause

This can occur for one of two reasons:

1. When using a trigger that supports Split On and the Split On option is turned on.

1. Or when the type of the dynamic content might differ from the data type of the parameter. This is expected behavior as the dynamic content picker filters the dynamic content based on the data type of the parameter. For instance, the dynamic content picker for a string parameter will show a filtered list of dynamic content that is strings.

   :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/dynamic-content-picker.png" alt-text="Screenshot shows the dynamic content picker filters the dynamic content based on the data type of the parameter.":::

## Resolution

If using a trigger that supports Split On, fix this issue by turning off the Split On option for the trigger card. To do so, follow the steps below:

1. First, on the trigger card, selected the three dots (...).

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/three-dots-on-trigger-card.png" alt-text="Screenshot that shows three dots icon on the trigger card.":::

2. Then, select **Settings**.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/settings.png" alt-text="Screenshot to select the Settings item in the options.":::

3. Then, **turn off** the Split on setting and select **Done**.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/split-on-is-off.png" alt-text="Screenshot to turn off the Split on setting and select the Done option.":::

The dynamic content should now be available automatically in the dynamic content picker.

If the dynamic content picker is filtering by the parameter data type, there are two possible workarounds.

1. The first workaround is to search for the dynamic content in the dynamic content picker. This will override the data type filtering.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/search-in-token-picker.png" alt-text="Screenshot to search for the dynamic content in the dynamic content picker.":::

2. The second workaround is to use the Compose action card, which will produce an output of type any.

    :::image type="content" source="media/dynamic-content-picker-missing-dynamic-content-from-previous-steps/compose-action-card.png" alt-text="Screenshot to use the Compose action card, which will produce an output of type any.":::
