---
title: Troubleshooting the expired tickets issue 
description: This article provides symptoms and resolution for the expired tickets issue.
ms.date: 01/04/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Expired tickets issue

This article helps you resolve the issue related to the Expired tickets.

## Symptoms

The "Expired tickets" issue might occur in Kerberos authentication, which indicates that a service has failed.

Kerberos tickets usually have a lifetime of about 10 hours and should be automatically renewed. Using stale tokens can cause a connection to fail. For more information, see [Kerberos authentication troubleshooting guidance](../../../windows-server/windows-security/kerberos-authentication-troubleshooting-guidance.md).

## Resolution

To resolve this issue, follow these steps:

1. Use the `KLIST purge` command to clear user tokens, or log off and back on, or restart the machine.

1. Use the `KLIST` command with the SSPIClient tool to view and manage Kerberos tickets and service principal names (SPNs) as shown in the following command:
  
   `KLIST GET MSSQLSvc\SQLProd01.contoso.com:1433`
