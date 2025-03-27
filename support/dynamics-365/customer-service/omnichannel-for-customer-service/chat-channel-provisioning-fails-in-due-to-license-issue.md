---
title: Chat channel provisioning fails in Dynamics 365 due to license issue
description: Solves an issue where the chat channel provisioning fails in Dynamics 365 Customer Service due to a license issue.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/27/2025
ms.reviewer: bavasude, srubinstein
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Chat channel provisioning fails in Dynamics 365 due to license issue

This article provides guidance to resolve the issue where the chat channel provisioning fails in Dynamics 365 Customer Service due to a license issue.

## Symptoms

When attempting to provision a chat channel in Dynamics 365 Customer Service, the system reports that there is no license available. This occurs even though licenses have been purchased.

## Cause

The issue occurs if the required Microsoft Dynamics 365 Customer Service Enterprise or Dynamics 365 Customer Engagement Plan license is not available or assigned. Licenses currently attached may be insufficient, such as basic or other messaging channel licenses, and do not include the necessary Customer Service Enterprise license required for provisioning the chat channel.

## Solution

To resolve this issue, follow the steps below:

1. Verify whether the Microsoft Dynamics 365 Customer Service Enterprise license or Dynamics 365 Customer Engagement Plan license is purchased and available in the tenant.

2. Ensure the license is assigned to the appropriate users.

3. Ensure the users have active subscription to the appropriate add-ons.

Refer to [Omnichannel for Customer Service system requirements](/dynamics365/customer-service/implement/system-requirements-omnichannel) to confirm the required licenses and provisioning prerequisites.
