---
title: Caller ID in Dynamics 365 shows Phone Numbers Not Custom Names
description: It's not possible to configure a display name for outbound calls in Dynamics 365 Customer Service. Only a phone number can be set as the caller ID number.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/24/2025
ms.custom: sap:Voice channel, DFM
---
# Can't set display name for outbound calls in Dynamics 365 Customer Service

Microsoft Dynamics 365 Customer Service enables businesses to manage customer interactions efficiently. However, you might encounter limitations regarding how outbound caller IDs are displayed. This article explains the issue, its cause, and provides guidance on the current configurations available.

## Symptoms

When agents make outbound calls using Dynamics 365 Customer Service, the caller ID displayed to the recipient only shows a toll-free number. You would prefer your company name to be displayed instead.

## Cause

Dynamics 365 Customer Service currently doesn't support configuring a display name (such as a company name) as the caller ID for outbound calls. The **Number label** field associated with the outbound profile is used in the agent dialer interface only and doesn't appear to users who receive the call.

## More information

For more information on configuring outbound and inbound profiles, see [Configure outbound and inbound profiles](/dynamics365/customer-service/administer/configure-outbound-inbound-profiles).
