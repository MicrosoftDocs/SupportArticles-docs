---
title: Select an active entitlement that belongs to the specified customer, contact, or product error
description: Resolves an error that occurs when selecting an active entitlement on a case in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 03/14/2024
---
# "Select an active entitlement that belongs to the specified customer, contact, or product" error

This article provides a resolution for the "Select an active entitlement that belongs to the specified customer, contact, or product, and then try again" error that occurs when you create a case with a contact in the **Customer** field in Microsoft Dynamics 365 Customer Service.

## Symptoms

After an entitlement is created for an account, when you try to [create a case](/dynamics365/customer-service/use/customer-service-hub-user-guide-create-a-case#create-a-case) with a contact in the **Customer** field, you receive the following error:

> Select an active entitlement that belongs to the specified customer, contact, or product, and then try again.

## Cause

The account selected in the entitlement might have a specific contact attached to it and selected in the Contacts grid. In this case, the entitlement is applied only when the contact selected in the entitlement's Contacts grid is also selected in the case. Otherwise, you will receive the above error message.

:::image type="content" source="media\entitlement-with-associate-customer-contact\seleted-account-on-entitlement.png" alt-text="Screenshot that shows an account is selected in an entitlement.":::

## Resolution

- Check the Contacts grid in the entitlement and see if a contact is also selected.
- If a contact is selected, do one of the following: 
    - In the case record where the entitlement needs to be applied, select the account and the contact which is selected in the entitlement's Contacts grid.
    - Remove the contact from the entitlement so the entitlement isn't attached to a specific contact.
- Use the `https://<orgurl>/api/data/v9.2/entitlementcontactscollection` API to check if the contact is attached to the entitlement.

For more information, see [Associate a customer contact with the entitlement](/dynamics365/customer-service/create-entitlement-define-support-terms-customer?tabs=customerserviceadmincenter#associate-a-customer-contact-with-the-entitlement).
