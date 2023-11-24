---
title: Data collection to troubleshoot SQL connectivity problems
description: This article provides questions based on several components using which you can effectively troubleshoot connectivity problems.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Collect data to troubleshoot SQL connectivity issues

This section is a comprehensive list of questions classified based on certain categories. While  [Prerequisites and checklist for resolving connectivity errors](resolve-connectivity-errors-checklist.md) has the most important items to be collected, the questions in this article can help you rule out many scenarios and narrow down your focus for  troubleshooting problems in an effective manner.

> [!NOTE]
> Not all questions might be applicable to all problems but serve as a list of things to consider while troubleshooting connectivity problems.

- [Client machine](#client-machine)
- [Server machine](#server-machine)
- [User information](#user-information)
- [Log information](#log-information)
- [Big picture questions](#big-picture-questions)
- [New or existing problem](#new-or-existing-problem)

## Method of collecting data

You can use tools such as Problem Steps Recorder (PSR), Network trace, and NETLOGON trace to collect data. This section provides detailed steps you can use to install and configure a combination of all three tools.

Follow these steps simultaneously on both the client and server machines. If the application is a 3-tier or n-tier architecture, run on intermediate servers, as well.

1. Install **NETMON** or **WIRESHARK** on all affected machines or use the built-in `NETSH` command (Windows 2008 or newer). No reboot is required.

1. Enable NETLOGON debug logging on the client and all servers by running the following command:

   `NLTEST /DBFLAG:2080FFFF`

1. If possible, do one of the following:

    - Reboot the client machine.
    - Ask the user to log off and log in again.
    - Close the client application and re-open it.

1. On the client machine, start the **Problem Steps Recorder** (psr.exe) and select **Start Record**.

   This will accurately capture all user actions that lead up to the problem and save the results to a ZIP file.

1. Start the network capture on all machines.

1. If you are using NETSH, run the `NETSH TRACE START CAPTURE=YES TRACEFILE=C:\TEMP%computername%.ETL` command (use an appropriate file or path name).

1. Flush the DNS cache on all machines by running the `IPCONFIG /FLUSHDNS` command.

1. Clear the NETBIOS cache on all machines by running the `NBTSTAT /RR` command.

1. Purge client Kerberos tickets by running the `KLIST purge` command.

1. Clear tickets on each server by running the `KLIST -li 0x3e7 purge` command.

    > [!NOTE]
    > Type the command and don't use copy or paste into the command line. The dash might get converted to a hyphen and break the command. `KLIST` is case-sensitive.

1. Reproduce the issue.

1. Stop the *psr.exe* recording.

1. Stop the network captures and save the recorded file by running the command `NETSH: NETSH TRACE STOP` with a meaningful name. For example, *SQLProd01.netmon.cap*.

1. Wait for the command prompt to reappear. Don't close the command window until this happens.

1. Copy the NETLOGON log to *C:\windows\debug\netlogon.log* and give a meaningful name. For example, *SQLProd01.netlogon.log*.

1. Disable logging by running the `NLTEST /DBFLAG:0x0` command.

## Client machine

You can collect the following information for the Client machine component.

- What is the operating system name, edition, and version (WinVer) used?
- What is the name and version of the SQL Server Driver or Provider?
- What is the machine name and IP address?
- Is the machine domain joined? If yes, what is the domain name?
- What is the application run-time environment used? For example, IIS, Windows Forms, Web Sphere, SSIS Job, and so on.
- Which is the Application language used?
- What is the connection string used?
- What type of authentication is used to connect to the server? For example, NTLM, Kerberos, SQL, or AAD.
- If the application is a server or service, does it delegate user credentials to the backend database?
- Is constrained delegation being used?
- Which is the application service account and domain?
- Which type of service is used? Is it physical, virtual or cloud? For example, IaaS vs Web App vs Web Role vs Power BI.
- Is the client driver JDBC or does it run on Linux or Mac?

> [!NOTE]
> The workflows are more Windows-oriented at the moment.

- Does the issue only affect legacy providers, such as Provider=SQLOLEBD or Driver={SQL Server} and not SQL Native client and newer drivers or vice versa?
- Does the issue only happen in one or several applications?
- Does a UDL file fail to connect to other SQL Servers or does it only fail to the SQL Server that has the problem?
- Can you log in to the SQL Server and connect using Management Studio?
- Does the issue only happen when you use the NETBIOS name of the server and not when you use the FQDN or vice versa? Does it work using the IP address?
- If the client is Windows 10 Enterprise Edition, is the Credential Guard feature turned ON? If yes, this might affect with the full delegation scenarios.

## Server machine

For a Linked Server, collect server information for both the mid-tier server and the back-end server. For an IIS-to-SQL delegation issue, collect information on the web server, including the *web.config* and authentication settings.

- What is the name of the operating system name, edition, and version (Winver)?
- What is the name and version of the database?  
- What is the name of the computer?
- What is the IP address?
- Is the machine domain joined? If yes, what is the domain name?
- What is the SQL Server service account and domain?
- What is the name of the SQL Server instance?
- Which protocols are enabled?
- Which is the port that the server listens on?
- What is the name of the server pipe? You can find this information in the (ERRORLOG).
- Which type of environment is used? Is it physical, virtual, or cloud? For example, IaaS (SQL in an Azure VM) or PaaS (Azure SQL Database, SQL MI).
- Is the database stand-alone, clustered, mirrored, or Always On?
- What is the Failover partner name and IP address?
- What is the Virtual cluster name or Listener name and port?
- Which is the Virtual IP or Listener IP?
- Which operating system is the database installed on? Is it Windows, Linux, or Mac? This might affect data collection.
- Is the database located in Azure?
- Is the server on the latest Service Pack and Cumulative Update? There’s no point in debugging an issue that's already fixed.
- Has SQL Server been upgraded recently to support TLS 1.2? Were the clients also patched? Has TLS 1.0 been turned off?
- Is the SQL Server service currently running?
- Is the SQL Browser service running?
- Is the problem specific to a service account? If you run the server using a different service account, does the problem get resolved?

## User information

- Does the user log into the client machine directly or access it remotely? For example, does the user use a browser?
- Is the user a service, such as SQL Agent? Is the process identity being used or a stored credential?
- What is the type of authentication used to connect to the client application? Is it Windows, Forms authentication, or Azure Active Directory?
- Does the user connect to the server using integrated security?
- What are the user name and domain name?

If the user is remote to the client application, collect the following details:

- What is the name of the computer and IP address?
- Is the machine domain joined? If yes, what is the domain name?
- Is the user connecting over a VPN or a proxy server? Does the issue happen if either of them is directly connected?
- If the user is connecting to a web server, is it load balanced?
- Are sticky sessions or session affinity being used?
- Is the user logging into a terminal server or jump box and accessing the application?
- Does the issue only affect users in particular organizational units (OUs)?
- Has the user, client, or server moved to a different OU in Active Directory?
- Does the issue only affect non-admin users?
- Does the issue only affect some or all of the users in a particular domain?

## Log information

- What is the exact error message in the call stack?
- Has the log been collected from the SQL Server ERRORLOG and ERRORLOG.1?
- Have the application event logs been collected from the client and server?
- Have the client application's log files and configuration files collected? For example, web.config, rsreportserver.config, *.config, or *.ini.
- Is a visual representation of the network available, which shows the computers, routers, and so on?

## Big picture questions

Following are some questions, which help you understand the category of issue so that you can proceed in the right direction in troubleshooting the problems:

- Does the issue only affect database connections, or does it affect web and file share connections as well? Many cases are reported to the SQL team because they are seen on the database server. However, it might be possible that the problem isn't related to the database  at all and might call for more general Windows or Active Directory support.
- If the user domain, client domain, or server domain are different, what is the trust relationship between them? Is it external, forest, one-way, two-way, or none?
- Does the connection work correctly if all the resources are in the same domain?
- Is the issue intermittent (or periodic) or is it consistent?
- Does the issue only occur if more than one user is using the application? Does it occur more often if more users are using it?  
- Does the issue only happen at certain times of the day or days of the week?
- Does the issue only happen when a backup is being taken or the database is being re-indexed?
- Does the issue affect more than one server?
- Does the issue only affect one node in a n-node cluster? If yes, perhaps rebuilding is more efficient.
- Does the issue affect only one or two clients out of several? If yes, perhaps rebuilding is more efficient.
- Does the issue only affect Named Pipes and not TCP or vice versa?
- Does the issue happen when you use a SQL login and TCP/IP?
- Is there a working case that can be compared against the failing case? How are the two systems different?

## New or existing problem

- Has the problem always existed (new installation) or did it function properly before recently breaking down?
- If it used to function properly, what changes were made to the environment? For example,  installed patches, upgraded domain controllers, changed the firewall settings, decommissioned domain controllers, and moved to a different Organizational Unit (OU) in the domain.

## See also

Consistent SQL Network Connectivity Issue

[Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md)

[Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)
