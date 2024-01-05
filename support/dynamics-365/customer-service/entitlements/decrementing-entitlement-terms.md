---
title: Entitlement remaining terms don't decrement as expected
description: Provides a resolution for the issue where entitlement remaining terms don’t decrement as expected in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 01/05/2024
---

# Entitlement remaining terms don’t decrement as expected.

This article provides a resolution for the issue where entitlement remaining terms don’t decrement as expected in Dynamics 365 Customer Service.

In Dynamics, we have two scenarios of decrementing entitlement terms. 

## Scenario 1:

- Select **Allocation Type** as **Number of cases** and under **Decrease Remaining On** select either **Case Resolution** or **Case Creation**. 

	- Selecting **Case Resolution** on **Decrease Remaining On** decreases the **Total Terms** after the case is resolved. 

	- Selecting **Case Creation** on **Decrease Remaining On** decreases the **Total Terms** after the case is created. 

For example:

- **Decreasing Remaining On** is set to **Case Resolution** and **Total Terms** is given as 10. 

	- Create a new case by adding entitlement and resolve it. 

	- After the case is resolved, 1 term is deducted and the balance of 9 terms is displayed on **Remaining Terms**. 

- **Decrease Remaining On** is set to **Case Creation** and **Total Terms** is given as 10. 

	- Create a new case by adding entitlement. 

	- When the case is created, 1 term is deducted and the balance of 9 terms is displayed on **Remaining Terms**.  

## Scenario 2: 

- Select **Allocation Type** as **Number of hours** and under **Decrease Remaining On** set to **Case Resolution**. 

- Create an activity in case form, for example, duration field is set to 30 min and that activity should be completed before resolving the case. 

- After the case is resolved, 0.5 term is deducted and the balance 9.5 terms is displayed on **Remaining Terms**. 

Here, the **Decrease Remaining On** calculation works as:

	1hour (60min) = 1 term 

	30min = 0.5 term  

Agents aren't able to create cases with entitlement when Remaining Terms is less than zero or when the term remaining for a channel is less than zero, when **Restrict based on entitlement terms** iss selected to **Yes**. 

## Symptoms

Entitlement remaining terms aren't decreasing.

## Cause

Entitlement remaining terms decrement doesn't work as expected. 

## Resolution 1:

After selecting **Do Not Decrement Entitlement terms** on case form, Remaining terms doesn't decrease entitlement terms even when a case is created or resolved. 

:::image type="content" source="media\decrementing-entitlement-terms\do-not-decrement-entitlement-terms-option-on-case-form.jpg" alt-text="Screenshot that shows Do Not Decrement Entitlement terms option on case form.":::

## Resolution 2:

1. Sign in to your Dynamics 365 Customer Engagement (on-premises) instance.
1. Go to **Settings** > **Advanced Settings** > **Customizations** > **Customize the System** to open the default solution.
1. Disable all custom plugins, workflows, custom .js code on entitlement and case entity. 
1. Remove custom active layer for case and entitlement entities. 
1. Remove custom active layer from **decremententitlementterm** field on case entity. 

