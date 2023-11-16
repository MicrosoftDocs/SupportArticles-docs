---
title: Troubleshoot slow running flows
description: Describes possible reasons for slow running flows and suggestions for alleviating the issue.
ms.reviewer: prkoduku, hinas
ms.date: 09/08/2023
ms.subservice: power-automate-flows
---
# Troubleshoot slow running flows

This article describes possible reasons for slow running flows and suggestions for alleviating the problem. However, this article doesn't apply to cases where triggers aren't firing, in which case the flow won't even start or show up in the run history list.

## Symptoms

A flow runs slowly and might appear to get stuck on a single step in the flow run details.

## Cause 1: The service you connect to runs slowly

For instance, a slow running SQL query can cause a flow to slow down while it waits for the query execution to complete.

## Cause 2: The connector you use slows down your flow as a service protection mechanism

- For example, the SharePoint connector caps actions at 600 per minute. A single SharePoint connection used across multiple flows can still execute only 600 operations per minute.

  Most connector pages have a [Throttling section](/connectors/sharepointonline/#limits) that documents this limit.

- You might see a "429 (Too Many Requests)" error in your flow with the error text like "Rate limit is exceeded. Try again in 27 seconds."

## Cause 3: Your flow executes more actions than the daily limits for your plan

- You can see the minimum number of actions that the Power Automate service allows for each plan on the [Request limits and allocation page](/power-platform/admin/api-request-limits-allocations).
- Every card executed in a flow counts as an API call (action). This includes actions that result in outgoing calls (for example, calling SharePoint) and actions that don't (for example, variable setting, delays, and so on). Only completed and failed (but not skipped) actions count toward the limit.
- The Power Automate service typically allows higher counts than those documented here and won't slow flows down based on occasional and reasonable overages. However, if your flow's action count exceeds these limits, they are subject to potential throttling, or in cases of extended violations, disabled.
- You can use the **Analytics** tab on the flow details page to check the actions and usage.

## Cause 4: Your flow exceeds the data consumption allowance per day

This is the amount of data your flow consumes because of input or output operations.

## Cause 5: Your flow exceeds the limit documented on the Power Automate limits and configuration page

[Learn more about Power Automate limits and configuration](/power-automate/limits-and-config).

- For these throttles, both executed and skipped actions (as what might happen in an if/else branch) count toward the limit.
- Violating the plan limits documented in the following [Plan summary](#plan-summary) section is much more common.
- During the [transition period](/power-platform/admin/power-automate-licensing/types#transition-period), enforcement isn't strict, and limits are higher. The transition period ends after [Power Platform admin center reports](/power-platform/admin/api-request-limits-allocations#view-detailed-power-platform-request-usage-information-in-the-power-platform-admin-center-preview) are generally available. Organizations will then have six months to analyze their usage and purchase appropriate licenses before strict enforcement on license limits begins.

#### Plan summary

|Plan|Limits per 24 hours|Data consumption per day|
|---|---|---|
|Office 365 Flow licenses, Power Apps per app, and Dynamics team member and trials |Final limit: 6,000 actions across all flows created by a single user. <br> Transition limit: 10,000 actions per flow |1 GB across all flows created by a single user.|
|Power Automate Premium, Power Apps Premium, Power Automate Per user, Power Automate Per user with attended RPA, and Power Apps per user |40,000 actions across all flows created by a single user. <br> Transition limit: 200,000 actions per flow |10 GB across all flows created by a single user. |
|Dynamics Professional licenses |40,000 actions across all flows created by a single user. <br> Transition limit: 200,000 actions per flow |10 GB across all flows created by a single user. |
|Dynamics Enterprise Application licenses |40,000 actions across all flows created by a single user. <br> Transition limit: 200,000 actions per flow |10 GB across all flows created by a single user. |
|Power Automate Process license, and Power Automate per flow license |250,000 actions per process. <br> Transition limit: 500,000 actions per flow |50 GB storage per flow. |

## Resolution 1: Redesign your flow to use fewer actions and less data

- If you have `Do until` or `For each item` loops in your flow, try to reduce the number of loop iterations by retrieving fewer items to iterate through.
- Many connectors have `Filter query` and `Top count` parameters that can be used to reduce the number of items and amount of data retrieved. For more information, see [Filtering with Odata](https://powerautomate.microsoft.com/blog/advanced-flow-of-the-week-filtering-with-odata/).
- If you have a scheduled flow that runs frequently, consider reducing the frequency. Many flows that run once per minute or hour can be revised to run less often.
- If your flow interacts with files, be conscious of the file size and try to reduce it if possible.
- If you need to reuse a single property returned by an action with a large output size multiple times, consider using the [Initialize Variable](/power-automate/create-variable-store-values#initialize-a-variable) to store that property and use the variable in later actions. Even if only one property from the output of an earlier action is used, all outputs of that action will be passed into the later action as inputs.

## Resolution 2: Purchase a Premium or Process license from the pricing page

[Learn more about Power Automate pricing](https://powerautomate.microsoft.com/pricing/).

A tenant administrator will need to purchase the plan because regular users will receive a message indicating that individual plan purchases aren't available at this time. The tenant administrator should then apply the plan to the user who created the flow. Process plans can be assigned on the flow details page. Once the license is purchased and assigned, the author of the flow should resave the flow. Alternatively, flows will be updated in the background once per week to reflect current plans.

If your flow executes thousands of actions every day, consider purchasing a Process license to get better throughput and higher quotas. The Process plan provides the best performance quotas available.

If you need more actions than what Power Automate provides on a daily basis, consider exporting your flow to Logic Apps. For more information about costs associated with Logic Apps, see [Plan to manage costs for Azure Logic Apps](/azure/logic-apps/plan-manage-costs).

## More information

- [Types of Power Automate licenses](/power-platform/admin/power-automate-licensing/types)
- [Frequently Asked Questions on Power Platform requests](/power-platform/admin/power-automate-licensing/types#power-platform-requests-faqs)
- Training module - [Troubleshoot slow-running flows in Power Automate](/training/modules/troubleshoot-slow-flows)
