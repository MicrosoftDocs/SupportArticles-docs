---
title: Intermittent or periodic authentication issue
description: Troubleshoots intermittent or periodic authentication issues.
ms.date: 11/28/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# Intermittent or periodic authentication issue

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](resolve-connectivity-errors-checklist.md#recommended-prerequisites) and go through the checklist. For more information, see [Self-Help Articles](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0015-Self-Help-Articles).

This article describes common causes and provides solutions for intermittent authentication issues in SQL Server connectivity.

## Symptoms

Intermittent or periodic authentication issues in SQL Server connectivity occur when users or applications face sporadic difficulties in authenticating with the SQL Server database, leading to disruptions in data access and application functionality.

## The most common error messages

- > [Cannot generate SSPI context](cannot-generate-sspi-context-error.md)
- > [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)

   > - Login failed for user ''
   > - Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'
   > - Login failed for user '\<UserName\>'
   > - Login failed for user '\<Domain\>\\<UserName\>'
   > - Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.

## Cause

The most common issues are caused by SQL Server performance or slow Domain Controller response. If using [NT LAN Manager (NTLM)](/openspecs/windows_protocols/ms-nlmp/c50a85f0-5940-42d8-9e82-ed206902e919), the Local Security Authority Subsystem Service (LSASS) has a bottleneck and limits how many new connections can be processed at once; other requests get backed up and may time out. Some causes, such as antivirus can be difficult to prove, but are common nonetheless and should be investigated even without hard proof, if other avenues of inquiry don't show promise.

## Order of troubleshooting

In general, troubleshooting should be based on data collected about the issue. If the issue is intermittent and network traces are difficult to capture, try different solutions and observing the results.

Since the issue is intermittent, we can assume configuration, such as Kerberos SPNs, is basically correct.

### Are multiple domains or data centers involved?

If yes, check whether the users in the local domain/data center have a good experience while users in the other domain or data center don't. If so, it could indicate a communication latency between data centers or between domain controllers. Use the following commands to investigate the issue:

- To check network latency, use [ping](/windows-server/administration/windows-commands/ping).

- To test credential validation latency issues, use [Runas](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771525(v=ws.11)) with various users.

If the issue persists even after testing with these commands, it suggests that the issue lies not with SQL Server, but with the network infrastructure or the the domain controller performance.

### SQL Server error log

The SQL Server error log may reveal performance issues on SQL Server, such as entries indicating I/O was taking longer than 15 seconds. The SQL Performance team have [PSSDIAG](https://support.microsoft.com/topic/pssdiag-data-collection-utility-513a299f-0b45-eb1a-adb4-bc2ad8ecf194) to run and analyze. You may want to do this if the network trace reveals delays with the SQL Server responses.
  
The error log may also include other domain-related errors, such as the following error log that indicates some sort of Active Directory performance issue:

```output
SSPI handshake failed with error code 0x80090311 while establishing a connection with integrated security; the connection has been closed.
SSPI handshake failed with error code 0x80090304 while establishing a connection with integrated security; the connection has been closed.
```

These codes translate as follows:

Error -2146893039 (0x80090311): No authority could be contacted for authentication.
Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.

### Client system event log

The system event log has various events, such as Kerberos, Local Security Authority (LSA), and Netlogon events, which indicate the computer can't connect to the domain controller for a period of time. To make them easier to find, filter on Error, Warning, and Critical events only. The event times need to be around the time of the outage. If there's a match, it would be an Active Directory issue.

In some cases, this may happen on SQL Server. Check the logs on that machine as well.

```output
Source: NETLOGON
Date: 8/12/2023 8:22:16 PM
Event ID: 5719
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: SQLPROD01
Description:
This computer was not able to set up a secure session with a domain controller in domain CONTOSO due to the following: The remote procedure call was cancelled. This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.
```

In the security event log filter on Event ID 4625, which shows the detailed information about login failure.

### SQL connectivity ring buffer

The ring buffer is a historical log of connection events on SQL Server, which means it can be taken after an outage. See [Collect the Connectivity Ring Buffer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-the-Connectivity-Ring-Buffer). Many events include login timers that tell you where the time is being spent. Time being spent on the network indicates a possible network or client latency. Time spent in SSL or SSPI APIs indicate potential issues with the Windows security subsystem. Enqueued time indicates a SQL Server performance issue.

### Connection pooling

The lack of [connection pooling](/dotnet/framework/data/adonet/sql-server-connection-pooling) can lead to intermittent logion failure issues. Not only can it run the client out of out-bound ports, but it can also overload the server and cause the server to reject incoming connection requests or flood a poorly performing domain controller. The best thing to do is to have the application developer use connection pooling in their application. It's ON by default in .NET and in IIS applications, so it's possible it may have been turned off for some reason. If the application uses custom pooling code, this is highly discouraged as almost all custom pooling implementations we have run into have issues. It's better to use the built-in mechanism. The lack of connection pooling will show as a large number of `TIME_WAIT` status codes in the `NETSTAT` output compared to `ESTABLISHED` connections.

### Issue related to low kernel memory

Running out of ephemeral ports is a relatively common cause of intermittent connection timeouts.

If you have an issue related to low kernel memory on the SQL Server machine, adjust **max server memory (MB)** in the **Properties** pane using in SQL Server Management Studio.

The default value is `2147483647 MB`, which means the server can starve the operating system (OS) of memory. It's best to set **max server memory (MB)** to about 4GB-8GB less than the physical memory on the machine; less if there are multiple instances or IIS or some other app server also runs on the machine.

## More information

[Credential Delegation Issue]
