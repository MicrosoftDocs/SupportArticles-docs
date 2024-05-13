---
title: You can only view data error when sharing a link in Teams
description: Provides a resolution for an issue where users get an error message that states that they can only view data when you share a link in Microsoft Teams as a Business Central user. 
ms.author: mikebc
ms.reviewer: jswymer
ms.date: 05/13/2024
---
# "You can only view data in Microsoft Teams" error in Business Central

This article provides a resolution for the "you can only view data in Microsoft Teams" error that occurs when you share a link to a user who has a Microsoft 365 license in Dynamics 365 Business Central.

## Symptoms

When you [share a link](/dynamics365/business-central/across-working-with-teams#share-a-link) in Microsoft Teams as a Business Central user, certain users might receive the following error message:

> When accessing Business Central with a Microsoft 365 license, you can only view data in Microsoft Teams.

## Cause

When a user shares a Business Central link to a Microsoft Teams chat or channel, navigating the link will always navigate out of Microsoft Teams where a user with a Microsoft 365 license can no longer access the data .

## Resolution

Share pages or records in Microsoft Teams in one of the following ways:

- Include the link preview as a card. For more information, see [Include a Business Central card in a Teams conversation](/dynamics365/business-central/across-working-with-teams#include-a-business-central-card-in-a-teams-conversation).
- Share data as a tab in the chat or channel. For more information, see [Add Business Central tab in Microsoft Teams](/dynamics365/business-central/across-teams-tab).
