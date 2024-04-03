---
title: Network logins being disallowed in SQL Server
description: This article provides a resolution for the consistent authentication issue in SQL Server that affects network login.
ms.date: 04/03/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# User account is restricted from using the Network Login type

This article helps you resolve an authentication issue that occurs when users don't have permissions to log in to a remote network. Network login type refers to the method or protocol used to authenticate and grant access to a network resource.

## Symptoms

You receive the following error message in the Windows event security log on a computer that's running SQL Server:

> The user account is not allowed the Network Login type.

> [!NOTE]
> The error message should read "The user account does not allow the Network Login type."

This means that the user doesn't have permissions to log in to the network.

## Cause

This error occurs if any existing problems affect the Windows permissions or policy settings.

## Resolution

To resolve this error, follow these steps:

1. In the Local Security Policy console, navigate to **Security Settings > Local Policies > User Rights Assignment**.

1. Look for the **Deny access to this computer from the network** policy setting.

   Check the *secpol.msc* file to determine whether the user account (or any group that the user might belong to) exists in the security policy settings.
