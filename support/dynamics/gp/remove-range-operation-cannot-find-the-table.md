---
title: Error when you process in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you process in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error when processing in Microsoft Dynamics GP: A remove range operation on table 'syContentPageXMLCache' cannot find the table

This article provides a solution to an error that occurs when you process in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3201492

## Symptoms

You get this message when trying to process in Microsoft Dynamics GP:

> "A remove range operation on table 'syContentPageXMLCache' cannot find the table"

## Cause

This message is usually encountered due to a network connection getting dropped or other connectivity issue.

## Resolution

We have ways to help test a network disconnect, but it would be up to you to resolve the issue. Helping you dig into this would be considered a consulting service to look at your environment and is out of scope for our regular support policy.

1. A good test to test the network connectivity on your machine is to have the user go into SQL Server Management Studio and save data from a SQL table into a temp table such as:

    ```sql
    select * into ##GL00100 from GL00100
    ```

    Then periodically have the user query on this table at different times:

    ```sql
    select * from ##GL00100
    ```

    If they ever get the message "invalid object name ##GL00100", then it is because the connection is getting dropped.

2. Run a continuous ping from the workstation to the SQL database server. Let the ping run, but if you see a "Request Timed Out" message, this indicates the connection to the server is not stable.

    ```console
    ping SERVERNAME -t -I 65500
    ```

3. In SQL Server Management Studio, right-click on the SQL instance name in the left margin and choose **PROPERTIES**. In the **Server Properties** window, click on the **CONNECTIONS** page. Verify the **Maximum number of concurrent connections** is set to 0 (zero) which is for unlimited connections. This is the default setting for SQL Server.

4. Ensure any Anti-virus software is found in the exclusions from scanning:

    - GP Code folder
    - Any network shares containing shared reports and forms dictionaries
    - The user's TEMP directory

5. Set up and use a new ODBC System DSN connection.

6. Check the user's Sleep settings.

    Make sure the Network card is not set to sleep. Open Device Manager, right-click on your **NIC** > **Properties** > **Advanced** tab, disable anything that has to do with power saving.

7. When all users are out of Microsoft Dynamics GP, run these scripts to make sure these tables are empty:

    There tables should be empty when all users are logged out of Microsoft Dynamics GP.

    ```sql
    select * from DYNAMICS..ACTIVITY select * from DYNAMICS..SY00800 select * from DYNAMICS..SY00801 select * from TEMPDB..DEX_LOCK select * from TEMPDB..DEX_SESSION Delete DYNAMICS..ACTIVITY Delete DYNAMICS..SY00800 Delete DYNAMICS..SY00801 Delete TEMPDB..DEX_LOCK Delete TEMPDB..DEX_SESSION
    ```

8. Restart both the SQL Server and the terminal servers.

9. Disable TCP Chimney on server and workstations. Refer to these articles for more information:

    - [Information about the TCP Chimney Offload, Receive Side Scaling, and Network Direct Memory Access features in Windows Server 2008](../../windows-server/networking/information-about-tcp-chimney-offload-rss-netdma-feature.md)

    - [Solving Connectivity errors to SQL Server](https://support.microsoft.com/sbs/topic/solving-connectivity-errors-to-sql-server-ae23c94b-b64b-5056-8b62-22e1694bb889)
