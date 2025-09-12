---
title: Button in Command Bar Not Showing After Grid Item Selection
description: Resolving the issue where a button in the command bar doesn't appear after selecting grid items in Microsoft Dynamics 365 apps.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Opportunity
---
# Button in command bar doesn't appear after grid item selection

This article provides a solution to the issue where a custom button on the command bar doesn't appear after selecting one or more grid items in Dynamics 365 apps.

_Applies to:_ &nbsp; Microsoft Dynamics 365
_Original KB number:_ &nbsp; 4481268

## Symptoms

A custom button is configured to appear in the grid, either in the `HomePageGrid` or `SubGrid` in Dynamics 365 apps.

- In the web client, this button appears in the ribbon or command bar regardless of whether grid items are selected.
- In the Unified Client Interface (UCI), this button appears when no grid items are selected. However, after selecting one or more grid items, the button disappears.

## Cause

This behavior is by design in the UCI. UCI introduces a context-sensitive approach to button visibility in grids. Specifically:

- Buttons are categorized as either item-specific or not.
- When one or more grid items are selected, only item-specific buttons are displayed.
- Buttons that don't require item selection are hidden when grid items are selected.

The context-sensitive behavior determines whether a button is considered item-specific based on the presence of a [selection count rule](/power-apps/developer/model-driven-apps/define-ribbon-enable-rules#selection-count-rule) in the associated command. If the command has a selection count rule, the button is categorized as item-specific.

> [!NOTE]
> Flyouts and split buttons are excluded from this behavior and are displayed regardless of item selection. This ensures that dynamic menu items aren't hidden incorrectly.

## Resolution

This design affects all buttons, including both custom and out-of-box buttons, except for flyouts and split buttons. This change helps prioritize item-specific commands by hiding non-item-specific buttons during item selection.

In most cases, it's helpful to hide buttons that don't act on selected items, so that *item-specific* commands appear more prominently.

If you need to run a generic command unrelated to the items selected during item selection, you can add the following rule to the definition of the custom ribbon command:

```XML
<EnableRule Id="Mscrm.AnySelection" />
```

This rule causes the Unified Client to treat the command as both an item-specific and a non-item-specific command, ensuring the button appears in both scenarios.

## More information

[Enhanced user experience with Unified Interface for model-driven apps](/power-apps/user/unified-interface)

[Ribbons in model-driven apps](/power-apps/developer/model-driven-apps/ribbons-available)
