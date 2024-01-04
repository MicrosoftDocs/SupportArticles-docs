---
title: Entitlement remaining terms don’t decrement as expected.
description: Provides a resolution for the issue where Entitlement remaining terms don’t decrement as expected in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 01/03/2024
---

# Entitlement remaining terms don’t decrement as expected.

This article provides a resolution for the issue where Entitlement remaining terms don’t decrement as expected in Dynamics 365 Customer Service.

In Dynamics, we have two scenarios of decrementing entitlement terms. 

## Scenario:  1 

	- Choosing **Allocation Type** as **Number of cases** and under **Decrease Remaining On** has two options **Case Resolution** and **Case Creation**. 

		- Choosing **Case Resolution** on **Decrease Remaining On** will decrease the **Total Terms** after the Case was resolved. 

		- Choosing **Case Creation** on **Decrease Remaining On** will decrease the **Total Terms** after the Case was Created. 

	**For example:**

	- **Decreasing Remaining** On was opted to **Case Resolution** and **Total Terms** was given as 10. 

		- Now create a new case by adding entitlement and resolve it. 

		- Now after resolving the case, it will deduct 1 term and balance 9 will be displayed on **Remaining Terms**. 

	- **Decrease Remaining On** was opted to **Case Creation** and **Total Terms** was given as 10. 

		- Now create a new case with adding entitlement. 

		- Upon creating a new case itself, it will deduct 1 term and balance 9 will be displayed on **Remaining Terms**.  

## Scenario: 2 

	- Choosing **Allocation Type** as **Number of hours** and under **Decrease Remaining On** was locked with option **Case Resolution**. 

	- In this scenario, we need to create an activity in case form, for example we have given 30 minutes in duration field and that activity should be completed before resolving the case. 

	- Now after resolving the case, it will deduct 0.5 term and balance 9.5 will be displayed on **Remaining Terms**. 

	Here the Decrease Remaining calculation works as 

		1hour (60mins) = 1 term 

		30mins = 0.5 term  

	Agents were not able to create cases with entitlement when Remaining Terms is less than zero or when the term remaining for a channel is less than zero, when **restrict based on entitlement terms** was selected to Yes. 

## Symptoms

Entitlement remaining terms were not decresing

## Cause

Entitlement remaining terms decrement does not work as expected. 

### Resolution: 1

After selecting **Do Not Decrement Entitlement terms** on case form, Remaining terms will not decrease on entitlement even after Case creation/resolution. 

:::image type="content" source="media\decrementing-entitlement-terms\do-not-decrement-entitlement-terms-option-on-case-form.jpg" alt-text="Screenshot that shows Do Not Decrement Entitlement terms option on case form.":::

### Resolution: 2

1. Go to Customizations and disable all custom plugins, workflows, custom .js code on entitlement and case entity. 
2. Remove custom active layer for case & entitlement entities. 
3. Remove custom active layer from **decremententitlementterm** field on case entity. 

