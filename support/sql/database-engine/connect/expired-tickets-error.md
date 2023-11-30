---
title: Troubleshooting the expired tickets error 
description: This article provides symptoms and resolution for the expired tickets error.
ms.date: 11/29/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Expired tickets error

This article helps you resolve the Expired tickets error.

## Symptoms

Kerberos tickets usually have a lifetime of about 10 hours and should be automatically renewed. Using stale tokens can cause a connection to fail. For more information, see [Kerberos authentication troubleshooting guidance](../../../windows-server/windows-security/kerberos-authentication-troubleshooting-guidance.md).

## Resolution

To resolve this error, follow these steps:

1. Use the `KLIST purge` command to clear user tokens, or log off and back on, or restart the machine.

1. Use the `KLIST` command with the SSPIClient tool to view and manage Kerberos tickets and service principal names (SPNs) as shown in the following command:

    `KLIST GET MSSQLSvc\SQLProd01.contoso.com:1433`
