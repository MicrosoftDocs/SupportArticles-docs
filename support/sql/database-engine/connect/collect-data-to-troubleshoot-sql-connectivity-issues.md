---
title: Data collection to troubleshoot SQL Server connectivity issues
description: This article provides questions based on several components that you can use to effectively troubleshoot SQL Server connectivity issues.
ms.date: 12/15/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, prmadhes, v-jayaramanp, haiyingyu
ms.custom: sap:Connection issues
---

# Collect data to troubleshoot SQL Server connectivity issues

This section provides a comprehensive list of questions that are classified by specific categories. Although the ["Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues"](resolve-connectivity-errors-checklist.md) topic includes the most important items to be collected, the questions in this article can help you troubleshoot more effectively by ruling out many scenarios and narrowing your focus.

> [!NOTE]
> Not all questions are applicable to all issues. However, these questions can guide you as you consider how to troubleshoot connectivity issues.

- [Client computer](#client-computer)
- [Server computer](#server-computer)
- [User information](#user-information)
- [Log information](#log-information)
- [Big picture questions](#big-picture-questions)
- [New or existing issue](#new-or-existing-issue)

## Method of collecting data

To collect data, you can use tools such as Problem Steps Recorder (PSR), Network trace, and NETLOGON trace. This section provides detailed steps to install and configure a combination of all these tools.

Follow these steps simultaneously on both the client and server computers. If the application is a 3-tier or n-tier architecture, run the installation on intermediate servers, also.

1. Install **WIRESHARK** on all affected computers or use the built-in `NETSH` command (Windows 2008 or later versions). No restart is required.

1. Enable NETLOGON debug logging on the client and all servers by running the following command:

   `NLTEST /DBFLAG:2080FFFF`

1. If possible, do one of the following:

    - Restart the client computer.
    - Ask the user to log off and log in again.
    - Close and reopen the client application.

1. On the client computer, start **Problem Steps Recorder** (psr.exe), and then select **Start Record**.

   This will accurately capture all user actions that preceded the issue, and save the results to a .zip file.

1. Start the network capture on all computers.

1. If you are using NETSH, run the `NETSH TRACE START CAPTURE=YES TRACEFILE=C:\TEMP%computername%.ETL` command (use an appropriate file or path name).

1. Flush the DNS cache on all computers by running the `IPCONFIG /FLUSHDNS` command.

1. Clear the NETBIOS cache on all computers by running the `NBTSTAT /RR` command.

1. Purge client Kerberos tickets by running the `KLIST purge` command.

1. Clear tickets on each server by running the `KLIST -li 0x3e7 purge` command.

    > [!NOTE]
    > Type the command. Don't copy and paste into the command line because the dash might get converted to a hyphen and break the command. `KLIST` is case-sensitive.

1. Reproduce the issue.

1. Stop the *psr.exe* recording.

1. Stop the network captures. Save the recorded file by running the command `NETSH: NETSH TRACE STOP` by using a meaningful name. For example, *SQLProd01.netmon.cap*.

1. Wait for the command prompt to reappear, and then close the window. Don't close the Command Prompt window before the prompt appears.

1. Copy the NETLOGON log to *C:\windows\debug\netlogon.log* and give the file a meaningful name. For example, *SQLProd01.netlogon.log*.

1. Disable logging by running the `NLTEST /DBFLAG:0x0` command.

## Client computer

You can collect the following information about the components of the client computer.

- What is the operating system name, edition, and version (WinVer)?
- What is the name and version of the SQL Server driver or provider?
- What are the computer name and IP address?
- Is the computer domain-joined? If yes, what is the domain name?
- What application run-time environment is used? For example, IIS, Windows Forms, Web Sphere, or SSIS Job.
- Which application language is used?
- What is the connection string used?
- What type of authentication is used to connect to the server? For example, NTLM, Kerberos, SQL, or AAD.
- If the application is a server or service, does it delegate user credentials to the back-end database?
- Is constrained delegation used?
- What are the application service account and domain?
- Which type of service is used? Is it physical, virtual, or cloud? For example, IaaS, Web App, Web Role, or Power BI.
- Is the client driver JDBC or does it run on Linux or Mac?

> [!NOTE]
> The workflows are currently more Windows-oriented.

- Does the issue affect only legacy providers, such as Provider=SQLOLEBD or Driver={SQL Server}, and not SQL Native client and later drivers (or vice versa)?
- Does the issue occur in only one application or in multiple applications?
- Does a UDL file fail when it tries to connect to other SQL Server-based servers, or does it fail to only the server that has the issue?
- Can you log in to the SQL Server-based server and connect using Management Studio?
- Does the issue occur only when you use the NETBIOS name of the server and not when you use the FQDN (or vice versa)? Does it work by using the IP address?
- If the client is running Windows 10 Enterprise Edition, is the Credential Guard feature turned on? If yes, this might affect full delegation scenarios.

## Server computer

For a Linked Server, collect server information for both the mid-tier server and the back-end server. For an IIS-to-SQL delegation issue, collect information on the web server, including the *web.config* and authentication settings.

- What is the name of the operating system name, edition, and version (Winver)?
- What is the name and version of the database?  
- What is the name of the computer?
- What is the IP address?
- Is the computer domain-joined? If yes, what is the domain name?
- What is the SQL Server service account and domain?
- What is the name of the SQL Server instance?
- Which protocols are enabled?
- Which is the port that the server listens on?
- What is the name of the server pipe? You can find this information in the (ERRORLOG).
- Which type of environment is used? Is it physical, virtual, or cloud? For example, IaaS (SQL in an Azure VM) or PaaS (Azure SQL Database, SQL MI).
- Is the database standalone, clustered, mirrored, or Always On?
- What is the Failover partner name and IP address?
- What is the Virtual cluster name or Listener name and port?
- Which is the Virtual IP or Listener IP?
- Which operating system is the database installed on? Is it Windows, Linux, or Mac? This might affect data collection.
- Is the database located in Azure?
- Is the server on the latest Service Pack and Cumulative Update? There’s no point in debugging an issue that is already fixed.
- Has SQL Server been upgraded recently to support TLS 1.2? Were the clients also updated? Has TLS 1.0 been turned off?
- Is the SQL Server service currently running?
- Is the SQL Browser service running?
- Is the issue specific to a service account? If you run the server using a different service account, does the issue get resolved?

## User information

- Does the user log in to the client computer directly or access it remotely? For example, does the user use a browser?
- Is the user a service, such as SQL Agent? Is the process identity being used or a stored credential?
- What is the type of authentication used to connect to the client application? Is it Windows, Forms authentication, or Azure Active Directory?
- Does the user connect to the server using integrated security?
- What are the user name and domain name?

If the user is remote to the client application, collect the following details:

- What are the computer name and IP address?
- Is the computer domain-joined? If yes, what is the domain name?
- Is the user connecting over a VPN or a proxy server? Does the issue occur if either method is directly connected?
- If the user is connecting to a web server, is the server load balanced?
- Are sticky sessions or session affinity being used?
- Is the user logging in to a terminal server or jump box and accessing the application?
- Does the issue affect only users in particular organizational units (OUs)?
- Has the user, client, or server moved to a different OU in Active Directory?
- Does the issue affect only non-administrative users?
- Does the issue affect all or only some of the users in a particular domain?

## Log information

- What is the exact error message in the call stack?
- Was the log collected from the SQL Server ERRORLOG and ERRORLOG.1 files?
- Were the application event logs collected from the client and server?
- Were the client application log files and configuration files collected? For example, *web.config, rsreportserver.config*, **.config*, or **.ini*.
- Is there an available visual representation of the network that shows the computers, routers, and so on?

## Big picture questions

The following questions can help you understand the category of issue so that you can troubleshoot in the right direction:

- Does the issue affect only database connections, or does it also affect web and file share connections? Many cases are reported to the SQL Server team because they occur on the database server. However, it might be possible that the issue isn't related to the database at all and might require more general Windows or Active Directory support.
- If the user domain, client domain, or server domain are different, what is the trust relationship between them? Is it external, forest, one-way, two-way, or none?
- Does the connection work correctly if all the resources are in the same domain?
- Is the issue intermittent (or periodic) or is it consistent?
- Does the issue occur only if more than one user is using the application? Does it occur more often if more users are using it?  
- Does the issue occur only at certain times of the day or on certain days of the week?
- Does the issue occur only when a backup is being taken or the database is being re-indexed?
- Does the issue affect more than one server?
- Does the issue affect only one node in a n-node cluster? If yes, perhaps rebuilding would be more efficient.
- Does the issue affect only one or two clients out of several? If yes, perhaps rebuilding would be more efficient.
- Does the issue affect only Named Pipes and not TCP (or vice versa)?
- Does the issue occur when you use a SQL Server login and TCP/IP?
- Is there a working case that can be compared against the failing case? How do the systems differ?

## New or existing issue

- Has the issue always existed (new installation) or did the application function correctly for some time before it recently broke?
- If the application used to function correctly, what changes were made to the environment? For example, installed updates, upgraded domain controllers, changes in the firewall settings, decommissioned domain controllers, or a move to a different organizational unit (OU) in the domain.

## See also

- Consistent SQL Network Connectivity Issue

- [Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md)

- [Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)
