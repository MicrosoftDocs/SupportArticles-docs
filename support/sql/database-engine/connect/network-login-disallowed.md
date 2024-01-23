---
title: Troubleshooting the network login issues 
description: This article provides symptoms and resolution for troubleshooting the consistent authentication issue related to the network login issue.
ms.date: 01/23/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# User can't access the remote network

This article helps you to resolve a consistent authentication issue that might arise when the user doesn't have the permission to in to a remote network.

## Symptoms

You might observe the following error message in the Windows event security log on the SQL Server:

> The user account is not allowed the Network Login type.

## Cause

This error occurs if there is any problem with the Windows permissions or policy settings.

## Resolution

Check the *secpol.msc* file to see that the user account (or a group they might belong to) doesn't exist in the **Local Policies > User Rights Assignment > Deny access to this computer from the network** security policy settings.
