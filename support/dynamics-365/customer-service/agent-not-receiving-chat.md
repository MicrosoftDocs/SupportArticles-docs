---
title: Agent isn't receiving chat
description: Provides a solution to issue where an agent doesn't receive a chat in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Agent isn't receiving chat in Omnichannel for Customer Service

This article provides a solution to an issue where an agent isn't receiving a chat in Omnichannel for Customer Service.

## Symptom

As an agent, you aren't receiving chat in the Omnichannel for Customer Service app.

## Cause

The issue is caused when you receive the chats in Customer Service Hub app.

## Resolution

You must remove the Customer Service Hub app from the channel provider configuration in the Channel Integration Framework app.

1. Sign in to **Channel Integration Framework**.
2. Select the record that is related to omnichannel.
3. Remove **Customer Service Hub** from the **Select Unified Interface Apps for the Channel** section.
4. Select **Save** to save the record.
