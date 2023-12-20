---
title: Troubleshooting the explicit misplaced SPN issue 
description: This article provides symptoms and solution for troubleshooting the explicit SPN is misplaced.
ms.date: 12/20/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Explicit misplaced SPN issue

This article helps you to resolve issues that might arise because of the explicit misplaced SPN.

## Symptoms

If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you receive an SSPI Context error message.

You might see the following error message when the SPN isn't registered properly.

> SQL Server cannot authenticate using Kerberos because the Service Principal Name (SPN) is missing, misplaced, or duplicated.

## Solution

To resolve this issue, follow these steps:

1. Use `SETSPN -L domain\svcacct` to list SPNs on the SQL Server service account.

1. Use `SETSPN -Q spnName` to find what account the SPN is on. You can move the SPN using `SETSPN -D` and `SETSPN -A` or choose an SPN that's already present in the correct account.
