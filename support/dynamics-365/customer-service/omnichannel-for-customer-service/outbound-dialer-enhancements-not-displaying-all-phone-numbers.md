---
title: Outbound Dialer Enhancements Not Displaying All Phone Numbers
description: Resolves an issue where only the business phone number is displayed for contacts or accounts when you use the enhanced outbound dialer in Microsoft Dynamics 365 Customer Service.
ms.reviewer: srubinstein
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/18/2025
ms.custom: sap:Voice channel, DFM
---
# Enhanced outbound dialer doesn't display all phone numbers

This article addresses an issue where the enhanced outbound dialer experience doesn't display all available phone numbers associated with contacts or accounts in Dynamics 365 Customer Service.

## Symptoms

When you use the [enhanced outbound dialer](/dynamics365/release-plan/2023wave2/service/dynamics365-customer-service/improvements-call-dialer) in Dynamics 365 Customer Service, only the business phone number is displayed for contacts or accounts. Other phone numbers, such as those entered in the mobile phone field, aren't shown, even if they're available in the system.

## Cause

This issue could be caused due to customizations on the **Contact** form. Specifically, if a custom mobile phone field has been created, it may not be populating the standard `mobilephone` attribute of the `contacts` entity. As a result, the enhanced outbound dialer retrieves and displays only the business phone number.

## Resolution

To resolve this issue, follow these steps:

1. Open the Dynamics 365 Customer Service environment.
2. Navigate to the [Contacts](/dynamics365/customer-service/administer/create-design-forms-customer-service-hub) entity and open the **Contact** form.
3. Check for any custom mobile phone fields that have been added to the form.
4. Ensure that these custom fields are configured to populate the standard `mobilephone` attribute of the `contacts` entity.
5. Save and publish the changes to the **Contact** form.
6. Test the enhanced outbound dialer to confirm that it now retrieves and displays all available phone numbers, including mobile numbers.

For more information on the Contact entity and attributes, see [Contact table/entity reference (Microsoft Dataverse)](/power-apps/developer/data-platform/reference/entities/contact).
