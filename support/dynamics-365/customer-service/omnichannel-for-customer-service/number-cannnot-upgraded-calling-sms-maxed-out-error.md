---
title: This Number Cannot be Upgraded Calling and SMS Capabilities Maxed Out error
description: Helps resolve an error related to a trial phone number in Azure Communication Services.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/25/2025
ms.custom: sap:Messaging capabilities, DFM
---
# "This number cannot be upgraded. Calling and SMS capabilities maxed out" error

This article helps you resolve the error you may encounter when your SMS channel is configured to use a trial phone number in Azure Communication Services.

## Symptoms

When you try to upgrade the capabilities of a phone number in Azure Communication Services, the following error message occurs:

> This number cannot be upgraded. Calling and SMS capabilities maxed out.

## Cause

This issue occurs when you try to upgrade the capabilities of a phone number in a trial environment and the maximum allowed capabilities for calling and SMS have been reached. Trial environments have limitations, and phone numbers in such environments can't be upgraded.

## Resolution

To resolve this issue,

1. Remove the default trial phone number.
2. Use the purchased phone number instead of the default phone number.

For information on configuring an SMS channel using Azure Communication Services, see [Configure an SMS channel using Azure Communication Services](/dynamics365/customer-service/administer/configure-sms-channel-acs).
For information on trial phone numbers in Azure Communication Services, see [Frequently asked questions about trial phone numbers in Azure Communication Services](/azure/communication-services/concepts/telephony/trial-phone-numbers-faq).
