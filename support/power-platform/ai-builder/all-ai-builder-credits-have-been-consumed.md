---
title: All AI Builder credits have been consumed
description: Provides a resolution for the issue that all AI Builder credits have been consumed.
ms.reviewer: chplanty, cdbellar
ms.date: 05/26/2023
ms.subservice: 
ms.author: antode
author: Antoine2F
---
# All AI Builder credits have been consumed

This article provides a resolution for the "All AI Builder credits in this environment have been consumed" error that occurs when you run a flow.

The resolution also solves the other issues related to the AI Builder credit consumption. For example, you receive the "You've consumed all your credits" or "You need an AI Builder license to use this component" message or "EntitlementNotAvailable" or "QuotaExceeded" error codes.

_Applies to:_ AI Builder

## Symptoms

Here are the different symptoms of this issue:

1. A banner shows the "Some environments have consumed all or almost all AI Builder credits." message on the Power Platform Administration Center Capacity page. 
1. A banner shows the "You've consumed all your AI Builder credits" message on the AI Builder pages.
1. Maker actions (Model creation, Model edit, and Quick test) are blocked on AI Builder pages.
1. A flow stops with the "All AI Builder credits in this environment have been consumed" error.

   > [!NOTE]
   > This error is displayed in the **Error** panel on the flow run page 

1. The Error Details of the AI Builder tile mentions one of the following:

   - Code="EntitlementNotAvailable"
   - Code="QuotaExceeded"
   - Message="Credit usage exceeds allocation."

1. In a Power App, a banner shows the "You need an AI Builder license to use this component" message when you try to perform an AI Builder action.

## Cause

This issue occurs because AI Builder actions consume AI Builder credits.  

These credits come from tenant-level or environment-level allocation.

Each day, the environment's consumption since the beginning of the month is computed.  
- When the consumption is close to allocated credits, a banner is displayed in Power Platform admin center capacity page and notification email is sent to Admin
- When the consumption exceeds allocated credits, a banner is displayed in AI Builder page, and Maker actions are blocked.
- When the consumption is much higher than allocated credits (some overage is allowed), AI Builder actions in flows and apps are blocked. Flows and Apps receive an error.

## Resolution

To solve this issue, add more credits to your environment.

If credits come from the tenant level (unassigned credits), you need to add credits at the tenant level: it can be done either by deallocating credits from other environments or by purchasing more.

If credits come from the environment Level, you need to allocate more credits to your environment: it can be done either by using the existing tenant-level environment or by first adding credits at the tenant level (using purchase or environment deallocation).

   > [!NOTE]
   > if 'Allow users to consume unassigned credit' setting is disabled in Power Platform admin center/Settings/AI Builder credit page, unassigned credits cannot be used.

### How to determine the source and number of allocated, unassigned, and owned credits

You need to be the Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Add-ons**.
1. The environments that have allocated AI Builder credits are listed with the number of allocated credits.
1. If an environment isn't listed or listed with zero AI Builder credits, then credits come from the tenant level. This step also provides the number of owned credits.

    1. On the right pane, select **Summary**.
    1. At the bottom of the pane, in the **Add-ons** section, the **AI Builder credits** indicates the total number of credits allocated to environments among the total of owned credits. The amount of tenant-level credits (unassigned credits) is the difference between these numbers.

### How to change the number of environment-allocated credits

You need to be the Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Add-ons**.
1. The environments that have allocated AI Builder credits are listed with the number of allocated credits.
1. Select **Assign to an environment**.
1. In the right-side panel, select your environment.
1. Modify the number of AI Builder credits. If the remaining credits aren’t enough, you can either deallocate credits from other environments or purchase more credits.

### How to change the amount of tenant-level credits (unassigned credits) by deallocating credits from environments

You need to be the Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Add-ons**.
1. The environments that have allocated AI Builder credits are listed with the number of allocated credits.
1. Select **Assign to an environment**.
1. In the right-side panel, select an environment.
1. Decrease the number of AI Builder credits.

   > [!NOTE]
   >if 'Allow users to consume unassigned credit' setting is disabled in Power Platform admin center/Settings/AI Builder credit page, unassigned credits cannot be used.

### How to change the amount of tenant-level credits (unassigned credits) by purchasing more AI Builder credits

You need to be the Billing Administrator of your tenant to perform these actions.

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/).
1. On the left pane, select **Billing** > **Purchase services**.
1. Search for AI Builder.
1. Select either **AI Builder Capacity Add-on T1** or **AI Builder Capacity Add-on T2 (min 10 packs)** or **AI Builder Capacity Add-on T3 (min 50 packs)** depending on how many packs you need. Each pack provides 1 million AI Builder credits.
1. Follow the purchase process.
1. Once purchased, follow the steps in the [How to change the number of environment allocated credits](#how-to-change-the-number-of-environment-allocated-credits) if credits come from the environment level.

   > [!NOTE]
   >if 'Allow users to consume unassigned credit' setting is disabled in Power Platform admin center/Settings/AI Builder credit page, unassigned credits cannot be used.

### How to evaluate the amount of credits to add

You need to be the Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** > **Capacity**.
1. On the right pane, select **Summary**.
1. At the bottom of the pane, in the **Add-ons** section, select **Download reports**.
1. Select **New** > **AI Builder** > **Submit**.
1. Select **Refresh** until the report with the latest report dates is marked as **Completed**.
1. Select the latest report and select **Download**. A .csv file is downloaded to your computer.
1. Open the .csv file in Excel. It contains the AI Builder credit consumption per day, user, and environment.
1. By adding all consumption of the current month of your environment, you can evaluate how many credits you need for an entire month for this environment.

## AI Builder purchase takes time, and I urgently need to unblock my Flow or my App. What can I do?

In the AI Builder page "You've consumed all your AI Builder credits" overage banner', and  in Power Platform admin center "Some environments have consumed all or almost all AI Builder credits." banner, you may find a 'Request extension' button.

When present and activated, this button allows to add 200K extension credits for the current month. These credits cannot be allocated/assigned and can be used directly by any environment in overage.
Number of extension requests per month and per year is limited.

Each extension request sends a notification email to Power Platform admin informing that extension credits have been requested and granted.

If 'Allow users to consume unassigned credit' setting is disabled in Power Platform admin center/Settings/AI Builder credit page, environment without assigned credit are blocked and extension credits won't help.


## Resources

For more information, see [AI Builder licensing](https://learn.microsoft.com/en-us/ai-builder/administer-licensing).
