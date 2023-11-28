---
title: Troubleshooting the Directory Services specific error messages
description: This article provides symptoms and resolution for troubleshooting the Directory Services specific error messages.
ms.date: 11/28/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Directory Services specific error messages

This article helps you to resolve the problem related to the directory services specific error messages.

## Symptoms

If the SQL Server ERRORLOG file contains the following messages, then this is an Active Directory issue. This might happen if the domain controller can't be contacted by Windows on the SQL Server computer, or the local security service (LSASS) is having a problem.

- `Error -2146893039 (0x80090311): No authority could be contacted for authentication.`
- `Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.`

## Resolution

If you need further assistance, contact the Microsoft Active Directory team.
