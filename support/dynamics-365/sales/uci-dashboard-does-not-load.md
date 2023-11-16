---
title: UCI Dashboard doesn't load
description: Provides a solution to an issue where UCI Dashboard doesn't load after the 2003.5 release.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# UCI Dashboard doesn't load after the 2003.5 release

This article provides a solution to an issue where UCI Dashboard doesn't load after the 2003.5 release.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4558635

## Symptoms

After being updated to the 2003.5 release, a dashboard that has a subgrid that has been configured to use a custom control (for example, an editable grid) doesn't load in UCI.

The dashboard may be stuck with a loading spinner, or it may show a generic error message:

> ("Something has gone wrong. Check technical details for more details").

## Cause

This issue is caused when there's a subgrid on the dashboard that has been configured to use a custom control, but not for all form factors. When there's a custom control configuration, but not all form factors have one, then it ends up being an unhandled null exception that prevents the dashboard from loading.

For example, the control configuration may look something like this:

:::image type="content" source="media/uci-dashboard-does-not-load/custom-control-configuration.png" alt-text="Screenshot shows an example of the control configuration.":::

Alternately, it may be caused by a control configuration that isn't used for any form factor, such as something like this:

:::image type="content" source="media/uci-dashboard-does-not-load/unused-editable-grid.png" alt-text="Screenshot of the unused subgrid custom control configuration.":::

## Resolution

The bug is fixed in the 2004.3 release. However, customers can work around the issue sooner by adding a control configuration for all form factors.

In some cases, the custom control being used may not allow being set for all form factors (for example, editable grid can't be set for phone form factor), or the customer may want to use the default read-only grid for some form factors. In those cases, this workaround is still applicable because the read-only grid may be also chosen as a custom control configuration.

For example, the first control configuration from the [Cause](#cause) section above can be changed to something like this to mitigate the issue:

:::image type="content" source="media/uci-dashboard-does-not-load/configuration-all-form-factors.png" alt-text="Screenshot shows the subgrid custom control configuration for all form factors.":::

Alternately, if this issue is happening because a control configuration that isn't used on any form factor, that control configuration can be removed.
