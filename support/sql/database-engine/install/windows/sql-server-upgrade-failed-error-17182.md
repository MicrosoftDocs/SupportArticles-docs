---
title: SQL Server upgrade fails with error 17182
description: This article discusses error 17182 that causes a SQL Server upgrade to fail when it runs update database scripts.
ms.date: 01/10/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni, v-jayaramanp
---

# SQL Server upgrade fails and returns error 17182

This article helps you troubleshoot error 17182 that occurs when you install a cumulative update (CU) or service pack (SP) for Microsoft SQL Server. The error occurs when database upgrade scripts are run.

## Symptoms

When you apply a CU or an SP for SQL Server, the Setup program reports the following error:

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.

When you check the SQL Server error log, you notice errors like the following:

```output
2019-04-27 00:49:59.53 spid13s     Unable to initialize SSL encryption because a valid certificate could not be found, and it is not possible to create a self-signed certificate.
2019-04-27 00:49:59.53 spid13s     Error: 17182, Severity: 16, State: 1.
2019-04-27 00:49:59.53 spid13s     TDSSNIClient initialization failed with error 0x80090331, status code 0x80. Reason: Unable to initialize SSL support. The client and server cannot communicate, because they do not possess a common algorithm.  
2019-04-27 00:49:59.53 spid13s     Error: 17182, Severity: 16, State: 1.
2019-04-27 00:49:59.53 spid13s     TDSSNIClient initialization failed with error 0x80090331, status code 0x1. Reason: Initialization failed with an infrastructure error. Check for previous errors. The client and server cannot communicate, because they do not possess a common algorithm.  
2019-04-27 00:49:59.53 spid13s     Error: 17826, Severity: 18, State: 3.
2019-04-27 00:49:59.53 spid13s     Could not start the network library because of an internal error in the network library. To determine the cause, review the errors immediately preceding this one in the error log.
2019-04-27 00:49:59.53 spid13s     Error: 17120, Severity: 16, State: 1.
2019-04-27 00:49:59.53 spid13s     SQL Server could not spawn FRunCommunicationsManager thread. Check the SQL Server error log and the Windows event logs for information about possible related problems.
```

## Cause

The problem occurs if TLS 1.0 is disabled on the server, and you try to install a build of Microsoft SQL Server 2012 or 2014 that doesn't contain the fix to enable TLS 1.2 support. For more information about this issue, see [KB3135769 - FIX: Error when you install SQL Server 2012 or SQL Server 2014 on a server that has TLS 1.2 enabled (microsoft.com)](https://support.microsoft.com/en-us/topic/kb3135769-fix-error-when-you-install-sql-server-2012-or-sql-server-2014-on-a-server-that-has-tls-1-2-enabled-3244c3e9-eb49-9964-ca6b-889e9fc1bad2).

## Resolution

To resolve the 17182 error, follow these steps:

1. Ask your system administrator to temporarily enable TLS 1.0 or TLS 1.1 on both the client and the server computers by using either of the following methods:

    - IIS Crypto (Schannel section) to validate and make changes to current TLS settings
    - Registry editor per Schannel-specific registry keys

    For more information, see [TLS 1.2 Upgrade Workflow](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0700-TLS-1.2-Upgrade-Workflow) and [SSL Errors after Upgrading to TLS 1.2](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0710-SSL-Errors-after-Upgrading-to-TLS-1.2).

1. Restart the SQL Server service.

1. Run the SQL Server 2012 or 2014 Setup program, and update the SQL Server version to a build that supports TLS 1.2. For more information about the updates that add support for TLS 1.2, see [KB KB3052404 - FIX: You cannot use the Transport Layer Security protocol version 1.2 to connect to a server that is running SQL Server 2014 or SQL Server 2012 (microsoft.com)](https://support.microsoft.com/topic/kb3052404-fix-you-cannot-use-the-transport-layer-security-protocol-version-1-2-to-connect-to-a-server-that-is-running-sql-server-2014-or-sql-server-2012-b6cbf004-bdaf-bff6-beb9-c23dfb17f33f).

1. Disable TLS 1.0 or TLS 1.1.

1. Restart the SQL Server service.
