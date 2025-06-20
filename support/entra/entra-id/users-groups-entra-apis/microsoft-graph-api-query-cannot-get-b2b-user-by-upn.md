---
title: Microsoft Graph API Requests Fail to Get B2B Users Using UPN
description: Provides a solution to an issue where a Microsoft Graph API request fails to get a Business-to-Business (B2B) user using User Principal Name (UPN).
ms.service: entra-id
ms.reviewer: bhvootla, v-weizhu
ms.custom: sap:Problem with querying or provisioning resources
ms.date: 06/20/2025
---
# Microsoft Graph API requests fail to get B2B users using UPN

This article provides a solution to an error that occurs when you run a Microsoft Graph API request to get a Business-to-Business (B2B) user using User Principal Name (UPN).

## Symptoms

When you execute a Microsoft Graph API request to get a B2B user using UPN, you might encounter an error.

Request example:

`https://graph.microsoft.com/v1.0/users/example_gmail.com#EXT#@example.onmicrosoft.com`

Response exmaple:

```output
{
"error": {
"code": "Request_ResourceNotFound",
"message": "Resource '<resource-id>' does not exist or one of its queried reference-property objects are not present.",
"innerError": {
"request-id": "<request-id>",
"date": "2019-12-05T23:55:40"
            }
        }
}
```

## Cause

The issue occurs because the `#` character in the UPN is treated as a special character in the URL. Everything after the `#` is treated as a fragment and isn't sent over the wire.

## Solution

To resolve this issue, you must encode the `#` character in the UPN as `%23`.

Here's the correct request format:

`https://graph.microsoft.com/v1.0/users/example_gmail.com%23EXT%23@example.onmicrosoft.com`

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
