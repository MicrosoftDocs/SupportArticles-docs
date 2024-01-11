---
title: Entitlement remaining terms don't decrement as expected
description: Provides a resolution for issues where entitlement remaining terms don't decrement as expected in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: v-psuraty
author: v-psuraty
ms.date: 01/11/2024
---
# Entitlement remaining terms don't decrement as expected

This article helps you resolve issues where entitlement remaining terms don't decrease as expected in Microsoft Dynamics 365 Customer Service.

In Dynamics 365 Customer Service, there are two scenarios of decrementing [entitlement terms](/dynamics365/customer-service/administer/create-entitlement-define-support-terms-customer?tabs=customerserviceadmincenter#create-an-entitlement).

## Scenario 1

When the **Allocation Type** field for an entitlement is set to **Number of cases**, you can set the **Decrease Remaining On** field to either **Case Creation** or **Case Resolution**.  

- If you select **Case Creation**, the **Remaining Terms** will be decreased when a new case is created.
- If you select **Case Resolution**, the **Remaining Terms** will be decreased when the case is resolved.

For example:

- **Decrease Remaining On** is set to **Case Creation** and **Total Terms** is given as 10.

  - Create a new case by adding entitlement.
  - When the case is created, 1 term is deducted and the number of **Remaining Terms** will be 9.

- **Decrease Remaining On** is set to **Case Resolution** and **Total Terms** is given as 10.

  - Create a new case by adding entitlement and resolve it.
  - After the case is resolved, 1 term is deducted and the number of **Remaining Terms** will be 9.

## Scenario 2

When the **Allocation Type** field for an entitlement is set to **Number of hours**, the **Decrease Remaining On** field can be set only to **Case Resolution**.

For example:

- Create an activity in case form that should be completed before resolving the case, with duration field set to 30 min.
- After the case is resolved, 0.5 term is deducted and the **Remaining Terms** will be 9.5.

Here, the **Decrease Remaining On** calculation works as:

```console
1hour (60min) = 1 term
30min = 0.5 term
```

When **Restrict based on entitlement terms** is set to **Yes**, agents won't be able to create cases with entitlement when **Remaining Terms** is less than zero or when the term remaining for a channel is less than zero.

## Symptoms

Entitlement remaining terms aren't decreasing as expected.

## Cause

Certain settings affect the behavior of entitlement remaining terms.

## Resolution 1

Check if **Do Not Decrement Entitlement terms** is selected in case form. If it is, then **Remaining terms** won't decrement when a case is created or resolved. To allow **Remaining terms** to decrement, deselect **Do Not Decrement Entitlement terms**.

:::image type="content" source="media\decrementing-entitlement-terms\do-not-decrement-entitlement-terms-option-on-case-form.png" alt-text="Screenshot that shows the Do Not Decrement Entitlement terms option on case form.":::

## Resolution 2

1. Sign in to your Dynamics 365 Customer Engagement (on-premises) instance.
1. Go to **Settings** > **Advanced Settings** > **Customizations** > **Customize the System** to open the default solution.
1. Disable all custom plugins, workflows, custom .js code on entitlement and case entity.
1. Remove custom active layer for case and entitlement entities.
1. Remove custom active layer from the **decremententitlementterm** field on case entity.
