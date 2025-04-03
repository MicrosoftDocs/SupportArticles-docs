---
title: Troubleshoot Issues with Provisioning Channels
description: Solves an issue where the Omnichannel Admin Center appears in read-only view and you can't manage or provision channels.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/31/2025
ms.reviewer: bavasude, srubinstein
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Can't provision channels in Omnichannel Admin Center

This article provides guidance for resolving provisioning issues when the Omnichannel Admin Center application appears in read-only view.

## Symptoms

When you try to provision a channel in the Omnichannel Admin Center, you encounter the following issues:

- The Omnichannel Admin Center appears in read-only view.
- You can't manage or provision channels through the Omnichannel Admin center.

## Cause

The Omnichannel Admin center has been deprecated. All functionalities previously available in the Omnichannel Admin center have been integrated into the Customer Service admin center. For more information, see [Deprecations in Dynamics 365 Customer Service](/dynamics365/customer-service/implement/deprecations-customer-service#provisioning-of-omnichannel-for-customer-service-in-power-platform-admin-center-is-deprecated).

## Resolution

To successfully provision the chat (or other) channels, follow these steps:

1. Navigate to your environment.
2. Open the **Customer Service admin center** application.
3. Go to **Channels** under **Customer Support**.
4. Select **Manage** to configure the channels.
5. Check the appropriate boxes to provision the channels that you want to use.
6. Select **Save**.

For more information, see [Provision channels in Dynamics 365 Contact Center](/dynamics365/contact-center/implement/provision-channels).
