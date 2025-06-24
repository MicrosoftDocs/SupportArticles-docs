---
title: Microsoft Graph List Users API Only Return One User
description: Provides a solution to an issue where the Microsoft Graph REST API List users only returns one user in a directory.
ms.date: 06/09/2025
ms.service: entra-id
ms.reviewer: bachoang, v-weizhu
ms.custom: sap:Problem with querying or provisioning resources
---
# Microsoft Graph List users API only returns one user in a directory

This article provides a solution to an issue where the Microsoft Graph REST API [List users](/graph/api/user-list) only returns one user in a directory.

## Symptoms

Consider the following scenario:

- You sign in to [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) by selecting the profile icon at the top right.

    :::image type="content" source="media/only-one-user-returned-by-microsoft-graph-list-users-api/microsoft-graph-explorer-sign-in.png" alt-text="Screenshot that shows the sign-in button in Microsoft Graph Explorer." lightbox="media/only-one-user-returned-by-microsoft-graph-list-users-api/microsoft-graph-explorer-sign-in.png":::

- After sign-in, you try to run this query `GET https://graph.microsoft.com/v1.0/users` to retrieve all users in your directory.

In this case, only one user is returned. The expected output is a list of multiple users from the directory.

:::image type="content" source="media/only-one-user-returned-by-microsoft-graph-list-users-api/list-users-query-result.png" alt-text="Screenshot that shows the query result." lightbox="media/only-one-user-returned-by-microsoft-graph-list-users-api/list-users-query-result.png":::

## Cause

This issue occurs because you sign in with a personal Microsoft account (MSA), as shown in the preceding screenshot. Personal accounts don't have access to organizational directory data in Microsoft Entra ID. As a result, the query only returns the user associated with the personal account.

## Solution

To retrieve all users in the directory, you must sign in to Microsoft Graph Explorer using an organizational Microsoft Entra account, such as `userPrincipalName = name@tenant.onmicrosoft.com`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
