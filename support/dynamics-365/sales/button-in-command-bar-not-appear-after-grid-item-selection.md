---
title: Button in command bar not showing after grid item selection
description: Button in command bar doesn't appear after grid item selection in Microsoft Dynamics CRM Online.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Opportunity
---
# Button in command bar doesn't appear after grid item selection in Microsoft Dynamics CRM Online

This article provides a resolution for the issue that the button customized to show doesn't appear as expected after one or more grid items are selected in Microsoft Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4481268

## Symptoms

There's a custom button that is customized to appear in the grid (either `HomePageGrid` or a `SubGrid`) in Microsoft Dynamics CRM Online.

In web client, this button will appear in the ribbon/command bar, regardless if grid items are selected or not.

In UCI, this button will appear when no grid items are selected, but once one or more grid items are selected, the button is gone.

## Cause

As part of the design for UCI, we've changed the behavior to be more context sensitive. Specifically, on grids, buttons are considered either *item specific* or not, and only *item-specific* buttons are shown when one or more items are selected, while non *item-specific* buttons are shown otherwise.

This means that buttons that don't require an item to be selected, will simply not be shown when an item is selected.  

The method that the determination is made is based on whether the command associated with the ribbon button has a SelectionCount rule. If it has a SelectionCount rule, it's considered to be an *item-specific* command.

> [!NOTE]
> Flyouts and split buttons are excluded from this change, and still shown in both cases of when items are selected or not. This is to ensure that menu items, some of which may be generated dynamically, isn't incorrectly hidden.

## Resolution

This is designed behavior that affects all buttons not just custom buttons, but out of box buttons as well (Note - flyouts and split buttons excluded since they have a menu with further child buttons and can't be easily categorized). This is an explicit design change from web client to Unified Client.

In most cases, it's helpful to hide buttons that don't act on selected items, so that *item-specific* commands appear more prominently.

If there's a strong scenario where users will need to run a generic command, unrelated to the items selected, during item selection, then the following workaround can be used:

In the definition of their Custom Ribbon Command, add the following rule:

```console
<EnableRule Id="Mscrm.AnySelection" />
```

This will cause the Unified Client to treat this command as both an *item-specific* command, and a non-item specific command, and display in both cases.
