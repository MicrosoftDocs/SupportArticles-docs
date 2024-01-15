---
title: Entitlement remaining terms don't decrement as expected
description: Provides a resolution for an issue where the remaining terms of entitlements don't decrement as expected in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: v-psuraty
author: v-psuraty
ms.date: 01/15/2024
---
# Remaining terms of entitlements don't decrement as expected

This article helps you resolve an issue where the remaining terms of entitlements don't decrease as expected in Microsoft Dynamics 365 Customer Service.

In Dynamics 365 Customer Service, there are two scenarios of decrementing [entitlement terms](/dynamics365/customer-service/administer/create-entitlement-define-support-terms-customer?tabs=customerserviceadmincenter#create-an-entitlement).

## Scenario 1

When the **Allocation Type** field of an entitlement is set to **Number of cases**, you can set the **Decrease Remaining On** field to either **Case Creation** or **Case Resolution**.  

- If you select **Case Creation**, the **Remaining Terms** will be decreased when a new case is created.
- If you select **Case Resolution**, the **Remaining Terms** will be decreased when the case is resolved.

For example:

- **Decrease Remaining On** is set to **Case Creation** and **Total Terms** is given as 10.

  - Create a new case by adding entitlements.
  - When the case is created, 1 term is deducted, and the number of **Remaining Terms** is 9.

- **Decrease Remaining On** is set to **Case Resolution** and **Total Terms** is given as 10.

  - Create a new case by adding entitlements and resolve it.
  - After the case is resolved, 1 term is deducted, and the number of **Remaining Terms** is 9.

## Scenario 2

When the **Allocation Type** field of an entitlement is set to **Number of hours**, the **Decrease Remaining On** field can be set only to **Case Resolution**.

For example:

- Create an activity in the case form that should be completed before resolving the case, with the duration field set to 30 minutes.
- After the case is resolved, 0.5 term is deducted, and the **Remaining Terms** is 9.5.

Here, the **Decrease Remaining On** calculation works as:

```console
1hour (60min) = 1 term
30min = 0.5 term
```

If **Restrict based on entitlement terms** is set to **Yes**, agents won't be able to create cases with entitlements when **Remaining Terms** is less than zero or when the term remaining for a channel is less than zero.

## Symptoms

The remaining terms of an entitlement aren't decreasing as expected.

## Cause

Certain settings affect the behavior of the entitlement remaining terms.

## Resolution 1

Check if **Do Not Decrement Entitlement terms** is selected in the case form. If so, the **Remaining terms** won't be decremented when a case is created or resolved. To allow **Remaining terms** to be decremented, deselect **Do Not Decrement Entitlement terms**.

:::image type="content" source="media\decrementing-entitlement-terms\do-not-decrement-entitlement-terms-option-on-case-form.png" alt-text="Screenshot that shows the Do Not Decrement Entitlement terms option on the case form.":::

## Resolution 2

1. Sign in to your Dynamics 365 Customer Engagement (on-premises) instance.
1. Go to **Settings** > **Advanced Settings** > **Customizations** > **Customize the System** to open the default solution.
1. Disable all custom plugins, workflows, and custom .js code on the entitlement and case entities.
1. Remove the custom active layer for the case and entitlement entities.
1. Remove the custom active layer from the **decremententitlementterm** field on the case entity.
