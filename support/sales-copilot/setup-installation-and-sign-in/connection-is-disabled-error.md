---
title: Can't sign in to Salesforce due to disabled connections
description: Resolves an error message in Sales app when you can't sign in to Salesforce due to disabled connections.
ms.date: 11/20/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# Can't sign in to Salesforce due to disabled connections

This article helps you troubleshoot and resolve an error that occurs in Sales app when you can't sign in to Salesforce due to disabled connections.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales app in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | All users  |

## Symptoms

When you try to sign in to Salesforce from Sales app, the following error message is displayed:

> Error from token exchange: The connection is disabled so it cannot be used.

:::image type="content" source="media/connection-is-disabled-error/connection-disabled-error-from-token-exchange.png" alt-text="Screenshot that shows the disabled Salesforce connection error.":::

## Cause

The Salesforce connection is disabled in the [msdyn_viva environment](/microsoft-sales-copilot/data-handling#copilot-for-sales-dataverse-and-your-crm).

The Data Loss Prevention (DLP) policy is enabled in the tenant's msdyn_viva environment, thereby blocking the Salesforce connector. Therefore, existing connections to Salesforce have been disabled.

## Resolution

1. [Sign out of Sales app](/microsoft-sales-copilot/more-options#sign-out-of-copilot-for-sales) and close the **Sales** pane.
1. Reopen the **Sales** pane and sign in to Salesforce.

> [!NOTE]
> If the issue isn't resolved, see [Can't sign in to Salesforce due to blocked Salesforce connector](sign-in-issue-with-blocked-connector.md) to unblock the Salesforce connector in the DLP policy.

## More information

If your issue is still unresolved, go to the [Sales in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
