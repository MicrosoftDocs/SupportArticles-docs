---
title: Authentication problem with network logins being disallowed in SQL Server
description: This article provides a resolution for the consistent authentication issue in SQL Server that affects network login.
ms.date: 03/15/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# "User account not allowed" error - Authentication failure

This article helps you resolve a consistent authentication issue that occurs when users don't have permissions to log in to a remote network.

## Symptoms

You receive the following error message in the Windows event security log on a computer that's running SQL Server:

> The user account is not allowed the Network Login type.

> [!NOTE]
> The error message should read "The user account does not allow the Network Login type."

## Cause

This error occurs if any existing problems affect the Windows permissions or policy settings.

## Resolution

To resolve this error, follow these steps:

1. In the Local Security Policy console, navigate to **Security Settings > Local Policies > User Rights Assignment**.

1. Look for the **Deny access to this computer from the network** policy setting.

   Check the *secpol.msc* file to determine whether the user account (or any group that the user might belong to) exists in the security policy settings.
