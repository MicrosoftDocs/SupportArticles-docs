---
title: Can't Look Up Users Using Microsoft Graph /Users Endpoint
description: Provides a solution to an issue where a user can't look up other users using the Microsoft Graph /users endpoint when a tenant policy configuration restricts access.
ms.date: 04/30/2025
ms.service: entra-id
ms.custom: sap:Getting access denied errors (Authorization)
ms.reviewer: daga, v-weizhu
---
# 401 HTTP response when looking up users using the Microsoft Graph /users endpoint

You can use the Microsoft Graph endpoint to interact programmatically with your tenant data. A common scenario is to use a Microsoft Graph `/users` endpoint to look up users in the tenant. In this case, if you use delegated permissions in your access token, the `User.Read.All` permission is necessary. There are ways to prevent you from looking up other users, such as using an [authorizationPolicy](/graph/api/resources/authorizationpolicy) object that can control Microsoft Entra authorization settings, unless you're a tenant administrator.

This article provides a solution to an issue where you can't look up other users using the Microsoft Graph `/users` endpoint after a tenant policy configuration restricts access to other users.

## Symptoms

After you enable an `authorizationPolicy` object in your tenant to prevent the user lookup action, a new application receives a 401 HTTP response when it performs this action. This issue occurs even though the proper permissions are consented to during app registration and the access token has the proper permissions.

## Cause

The `allowedToReadOtherUser` property in the `authorizationPolicy` is set to `false`. This setting prevents the default user role from reading other users. You can check its value via a `GET` request:

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
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
