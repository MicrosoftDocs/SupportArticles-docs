---
title: Can't sign in to Salesforce due to disabled connections
description: Resolves the error message in Microsoft Copilot for Sales when you can't sign in to Salesforce due to disabled connections.
ms.date: 12/26/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
---
# Can't sign in to Salesforce due to disabled connections

This article helps you troubleshoot and resolve the error that occurs in Microsoft Copilot for Sales when you can't sign in to Salesforce due to disabled connections.

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

The Salesforce connection is disabled on the default environment.

The Data Loss Prevention (DLP) policy is enabled on the default environment in the tenant thereby blocking the Salesforce connector. Therefore, existing connections to Salesforce have been disabled.

## Resolution

1. Sign out from Copilot for Sales and close the Copilot for Sales pane.
1. Reopen the Copilot for Sales pane and sign in to Salesforce.

> [!NOTE]
> If the issue isn't resolved, see [Unable to sign in to Salesforce due to blocked Salesforce connector](tsg-blocked-connector-sf.md) to unblock the Salesforce connector in DLP policy.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
