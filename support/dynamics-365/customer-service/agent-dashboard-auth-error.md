---
title: Agent dashboard doesn't load or displays authorization error
description: Provides a solution for when the agent dashboard doesn't load or displays an authorization error in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Agent dashboard doesn't load or displays an authorization error

This article provides a solution for when the agent dashboard in Omnichannel for Customer Service isn't loading or displays an authorization error.

## Symptom

The agent dashboard won't load or gives an authorization error.

## Cause

The issue might happen due to the following reasons:

- Azure Active Directory consent is not available for Omnichannel for Customer Service app.
- Agent doesn't the Omnichannel agent role privileges.
- Agent is not assigned to any queue.

## Resolution

Perform the following steps:

- Contact your administrator to verify that Azure Active Directory consent is given to the Omnichannel for Customer Service application on your tenant. Go to [Authorize access](https://go.microsoft.com/fwlink/p/?linkid=2070932) to get access. To learn more, see [Provide data access consent](omnichannel-provision-license.md#provide-data-access-consent).
- Ensure the agent account has the role **Omnichannel Agent**. For more information about the relevant roles, see [Understand roles and their privileges](add-users-assign-roles.md#understand-roles-and-their-privileges). 
- Ensure the agent account is assigned to at least one queue in the Omnichannel Administration app. To learn more, see [Manage users in Omnichannel for Customer Service](users-user-profiles.md).
