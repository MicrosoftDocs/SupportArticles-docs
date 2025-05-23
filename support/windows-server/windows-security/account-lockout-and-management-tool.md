---
title: Introduction to Account Lockout and Management Tools
description: Introduces Account Lockout and Management Tools for Windows Server.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows security technologies\account lockouts
- pcy:WinComm Directory Services
---
# Introduction to Account Lockout and Management Tools

This article introduces [Account Lockout and Management Tools](https://www.microsoft.com/download/details.aspx?id=18465) for Windows Server.

_Original KB number:_ &nbsp; 4469275

## Summary

This article introduces Account Lockout and Management Tools. This set of tools helps you manage accounts and troubleshoot account lockouts.

## More information

The following files are included in the Account Lockout and Management Tools package:

- AcctInfo.dll - Helps you isolate and troubleshoot account lockouts and change a user's password on a domain controller in that user's site. This tool adds new property pages to user objects in the Active Directory Users and Computers Microsoft Management Console (MMC).

- ALockout.dll - On the client computer, helps determine a process or application that is sending wrong credentials.

    > [!IMPORTANT]
    > Do not use this tool on servers that host network applications or services. Also, you should not use ALockout.dll on servers that are running Microsoft Exchange Server because it may prevent the Exchange store from starting.

- ALoInfo.exe - Displays the names and age of passwords for all user accounts.

- EnableKerbLog.vbs - Used as a startup script by enabling Kerberos protocol to log on to all clients that run Windows 2000 and later versions of Windows.

- EventCombMT.exe - Collects specific events from event logs of several different computers in one central location.

- LockoutStatus.exe - To help collect the relevant logs, determines all the domain controllers that are involved in a lockout of a user account. LockoutStatus.exe uses the NLParse.exe tool to parse Netlogon logs for specific Netlogon return status codes. This tool directs the output to a comma-separated value (.csv) file that you can sort later.

- NLParse.exe - Used to extract and display desired entries from the Netlogon log files.




###########################################
# Maintaining and Monitoring Account Lockout

After you configure the account lockout options that you want, set up the computers so that you can capture more data about the accounts that are being locked out. This section describes how to enable auditing, Netlogon logging, and Kerberos logging, as well as which computers to retrieve the logs from. After you configure the logging and capture the appropriate data, this section will show you how to analyze the information so that you can ensure account lockout settings are working and identify attacks.

# Enable Auditing at the Domain Level
The following sections describe how to enable auditing at the domain level for different operating systems.

To effectively troubleshoot account lockout, enable auditing at the domain level for the following events:

Account Logon Events – Failure
Account Management – Success
Logon Events – Failure

## Windows 2000 and Windows Server 2003 Domains
The Audit Policy settings are located in the Default Domain policy settings. To view the Auditing policy settings, in the Group Policy MMC, double-click Computer Configuration, double-click Windows Settings, double-click Security Settings, double-click Local Policies, and then double-click Audit Policy. Enable auditing for the event types listed in the previous section.

## Windows NT Server 4.0 Domain
Open User Manager, click Policies, click Auditing, enable Logon and Logoff auditing for failure events, and then enable User and Group Management auditing for success events.

# Settings for Event Logs
For troubleshooting purposes, change some of the settings for the Security event logs:

Set the maximum security log size to 10,000 KB or more. This helps to ensure that important events are not overwritten when the log file becomes large in size.

Set the event retention method to Overwrite events as needed to ensure that the computer is not shut down because there are too many Security event log entries, even when the log file becomes large in size.

For information about how to change the size and retention method of the Security event log, see the Help documentation for the operating system with which you are working.

Because the events can occur on both the client and the server, you can use the following tools to help you gather the information in a single location.

Use the EventCombMT.exe tool, a multithreaded tool, to gather specific events from event logs from several different computers to one central location and then search those event logs for specific data of interest. Some specific search categories are built into the tool, such as account lockouts, which is already configured to include events 529, 644, 675, 676, and 681. For more information, see the Help file that is included with the tool.

Use the Eventlog.pl tool to help you manage event logs in Windows 2000. You can use this tool to change the properties of event logs, back up event logs, export event lists to text file, clear event logs, and query the properties of the event logs. For more information, see "HOW TO: Use the Event Log Management Script Tool (Eventlog.pl) to Manage Event Logs in Windows 2000" in the Microsoft Knowledge Base.

# Netlogon Logging
You can use Netlogon logging to capture Netlogon and NTLM events. It is recommended that you configure Netlogon logging in a Windows 2000 domain that has Windows 2000 clients.

You must configure Netlogon logging on the primary domain controller (PDC) and on any other domain controllers that are involved in user authentication. To determine the authenticating domain controller, at a command prompt, type set l or use the LockoutStatus.exe tool. For more information about the LockoutStatus.exe tool, see the "Account Lockout Tools" section in this document. For enterprises that have less than 10 domain controllers, you should enable Netlogon logging on all domain controllers for each domain.

# Enabling Netlogon Logging on Computers Running Windows 2000 Server
To enable Netlogon logging on computers that are running Windows 2000 Server, at a command prompt, type nltest /dbflag:2080ffff. The log file is created in Systemroot\Debug\Netlogon.log. If the log file is not in that location, stop and restart the Netlogon service on that computer. To do this, at a command prompt, type net stop netlogon & net start netlogon. For more information, see "Enabling Debug Logging for the Netlogon Service" on the Microsoft Knowledge Base.

If free disk space is low, make sure there is enough space to allow the 40 megabytes (MB) maximum space for the logging. You should also consider the disk space that Netlogon logging uses. When Netlogon.log reaches 20 MB in size, it is renamed to Netlogon.bak and a new Netlogon.log is created with the latest Netlogon data. After that Netlogon.log reaches 20 MB in size, Netlogon.bak is truncated, and the current Netlogon.log file is renamed to Netlogon.bak. Because of this process, the total disk space that is used by Netlogon logging is never more than 40 MB.

  > [!Note]
  > Performance may be slightly degraded by the logging process. Therefore, you should disable Netlogon logging after you have captured the events that you want in the log file. To disable Netlogon logging, at a command prompt, type nltest /dbflag:0, press ENTER, type net start netlogon and then press ENTER.

# Kerberos Logging
If account lockouts involve Kerberos clients that are running a member of the Windows 2000 family or later, you can enable Kerberos logging on those client computers. You would typically perform this step after you have determined that there is an authentication issue that is related to Kerberos.

To enable Kerberos event logging on a computer

Click Start, click Run, type regedit, and then press ENTER.

Add the HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters registry value to the registry key:

Registry value: LogLevel

Value type: REG_DWORD

Value data: 0x1

If the Parameters registry key does not exist, create it.

Close Registry Editor and restart the computer.

  > [!Warning]
  > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

  > [!Note]  
  > Performance may be degraded by the logging process. Therefore, you should disable the logging process after you capture the events that you want in the log file. To disable logging, remove the LogLevel registry value, and then restart the computer.

You can automate this process by using the script that is in the "Account Lockout Tools" section in this document. This script sets the Kerberos logging key in the registry on client computers that are running Windows 2000. If you want to enable logging for groups of computers, you can specify this script as a startup script in an Active Directory Group Policy.

To disable Kerberos event logging on a computer

Click Start, click Run, type regedit, and then press ENTER.

Delete the HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters\LogLevel registry value.

Close Registry Editor and restart the computer.


  > [!Warning]
  >Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

For more information, see the "HOW TO: Enable Kerberos Event Logging" in the Microsoft Knowledge Base.

## Event and Netlogon Log Retrieval
After you set the auditing and logging, wait until account lockouts occur. When the account lockout occurs, retrieve both the Security event log and the System event log, as well as the Netlogon logs for all of the computers that are involved with the client's lockout. This includes the PDC emulator operations master, the authenticating domain controller, and all of the client computers that have user sessions for the locked-out user.

To determine the domain controllers that are involved with the lockout, run the LockoutStatus.exe tool and specify the user account that is locked out. This tool gathers and displays information about the specified user account from all the domain controllers in the domain. In addition, the tool displays the user's badPwdCount value on each domain controller. The domain controllers that have a badPwdCount value that reflects the bad password threshold setting for the domain are the domain controllers that are involved in the lockout. These domain controllers always include the PDC emulator operations master.

The badPwdCount value may appear to be higher than the threshold because of the way that passwords are chained to the PDC emulator operations master. When a bad password is presented by a user or program, both the authenticating domain controller and the PDC emulator operations master increment their badPwdCount value for that account. When Active Directory replication occurs, this can result in an increased value. However, the end result—the account becoming locked out—remains the same.

You can also use the EventCombMT.exe tool to gather specific event log data from multiple computers to one central location. For more information about both the EventCombMT.exe and LockoutStatus.exe tools, see the "Account Lockout Tools" section in this document.

# Analyzing Log File Information
The previous section described the processes that you can use to enable log files to record information that is lockout-specific on your computers. This section focuses on analyzing those log files and determining what behavior occurred that created the log files and caused the issue that you are trying to resolve. This section also describes how to resolve the issues that you find when you analyze the log files.

## Analyzing Netlogon Log Files
Before you start to analyze the Netlogon log files, you should be familiar with the authentication process works from previous sections in this paper. Although this section describes an NTLM authentication process, a similar chain of events occurs during Kerberos authentication.

The following sample scenario discusses what occurs when a user who is on a client computer tries to gain accesses to a resource that is on a file server in the same domain as the user account. In this process:

User credentials are passed to the file server. This is displayed in the Network Logon section in the Netlogon.log file.

The file server tries to authenticate the user, but the file server has to forward the credentials to the authenticating domain controller for validation because this account is a domain user account. This behavior is displayed as Transitive Network logon in the Netlogon.log file and is commonly referred to as pass-through authentication.

If the password is incorrect or if it is not the same as the password that is stored by the authenticating domain controller, the authenticating domain controller chains the credentials to the PDC for validation. This is displayed as Transitive Network Logon in the Netlogon.log file.

# Netlogon Log File Walkthrough
The following sections provide a sample Netlogon.log file output from the following three computers:

The PDC operations master for the domain: DC002

The authenticating domain controller: DC003

The member server: MEMSERVER01

The sample output sections show the following participants involved in network authentication:

Domain name: Tailspintoys

Logon user name: User1

Logon computer name: Computer-006

# Transitive Network Logon (Pass-Through Authentication)
Sample from the DC002 PDC emulator Netlogon log file:


Copy
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC000006A
29-Mar 14:28:31 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC0000234
Sample from the DC003 authentication domain controller Netlogon log file:


Copy
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via MEMSERVER01) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via MEMSERVER01) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via MEMSERVER01) 0xC000006A
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via MEMSERVER01) 0xC000006A
29-Mar 14:28:31 Transitive Network logon Tailspintoys\User1
Computer-006 (via MEMSERVER01) 0xC000006A
29-Mar 14:28:31 Transitive Network logon Tailspintoys\User1
Computer-006 (via MEMSERVER01) 0xC0000234
Sample from the MEMSERVER01 member server Netlogon log file:


Copy
29-Mar 14:28:31 Network logon Tailspintoys\User1
Computer-006 0xC000006A
29-Mar 14:28:31 Network logon Tailspintoys\User1
Computer-006 0xC000006A
29-Mar 14:28:32 Network logon Tailspintoys\User1
Computer-006 0xC000006A
29-Mar 14:28:32 Network logon Tailspintoys\User1
Computer-006 0xC000006A
29-Mar 14:28:32 Network logon Tailspintoys\User1
Computer-006 0xC000006A
29-Mar 14:28:32 Network logon Tailspintoys\User1
Computer-006 0xC0000234
These Netlogon.log file samples provide an example of the information contained in the Netlogon logs. This information is used to trace the account lockout from the domain controller back to the member server on which a user or application tried to gain access with the incorrect credentials.

# Stepping Through the Netlogon Log File Sample
This section describes the standard analysis process of log files when attempting to determine the cause of an account lockout issue.

In most troubleshooting scenarios, you should begin your log file analysis by examining the Netlogon.log file on the PDC operations master. Because this is a transitive network logon, you can find the authenticating domain controller by viewing the "Via" line in the Netlogon.log file for the domain controller that is chaining logon to the PDC operations master.

# Sample from the PDC Emulator (DC002) Netlogon Log File
On the "Via" line from the PDCs Netlogon.log file in the following example, note that the authentication is being chained from DC003.


Copy
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer006 (via DC003) 0xC000006A
This is an illustration of step 3 of the authentication process that was detailed in "Analyzing Netlogon Log Files" previously in this document.

# Sample from the Authentication Domain Controller (DC003) Netlogon Log File
In the Netlogon log file on DC003, this authentication is still a transitive network logon, because credentials were sent to DC003 for verification. Because of this, note where the credentials are sent from. In this example, the credentials are being sent via MEMSERVER01":


Copy
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer006 (via MEMSERVER01) 0xC000006A
This is an illustration of step 2 of the authentication process that was detailed in "Analyzing Netlogon Log Files" previously in this document.

The file server tries to authenticate the user, but the file server has to forward the credentials to the authenticating domain controller for validation because this is a domain user account. This is displayed as Transitive Network logon in the FileServername section of the Netlogon.log file.

# Sample from the Member Server (MEMSERVER01) Netlogon Log File
From the Netlogon.log file on MEMSERVER01 from the same time period, verify the actual client computer name where the original logon or session setup request came from. In this example, the request came from Computer-006:


Copy
29-Mar 14:28:31 Network logon   Tailspintoys\User1
Computer-006 0xC000006A
This is an illustration of step 1 of the authentication process that was detailed in "Analyzing Netlogon Log Files" previously in this document.

User credentials are passed to the file server. This is displayed in the Network Logon section in the Netlogon.log file.

Even though the log file does not display the exact process that is sending the incorrect credentials, Netlogon log files do provide the following information to help you troubleshoot the lockout:

Netlogon output displays the number of unsuccessful logon attempts (0xC000006A) for a user's account in a certain time period. Logs in which there are several 0xC000006A events in one second indicate that the lockout is most likely caused by a process, program, or script that is sending incorrect credentials.

Netlogon output provides a complete picture of all computers that are involved in the account lockout. You can narrow down the culprit by determining the common elements, such as programs, among the computers involved. For example, from the Netlogon output above, after you determined that MEMSERVER01 was common to all user lockouts, the troubleshooting focus changed to the particular network services or user accounts that are used by MEMSERVER01.

In this example, MEMSERVER01 is the Microsoft Exchange server. After you examine the Microsoft Outlook client and Exchange server settings, you may want to use the information that is in the following two articles to help resolve the issue. These articles describe how to remove unnecessary RPC bindings from the Exchange server. For example, remove Named Pipe support if there is no client that requires the named pipes.

"Outlook Locks Your Account Because of a Directory Service Referral with Exchange 2000 Server" in the Microsoft Knowledge Base.

"Unexpected Account Lockouts Caused When Logging On to Outlook from an Untrusted Domain" in the Microsoft Knowledge Base.

If the Netlogon logs from all domain controllers from the time of lockout but do not display data that pertains to any of the locked-out user accounts that you are analyzing, then NTLM authentication is not involved in the lockouts. This normally indicates that the authentication issues are between computers running Windows 2000 or later, because earlier versions of Windows used NTLM authentication exclusively. You should focus on Kerberos authentication troubleshooting by using Kerberos logging and examining the Security event logs.

# Netlogon Log File Error Codes
Each event in the Netlogon log contains a corresponding error code. The following table describes these error codes.

Table 3 Netlogon Log Error Codes

Log Code | Description
---|---
0x0|Successful login
0xC0000064|The specified user does not exist
0xC000006A|The value provided as the current password is not correct
0xC000006C|Password policy not met
0xC000006D|The attempted logon is invalid due to a bad user name
0xC000006E|User account restriction has prevented successful login
0xC000006F|The user account has time restrictions and may not be logged onto at this time
0xC0000070|The user is restricted and may not log on from the source workstation
0xC0000071|The user account's password has expired
0xC0000072|The user account is currently disabled
0xC000009A|Insufficient system resources
0xC0000193|The user's account has expired
0xC0000224|User must change his password before he logs on the first time
0xC0000234|The user account has been automatically locked  > [!Note]  > Many of these codes provide information in the log file that is redundant with the corresponding Netlogon event log. This allows you to analyze the events in a variety of ways.

# Frequently Asked Questions
This section answers common questions that might be helpful in troubleshooting the Account Lockout feature in the Windows Server 2003 family.

Do the logon attempts happen seconds apart or are there many invalid logon attempt events (error code 0xC000006A) in the same second?

The pattern shows whether this is a user error or a process or program that is creating the lockout. Users take several seconds between events, however, a process or program typically register many invalid or unsuccessful logon attempt events in one second.

  > [!Note]
  > You can use the NLParse.exe tool to parse Netlogon logs for specific events that are related to account lockout, such as events 0xC000006A and 0xC0000234. The parsed data is sent to a .csv file that you can read by using a program like Microsoft Excel. For more information about NLParse, see the "Account Lockout Tools" section in this document.

From which computers are the invalid logon attempt events generated?

When you review the Netlogon logs and event logs, you can isolate from which computer the user was logged on during the account lockouts. In many situations, you will discover that a user is logged onto multiple computers; after the user changes their password on one computer, the user account is locked out.

What client computers are displayed in the Netlogon log files?

If only Windows 98 or Windows 95 clients are locked out, you may need to install the directory service client for those clients. For example, below, the Computer-006 computer generates the invalid logon attempt event:


Copy
29-Mar 14:28:30 Transitive Network logon Acme\User1
Computer-006 (via DC003) 0xC000006A
Which user accounts are associated with the invalid logon attempt events?

If privileged accounts (such as the administrator, service accounts, and well-known application account names) are receiving a large number of incorrect password attempts, first review the information for the computers that have made the attempts with the incorrect passwords, and then determine if there is a wrong password for the account. After you do this, if the passwords on all of the accounts are reset and incorrect password attempts persist, perform a trace to determine if the computer is under an attack. You can place an event trigger to stop the trace and determine where the attempt may be coming from. Internal or external computers can be a threat if there are worm viruses or compromises. The following example shows that the 0xC000006A error code is generated from the Tailspintoys\User1 user:


Copy
29-Mar 14:28:30 Transitive Network logon Tailspintoys\User1
Computer-006 (via DC003) 0xC000006A
Is there an obvious pattern to the invalid logon attempt events and account lockouts?

Pattern: All users on the domain are locked out, including users who did not change their password. There are many unsuccessful authentication attempts per second.

Possible Solution: If you determine that the log files show that most or all of the user accounts are locked out in your domain, you must perform a trace to determine whether the source of the attack is internal or external to your network. If the attack appears to come from a internal computer, examine the processes running on these computers as this likely indicates a common process that uses outdated or incorrect credentials. Attacks from outside your network often indicate denial of service or brute force attacks against your user accounts.

Pattern: Alphabetical list of users in the log files.

Possible Solution: If the log files show that all of the user accounts are locked out in a list that is almost alphabetical, it is most likely that this behavior is caused by an attempt to break passwords or a denial of service attack. You must perform a network trace to the source of the attack.

Pattern: A specific number of logon attempts are made on each locked-out account.

Possible Solution: If you determine that the log files display a specific number of logon attempts for a each user, add the number of occurrences of 0xC000006A and 0xC0000234 errors for the user. In some scenarios, you may see a pattern of a specific number of attempts for one user, and then the same number of attempts for another user, and so on. This behavior may be an attack on the network or a program could be sending a specific set of attempts. 16 or 17 attempts per user is a common figure for these types of attacks.

In most account lockout situations, you must use Netlogon log files to determine which computers are sending bad credentials. When you analyze Netlogon log files, look for the 0xC000006A event code, because this event will help you determine where the bad password attempts began to occur. When you see the 0xC000006A event code and it is followed by a 0xC0000234 event code, the event codes that come after these event codes help you determine what caused the account lockout. If you see patterns in the log files, the patterns can help you determine if the event code was logged because of either a program attack or user error.

# Analyzing Event Logs
You cannot determine the authentication type that was used when an account is locked out unless you enable Netlogon logging before the account lockout. However, because of differences in authentication, there may be situations in which Netlogon logging does not capture the data that you need to determine which computers were involved in an account lockout. Configuring the appropriate computers to create event logs may provide additional information in these situations.

Before the problems occur, you should enable security auditing and Kerberos logging on all computers that might be involved in the account lockout event. Enabling auditing and Netlogon log files is discussed elsewhere in this document. If the auditing is not configured before the initial error occurs, it can be done afterwards.

Once the account lockout occurs, there are several tasks that should be completed to help identify the cause of the issue:

Obtain both the Security and System event logs from all of the computers that are locked out if those computers were logged on when the lockout occurred. Also, obtain these log files from the PDC emulator operations master and all domain controllers that may be involved in the account lockout.

Look for Event 675 (Preauthentication Failures) in the Security event log for the domain controllers for the locked-out user account. This event displays the IP address of the client computer from which the incorrect credentials were sent. When you view these events in the Security event log from the PDC, an IP address with Event 675 may be the IP address of another domain controller because of password chaining from other domain controllers. If this is true, obtain the Security event log from that domain controller to see the Event 675. The IP address that is listed in that Event 675 should be the IP address for the client computer that sent the invalid credential.

After you know which client computer is sending the invalid credentials, determine the services, programs, and mapped network drives on that computer. If this information does not reveal the source of the account lockout, perform network traces from that client computer to isolate the exact source of the lockout.

  > [!Note]
  > You can use the EventCombMT.exe tool to gather event log dates from different domain controllers at the same time. For more information about EventCombMT.exe, see the Account Lockout Tools section in this document.

For more information, see the following articles:

"Windows 2000 Security Event Descriptions (Part 1 of 2)" in the Microsoft Knowledge Base.

"Windows 2000 Security Event Descriptions (Part 2 of 2) in the Microsoft Knowledge Base.

# Example Event Log Entry: Incorrect Password Processed by Kerberos
The following example displays a sample Event 675 in the Security event log from the PDC emulator operations master:


Copy
Event Type: Failure Audit
Event Source: Security
Event Category: Account Logon
Event ID: 675
Date: 12/5/2001
Time: 5:47:26 PM
User: NT AUTHORITY\SYSTEM
Computer: COMPUTER-006
Description:
Pre-authentication failed:
User Name: user1
User ID: %{S-1-5-21-4235101579-1759906425-16398432-1114}
Service Name: krbtgt/Tailspintoys.com
Pre-Authentication Type: 0x2
Failure Code: 0x18
Client Address: 172.16.1.85
In this example, failure code 0x18 is listed because an incorrect user name or password was used. The client address of 172.16.1.85 identifies the network client that caused this failure. The user name "user1" is also included in this event. The client address and user name should provide enough information for you to begin to address the issue, because you know which user is attempting to logon from which computer.

# Example Event Log Entry: Account is Locked Out
The following example displays a sample of Event 644, which indicates that the account is locked out:


Copy
Event Type: Success Audit
Event Source: Security
Event Category: Account Management
Event ID: 644
Date: 12/5/2001
Time: 5:47:26 PM
User: Everyone
Computer: COMPUTER-006
Description:
User Account Locked Out:
Target Account Name: user1
Target Account ID:%{S-1-5-21-4235101579-1759906425-16398432-1114}
Caller Machine Name:COMPUTER-006
Caller User Name:USER1$
Caller Domain:TAILSPINTOYS
Caller Logon ID:(0x0,0x3E7)
For more information about account lockout events, see "Audit Account Lockout" on the Microsoft TechNet Web site.

# Example Event Log Entry: Logon Failure
The following example displays a sample of Event 529, which results from an unsuccessful logon attempt due to an invalid user name or password. This event is often useful in identifying the source of the lockout:


Copy
Event Type: Failure Audit
Event Source: Security
Event Category: Logon/Logoff
Event ID: 529
Date: 12/21/2001
Time: 2:05:20 PM
User: NT AUTHORITY\SYSTEM
Computer: COMPUTER-006
Description:
Logon Failure:
   Reason: Unknown user name or bad password
   User Name: user1
   Domain: Tailspintoys
   Logon Type: 2
   Logon Process: User32
   Authentication Package:    Negotiate
   Workstation Name: COMPUTER-006
This event contains several useful elements. It identifies the name of the computer that is attempting authentication, as well as the user and domain name. It also displays the logon type, which is discussed later in this section.

When Event 529 is logged, you should look for patterns in the event. Determine if there are several 529 events logged and determine if they all occur in one second or if they occur at specific time intervals. If so, there is a process or service that is running on the computer that is sending incorrect credentials. Look at the Logon Process and Logon Type entries in the log to determine the type of process that is passing incorrect credentials and to determine how the process is logging on.

# Example Event Log Entry: Account Is Disabled
When there is an attempt to logon using a disabled account, a specific event is created in the event log. This can help you quickly identify intruders, because normal operations should not allow for the use of locked out accounts. You should analyze and respond quickly to these events.


Copy
Event Type:    Failure Audit
Event Source: Security
Event Category: Logon/Logoff
Event ID: 531
Date: 12/21/2001
Time: 2:05:21 PM
User: NT AUTHORITY\SYSTEM
Computer: COMPUTER-006
Description:
   Logon Failure:
   Reason: Account currently disabled
   User Name: user1
   Domain: TAILSPINTOYS
   Logon Type: 2
   Logon Process: User32
   Authentication Package: Negotiate
# Kerberos Events Logged During an Account Lockout
Once Kerberos logging is enabled, certain events will be logged when an account lockout occurs. These events are described in this section.

## Incorrect Password
This event is logged when an incorrect password is received by Kerberos as part of an authentication request.


Copy
Event Type:   Error
Event Source: Kerberos
Event Category: None
Event ID: 4
Date: 12/21/2001
Time: 2:02:05 PM
User: N/A
Computer: COMPUTER-006
Description:
   The function LogonUser received a Kerberos Error Message:
   on logon session TAILSPINTOYS\user1
   Client Time:
   Server Time: 19:2:5.0000 12/21/2001 (null)
   Error Code: 0x18 KDC_ERR_PREAUTH_FAILED
   Client Realm:
   Client Name:
   Server Realm: TAILSPINTOYS.COM
   Server Name: krbtgt/TAILSPINTOYS.COM
   Target Name: krbtgt/TAILSPINTOYS@TAILSPINTOYS
   Error Text:
   File:
   Line: Error Data is in record data.
# Kerberos Event When a User Account Is Locked Out
This event is logged when Kerberos is used for authentication and an account lockout occurs.


Copy
Event Type: Error
Event Source: Kerberos
Event Category: None
Event ID: 4
Date: 12/21/2001
Time: 2:05:21 PM
User: N/A
Computer: COMPUTER-006
Description:
   The function LogonUser received a Kerberos Error Message:
   on logon session TAILSPINTOYS\user1
   Client Time:
   Server Time: 19:5:21.0000 12/21/2001 (null)
   Error Code: 0x12 KDC_ERR_CLIENT_REVOKED
   Client Realm:
   Client Name:
   Server Realm: TAILSPINTOYS.COM
   Server Name: krbtgt/TAILSPINTOYS.COM
   Target Name: krbtgt/TAILSPINTOYS@TAILSPINTOYS
   Error Text:
   File:
   Line: Error Data is in record data
# Logon Events
Many different events can be created by various logon and logoff actions. The following table describes each logon event.

Table 4 Logon Event IDs

Event ID	| Description
---|---
528|A user successfully logged on to a computer. For information about the type of logon, see the Logon Types table below.
529|Logon failure. A logon attempt was made with an unknown user name or a known user name with a bad password.
530|Logon failure. A logon attempt was made, but the user account tried to log on outside of the allowed time.
531|Logon failure. A logon attempt was made using a disabled account.
532|Logon failure. A logon attempt was made using an expired account.
533|Logon failure. A logon attempt was made by a user who is not allowed to log on at this computer.
534|Logon failure. The user attempted to log on with a type that is not allowed.
535|Logon failure. The password for the specified account has expired.
536|Logon failure. The Netlogon service is not active.
537|Logon failure. The logon attempt failed for other reasons.  > [!Note]  > In some cases, the reason for the logon failure may not be known.
538|The logoff process was completed for a user.
539|Logon failure. The account was locked out at the time the logon attempt was made.
540|A user successfully logged on to a network.
541|Main mode Internet Key Exchange (IKE) authentication was completed between the local computer and the listed peer identity (establishing a security association), or quick mode has established a data channel.
542|A data channel was terminated.
543|Main mode was terminated.  > [!Note]  > This might occur as a result of the time limit on the security association expiring, policy changes, or peer termination. (The default expiration time for security associations is eight hours.)
544|Main mode authentication failed because the peer did not provide a valid certificate or the signature was not validated.
545|Main mode authentication failed because of a Kerberos failure or a password that is not valid.
546|IKE security association establishment failed because the peer sent a proposal that is not valid. A packet was received that contained data that is not valid.
547|A failure occurred during an IKE handshake.
548|Logon failure. The security identifier (SID) from a trusted domain does not match the account domain SID of the client.
549|Logon failure. All SIDs that correspond to untrusted namespaces were filtered out during an authentication across forests.
550|A denial-of-service attack may have taken place.
551|A user initiated the logoff process.
552|A user successfully logged on to a computer using explicit credentials while already logged on as a different user.
672|An authentication service (AS) ticket was successfully issued and validated.
673|A ticket-granting service (TGS) ticket was granted.
674|A security principal renewed an AS ticket or TGS ticket.
675|Preauthentication failed. This event is generated on a Key Distribution Center (KDC) when a user types in an incorrect password.
676|Authentication ticket request failed. This event is not generated in Windows XP or in the Windows Server 2003 family.
677|A TGS ticket was not granted. This event is not generated in Windows XP or in the Windows Server 2003 family.
678|An account was successfully mapped to a domain account.
681|Logon failure. A domain account logon was attempted. This event is not generated in Windows XP or in the Windows Server 2003 family.
682|A user has reconnected to a disconnected terminal server session.
683|A user disconnected a terminal server session without logging off.  > [!Note]  > This event is generated when a user is connected to a terminal server session over the network. It appears on the terminal server.

# Netlogon Logon Types
When many Netlogon logon events are logged, a logon type is also listed in the event details. The following table describes each logon type.

Table 5 Netlogon Logon Types

Logon type	| Logon title	| Description
---|---|---
2|Interactive|A user logged on to this computer.
3|Network|A user or computer logged on to this computer from the network.
4|Batch|The batch logon type is used by batch servers, where processes may be executing on behalf of a user without their direct intervention.
5|Service|A service was started by the Service Control Manager.
7|Unlock|This workstation was unlocked.
8|NetworkCleartext|A user logged on to this computer from the network. The user's password was passed to the authentication package in its unhashed form. The built-in authentication packages all hash credentials before sending them across the network. The credentials do not traverse the network in plaintext (also called cleartext).
9|NewCredentials|A caller cloned its current token and specified new credentials for outbound connections. The new logon session has the same local identity, but uses different credentials for other network connections.
10|RemoteInteractive|A user logged on to this computer remotely using Terminal Services or Remote Desktop.
11|CachedInteractive|A user logged on to this computer with network credentials that were stored locally on the computer. The domain controller was not contacted to verify the credentials.


