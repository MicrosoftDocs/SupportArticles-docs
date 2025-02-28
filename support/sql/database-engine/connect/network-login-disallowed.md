---
title: Problem with the user account's access to the network login
description: This article provides the resolution steps when users have insufficient permissions to log in to a networked system.
ms.date: 04/17/2024
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# User doesn't have permissions to log in to the network

This article helps you resolve an authentication issue that might arise when users don't have permissions to log into a networked system because a policy or setting prevents access. Network login type refers to the method or protocol used to authenticate and grant access to a network resource or service.

## Symptoms

You receive the following error message in the Windows event security log on a computer that's running SQL Server:

> The user account is not allowed the Network Login type.

> [!NOTE]
> The error message should read "The user account does not allow the Network Login type."

This means that the user doesn't have permissions to log in to the network.

## Cause

This error might occur because of any one of the following reasons:

- The user might not have the correct credentials.
- The user's account might be restricted to access the network.
- Misconfigured firewalls, routers, or ACLs might prevent the user from accessing the network.
- The network might have policies restricting specific types of logins, like remote access.

## Resolution

To resolve this error, follow these steps:

1. In the Local Security Policy console, navigate to **Security Settings > Local Policies > User Rights Assignment**.

1. Look for the **Deny access to this computer from the network** policy setting.

   Check the *secpol.msc* file to determine whether the user account (or any group that the user might belong to) exists in the security policy settings.

## More information

[Consistent authentication issues in SQL Server](consistent-authentication-connectivity-issues.md)
