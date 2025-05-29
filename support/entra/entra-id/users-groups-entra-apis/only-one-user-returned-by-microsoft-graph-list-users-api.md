---
title: Microsoft Graph List Users API Only Return One User
description: Provides a solution to an issue where the Microsoft Graph REST API List users only returns one user in a directory.
ms.date: 05/29/2025
ms.service: entra-id
ms.reviewer: bachoang, v-weizhu
ms.custom: sap:Problem with querying or provisioning resources
---
# Microsoft Graph List users API only returns one user in a directory

This article provides a solution to an issue where the Microsoft Graph REST API [List users](/graph/api/user-list) only returns one user in a directory.

## Symptoms

Consider the following scenario:

- You sign in to [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) by selecting the profile icon at the top right.

    :::image type="content" source="media/only-one-user-returned-by-microsoft-graph-list-users-api/microsoft-graph-explorer-sign-in.png" alt-text="Image alt text." lightbox="media/only-one-user-returned-by-microsoft-graph-list-users-api/microsoft-graph-explorer-sign-in.png" border="false":::

- After sign-in, you try to run this query `GET https://graph.microsoft.com/v1.0/users` to retrieve all users in your directory.

In this case, only one user is returned. The expected output is a list of multiple users from the directory.

:::image type="content" source="media/only-one-user-returned-by-microsoft-graph-list-users-api/list-users-query-result.png" alt-text="Image alt text." lightbox="media/only-one-user-returned-by-microsoft-graph-list-users-api/list-users-query-result.png" border="false":::

## Cause

This issue occurs because you're signed in with a personal Microsoft account (MSA) as shown in the preceeding screenshot. Personal accounts don't have access to organizational directory data in Microsoft Entra ID. As a result, the query only returns the user associated with the personal account.

## Solution

To retrieve all users in the directory, you must sign in to Microsoft Graph using an organizational Microsoft Entra account, such as `userPrincipalName = name@tenant.onmicrosoft.com`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]