---
title: Troubleshooting the explicit misplaced SPN issue 
description: This article provides cause, symptoms, and workarounds for troubleshooting the explicit SPN is missing issue.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Explicit misplaced SPN

## Symptoms

If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you will get an "SSPI Context" error message.

## Solution

To resolve this errors, follow these steps:

1. Use `SETSPN -L domain\svcacct` to list SPNs on the SQL Server service account.

1. Use `SETSPN -Q spnName` to find what account the SPN is on. You can move the SPN using `SETSPN -D` and `SETSPN -A` or choose an SPN already in the correct account.