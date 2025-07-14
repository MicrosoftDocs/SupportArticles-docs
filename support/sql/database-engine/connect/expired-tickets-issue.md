---
title: Kerberos tickets - KRB_AP_ERR_TKT_EXPIRED error in SQL Server
description: This article provides symptoms and resolution for the consistent authentication errors to SQL Server that impact Kerberos tickets.
ms.date: 03/13/2024
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# KRB_AP_ERR_TKT_EXPIRED error in Kerberos tickets

This article helps you resolve consistent authentication issues that might affect Kerberos tickets.

Kerberos is a protocol that uses secret keys for providing secure authentication for client or server applications. A ticket is issued to a user for successful authentication. Typically, Kerberos tickets have a lifetime of about 10 hours and are renewed automatically.

## Symptoms

The Key Distribution Center (KDC) displays a `KRB_AP_ERR_TKT_EXPIRED` error message that indicates that a service has failed.

## Cause

The Kerberos connection fails if a user tries to use an expired ticket for authentication. For more information, see [Kerberos authentication troubleshooting guidance](../../../windows-server/windows-security/kerberos-authentication-troubleshooting-guidance.md).

## Resolution

To resolve this error, follow these steps:

1. Use the `KLIST purge` command to clear user tickets, or log off and back on, or restart the computer.

1. Use the `KLIST` command together with the SSPIClient tool to view and manage Kerberos tickets and service principal names (SPNs), as shown in the following command:
  
   `KLIST GET MSSQLSvc\SQLProd01.contoso.com:1433`

## More information

[Consistent authentication issues in SQL Server](consistent-authentication-connectivity-issues.md)
