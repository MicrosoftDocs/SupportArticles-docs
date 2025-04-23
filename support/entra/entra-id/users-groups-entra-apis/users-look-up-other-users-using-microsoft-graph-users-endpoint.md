---
title: Can't look up users using Microsoft Graph /users endpoint
description: Provides a solution to an issue where a user can't look up other users using the Microsoft Graph /users endpoint when a tenant policy configuration restricts access.
ms.date: 04/23/2025
ms.service: entra-id
ms.custom: sap:Getting access denied errors (Authorization)
ms.reviewer: daga, v-weizhu
---
# 401 HTTP response when looking up users using Microsoft Graph /users endpoint

You can use the Microsoft Graph endpoint to interact programmatically with your tenant data. A common scenario is a Microsoft Graph `/users` endpoint to look up users in the tenant. In this scenario, if you use delegated permissions in your access token, the `User.Read.All` permission is necessary. However, there are ways to prevent you from looking up other users, for example, using an [authorization policy](https://learn.microsoft.com/en-us/graph/api/resources/authorizationpolicy) that can control Microsoft Entra authorization settings.

This article provides a solution to an issue where you can't look up other users using the Microsoft Graph `users` endpoint when a tenant policy configuration restricts access.

## Symptoms

After you enable an authorization policy in your tenant to prevent the user lookup action, if a new application performs this action, it gets a 401 HTTP response. This issue occurs even though proper permissions are consented to on the app registration and the access token has the proper permission. It doesn't occur with tenant administrators.

## Cause

The `allowedToReadOtherUser` property on the [authorization policy](/graph/api/resources/authorizationpolicy) is set to `false`, which restricts access. You can check its value via a `GET` request:

`GET https://graph.microsoft.com/v1.0/policies/authorizationPolicy`

## Solution

To resolve this issue, set the value of the `allowedToReadOtherUser` property to `true` via a `PATCH` request as follows:

```msgraph
PATCH https://graph.microsoft.com/v1.0/policies/authorizationPolicy
{
    "defaultUserRolePermissions": {
    "allowedToReadOtherUsers": true
    }
}

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]