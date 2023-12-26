---
title: No access to Dynamics 365 error occurs in Copilot for Sales
description: Resolves an issue where users don't have access to Dynamics 365 through Copilot for Sales add-in for Outlook.
ms.date: 12/26/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# "No access to Dynamics 365" error occurs in Copilot for Sales

This article helps you troubleshoot and resolve issues when users don't have access to Dynamics 365.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365      |
|**Users**     | Users trying to sign in to Dynamics 365 environment from Copilot for Sales |

## Symptoms

After a user signs in to Dynamics 365 through [Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/use-sales-copilot-outlook), the following error message is displayed:

> You don't seem to have access to Dynamics 365. Please contact your admin, or sign in with a different Microsoft account.

:::image type="content" source="media/no-access-to-dynamics-365-error/no-access-d365.png" alt-text="Screenshot that shows the error that occurs when the user try to sign in.":::

## Cause

The user doesn't have required security roles assigned.

To use Copilot for Sales, users must have a valid Dynamics 365 license and appropriate security roles assigned to them. These roles have required permissions for Copilot for Sales to work properly.

## Resolution

The following security roles must be assigned to each user using Copilot for Sales:

- Salesperson
- Basic User
- Copilot for Sales User or Viva Sales User

For information about how to assign security roles to users, see [Assign a security role to a user](/power-platform/admin/assign-security-roles).

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
