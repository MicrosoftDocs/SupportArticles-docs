---
title: This Number Cannot be Upgraded Calling and SMS Capabilities Maxed Out error
description: Helps resolve an error related to a trial phone number in Azure Communication Services.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/24/2025
ms.custom: sap:Messaging capabilities, DFM
---
# "This number cannot be upgraded, Calling and SMS capabilities maxed out" error 

This article helps you resolve the error you may encounter when using a trial phone number in Azure Communication Services.

## Symptoms

When you try to upgrade the capabilities of a phone number in Azure Communication Services, the following error message occurs:

> This number cannot be upgraded. Calling and SMS capabilities maxed out.

## Cause

This issue occurs when you try to upgrade the capabilities of a phone number in a trial environment and the maximum allowed capabilities for calling and SMS have been reached. Trial environments have limitations, and phone numbers in such environments can't be upgraded.

## Resolution

To resolve this issue,

1. Remove the default trial phone number.
2. Use the purchased phone number instead of the default phone number.

For more information about trial phone numbers in Azure Communication Services, see [Frequently asked questions about trial phone numbers in Azure Communication Services](/azure/communication-services/concepts/telephony/trial-phone-numbers-faq).
