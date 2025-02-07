---
title: No access to Dynamics 365 error in Copilot for Sales
description: Resolves an issue where users can't access Dynamics 365 through the Copilot for Sales add-in for Outlook.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Permissions
---
# "No access to Dynamics 365" error in Copilot for Sales

This article helps you troubleshoot and resolve issues when users can't access Microsoft Dynamics 365 through the [Microsoft Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/open-app#access-copilot-for-sales-in-outlook).

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365      |
|**Users**     | Users trying to sign in to the Dynamics 365 environment from Copilot for Sales |

## Symptoms

After a user signs in to Dynamics 365 through the Copilot for Sales add-in for Outlook, the following error message is displayed:

> You don't seem to have access to Dynamics 365. Please contact your admin, or sign in with a different Microsoft account.

:::image type="content" source="media/no-access-to-dynamics-365-error/no-access-d365.png" alt-text="Screenshot that shows the error that occurs when the user tries to sign in.":::

## Cause

The user doesn't have the required security roles assigned.

To use Copilot for Sales, users must have a valid Dynamics 365 license and be assigned the appropriate security roles. These roles have the required permissions for Copilot for Sales to work properly.

## Resolution

The following security roles must be assigned to each user using Copilot for Sales:

- **Salesperson**
- **Basic User**
- **Sales Copilot User**

For information about how to assign security roles to users, see [Assign a security role to a user](/power-platform/admin/assign-security-roles).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
