---
title: Specific Entitlement, which though active, but when selected on a case it gives an error that please select an active entitlement.
description: Provides a resolution for the issue where a specific entitlement, which though active, but when selected on a case it gives an error that please select an active entitlement.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# A specific entitlement, which though active, but when selected on a case it gives an error that please select an active entitlement.

This article provides a resolution for the issue where a specific entitlement, which though active, but when selected on a case it gives an error that please select an active entitlement.

## Symptoms

When an Entitlement is created for an Account and the user tries to create a case with any contact in the customer field on the case it throws an error “please select an active entitlement”

## Cause

The account selected in the entitlement might have only a specific contact attached to it. 

Please check the contacts grid on the entitlement and see if a contact is selected on the same.

As seen in image below. An account is selected on the entitlement, but it has specific contact selected on the contact’s grid. So, only when the contact selected on the entitlements contact grid is selected on the case the entitlement will get applied.

:::image type="content" source="media\entitlement-with-associate-customer-contact\seleted-account-on-entitlement.png" alt-text="Screenshot that shows account is selected on the entitlement.":::

API call https:// <orgurl> /api/data/v9.2/entitlementcontactscollection can also be used to check if contacts are attached to the entitlement.

### Resolution

Select the account and the contact selected in the entitlement on the case record where the entitlement needs to be applied.

Or 

Remove the contact from the entitlement.

For more information please visit [Associate a customer contact with the entitlement](https://learn.microsoft.com/en-us/dynamics365/customer-service/create-entitlement-define-support-terms-customer?tabs=customerserviceadmincenter#associate-a-customer-contact-with-the-entitlement).

