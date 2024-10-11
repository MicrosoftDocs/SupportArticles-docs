---
title: User does not have required privileges to access the org error
description: Resolves an error message that states the user doesn't have required privileges to access the organization when the Administration mode is enabled in Copilot for Sales.
ms.date: 01/10/2024
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# "User does not have required privileges to access the org in Admin Only mode" error

This article provides a resolution for an error message that occurs in Microsoft Copilot for Sales when the organization is in [Administration mode](/power-platform/admin/admin-mode).

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in and Teams app    |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365      |
|**Users**     | Users trying to use Copilot for Sales when **Administration mode** is enabled. |

## Symptoms

When you use Copilot for Sales, you receive the "Something went wrong" error message with the following error description:

> User does not have required privileges (or role membership) to access the org when it is in Admin Only mode.

The error might be displayed before or after you sign in to an environment from Copilot for Sales.

## Cause

The [Administration mode](/power-platform/admin/admin-mode) is enabled for the environment, and the affected users aren't administrators.

When an administrator enables the **Administration mode** for an environment, regular users, regardless of their role assignment, can't access the environment. The user who is already signed in or tries to sign in to the environment can't access data from the environment and will see the error message.

:::image type="content" source="media/user-does-not-have-required-privileges-error/enabled-administration-mode.png" alt-text="Screenshot that shows the Administration mode is enabled for the environment.":::

## Resolution

To resolve this issue, the administrator must disable the **Administration mode** for the environment.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
