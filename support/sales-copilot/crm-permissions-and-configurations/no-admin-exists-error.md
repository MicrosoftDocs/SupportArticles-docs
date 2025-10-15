---
title: You don't have permission for this when opening Sales app
description: Resolves the You don't have permission for this error that occurs in Sales app when a user tries to open the app.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# "You don't have permission for this" error when opening Sales app

This article helps you resolve the "You don't have permission for this" error in Sales app when a user tries to open the app.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales app in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce       |
|**Users**     | The first user who opens the app in the tenant.      |

## Symptoms

When a user tries to open Sales app, the following error is displayed:

> You don't have permission for this

:::image type="content" source="media/ask-admin-help/ask-admin-help.png" alt-text="Screenshot that shows the You don't have permission for this error.":::

## Cause

This error occurs when the first user in a tenant tries to [open Sales app](/microsoft-sales-copilot/open-app), and the tenant doesn't have any administrators assigned to create the environment.

## Resolution

To resolve this issue, assign at least one administrator to the tenant with your administrator credentials.

1. Open one of the following URLs as per your tenant type:

    - Production: [https://admin.powerplatform.microsoft.com/](https://admin.powerplatform.microsoft.com/)
    - Non-production: [https://admin.preprod.powerplatform.microsoft.com/](https://admin.preprod.powerplatform.microsoft.com/)

1. In the left pane, select **Admin centers** > **Microsoft Entra ID**.
1. In the left pane, select **Roles & admins** > **Roles & admins**.
1. Find the **Global Administrator** and **Power Platform Administrator** roles, and then assign the right users to the roles.

## More information

If your issue is still unresolved, go to the [Sales solution in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
