---
title: Troubleshooting Kerberos tickets issue 
description: This article provides symptoms and resolution for the consistent authentication specific issue related to Kerberos tickets.
ms.date: 01/19/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshooting issues in Kerberos tickets

This article helps you resolve consistent authentication issues that might arise because of Kerberos tickets.

Kerberos is a protocol that uses secret keys for providing secure authentication for client or server applications. A ticket is issued to a user for successful authentication. Kerberos tickets usually have a lifetime of about 10 hours and should be automatically renewed.

## Symptoms

Consider the following scenario when the user presents expired tokens. The Key Distribution Center (KDC) shows the `KRB_AP_ERR_TKT_EXPIRED` error, which indicates that a service has failed.

## Cause

When a user tries to use an expired ticket for authentication, the Kerberos connection will fail. For more information, see [Kerberos authentication troubleshooting guidance](../../../windows-server/windows-security/kerberos-authentication-troubleshooting-guidance.md).

## Resolution

To resolve this error, follow these steps:

1. Use the `KLIST purge` command to clear user tokens, or log off and back on, or restart the machine.

1. Use the `KLIST` command with the SSPIClient tool to view and manage Kerberos tickets and service principal names (SPNs) as shown in the following command:
  
   `KLIST GET MSSQLSvc\SQLProd01.contoso.com:1433`
