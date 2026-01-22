---
title: All AI Builder credits have been consumed
description: Provides a resolution for the issue that all AI Builder credits have been consumed in Microsoft Power Platform.
ms.reviewer: chplanty, cdbellar
ms.date: 01/19/2026
ms.custom: sap:AI Builder\Administration and Licensing
ms.author: antode
author: Antoine2F
---
# All AI Builder credits have been consumed

This article provides a resolution for the "All AI Builder credits in this environment have been consumed" error that occurs when you run a flow in Microsoft Power Platform.

The resolution also addresses other issues related to AI Builder credit consumption. For example, you receive the "You've consumed all your credits" or "You need an AI Builder license to use this component" message or the "EntitlementNotAvailable" or "QuotaExceeded" error code.

_Applies to:_ AI Builder

## Symptoms

Here are the different symptoms of this issue:

1. A banner shows the "Some environments have consumed all or almost all AI Builder credits" message on the **Capacity** page in the Power Platform admin center.
1. A banner shows the "You've consumed all your AI Builder credits" message on the AI Builder page.
1. A flow stops with the "All AI Builder credits in this environment have been consumed" or "Missing Copilot Credit or AI Builder credit capacity" error.

   > [!NOTE]
   > This error is displayed in the **Error** panel on the flow run page.

1. The **Error Details** of the AI Builder tile mentions one of the following:

   - Code="EntitlementNotAvailable"
   - Code="QuotaExceeded"
   - Message="Credit usage exceeds allocation."

1. In Power Apps, a banner shows the "You need an AI Builder license to use this component" or "Missing Copilot Credit or AI Builder credit capacity" message when you try to perform an AI Builder action.

## Cause

This issue occurs because AI Builder actions consume AI Builder credits and/or Copilot Credits, depending on the context. These credits come from tenant-level or environment-level allocations.
In Power Apps or Power Automate context, AI Builder actions consume AI Builder credits first, then if exhausted or absent, they consume Copilot Credits. In Microsoft Copilot Studio context (agents, agent flows), AI Builder actions consume Copilot Credits only.

The environment's consumption is computed regularly, and is reset at the beginning of the month.  

- When the computed consumption is close to the allocated credits, a banner is displayed on the **Capacity** page in the Power Platform admin center, and a notification email is sent to the administrator.
- When the computed consumption exceeds the tenant-level or environment-level credits (125%), AI Builder actions in flows and apps are blocked, and an error message is displayed in flows and apps.

Sometimes environment's consumption can be computed with an important delay (like 5 days). In such case, the decision will be made based on the last known computed consumption. This can lead to important consumption beyond the capacity before AI Builder actions are blocked or fall back to Copilot Credits. Such overage isn't billed to the customer and doesn't impact other environments.

## Resolution

To solve this issue, add more AI Builder credits or Copilot Credits to your environment.

If credits come from the tenant level (unassigned credits), you need to add credits at the tenant level. This can be done by deallocating credits from other environments or by purchasing more.

If credits come from the environment level, you need to allocate more credits to your environment. This can be done by using the existing tenant-level environment or by adding credits at the tenant level first (using purchase or environment deallocation).

> [!NOTE]
> For AI Builder credits, if the **Allow users to consume unassigned credit** setting is disabled, the unassigned credits can't be used. You can go to the Power Platform admin center, select **Settings**, and then open the **AI Builder credit** page to enable this setting.

#### How to determine the source and number of allocated, unassigned, and owned credits

You need to be the administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Add-ons**.
1. The environments that have allocated AI Builder credits are listed with the number of allocated credits.
1. If an environment isn't listed or listed with zero AI Builder credits, the credits come from the tenant level. This step also provides the number of owned credits.

    1. On the right pane, select **Summary**.
    1. At the bottom of the pane, in the **Add-ons** section, the **AI Builder credits** indicates the total number of credits allocated to environments among the total of owned credits. The amount of tenant-level credits (unassigned credits) is the difference between these numbers.

#### How to change the number of environment-allocated AI Builder credits

You need to be the administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Add-ons**.
1. The environments that have allocated AI Builder credits are listed with the number of allocated credits.
1. Select **Assign to an environment**.
1. In the right-side panel, select your environment.
1. Modify the number of AI Builder credits. If the remaining credits aren't enough, you can deallocate credits from other environments or purchase more.

#### How to change the number of tenant-level AI Builder credits (unassigned credits) by deallocating credits from environments

You need to be the administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Add-ons**.
1. The environments that have allocated AI Builder credits are listed with the number of allocated credits.
1. Select **Assign to an environment**.
1. In the right-side panel, select an environment.
1. Reduce the number of AI Builder credits.

> [!NOTE]
> If the **Allow users to consume unassigned credit** setting is disabled, the unassigned credits can't be used. You can go to the Power Platform admin center, select **Settings**, and then open the **AI Builder credit** page to enable this setting.

#### How to change the number of tenant-level AI Builder credits (unassigned credits) by purchasing more AI Builder credits

As AI Builder Capacity Add-on are in 'End of Sales' state, that's only possible if you already have active AI Builder Add-ons. You need to be the billing administrator of your tenant to perform these actions.

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/).
1. On the left pane, select **Billing** > **Purchase services**.
1. Search for AI Builder.
1. Select **AI Builder Capacity Add-on T1**, **AI Builder Capacity Add-on T2 (min 10 packs)**, or **AI Builder Capacity Add-on T3 (min 50 packs)**, depending on how many packs you need. Each pack provides 1 million AI Builder credits.
1. Follow the purchase process.
1. Once purchased, follow the steps in [How to change the number of environment-allocated credits](#how-to-change-the-number-of-environment-allocated-credits) if the credits come from the environment level.

> [!NOTE]
> If the **Allow users to consume unassigned credit** setting is disabled, the unassigned credits can't be used. You can go to the Power Platform admin center, select **Settings**, and then open the **AI Builder credit** page to enable this setting.

#### How to evaluate the amount of AI Builder credits to add

You need to be the administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Summary**.
1. At the bottom of the pane, in the **Add-ons** section, select **Download reports**.
1. Select **New** > **AI Builder** > **Submit**.
1. Select **Refresh** until the report with the latest report date is marked as **Completed**.
1. Select the latest report and select **Download**. A .csv file is downloaded to your computer.
1. Open the .csv file in Excel. It contains the AI Builder credit consumption per day, user, and environment.
1. By adding all your environment's consumption for the current month, you can evaluate how many credits this environment needs for the entire month.

## Resources

For more information, see [AI Builder licensing](/ai-builder/administer-licensing).
