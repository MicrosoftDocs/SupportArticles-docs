---
title: Service cannot start after you use SSL certificate
description: This article provides resolution for the problem that occurs after you configure a SSL certificate that uses Microsoft Enhanced Cryptographic Provider 1.0.
ms.date: 11/03/2020
ms.custom: sap:Security Issues
ms.reviewer: Milu
ms.prod: sql
---
# SQL Server service cannot start after you configure an instance to use a Secure Sockets Layer certificate

 This article provides resolution for the problem that occurs after you configure a SSL certificate that uses Microsoft Enhanced Cryptographic Provider 1.0.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 928779

## Symptoms

Consider the following scenario. You configure an instance of SQL Server to use a SSL certificate. The SSL certificate uses the Enhanced Cryptographic Provider 1.0. In this scenario, the SQL Server service cannot start. Additionally, when you try to start the SQL Server service, the following error messages are written to the SQL Server Errorlog file:

- Error message 1

  > **Date** **Time** Server Unable to load user-specified certificate. The server will not accept a connection. You should verify that the certificate is correctly installed. See "Configuring Certificate for Use by SSL" in Books Online.

- Error message 2

  > **Date** **Time** Server Error: 17182, Severity: 16, State: 1.

- Error message 3

  > **Date** **Time** Server TDSSNIClient initialization failed with error 0x80092004, status code 0x80.

- Error message 4

  > **Date** **Time** Server Error: 17182, Severity: 16, State: 1.

- Error message 5

  > **Date** **Time** Server TDSSNIClient initialization failed with error 0x80092004, status code 0x1.

- Error message 6

  > **Date** **Time** Server Error: 17826, Severity: 18, State: 3.

## Cause

This problem occurs because you cannot use a certificate that has the cryptographic service provider Enhanced Cryptographic Provider version 1.0 as a server certificate.

## Resolution

To work around this problem, use any of the following methods:

- Do not specify any certificate. Therefore, SQL Server generates a self-signed certificate. To do this, leave the **Certificate** box blank in SQL Server Configuration Manager.

  For more information, visit the following Developer Network (MSDN) Web sites:

  - [Configuring Server Network Protocols and Net-Libraries](/previous-versions/sql/sql-server-2008-r2/ms177485(v=sql.105))

  - [Encrypting Connections to SQL Server](/previous-versions/sql/sql-server-2008-r2/ms189067(v=sql.105))

- Use a certificate that uses the RSA Channel Cryptographic Provider cryptographic service provider for the SQL Server certificate.

## More information

SSL certificates that use the Enhanced Cryptographic Provider 1.0 can be used for client certificates. However, the certificates are unsuitable as server certificates. To determine the provider of a certificate, run the command at a command prompt: `certutil -v -store my`.

The following error message is mentioned in the [Symptoms](#symptoms) section:

> Date Time Server TDSSNIClient initialization failed with error 0x80092004, status code 0x80.

In this error message, **error state 0x80** indicates that a problem is in the SSL certificate. Additionally, **0x80092004** is a Security Support Provider Interface (SSPI) error code that translates to **CRYPT_E_NOT_FOUND**.
