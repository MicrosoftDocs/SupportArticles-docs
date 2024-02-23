---
title: MSExchangeDSAccess Event ID 2080
description: Describes the columns in Event 2080 and their contents and how to use the information in Event ID 2080 to diagnose DSAccess problems.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: sschiem, v-six
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 2080 from MSExchangeDSAccess

_Original KB number:_ &nbsp; 316300

## Summary

In Exchange Server 2016, Exchange Server 2013, and Exchange Server 2010, AD Access (an Active Directory Service Access component) generates a topology detection event in the Exchange Server application log.

The Event 2080 log entry:

> Log Name:      Application  
Source:        MSExchange ADAccess  
Event ID:      2080  
Task Category: Topology  
Level:         Information  
Keywords:      Classic  
Description:  
     Process Microsoft.Exchange.Directory.TopologyService.exe (PID=4016). Exchange Active Directory Provider has discovered the following servers with the following characteristics:  
(Server name | Roles | Enabled | Reachability | Synchronized | GC capable | PDC | SACL right | Critical Data | Netlogon | OS Version)  
In-site:  
`domaincontroller1.company.com` CDG 1 7 7 1 0 0 1 7 1  
`domaincontroller2.company.com` CDG 1 7 7 1 0 1 1 7 1  
`domaincontroller3.company.com` CDG 1 7 7 1 0 1 1 7 1  
Out-of-site:

## More information

The following information describes the columns in Event 2080 and their contents.

### Example table

|Server name|Roles|Enabled|Reachability|Synchronized|GC capable|PDC|SACL right|Critical data|Netlogon check|System version|
|---|---|---|---|---|---|---|---|---|---|---|
|`domaincontroller1.company.com`|CDG|1|7|7|1|0|0|1|7|1|
|`domaincontroller2.company.com`|CDG|1|7|7|1|0|1|1|7|1|
|`domaincontroller3.company.com`|CDG|1|7|7|1|0|1|1|7|1|

### Column descriptions

- **Server name:** The first column indicates the name of the domain controller that the rest of the data in the row corresponds to.
- **Roles:** The second column shows whether the particular server can be used as a configuration domain controller (column value C), a domain controller (column value D), or a global catalog server (column value G) for this particular Exchange server. A letter in this column means that the server can be used for the designated function, and a hyphen (-) means that the server cannot be used for that function. In the example that is described earlier in this article, the **Roles** column contains the value **CDG** to indicate that the service can use the server for all three functions.
- **Enabled:** The third column indicates whether the domain controller is enabled to use Exchange Server.
- **Reachability:** The fourth column shows whether the server is reachable by a Transmission Control Protocol (TCP) connection. These bit flags are connected by an **OR** value. 0x1 means the server is reachable as a global catalog server (port 3268), 0x2 means the server is reachable as a domain controller (port 389), and 0x4 means the server is reachable as a configuration domain controller (port 389). In other words, if a server is reachable as a global catalog server and as a domain controller but not as a configuration domain controller, the value is **3**. In this example, the value of **7** in the third column means that the server is reachable as a global catalog server, as a domain controller, and as a configuration domain controller (0x1 | 0x2 | 0x4 = 0x7).
- **Synchronized:** The fifth column shows whether the `isSynchronized` flag on the rootDSE of the domain controller is set to **TRUE**. These values use the same bit flags connected by an **OR** value as the flags that are used in the **Reachability** column.
- **GC capable:** The sixth column is a Boolean expression that states whether the domain controller is a global catalog server.
- **PDC:** The seventh column is a Boolean expression that states whether the domain controller is a primary domain controller for its domain.
- **SACL right:** The eighth column is a Boolean expression that states whether DSAccess has the correct permissions to read the SACL (part of `nTSecurityDescriptor`) against that directory service.
- **Critical data:** The ninth column is a Boolean expression that states whether DSAccess found this Exchange server in the configuration container of the domain controller listed in **Server name** column.
- **Netlogon check:** The tenth column indicates whether AD Access successfully connected to a domain controller's Net Logon service. This requires the use of Remote Procedure Call (RPC). That call may fail for reasons other than that a server is down. For example, firewalls may block this call. So, if there is a value of **7** in the ninth column, this means that the Net Logon service check was successful for each role (domain controller, configuration domain controller, and global catalog).
- **System version:** The eleventh column indicates whether the operating system of the listed domain controller satisfies the operating system requirements of Exchange Server for use by DSAccess.

## How to use the information in Event ID 2080 to diagnose DSAccess problems

When you review the Event ID 2080 message, look at the **Roles** column first. There should be at least one server that can service the C role, at least one server that can service the D role, and at least one server that can service the G role. If there is a hyphen instead of a letter in any of these spaces, review your topology. Confirm that you have at least one domain controller and one global catalog server either in the site that your Exchange server is in or in the closest connected sites with the lowest siteLink cost.

Next, look at the **Reachability** column. Generally, you see one of several possible numbers in this column. If the domain controller is a domain controller but not a global catalog server (**Roles** column shows CD-), this number is 6 (0x2 | 0x4) to signify that the server's domain controller port (389) is reachable by a TCP connection. If the domain controller is a global catalog server (**Roles** column shows **CDG**), this number is 7 (0x1 | 0x2 | 0x4), which signifies that the server's domain controller port (389) and global catalog server port (3268) are reachable by a TCP connection. If you see other numbers here (especially 0), there may be a problem with the connection from the Exchange server to the directory service.

Next, look at the **SACL right** column. DSAccess does not use any domain controller that does not have permissions to read the SACL on the `nTSecurityDescriptor` attribute in the domain controller. You must have at least one server that satisfies each role (C, D, or G), that is reachable for that role (the appropriate bit flag connected by an OR value in the **Reachability** column), and that shows **1** in the **SACL right** column. If you do not have these servers, confirm that the domain controller that shows **0** in the **SACL right** column has been domain-prepped, and then confirm that your Recipient Update Services are configured properly.
