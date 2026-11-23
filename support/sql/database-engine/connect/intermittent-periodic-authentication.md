---
title: Troubleshoot Intermittent Authentication Issues
description: Troubleshoot intermittent SQL Server authentication failures by checking server performance, domain controller response, event logs, and connection pooling.
ms.date: 11/17/2026
ms.reviewer: prmadhes, jopilov
ms.custom: sap:Database Connectivity and Authentication
ai-usage: ai-assisted
---
# Intermittent or periodic authentication issues in SQL Server

## Summary

This article helps you troubleshoot intermittent or periodic authentication issues in SQL Server, such as sporadic "Cannot generate SSPI context" and "Login failed for user" errors. These issues disrupt data access and application functionality, and they're most often caused by SQL Server performance problems or a slow domain controller response. The article lists the common error messages and causes, and then walks you through steps to find out whether the problem is network latency, domain controller performance, SQL Server resource pressure, missing connection pooling, or low kernel memory.

## Prerequisites

Before you start troubleshooting, check the [prerequisites](resolve-connectivity-errors-checklist.md#recommended-prerequisites) and go through the checklist. For more information, see [Self-Help Articles](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0015-Self-Help-Articles).

If your authentication errors are consistent instead of intermittent, see [Consistent authentication issues in SQL Server](consistent-authentication-connectivity-issues.md).

## Symptoms

Intermittent or periodic authentication issues in SQL Server connectivity occur when users or applications face sporadic difficulties authenticating with the SQL Server database. This causes disruptions in data access and application functionality.

## Common error messages

- > [Cannot generate SSPI context](cannot-generate-sspi-context-error.md)
- > [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)

   > - Login failed for user ''
   > - Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'
   > - Login failed for user '\<UserName\>'
   > - Login failed for user '\<Domain\>\\<UserName\>'
   > - Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.

## Common causes

The most common causes of intermittent authentication failures are:

- SQL Server performance issues.
- Slow domain controller response.
- A bottleneck in the Local Security Authority Subsystem Service (LSASS) when you use [NT LAN Manager (NTLM)](/openspecs/windows_protocols/ms-nlmp/c50a85f0-5940-42d8-9e82-ed206902e919). LSASS limits how many new connections it can process at once, so other requests back up and might time out.

Other causes, such as [antivirus software or network filter drivers](intermittent-periodic-network-issue.md#issues-related-to-antivirus-or-network-filter-driver), can be difficult to prove but are still common. Investigate them even without hard proof if other avenues of inquiry are ineffective.

## Troubleshooting process

Since the issue is intermittent, the configuration, such as Kerberos Service Principal Names (SPNs), is likely correct. To solve this issue, try the following troubleshooting steps.

### Check for latency differences between domains or data centers

If your environment involves multiple domains or data centers, check whether users in the local domain or data center don't experience the issue while users in other domains or data centers do. If so, it might indicate a communication latency between data centers or domain controllers. Use the following commands to investigate the issue:

- To check network latency, use [ping](/windows-server/administration/windows-commands/ping). For example:

  1. Run the command: `ping <DatabaseServer>`.
  1. Look at the time column and compare that time to that in the other domain or data center.

     ```output
     Pinging <DatabaseServer> [10.10.10.3] with 32 bytes of data:
     Reply from 10.10.10.3: bytes=32 time=68ms TTL=116
     Reply from 10.10.10.3: bytes=32 time=67ms TTL=116
     Reply from 10.10.10.3: bytes=32 time=67ms TTL=116
     ```

- To test credential validation latency issues, use [Runas](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771525(v=ws.11)) with various users. For example:

  1. Run `runas /user:<DomainName>\<UserAccountName> cmd.exe`.
  1. Enter the password of the user after a command prompt shows up.

If the issue persists even after testing with these commands, the issue isn't with SQL Server but with the network infrastructure or domain controller performance. For more network-focused troubleshooting, see [Troubleshoot intermittent or periodic issues with connecting to SQL Server](intermittent-periodic-network-issue.md).

### Check the SQL Server error log for performance and domain errors

The SQL Server error log might reveal performance issues, such as non-yielding or deadlocked schedulers. If a network trace reveals delays in SQL Server responses, use [SQL LogScout](https://github.com/microsoft/SQL_LogScout) to collect core SQL Server logs with the **Basic** scenario and performance data with the **LightPerf** scenario. Review the collected data to investigate the delays.
  
The error log might also include other domain-related errors, such as the following error log that indicates some Active Directory performance issues:

```output
SSPI handshake failed with error code 0x80090311 while establishing a connection with integrated security; the connection has been closed.
SSPI handshake failed with error code 0x80090304 while establishing a connection with integrated security; the connection has been closed.
```

The following operating system error codes indicate the cause of the failure:

- > Error -2146893039 (0x80090311): No authority could be contacted for authentication.

- > Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.

### Review client and server event logs for network errors

The system event log contains various events, such as Kerberos, Local Security Authority (LSA), and Netlogon events. These events indicate the computer can't connect to the domain controller. To make them easier to find, filter for **Error**, **Warning**, and **Critical** events. Look for events that occurred around the time of the outage. If you find a match, it might be an Active Directory issue.

The same errors can also occur on the SQL Server machine, so check the event logs on that machine as well. For example:

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

In the security event log, filter for *Event ID 4625*. This event shows detailed information about the login failure.

### Collect and review the SQL Server connectivity ring buffer

The ring buffer is a historical log of connection events on SQL Server, so you can collect it after an outage. Many events include login timers that tell you where time is spent:

- Time spent on the network indicates a possible network or client latency.
- Time spent on Secure Sockets Layer (SSL) or Security Support Provider Interface (SSPI) APIs indicates potential issues with the Windows security subsystem.
- Enqueued time indicates a SQL Server performance issue.

For more information, see [Collect the Connectivity Ring Buffer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-the-Connectivity-Ring-Buffer).

### Connection pooling

The lack of [connection pooling](/dotnet/framework/data/adonet/sql-server-connection-pooling) can result in intermittent login failures.

> [!NOTE]
> The lack of connection pooling shows a large number of `TIME_WAIT` status codes in the `NETSTAT` output compared to established connections.

If you don't enable connection pooling, the client might run out of outbound ports and overload the server. This overload can cause the server to reject incoming connection requests or flood a poorly performing domain controller. 

The best approach is to use connection pooling in your applications. Connection pooling is on by default in .NET and Internet Information Services (IIS) applications, but it might be turned off for some reason.

It's strongly discouraged for applications to use custom pooling code. Almost all custom pooling implementations have issues. It's advisable to use the built-in connection pooling mechanism.

### Issues related to low kernel memory

Running out of ephemeral ports is a relatively common cause of intermittent connection time-outs.

**Issue**: Low kernel memory on the SQL Server machine.

**Solution**: In SQL Server Management Studio, adjust **max server memory (MB)** in the server **Properties**. Use the [max server memory sizing guidance](/sql/database-engine/configure-windows/server-memory-server-configuration-options#max-server-memory) to choose a value based on memory usage during normal operation. Leave enough memory for the operating system, other applications and SQL Server instances, and SQL Server allocations that this setting doesn't limit.

> [!NOTE]
> The default value is `2147483647 MB`, which means the server can cause the operating system (OS) to run out of memory.

## Related content

- [Kerberos authentication overview](/windows-server/security/kerberos/kerberos-authentication-overview)
- [Troubleshoot port exhaustion issues](/troubleshoot/windows-client/networking/tcp-ip-port-exhaustion-troubleshooting)