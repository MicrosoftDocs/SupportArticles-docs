---
title: Troubleshooting the network login disallowed error 
description: This article provides symptoms and resolution for troubleshooting the network login disallowed issue .
ms.date: 01/10/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Network login disallowed error

This article helps you to resolve the consistent authentication issue related to network login disallowed. The network login disallowed occurs if there is any problem with the Windows permissions or policy settings.

## Symptoms

You might observe the following error message in an event on the SQL Server in a scenario where the user doesn't have the allowed login type.

> The user account is not allowed the Network Login type.

## Resolution

Check the *secpol.msc* file to see that the user account (or a group they might belong to) doesn't exist in the **Local Policies > User Rights Assignment > Deny access to this computer from the network** security policy settings.
