---
title: Welcome email isn't sent when new customers are created
description: This article provides troubleshooting guidance that can help if a welcome email notification isn't sent when a new customer is created in Microsoft Dynamics 365 Commerce.
author: josaw1
ms.author: josaw
ms.date: 08/08/2023
ms.custom: sap:Customer accounts and loyalty\Issues with customer account in e-commerce
---
# Welcome email isn't sent when new customers are created

This article provides troubleshooting guidance that can help if a welcome email notification isn't sent when a new customer is created in Microsoft Dynamics 365 Commerce.

## Symptoms

When a new customer is created in Commerce headquarters, a welcome email isn't sent to the customer, even though an email notification is configured for the **Customer created** email notification type.

## Resolution

Associate an email notification profile under **Commerce parameters**:

1. In Commerce headquarters, go to **Retail and Commerce** > **Headquarters setup** > **Parameters** > **Commerce parameters** > **General**.
2. In the **Email notification profile** drop-down list, select the email notification profile that contains a mapping between the customer created notification type and a customer created email template.

> [!NOTE]
> When you enable customer created notifications, customers that are created in all channels within the legal entity will receive a customer created email. Currently, customer created notifications can't be limited to a single channel.

## More information

- [Create email templates for transactional events](/dynamics365/commerce/email-templates-transactions)
- [Set up an email notification profile](/dynamics365/commerce/email-notification-profiles)
