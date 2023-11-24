---
title: Troubleshooting the access via group error 
description: This article provides cause, symptoms, and solution for troubleshooting the access via group error.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Access via group error

## Symptoms

If the user doesn't belong to a local group that's used to grant access to the server, the provider should display the "Login failed for user 'contoso/user1'" error message.
The DBA can double-check this by looking at the Security\Logins in SSMS. If it's a contained database, the DBA checks under databasename.

When you run the  `xp_logininfo 'contoso/user1'` stored procedure, the following might occur:

- If you receive an error, SQL can't resolve the username at all. It is likely that a name isn't present in the Active Directory or there might be issues connecting to the DC. Try using another name to check if the issue is related to a specific account.

- If you are connecting to cross-domain, the group must be in the SQL Server domain, and not the user domain so that its membership can be resolved.

- If no rows are returned, then there is no group that provides access to the server.
- If one or more rows are returned, then the user belongs to a group that provides the access.

## Solution

To be added