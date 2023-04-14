---
title: Agent doesn't receive a chat
description: Provides a resolution for the issue where an agent doesn't receive a chat in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# An agent doesn't receive a chat in Omnichannel for Customer Service

This article provides a solution for the issue where an agent isn't receiving a chat in Omnichannel for Customer Service.

## Symptoms

As an agent, you aren't receiving a chat in the Omnichannel for Customer Service app.

## Cause

The issue occurs when you receive the chats in Customer Service Hub app.

## Resolution

To resolve this issue, you must remove the Customer Service Hub app from the channel provider configuration in the Channel Integration Framework app.

1. Sign in to Dynamics 365 Channel Integration Framework.
2. Select the record that is related to omnichannel.
3. Remove **Customer Service Hub** from the **Select Unified Interface Apps for the Channel** section.
4. Select **Save** to save the record.
