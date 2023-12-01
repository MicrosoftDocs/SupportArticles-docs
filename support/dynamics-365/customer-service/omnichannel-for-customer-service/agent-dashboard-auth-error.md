---
title: Agent dashboard doesn't load or shows an authorization error
description: Provides a resolution for the issue where the agent dashboard doesn't load or displays an authorization error in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: vamullap
ms.date: 05/23/2023
---
# Agent dashboard doesn't load or displays an authorization error

This article provides a resolution for the issue where the agent dashboard in Omnichannel for Customer Service isn't loading or displays an authorization error in Omnichannel for Customer Service.

## Symptoms

The agent dashboard won't load or shows an authorization error.

## Cause

The issue might occur due to the following reasons:

- Microsoft Entra consent isn't available for the Omnichannel for Customer Service app.
- Agent doesn't have the **Omnichannel Agent** role privileges.
- Agent isn't assigned to any queue.

## Resolution

To resolve this issue, take the following steps:

1. Contact your administrator to verify that Microsoft Entra consent is given to the Omnichannel for Customer Service app on your tenant. Go to [Authorize access](https://go.microsoft.com/fwlink/p/?linkid=2070932) to get access. To learn more, see [Provide data access consent](/dynamics365/customer-service/implement/data-access-consent).
2. Ensure the agent account has the **Omnichannel Agent** role. For more information about the relevant roles, see [Understand roles and their privileges](/dynamics365/customer-service/add-users-assign-roles#understand-roles-and-their-privileges).
3. Ensure the agent account is assigned to at least one queue in the Omnichannel Administration app. To learn more, see [Manage users in Omnichannel for Customer Service](/dynamics365/customer-service/users-user-profiles).
