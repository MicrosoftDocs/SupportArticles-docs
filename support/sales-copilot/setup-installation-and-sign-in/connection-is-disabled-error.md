---
title: Can't sign in to Salesforce due to disabled connections
description: Resolves an error message in Microsoft Copilot for Sales when you can't sign in to Salesforce due to disabled connections.
ms.date: 01/25/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
---
# Can't sign in to Salesforce due to disabled connections

This article helps you troubleshoot and resolve an error that occurs in Microsoft Copilot for Sales when you can't sign in to Salesforce due to disabled connections.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | All users  |

## Symptoms

When you try to sign in to Salesforce from Copilot for Sales, the following error message is displayed:

> Error from token exchange: The connection is disabled so it cannot be used.

:::image type="content" source="media/connection-is-disabled-error/connection-disabled-error-from-token-exchange.png" alt-text="Screenshot that shows the disabled Salesforce connection error.":::

## Cause

The Salesforce connection is disabled in the [msdyn_viva environment](/microsoft-sales-copilot/data-handling#copilot-for-sales-dataverse-and-your-crm).

The Data Loss Prevention (DLP) policy is enabled in the tenant's msdyn_viva environment, thereby blocking the Salesforce connector. Therefore, existing connections to Salesforce have been disabled.

## Resolution

1. [Sign out of Copilot for Sales](/microsoft-sales-copilot/sign-out-sales-copilot) and close the Copilot for Sales pane.
1. Reopen the Copilot for Sales pane and sign in to Salesforce.

> [!NOTE]
> If the issue isn't resolved, see [Can't sign in to Salesforce due to blocked Salesforce connector](sign-in-issue-with-blocked-connector.md) to unblock the Salesforce connector in the DLP policy.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
