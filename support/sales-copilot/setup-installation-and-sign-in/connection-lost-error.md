---
title: Connection lost due to an expired or invalid session or a bad OAuth token
description: Resolves the Connection lost error in Sales app when you're logged out due to an expired or invalid session or a bad OAuth token.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# Connection lost due to an expired or invalid session or a bad OAuth token

This article helps you troubleshoot and resolve the "Connection lost" error when you're logged out of Sales app due to an expired or invalid session or a bad OAuth token.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales app in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Users performing any action that requires a connection to Salesforce.|

## Symptoms

When you try to perform any action in Sales app, which requires a connection to Salesforce, you're logged out of Sales app and the following error message is displayed:

> Connection lost

## Cause 1: Bad OAuth token

The Salesforce connection, created using the Salesforce connector, maintains the authentication tokens for the connected user. The same authentication tokens are used to communicate with Salesforce. The bad OAuth token error occurs when the Salesforce connection is unable to renew the authentication tokens.

## Cause 2: Expired or invalid session

The Salesforce session has reached its expiration time, or the session has become invalid. This is based on the session configuration in Salesforce.

## Resolution

To solve this issue, perform one of these steps:

- Select **Sign in again** in the error message, and then sign in to Salesforce again.
- [Sign out of Sales app](/microsoft-sales-copilot/more-options#sign-out-of-copilot-for-sales) and then sign in to Salesforce again.

## More information

If your issue is still unresolved, go to the [Sales solution in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
