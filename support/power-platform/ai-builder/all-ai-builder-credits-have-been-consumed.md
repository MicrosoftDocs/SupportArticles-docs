---
title: All AI Builder credits have been consumed
description: This article provides guidance on how to resolve the 'All AI Builder credits have been consumed' issue.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 05/23/2023
ms.subservice: 
ms.author: antode
author: Antoine2F
---

# All AI Builder credits have been consumed

This article provides guidance on how to resolve the 'All AI Builder credits in this environment have been consumed' issue.
Issue symptoms also include 'You've consumed all your credits' banner, 'You need an AI Builder license to use this component' banner,  'EntitlementNotAvailable' or 'QuotaExceeded' error codes.

_Applies to:_ AI Builder

## Symptoms

Here are the different symptoms of this issue:
1. A banner is displayed in AI Builder pages : 'You've consumed all your credits.'

1. Maker actions in AI Builder pages are blocked. (Model creation, Model edit, Quick test)

1. Flow stops with following error 'All AI Builder credits in this environment have been consumed'.
This error is displayed in Error panel in Flow run page, and may be available in flow error notification by email.

1. The json in the AI Builder tile in error mentions 
-Code="EntitlementNotAvailable"
-Code="QuotaExceeded"
-Message="Credit usage exceeds allocation."

1. In a PowerApp, a banner displays 'You need an AI Builder license to use this component.' message when trying to perform an AI Builder action.

## Cause

AI Builder actions consume AI Builder credits.  
These credits comes from Tenant level or from Environment level allocation.  
Each day, environment consumption since beginning of the month is computed.  

- When consumption is higher than allocated credits, this issue is raised with following symptoms: banner is displayed and Maker actions are blocked.  

- When consumption is much higher than allocated credits (small overage is allowed), following symptoms occur: AI Builder actions in flows and apps are blocked.  

## Resolution

Your environment needs additional credits. 
If credits comes from tenant Level (unasssigned credits), you need to add credits at tenant level, either by deallocating credits from other environments, or by purchasing more.
If credits comes from environment Level, you need to allocate more credits to your environment, either by using existing tenant level environment, or by first adding credits at tenant level, using purchase or environment deallocation.


### How to determine the source and amount of allocated, unassigned and owned credits
You need to be Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** then **Capacity**.
1. On the right pane, select **Add-ons**
1. Every environment with allocated AI Builder credits is listed with the number of allocated credits
1. If environment is not listed or listed with 0 AI Builder credits, then credits come from tenant level. This step also gives the amount of owned credits.
    1. On the right pane, select **Summary**
    1. At the bottom of the pane, in the **Add-ons** section, look at **AI Builder credits**: it indicates the total number of credits allocated to environments among the total of owned credits. Amount of Tenant level credits (unassigned credits) is the difference between these numbers.

### How to change the amount of environment allocated credits
You need to be Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** then **Capacity**.
1. On the right pane, select **Add-ons**
1. Every environment with allocated AI Builder credits is listed with the number of allocated credits
1. Click on **Assign to an environment**
1. In the right-side panel, select your environment
1. Modify the number of AI Builder credits. If the number of remaining credits is not enough, you can either deallocate credits from other environments or purchase additional credits.

### How to change the amount of tenant level credits (unassigned credits) by unallocating credits from environments
You need to be Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** then **Capacity**.
1. On the right pane, select **Add-ons**
1. Every environment with allocated AI Builder credits is listed with the number of allocated credits
1. Click on **Assign to an environment**
1. In the right-side panel, select an environment 
1. Decrease the number of AI Builder credits. 

### How to change the amount of tenant level credits (unassigned credits) by purchasing additional AI Builder credits
You need to be Billing Administrator of your tenant to perform these actions.
1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/).
1. On the left pane, select **Billing** then **Purchase services**.
1. Search for AI Builder 
1. Select either  AI Builder Capacity Add-on T1 or AI Builder Capacity Add-on T2 (min 10 packs) or AI Builder Capacity Add-on T3 (min 50 packs) depending on how many packs you need. Each pack provides 1 million AI Builder credits.
1. Follow the purchase process
1. Once purchased, follow **#How to change the amount of environment allocated credits** steps if credits come from environment level.

### How to evaluate the amount of credits to add
You need to be Administrator of your environment to perform these actions.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. On the left pane, select **Resources** then **Capacity**.
1. On the right pane, select **Summary**
1. At the bottom of the pane, in the **Add-ons** section, select **Download reports**
1. Select **New** then **AI Builder** in the drop down, then **Submit**
1. Select **Refresh** until the report with latest Report dates is marked as Completed
1. Select the latest Report and click **Download** : a csv is downloaded to your computed
1. Open the csv file in excel: it contains the AI Builder credit consumption per day, user, and environment. 
1. By adding all consumption of current month of your environment, you can evaluate how much credit you need for an entire month for this environment.



## AI Builder purchase will take time and I need to urgently unblock my Flow or my App, what can I do?
Please send an email to aihelpen@microsoft.com with following title and information:
Title: AI Builder consumption overage
Required information: 
- Company name,  tenantId, Environment Id
- Context of the overage and urgency (provide information on the AI Builder use case). 
- Amount of available credits, current and expected consumption.
- How you plan to resolve the issue in a near future

We will analyze your request.

## Resources

For more information, see [AI Builder licensing](/ai-builder/administer-licensing).
