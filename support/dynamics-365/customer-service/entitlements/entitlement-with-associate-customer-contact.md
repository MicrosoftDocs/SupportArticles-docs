---
title: "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error
description: Provides a resolution for the issue that occurs while selecting an active entitlement on a case.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 02/27/2023
---
# "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error

This article provides a resolution for the "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error that occurs when you create a case with any contact in the customer field on the case.

## Symptoms

When an entitlement is created for an account and you try to create a case with any contact in the customer field on the case, you see the "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error.

## Cause

The account selected in the entitlement might have only a specific contact attached to it. For example, an account is selected on the entitlement, but it has a specific contact selected on the contact’s grid. So, only when the contact selected on the entitlements contact grid is selected on the case, the entitlement gets applied.

:::image type="content" source="media\entitlement-with-associate-customer-contact\seleted-account-on-entitlement.png" alt-text="Screenshot that shows account is selected on the entitlement.":::

### Resolution

- Check the contacts grid on the entitlement and see if a contact is selected on the same.
- Select the account and the contact selected in the entitlement on the case record where the entitlement needs to be applied or remove the contact from the entitlement.
- Use API: https://orgurl/api/data/v9.2/entitlementcontactscollection to check if contacts are attached to the entitlement.

For more information, see [Associate a customer contact with the entitlement](/dynamics365/customer-service/create-entitlement-define-support-terms-customer?tabs=customerserviceadmincenter#associate-a-customer-contact-with-the-entitlement).

