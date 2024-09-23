---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title: Grid filter for lookup column not showing any suggestions
description: The grid column filter for lookup type field does not show any record suggestions or it says "No Records Found"
author: akmaloo
ms.author: akmaloo
ms.service: powerapps
ms.topic: troubleshooting
ms.date:     09/19/2024
ms.subservice: troubleshoot
---
# Grid filter for Lookup column not showing any suggestions in a model-driven app

## Symptoms

When you try to filter data on a lookup column, you do not see a list of values, or it says, "No Records Found". For example, the filter on the Parent Business column doesn't show any results as shown in the screenshot below.
![emptyfiltersuggestions](media/grid-filter-not-showing-any-suggestions/emptyfiltersuggestions.png)

## Cause

This can happen in two situations:

1. The records for this lookup field do not have their primary field populated, so the filter dropdown will show blank.
1. The lookup view for the entity associated with the column does not have the primary field added as part of its view as shown in the screenshot below.
![primaryfieldabsent](media/grid-filter-not-showing-any-suggestions/primaryfieldabsent.png)

## Mitigation

1. The records need to populate their primary field.
1. Edit the Lookup View for the entity and add the primary field.
![addColumn](media/grid-filter-not-showing-any-suggestions/addcolumn.png)

## See also

[Troubleshooting grid issues in Power Apps](grid-issues.md)