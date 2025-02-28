---
title: There is a problem with the flow's trigger
description: You might see an error that states there is a problem with the flow's trigger in a flow's run history. Provides a resolution.
ms.reviewer: alchin
ms.date: 03/31/2021
ms.custom: sap:Flow run issues\Triggers
---
# "There is a problem with the flow's trigger" error shown in a flow's run history

This article provides a resolution for the issue that you might see the **There is a problem with the flow's trigger** error in a flow's run history.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4540228

## Symptoms

You might see the following banner in a flow's run history.

:::image type="content" source="media/there-is-a-problem-with-the-flows-trigger/error-message.png" alt-text="Screenshot of the error in a flow's run history." border="false":::

## Cause

The banner is displayed when the flow's trigger encounters an error. The purpose of the banner is to inform the user of a problematic trigger that will result in a flow not running. The banner can be particularly helpful when a flow hasn't had an initial run and therefore will have no run history available.

## Resolution

To understand why the trigger failed and how to fix the issue:

1. Select the **Fix the trigger** link.
2. The failed trigger will be displayed. Select the trigger to inspect the underlying error message:

   :::image type="content" source="media/there-is-a-problem-with-the-flows-trigger/trigger-details.png" alt-text="Screenshot to select the trigger to inspect the underlying error message." border="false" :::

In the above example, the trigger failed because the specified folder wasn't found in the SharePoint library. The fix would be to update the folder name to a valid name.

Trigger failures with 4xx status codes are typically errors that the user should fix. Common issues might include:

- A change in the connection that the flow is using (for example, password expired).
- A trigger input that is invalid.
- Failure to register a webhook trigger.

Trigger failures with 5xx status codes are typically system issues and can occur due to transient events. These errors should eventually self-heal.

## Known issues

Currently the banner might continue to be displayed even when the next trigger event is successfully executed. The product team is working toward resolving the issue. If your flow continues to run successfully even while the banner is present, then you might be encountering this issue.
