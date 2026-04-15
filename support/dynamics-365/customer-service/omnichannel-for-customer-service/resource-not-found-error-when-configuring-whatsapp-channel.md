---
title: Resource Not Found Error When Configuring WhatsApp Channel
description: Solves the Resource not found for the segment error when configuring the WhatsApp channel in Microsoft Dynamics 365 Customer Service or Dynamics 365 Contact Center.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/14/2026
ms.reviewer: parkmermel
ms.custom: sap:WhatsApp via Twilio, DFM
---
# Resource not found error when configuring WhatsApp channel

This article provides guidance on resolving the "A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'" error that may occur when you configure the WhatsApp channel in Dynamics 365 Customer Service or Dynamics 365 Contact Center.

## Symptoms

When you try to [configure the WhatsApp channel](/dynamics365/customer-service/administer/configure-whatsapp-channel) in Dynamics 365 Customer Service or Dynamics 365 Contact Center, you receive the following error message:

> A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'.

## Cause

This issue occurs when certain required Omnichannel-related plugins are disabled.

## Resolution

To resolve this issue, do as follows:

1. Go to [Power Apps](https://make.powerapps.com/), and select your environment.
1. Select **Solutions** > **Default Solution**.
1. Select **Objects**, and then search "processes".
1. In the search box on the top right, search **UpdatePrivacyTerms**.
1. Select **UpdatePrivacyTerms** and activate it.

### Related information

[configure the WhatsApp channel](/dynamics365/customer-service/administer/configure-whatsapp-channel)  
