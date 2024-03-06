---
title: Select an active entitlement that belongs to the specified customer, contact, or product, and then try again error
description: Provides a resolution for the issue that occurs while selecting an active entitlement on a case in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 03/06/2024
---
# "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error

This article provides a resolution for the "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error that occurs when you create a case with a contact in the **Customer** field on the case in Microsoft Dynamics 365 Customer Service.

## Symptoms

When an entitlement is created for an account and you try to [create a case](/dynamics365/customer-service/use/customer-service-hub-user-guide-create-a-case#create-a-case) with a contact in the **Customer** field on the case, you receive the following error:

> Select an active entitlement that belongs to the specified customer, contact, or product, and then try again.

## Cause

The account selected in the entitlement might have a specific contact attached to it and selected in the contacts grid. In this case, the entitlement gets applied only when the contact selected in the entitlement's contacts grid is also selected in the case.

:::image type="content" source="media\entitlement-with-associate-customer-contact\seleted-account-on-entitlement.png" alt-text="Screenshot that shows an account is selected on the entitlement." lightbox="media/entitlement-with-associate-customer-contact/seleted-account-on-entitlement.png":::

### Resolution

- Check the contacts grid on the entitlement and see if a contact is selected on the same.
- In the case record where the entitlement needs to be applied, select the account and the contact selected in the entitlement contact's grid. Or, remove the contact from the entitlement so it isn't attached to a specific contact.
- Use the `https://orgurl/api/data/v9.2/entitlementcontactscollection` API to check if contacts are attached to the entitlement.

For more information, see [Associate a customer contact with the entitlement](/dynamics365/customer-service/create-entitlement-define-support-terms-customer?tabs=customerserviceadmincenter#associate-a-customer-contact-with-the-entitlement).
