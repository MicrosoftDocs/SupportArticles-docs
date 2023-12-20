---
title: No access to Dynamics 365
description: Troubleshoot and resolve issues when users don't have access to Dynamics 365.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# No access to Dynamics 365

This article helps you troubleshoot and resolve issues when users don't have access to Dynamics 365.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365      |
|**Users**     | Users trying to sign in to Dynamics 365 environment from Sales Copilot |

## Symptom

After a user signs in to Dynamics 365 through Sales Copilot add-in for Outlook, the following error message is displayed: `You don't seem to have access to Dynamics 365. Please contact your admin, or sign in with a different Microsoft account.`

:::image type="content" source="media/tsg-no-access-d365.png" alt-text="f":::

## Cause

User doesn't have required security roles assigned.

To use Sales Copilot, users must have a valid Dynamics 365 license and appropriate security roles assigned to them. These roles have required permissions for Sales Copilot to work properly.

## Solution

The following security roles must be assigned to each user using Sales Copilot:

- Salesperson
- Basic User
- Sales Copilot User or Viva Sales User

For information about how to assign security roles to users, see [Assign a security role to a user](/power-platform/admin/assign-security-roles).

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.