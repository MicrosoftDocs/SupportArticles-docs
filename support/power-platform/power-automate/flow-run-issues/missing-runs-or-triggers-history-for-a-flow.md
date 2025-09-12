---
title: Missing runs or triggers history for a flow
description: A flow's execution is stored and displayed on the Run history page only for 28 days.
ms.reviewer: anaggar
ms.date: 09/04/2024
ms.custom: sap:Flow run issues\Triggers
---
# Missing runs or triggers history for a flow

For a flow, sometimes you can't find the trigger or run history on the **Run history** page or the flow's **Details** page in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4538672

## Symptoms

You can't see your Power Automate flow on the **Run history** page or the flow's **Details** page.

## Cause

By default, flow run data is stored for 28 days. If you ran your flow over 28 days ago, it will no longer be shown on the flow's **Run history** page.

:::image type="content" source="media/missing-runs-or-triggers-history-for-a-flow/28-day-run-history.png" alt-text="Screenshot of the message indicating that only run logs for no longer than 28 days will be shown on the Run history page.":::

## Resolution

If it's been over 28 days since you ran the flow, run it again so that the flow run data appears on the **Run history** page.

To maintain a flow run history for over 28 days, you need to manually capture the run history before it's deleted.

> [!TIP]
> With the **Cloud flow run history in Dataverse** feature, administrators can manage or reduce the number of days for which the flow runs are retained in the [Power Platform admin center](https://admin.powerplatform.microsoft.com). For more information, see [Set FlowRun time to live in Power Platform admin center](/power-automate/dataverse/cloud-flow-run-metadata#set-flowrun-time-to-live-in-power-platform-admin-center).
