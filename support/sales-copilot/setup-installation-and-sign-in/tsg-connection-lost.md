---
title: Connection lost due to an expired or invalid session or a bad OAuth token
description: Resolves the Connection lost error in Copilot for Sales when you're logged out due to an expired or invalid session or a bad OAuth token.
ms.date: 12/22/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Connection lost due to an expired or invalid session or a bad OAuth token

This article helps you troubleshoot and resolve the "Connection lost" error when you're logged out of Microsoft Copilot for Sales due to an expired or invalid session or a bad OAuth token.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Users performing any action that requires a connection to Salesforce.|

## Symptoms

When you try to perform any action in Microsoft Copilot for Sales, which requires a connection to Salesforce, you're logged out of Copilot for Sales and the following error message is displayed:

> Connection lost.

:::image type="content" source="media/tsg-connection-lost/tsg-conn-lost.png" alt-text="Screenshot showing connection lost error.":::

## Cause 1: Bad OAuth token

The Salesforce connection, created using the Salesforce connector, maintains the authentication tokens for the connected user. The same authentication tokens are used to communicate with Salesforce. The bad OAuth token error occurs when the Salesforce connection is unable to renew the authentication tokens.

## Cause 2: Expired or invalid session

The Salesforce session has reached its expiration time or the session has become invalid. This is based on the session configuration in Salesforce.

## Resolution

To solve this issue, follow one of these steps:

- Select **Sign in again** in the error message, and then sign in to Salesforce again.
- [Sign out from Copilot for Sales](/microsoft-sales-copilot/sign-out-sales-copilot) and then sign in to Salesforce again.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
