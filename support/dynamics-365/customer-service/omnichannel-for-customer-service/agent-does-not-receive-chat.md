---
title: Agent doesn't receive a chat
description: Provides a resolution for the issue where an agent doesn't receive a chat in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: vamullap
ms.date: 05/23/2023
---
# An agent doesn't receive a chat in Omnichannel for Customer Service

This article provides a resolution for the issue where an agent isn't receiving a chat in Omnichannel for Customer Service.

## Symptoms

As an agent, you aren't receiving a chat in the Omnichannel for Customer Service app.

## Cause

The issue occurs when you receive the chats in the Customer Service Hub app.

## Resolution

To resolve this issue, you must remove the Customer Service Hub app from the channel provider configuration in the Channel Integration Framework app.

1. Sign in to the Dynamics 365 Channel Integration Framework app.
2. Select the record that's related to omnichannel.
3. Remove **Customer Service Hub** from the **Select Unified Interface Apps for the Channel** section.
4. Select **Save** to save the record.
