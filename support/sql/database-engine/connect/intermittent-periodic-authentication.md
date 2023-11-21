---
title: Intermittent or periodic authentication issue
description: Troubleshoots intermittent or periodic authentication issues.
ms.date: 11/20/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
Intermittent or Periodic Authentication Issue

Intermittent or periodic authentication issues in SQL Server connectivity occur when users or applications face sporadic difficulties in authenticating with the SQL Server database, leading to disruptions in data access and application functionality. This article addresses common causes and solutions for intermittent authentication issues in SQL Server connectivity.

Some of the most common error messages are:
•	Cannot generate SSPI context
•	Login failed for user '(null)'
•	Login failed for user ''
•	Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'
•	Login failed for user 'JohnDoe'
•	Login failed for user 'Contoso\JohnDoe'
•	Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.


Appropriate Expectations

•	This issue may take a while to resolve depending on the frequency that the problem occurs, whether it happens to one of many clients vs. all clients vs. application server, and whether it happens more often at set times of day, e.g. busy periods or during backups or reindexing.
•	The most common issues are related to SQL Server performance or slow Domain Controller response. If using NTLM, then LSASS (Local Security Provider)  has a bottleneck and limits how many new connections can be processed at once; additional requests get backed up and may timeout. Some causes, such as antivirus can be difficult to prove, but are common nonetheless and should be investigated even without hard proof, if other avenues of inquiry do not show promise.

Pre-Work
•	Please perform the initial data collection and narrowing steps: https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/resolve-connectivity-errors-checklist#recommended-prerequisites . This will help get a macro perspective of the scope of an issue, such as whether the issue affects multiple computers or just one, or whether only those computers in a specific data center are facing issues. This can help focus the troubleshooting steps. It will also make you prepared for discussing the issue with Microsoft Support should you choose to do so.
Review the public troubleshooting documents listed in section Self-Help Articles.
•	Make sure you understand the application architecture. Make a summary in a succinct form, similar to the below description:
•	There are two domains involved: CONTOSO and FABRIKAM.
•	The client (SPARKY.CONTOSO.COM) is Windows 2012.
•	The user (CONTOSO\JOHNDOE) runs EDGE and connects to a web server (_HTTP://WEB01.CONTOSO.COM/Accounting) using Integrated security.
•	The IIS app pool runs as (CONTOSO\WEB_SVC).
•	The web server connects to SQL Server 2014 (SQLProd01.FABRIKAM.COM\Accounting on port 1433) using the SqlClient .NET 4.6.2 Provider and delegates the user credentials to SQL Server via integrated security.
•	The SQL Server service account is FABRIKAM\SQL_SVC_01.

Order of Troubleshooting

In general, troubleshooting should be data driven, which may give way to empirical tests in a more focused context. If the issue is very intermittent and network traces will be difficult to capture, then the empirical methods may be applied first.
Since the issue is intermittent, we can assume configuration, such as Kerberos SPNs, is basically correct.
•	Are multiple domains or data centers involved?
If multiple domains or data centers are involved, check whether the users in the local domain/data center have a good experience while users in the other domain or data center do not. If that is the case, it could be a communication latency between data centers or between domain controllers. Use PING to check network latency. Use the RUNAS command with various users to test credential validation latency issues. These commands can eliminate SQL Server from the issue and show a more fundamental issue with the networking infrastructure or domain controller performance.
•	SQL Server ERRORLOG The SQL Server ERRORLOG may reveal performance issues on SQL Server, such as entries indicating I/O was taking longer than 15 seconds. The SQL Performance team to have a PSSDIAG run and analyzed. You may want to do this, anyway, if the network trace reveals delays with the SQL Server responses.
The ERRORLOG may also include other domain-related errors, such as the following that indicate some sort of Active Directory performance issue:

	SSPI handshake failed with error code 0x80090311 while establishing a connection with integrated security; the connection has been closed.
	SSPI handshake failed with error code 0x80090304 while establishing a connection with integrated security; the connection has been closed.

	These codes translate as follows:
	
Error -2146893039 (0x80090311): No authority could be contacted for authentication.
        	Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.

Examine Client System Event Log

The system event log will have various events, such as KERBEROS, LSA, and NETLOGON events, which indicate the computer was not able to connect to the domain controller for a period of time. To make them easier to find, filter on Error, Warning, and Critical events only. The event times need to be around the time of the outage. If there is a match, this would be an Active Directory issue.
In some cases, this may happen on the SQL Server. Check the logs on that machine, as well.

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

In the security event log filter on Event ID 4625, which shows the detailed information about login failure.

SQL Connectivity Ring Buffer
The ring buffer is a historical log of connection events on the SQL Server, which means it can be taken after an outage. See Collect the Connectivity Ring Buffer. Many events include login timers that tell you where the time is being spent. Time being spent on the network indicates a possible network or client latency. Time spent in SSL or SSPI APIs indicate potential issues with the Windows security subsystem. Enqueued time indicates a SQL performance issue. 
Connection Pooling
Connection Pooling (actually, the lack thereof) can be a bad offender in intermittent logion failure issues. Not only can it run the client out of out-bound ports, but it can also overload the server and cause the server to reject incoming connection requests or flood a poorly performing domain controller. The best thing to do is to have the application developer use Connection Pooling in their application. It is ON by default in .NET and in IIS applications, so it's possible it may have been turned it off for some reason. If the application uses custom pooling code, this is highly discouraged as almost all custom pooling implementations we have run into have issues; it is generally better to use the built-in mechanism.
Lack of connection pooling will show as a large number of TIME_WAIT status codes in the NETSTAT output compared to ESTABLISHED connections.
Miscellaneous

Running out of ephemeral ports is a relatively common cause of intermittent connection timeouts.

Low Kernel Memory on the SQL Server Machine In SQL Server Management Studio, check Maximum Server Memory in Server Properties pane. The default is to 2147483647MB, which means the server can starve the OS of memory. It's best to set this to about 4GB-8GB less than the physical memory on the machine; less if there are multiple instances or IIS or some other app server also runs on the machine.


See Also
Credential Delegation Issue
