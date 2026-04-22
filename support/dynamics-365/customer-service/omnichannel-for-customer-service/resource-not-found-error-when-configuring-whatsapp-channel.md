---
title: Resolve WhatsApp Channel Resource Not Found Error
description: Troubleshoot the msdyn_UpdatePrivacyTerms Resource not found error in Dynamics 365 Customer Service. Follow step-by-step instructions to reactivate the process.
ai-usage: ai-assisted
ms.date: 04/22/2026
ms.reviewer: srreddy, parkmermel, nenellim, v-shaywood
ms.custom: sap:WhatsApp via Twilio, DFM
---
# Resource not found error when configuring WhatsApp channel

## Summary

When you configure the WhatsApp channel in [Dynamics 365 Customer Service](/dynamics365/customer-service/implement/overview) or [Dynamics 365 Contact Center](/dynamics365/customer-service/implement/introduction-omnichannel), you might receive a "Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'" error. This error occurs because a required omnichannel process is deactivated. Reactivating the process resolves the issue.

## Symptoms

When you try to [configure the WhatsApp channel](/dynamics365/customer-service/administer/configure-whatsapp-channel) in Dynamics 365 Customer Service or Dynamics 365 Contact Center, you receive the following error message:

> A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'.

## Cause

This issue occurs when the required **UpdatePrivacyTerms** omnichannel process is deactivated in your environment.

## Solution

To resolve this issue, reactivate the **UpdatePrivacyTerms** process:

1. Go to [Power Apps](https://make.powerapps.com/) and select your environment.
1. Select **Solutions** > **Default Solution**.
1. Select **Objects** and then search for *processes*.
1. In the search box in the upper-right corner, enter *UpdatePrivacyTerms*.
1. Select the **UpdatePrivacyTerms** process, and then select **Activate**.

## Related content

- [Provision channels in Dynamics 365 Contact Center](/dynamics365/contact-center/implement/provision-channels)
