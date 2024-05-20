---
title: Personal view queue filter not working correctly
description: Provides a resolution for an issue where personal view queue filters aren't working properly in Customer Service.
ms.reviewer: laalexan
ms.author: nickstinnett
ms.date: 05/20/2024
ms.custom: sap:Queues\Unable to view queue item
---
# Personal view queue filters aren't working properly in Customer Service

This article provides a resolution for an issue where the personal view queue filters you previously created don't work properly in Microsoft Dynamics 365 Customer Service.

## Symptoms

When you use personal view filters, you might encounter an outdated format of filters and linked entities from the "Queues I'm a member of" filter, and an error message like the following one:

> <Entity ID> Link entity with name or alias S_Internal_<> is not found

## Cause

When you create a personal view, it's saved to the runtime-applied filters. A recent system change to the filter structure caused incompatibility with personal views that were previously created with the **Queues I'm a member of** or **All Queues** filter selected. The system change was applied to fix an issue where the **Edit filters** experience wasn't available for queue item views. This fix was implemented by restructuring the **Queues I'm a member of** so that the queues can properly display and be used in the **Edit filters** panel. Because of this change, any personal view filters you previously created might not work properly.

## Resolution

To resolve this issue and make the personal view work in the advanced filter, use either of the following methods:

### Method 1: Re-create the view

If your personal view filter is relatively simple, it might be faster and more reliable for you to re-create the view. Before deleting or deprecating the old view, be sure to test your new view first.

### Method 2: Remediate the view

Follow these steps to remove the old format of the queue filters and replace it with the updated version:

1. Open the personal view in the queue item grid.

1. If the queue dropdown is set to **Queues I'm a member of** or **All Queues**,  change the dropdown to a specific queue. You can use your default user queue or any single queue that you're a member of (for example, "\<firstname lastname>").

1. Open the advanced filter panel and remove the **Queue** related entities and missing relationship groups.

   :::image type="content" source="media/edit-filters-queue-items.png" alt-text="Screenshot that shows the related entities and missing relationship groups that need to be removed.":::

   > [!NOTE]
   > You might see duplicate entries for the **Type Equals Private** filter. Make sure to remove the entire group that contains them.

1. Select **Apply**, and then save the changes in the current view.

1. Go back to the **Queues I'm a member of** filter option if you weren't automatically returned to the option, and then open the advanced filter.

1. Remove the specific queue filter that was temporarily applied to the view in steps 2 and 3.

1. Select **Apply**, and then save the changes in the current view. The view is now updated with the correct filter and will work properly with the advanced filter experience.

## More information

[Create and edit views in model-driven apps](/power-apps/maker/model-driven-apps/create-edit-views-app-designer)
