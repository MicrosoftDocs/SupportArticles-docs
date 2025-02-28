---
title: Data collection methods for SQL connectivity issues
description: This article provides possible list of questions based on several components that you can use to effectively identify the type of SQL Server connectivity issues and find the right resolution.
ms.date: 05/29/2024
ms.reviewer: jopilov, prmadhes, v-jayaramanp, haiyingyu
ms.custom: sap:Connection issues
---

# Collect data to troubleshoot SQL Server connectivity issues

This article helps you to identify the root cause of SQL Server connectivity issues by asking relevant questions based on specific categories. Although the [Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md) article includes the most important items to be collected, the questions in this article can help you narrow down the cause of the connectivity issues and troubleshoot them effectively.

> [!NOTE]
> Not all questions are applicable to all issues. However, these questions can guide you as you consider how to troubleshoot connectivity issues.

Using the information provided in this article, once you are able to zero-in on the exact nature of the issue, see [Overview of consistent authentication issues in SQL Server](consistent-authentication-connectivity-issues.md) for the type of errors.

## Method of collecting data

To collect data, you can use tools such as [Problem Steps Recorder (PSR)](/office/troubleshoot/settings/how-to-use-problem-steps-recorder), [Network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace), and [NETLOGON](../../../windows-client/windows-security/enable-debug-logging-netlogon-service.md) trace. This section provides detailed steps to install and configure a combination of all these tools.

Follow these steps simultaneously on both the client and server computers. If the application is a 3-tier or n-tier architecture, then run the installation on intermediate servers as well.

1. Install **[WireShark](https://www.wireshark.org/download.html)** on all affected computers or use the built-in `NETSH` command (Windows 2008 or later versions). No restart is required.

1. Enable NETLOGON debug logging on the client and all servers by running the following command:

   `NLTEST /DBFLAG:2080FFFF`

1. If possible, do one of the following steps:

    - Restart the client computer.
    - Ask the user to log off and log in again.
    - Close and reopen the client application.

1. On the client computer, start **Problem Steps Recorder** (psr.exe), and then select **Start Record**.

   This tool accurately captures all user actions that precede the issue and saves the results to a .zip file.

1. Start the network capture on all computers.

1. If you're using NETSH, run the `NETSH TRACE START CAPTURE=YES TRACEFILE=C:\TEMP%computername%.ETL` command (use an appropriate file or path name).

1. Flush the Domain Name System (DNS) cache on all computers by running the `IPCONFIG /FLUSHDNS` command.

1. Clear the NETBIOS cache on all computers by running the `NBTSTAT /RR` command.

1. Purge client Kerberos tickets by running the `KLIST purge` command.

1. Clear tickets on each server by running the `KLIST -li 0x3e7 purge` command.

    > [!NOTE]
    > Type the command. Don't copy and paste into the command line because the hyphen might get converted to a long (em) dash. `KLIST` is case-sensitive.

1. Reproduce the issue.

1. Stop the *psr.exe* recording.

1. Stop the network captures. Save the recorded file by running the command NETSH: `NETSH TRACE STOP` by using a meaningful name. For example, the name of the file can be *SQLProd01.netmon.cap*.

1. Wait for the command prompt to reappear, and then close the window. Don't close the Command Prompt window before the prompt appears.

1. Copy the NETLOGON log to *C:\windows\debug\netlogon.log* and give the file a meaningful name. For example, *SQLProd01.netlogon.log*.

1. Disable logging by running the `NLTEST /DBFLAG:0x0` command.

## Collect data to categorize the issues

The following set of questions are designed to help you find the category into which an issue falls, thus guiding you towards the right direction of troubleshooting. Select each dropdown for related questions.

Before you jump into the asking the specific questions, make sure that all the prerequisites required for the SQL Server connections have been met. For more information on the prerequisites, see [Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md).

<details><summary><b>Broader perspective questions</b></summary>

- Does the issue affect only database connections, or does it also affect web and file share connections?
  Many cases are reported to the SQL Server team because they occur on the database server. However, it might be possible that the issue isn't related to the database at all and might require more general Windows or Active Directory support.
- Does a trust relationship exist between the user domain, client domain, or server domain if they're different? Is it external, forest, one-way, two-way, or none?
- Does the connection work correctly if all the resources are in the same domain?
- Is the issue intermittent or periodic or is it consistent?
- Does the issue occur only if more than one user is using the application? Does it occur more often if more users are using it?  
- Does the issue occur only at certain times of the day or on certain days of the week?
- Does the issue occur only when a backup is being taken or the database is being re-indexed?
- Does the issue affect more than one server?
- Does the issue affect only one node in a n-node cluster? If yes, it might be more efficient to consider rebuilding that particular node.
- Does the issue affect only one or two clients out of several? If yes, perhaps rebuilding would be more efficient.
- Does the issue affect only Named Pipes and not TCP (or vice versa)?
- Does the issue occur when you use a SQL Server login and TCP/IP?
- Does a working case exist that can be compared against the failing case? How do the systems differ?

</details>

<details><summary><b>Client computer</b></summary>

Use the following questions to collect data about the different components of the client computer. This data might be useful in identifying the issues.

- What is the operating system name, edition, and version (WinVer)?
- What is the name and version of the SQL Server driver or provider?
- What are the computer name and IP address?
- What is the computer's domain status? If it's joined to a domain, what's the domain name?
- What application run-time environment is used? For example, Internet Information Services (IIS), Windows Forms, Web Sphere, or SQL Server Integration Services (SSIS) Job.
- Which application language is used?
- What is the connection string used?
- What type of authentication is used to connect to the server? For example, New Technology LAN Manager (NTLM), Kerberos, SQL, or Azure Active Directory (AAD).
- If the application is a server or service, does it delegate user credentials to the back-end database?
- Is constrained delegation used?
- What are the application service account and domain?
- Which type of service is used? Is it physical, virtual, or cloud? For example, IaaS, Web App, Web Role, or Power BI.
- What is the client driver? Is it Java Database Connectivity (JDBC), or does it run on Linux or Mac?

    > [!NOTE]
    > The workflows are currently more Windows-oriented.

- Does the issue affect only legacy providers, such as `Provider=SQLOLEBD` or `Driver={SQL Server}`, and not SQL Native Client and later drivers (or vice versa)?
- Does the issue occur in only one application or in multiple applications?
- Does a Universal Data Link (UDL) file fail when it tries to connect to other SQL Server-based servers, or does it fail to only the server that has the issue?
- Does the user log in to the SQL Server-based server and try connecting by using SQL Server Management Studio (SSMS)?
- Does the issue occur only when you use the NETBIOS name of the server and not when you use the Fully Qualified Domain Name (FQDN) (or vice versa)? Does it work by using the IP address?
- Does the client running Windows 10 Enterprise Edition have the Credential Guard feature turned on? If yes, this might affect full delegation scenarios.

</details>

<details><summary><b>Log information</b></summary>

Use the following questions to collect data about the log files:

- What is the exact error message in the call stack?
- Was the log collected from the SQL Server *ERRORLOG* and *ERRORLOG.1* files?
- Were the application event logs collected from the client and server?
- Were the client application log files and configuration files collected? For example, *web.config, rsreportserver.config*, **.config*, or **.ini*.
- Is there an available visual representation of the network that shows the computers, routers, and so on?

</details>

<details><summary><b>New or existing issues</b></summary>

Refers to determining whether the problem is a recent development or if it has persisted for a while:

- Has the issue always existed (new installation) or did the application function correctly for some time before it recently broke?
- If the application used to function correctly, what changes were made to the environment? For example, installed updates, upgraded domain controllers, changes in the firewall settings, decommissioned domain controllers, or a move to a different OU in the domain.

</details>

<details><summary><b>Server computer</b></summary>

For a Linked Server, collect server information for both the mid-tier server and the back-end server. For an IIS-to-SQL delegation issue, collect information on the web server, including the *web.config* and authentication settings.

- What is the name of the operating system name, edition, and version (Winver)?
- What is the name and version of the database?  
- What is the name of the computer?
- What is the IP address?
- What is the domain name if the computer is domain-joined?
- What is the SQL Server service account and domain?
- What is the name of the SQL Server instance?
- Which protocols are enabled?
- Which is the port that the server listens on?
- What is the name of the server pipe? You can find this information in the error log.
- Which type of environment is used? Is it physical, virtual, or cloud? For example, IaaS (SQL in an Azure Virtual Machine (VM)) or PaaS (Azure SQL Database, SQL Managed Instance (MI)).
- Is the database deployed as standalone, clustered, mirrored, or using Always On?
- What is the Failover partner name and IP address?
- What is the Virtual cluster name or Listener name and port?
- Which is the Virtual IP or Listener IP?
- Which operating system is the database installed on? Is it Windows, Linux, or Mac? This might affect data collection.
- What is the location of the database? Is it in Azure?
- What is the current status of the server in terms of the latest Service Pack and Cumulative Update?
  There's no point in debugging an issue that's already fixed.
- Has SQL Server been upgraded recently to support Transport Layer Security (TLS) 1.2? Were the clients also updated? Has TLS 1.0 been turned off?
- What is the current status of the SQL Server service? Is it running?
- What is the status of the SQL Browser service? Is it running?
- What is the specificity of the issue to a service account? Does running the server using a different service account resolve the issue?

</details>

<details><summary><b>User information</b></summary>

Collect the following user details:

- Does the user log in to the client computer directly or access it remotely? For example, does the user use a browser?
- Is the user a service, such as SQL Agent? Is the process identity being used or a stored credential is being used?
- What is the type of authentication used to connect to the client application? Is it Windows, Forms authentication, or AAD?
- Does the user connect to the server using integrated security?
- What are the username and domain name?

If the user is remote to the client application, collect the following details:

- What are the computer name and IP address?
- Is the computer domain-joined? If yes, what is the domain name?
- Is the user connecting over a VPN or a proxy server? Does the issue occur if either method is directly connected?
- If the user is connecting to a web server, is the server load balanced?
- Are sticky sessions or session affinity being used?
- Is the user logging in to a terminal server or jump box and accessing the application?
- Does the issue affect only users in particular organizational units (OUs)?
- Has the user, client, or server moved to a different organizational unit (OU) in Active Directory?
- Does the issue affect only non-administrative users?
- Does the issue affect all or only some of the users in a particular domain?

</details>

## See also

- [Consistent SQL Network Connectivity Issue](consistent-sql-network-connectivity-issue.md)

- [Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md)

- [Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)

- [Change NETMON parser port for SQL Server](change-netmon-parser-port-for-sql-server.md)

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]