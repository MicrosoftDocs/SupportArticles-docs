---
title: Error 0x80004005 starting OpalisActionService
description: Fix an issue where you receive Error 0x80004005 Unspecified Error when trying to start the OpalisActionService service.
ms.date: 06/26/2024
---
# Error 0x80004005: Unspecified Error when starting the OpalisActionService service

This article helps fix an issue where you receive the **Error 0x80004005: Unspecified Error** error message when you try to start the OpalisActionService service.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2023357

## Symptoms

When attempting to start the OpalisActionService service using the Windows Services applet, the following error is received:

> Error 0x80004005: Unspecified Error

The following errors may be captured in the Action Server logs (if using SQL Server):

> Cannot open DB connection  
> [DBNETLIB][ConnectionOpen (Connect()).]SQL Server does not exist or access denied.  
> -2147467259

## Cause

The OpalisActionService process is unable to connect to the database. Which could be because of any of the following reasons:

1. The database instance isn't running.
2. Hostname provided for database server doesn't resolve correctly via Domain Name System (DNS).
3. An incorrect database instance has been referenced.
4. A non-standard Transmission Control Protocol (TCP)/Internet Protocol (IP) port may have been configured for TCP/IP connectivity.
5. TCP/IP may not be configured as an acceptable binding or an alternative protocol binding may be configured as higher priority causing connections to work from some locations but not others (for example, local versus remote).
6. The user account provided doesn't have permission to access the database.

## Resolution

Correct the problem that's preventing the OpalisActionService process from accessing the database.

1. Verify database instance is running

    If the database instance isn't running, it can't accept the connections from the OpalisActionService service. When the OpalisActionService service is unable to make initial contact with the database, it's designed to terminate. It only occurs if connectivity can't be obtained at service start. If the Action Server is installed on the same server as the database, a failure to start the OpalisActionService service at machine startup could be a result of the database instance not having started yet. This can be resolved by establishing a dependency in the OpalisActionService service on the database instance service.

2. Verify database server hostname

    Check to ensure that the hostname of the database server doesn't have a typo and validate that the appropriate hostname responds to network traffic (for example, ping for response and validation that the correct IP responds).

3. Incorrect database instance

    Check that the appropriate instance is being referenced.

4. Database instance port

    Validate that the expected port has been configured for use.

5. Protocol configuration

    If multiple protocols are in use, protocols other than TCP/IP may cause connectivity to work from some locations but fail from others (for example, local versus remote). If multiple protocols are configured on the database server, it may be necessary to explicitly define the protocol to use.

6. User account permission

    The user account is defined by using the Opalis Integration Server Database Configuration utility. If using Microsoft SQL Server as the database server with **Windows Authentication** as the selected security provider, the user account that starts the OpalisActionService service is leveraged. The configured account must have **Read** and **Write** permissions to the Opalis database.
