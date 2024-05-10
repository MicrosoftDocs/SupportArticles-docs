---
title: Personal view queue filter error
description: Provides a resolution for the issue where personal view queue filters aren't working in Customer Service.
ms.reviewer: laalexan
ms.author: nickstinnett
ms.date: 05/10/2024
ms.custom:
---

# Personal view queue filters aren't working properly in Customer Service

This article provides a resolution for the issue where personal view queue filters aren't working properly.

## Symptoms

When using personal view filters, you might encounter an issue with an outdated format of the applied queue filters (for example, **“Queues I’m a member of**). 

## Cause

When you create a personal view, it saves down to the runtime-applied filters. A recent system change to the filter structure caused an incompatibility with personal views that were previously created with **Queues I'm a member of** or **All Queues** filters selected. The system change was applied to fix an issue where the **Edit filters** experience wasn't available for queue item views. This fix was implemented by restructuring the **Queues I'm a member of** so that the queues could properly display and be used in the **Edit filters** panel. As a result of this change, any personal view filters you previously created may not work properly.

## Resolution

To resolve this issue and make the personal view work in the advanced filter, you can use either of the following options:
- Recreate the view
- Remediate the view

### Recreate the view

If your personal view filter is relatively simple, it might be faster and more reliable for you to recreate the view. Before deleting or deprecating the old view, be sure to test your new view first.

## Remediate the view
Use the following steps to remove the old format of the queue filters and replace them with the updated version: 

1. Open the personal view in the queue item grid.
1. If the queue dropdown is set to **Queues I’m a member of** or **All queues**, then change the dropdown to a specific queue. You can use your default user queue or any singular queue that you're a member of (for example: “&lt;firstname lastname&gt;”). 
1. Open the advanced filter panel and remove both **Related entity** groups.
   > [!Note]
   > You might see duplicate entries for the **Type Equals Private** filter. Make sure to remove the entire group that contains them.
1. Select **Apply**, and then save the changes in the current view.
1. Go back to **Queues I’m a member of** filter option if you weren't automatically returned to the option, and open the advanced filter.
1. Remove the specific queue filter that was applied to the view temporarily as part of steps 2 and 3.
1. Select **Apply**, and then save the changes in the current view. The view is now updated with the correct filter, and will work properly with the advanced filter experience.
