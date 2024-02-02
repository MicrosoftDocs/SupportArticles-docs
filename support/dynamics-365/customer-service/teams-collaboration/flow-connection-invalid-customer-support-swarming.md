---
title: Flow connection isn't valid for customer support swarming
description: Provides a resolution for an issue where the flow connection isn't valid for customer support swarming in Dynamics 365 Customer Service.
ms.author: jinywang
ms.reviewer: laalexan
ms.date: 10/11/2023
---
# Flow connection isn't valid when configuring expert notifications in customer support swarming

This article provides a resolution for an issue where the flow connection isn't valid when configuring expert notifications for customer support swarming in Microsoft Dynamics 365 Customer Service.

## Symptoms

The flow can't be enabled automatically through the **Expert notifications** card on the [customer support swarming form](/dynamics365/customer-service/configure-customer-support-swarming#overview-of-the-customer-support-swarming-page), or there's an issue with the flow connection.

## Resolution

Take the following troubleshooting steps to diagnose and fix the issue:

1. On the swarm form's **Expert notifications** card, open Power Automate by selecting the **Edit in Power Automate** link under **Activate notifications for experts**.
2. In the Power Automate sitemap, select **Connections** under **Data**.
3. Remove the connection by selecting the vertical ellipsis next to it, and then select **Delete** from the dropdown menu.
4. Return to the swarm form and select **Activate notifications** to reactivate the flow.

If the issue persists, contact Microsoft Support to raise a ticket.

## See also

For more information about configuring customer support swarming, see [Configure customer support swarming for complex cases](/dynamics365/customer-service/configure-customer-support-swarming).
