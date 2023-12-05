---
title: Intermittent or periodic authentication issues
description: Troubleshoots intermittent or periodic authentication issues in SQL Server connectivity.
ms.date: 11/28/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# Intermittent or periodic authentication issues in SQL Server

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](resolve-connectivity-errors-checklist.md#recommended-prerequisites) and go through the checklist. For more information, see [Self-Help Articles](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0015-Self-Help-Articles).

This article describes common causes of intermittent authentication issues in SQL Server connectivity and provides solutions.

## Symptoms

Intermittent or periodic authentication issues in SQL Server connectivity occur when users or applications face sporadic difficulties authenticating with the SQL Server database. This causes disruptions in data access and application functionality.

## The most common error messages

- > [Cannot generate SSPI context](cannot-generate-sspi-context-error.md)
- > [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)

   > - Login failed for user ''
   > - Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'
   > - Login failed for user '\<UserName\>'
   > - Login failed for user '\<Domain\>\\<UserName\>'
   > - Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.

## Cause

The most common issues are caused by SQL Server performance or slow domain controller response. If using [NT LAN Manager (NTLM)](/openspecs/windows_protocols/ms-nlmp/c50a85f0-5940-42d8-9e82-ed206902e919), the Local Security Authority Subsystem Service (LSASS) has a bottleneck and limits how many new connections can be processed at once. Other requests are backed up and may time out. Some causes, such as antivirus, can be difficult to prove, but are still common and should be investigated even without hard proof if other avenues of inquiry are ineffective.

## Troubleshooting process

Since the issue is intermittent, it's likely that the configuration, such as Kerberos Service Principal Names (SPNs), is correct. To solve this issue, try the following troubleshooting steps:

#### Difference in latency between multiple domains or data centers

If yes, check whether the users in the local domain or data center have a good experience while users in other domains or data centers don't. If so, it might indicate a communication latency between data centers or domain controllers. Use the following commands to investigate the issue:

- To check network latency, use [ping](/windows-server/administration/windows-commands/ping).

- To test credential validation latency issues, use [Runas](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771525(v=ws.11)) with various users.

If the issue persists even after testing with these commands, the issue isn't with SQL Server but with the network infrastructure or domain controller performance.

#### Look for performance issue in SQL Server error log

The SQL Server error log may reveal performance issues on SQL Server, such as entries indicating I/O taking longer than 15 seconds. The SQL Performance team has [PSSDIAG](https://support.microsoft.com/topic/pssdiag-data-collection-utility-513a299f-0b45-eb1a-adb4-bc2ad8ecf194) to run and analyze. You may need to do this if the network trace reveals delays in SQL Server responses.
  
The error log may also include other domain-related errors, such as the following error log that indicates some Active Directory performance issues:

```output
SSPI handshake failed with error code 0x80090311 while establishing a connection with integrated security; the connection has been closed.
SSPI handshake failed with error code 0x80090304 while establishing a connection with integrated security; the connection has been closed.
```

The following operating system error codes indicate the cause of the failure:

- > Error -2146893039 (0x80090311): No authority could be contacted for authentication.

- > Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.

#### Client system event log

The system event log has various events, such as Kerberos, Local Security Authority (LSA), and Netlogon events. These events indicate the computer can't connect to the domain controller for some time. To make them easier to find, filter only **Error**, **Warning**, and **Critical** events. The event time needs to be around the time of the outage. If there's a match, it might be an Active Directory issue.

In some cases, this issue may happen on SQL Server. Check the logs on that machine as well.

```output
Source: NETLOGON
Date: <DateTime>
Event ID: 5719
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: SQLPROD01
Description:
This computer was not able to set up a secure session with a domain controller in domain CONTOSO due to the following: The remote procedure call was cancelled. This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.
```

In the security event log, filter *Event ID 4625*. This event shows detailed information about the login failure.

#### SQL connectivity ring buffer

The ring buffer is a historical log of connection events on SQL Server, which means it can be taken after an outage. Many events include login timers that tell you where time is spent:

- Time spent on the network indicates a possible network or client latency.
- Time spent on Secure Sockets Layer (SSL) or Security Support Provider Interface (SSPI) APIs indicates potential issues with the Windows security subsystem.
- Enqueued time indicates a SQL Server performance issue.

For more information, see [Collect the Connectivity Ring Buffer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-the-Connectivity-Ring-Buffer).

#### Connection pooling

The lack of [connection pooling](/dotnet/framework/data/adonet/sql-server-connection-pooling) can result in intermittent login failures.

> [!NOTE]
> The lack of connection pooling will show a large number of `TIME_WAIT` status codes in the `NETSTAT` output compared to established connections.

Connection pooling can't only run the client out of outbound ports, but also overload the server, causing the server to reject incoming connection requests or flooding a poorly performing domain controller.

The best thing to do is to have the application developer use connection pooling in their applications. Connection pooling is ON by default in .NET and Internet Information Services (IIS) applications, but it might have been turned off for some reason.

It's highly discouraged if the application uses a custom pooling code, as almost all custom pooling implementations we've encountered have issues. It's better to use the built-in mechanism.

#### Issues related to low kernel memory

Running out of ephemeral ports is a relatively common cause of intermittent connection time-outs.

**Issue**: Low kernel memory on the SQL Server machine.

**Solution**: Adjust the **max server memory (MB)** in the **Properties** pane in SQL Server Management Studio. It's best to set the **max server memory (MB)** to about 4 GB to 8 GB less than the physical memory on the machine. This value should be smaller if there are multiple instances, IIS, or some other application servers running on the machine.

> [!NOTE]
> The default value is `2147483647 MB`, which means the server can cause the operating system (OS) to run out of memory.
