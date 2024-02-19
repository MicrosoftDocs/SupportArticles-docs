---
title: Troubleshoot DFSN access failures
description: Provides help to troubleshoot DFSN failures.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, clandis, davfish
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Troubleshoot Distributed File System Namespace access failures in Windows

This article provides a solution to solve Distributed File System Namespace (DFSN) access failures.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 975440

## Symptoms

On a computer that is running Windows XP or Window Server 2003, when you try to access to a DFSN, you receive the following error message:

> \\\\\<Domain Name>\\\<DFS Namespace> is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.
>
> Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied.

On Windows Vista and later versions of Windows, you may receive one of the following error messages:

> Windows cannot access \\\\\<Domain Name>\\\<DFS Namespace>

> The Network Path was not found

## Cause

This error typically occurs because the DFSN client cannot complete the connection to a DFSN path.

The connection may fail because of any of the following reasons:

- Failure to connect to a domain controller to obtain a DFSN namespace referral
- Failure to connect to a DFSN server
- Failure of the DFSN server to provide a folder referral

## Resolution

To resolve this problem, you must evaluate network connectivity, name resolution, and DFSN service configuration. You can use the following methods to evaluate each of these dependencies.

### Connectivity

In this article, connectivity refers to the client's ability to contact a domain controller or a DFSN server. If a client cannot complete a network connection to a domain controller or to a DFSN server, the DFSN request fails.

You can use the following tests to verify connectivity.

Determine whether the client was able to connect to a domain controller for domain information by using the `DFSUtil.exe /spcinfo` command. The output of this command describes the trusted domains and their domain controllers that are discovered by the client through DFSN referral queries. This is known as the *Domain Cache*.

In the following example, both the DNS domain name `contoso.com` and the NetBIOS domain name CONTOSO are discovered by the client. Two domain controllers were identified for the domain name CONTOSO: 2003server2 and 2003server1. If the client accesses the DNS name `contoso.com`in a request, the entries are displayed under the `contoso.com` entry.

```output
[*][2003server1.contoso.com]
[*][CONTOSO]
[*][contoso.com]
[+][CONTOSO]
    [-2003server2]
    [+2003server1]
[-][contoso.com]
```

Entries that are marked by an asterisk (*) were obtained through the Workstation service. The other entries were obtained through referrals by the DFSN client. The entries that are marked by a plus sign (+) are the domain controllers that are currently used by the client. For more information about referral processes, see [How DFS Works](/previous-versions/windows/it-pro/windows-server-2003/cc782417(v=ws.10)).

To evaluate connectivity, try a simple network connection to the active domain controller by using its IP address. For example, type either of the following commands:

- `start \\192.168.1.11`
- `net view \\192.168.1.11`

A successful connection lists all shares that are hosted by the domain controller.

If the connection is successful, determine whether a valid DFSN referral is returned to the client after it accesses the namespace. You can do this by viewing the referral cache (also known as the PKT cache) by using the `DFSUtil.exe /pktinfo` command.

The following output details the expected entries within the client's referral cache after the client accesses the DFSN path `\\contoso.com\dfsroot\link`. The root has two targets (rootserver1 and rootserver2). The link has a single target (fileserver).

```output
Entry: \contoso.com\dfsroot
ShortEntry: \contoso.com\dfsroot
Expires in 300 seconds
UseCount: 0 Type:0x81 ( REFERRAL_SVC DFS )
    0:[\ROOTSERVER1\dfsshare] State:0x119 ( ACTIVE )
    1:[\ROOTSERVER2\dfsshare] State:0x09 ( )

Entry: \contoso.com\dfsroot\link
ShortEntry: \contoso.com\dfsroot\link
Expires in 1800 seconds
UseCount: 0 Type:0x1 ( DFS )
    0:[\fileserver\data] State:0x131 ( ACTIVE )
```

If you cannot find an entry for the desired namespace, this is evidence that the domain controller did not return a referral. DFSN service failures are discussed later in this article.

If you see an entry for the namespace (that is, `\contoso.com\dfsroot`), the entry proves that the client was able to contact a domain controller, but then did not reach any DFSN namespace targets. If not any of the namespace targets that are listed are designated as ACTIVE, that indicates that all targets were unreachable.

Try to access to each namespace server by using IP addresses. For this test, you must specify only the IP address of the server, and you must not include the namespace share (that is, `net view \\192.168.1.11` but not `net view \\192.168.1.11\dfsroot`). Otherwise, you may unknowingly be referred to another DFS root server. If this occurs, you will receive misleading results. Note any error messages that are reported during these actions.

You must investigate and resolve any failures of a domain controller or of DFS namespace server communications. For more information about TCP/IP networking details and about troubleshooting utilities, see [TCP/IP Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc778264(v=ws.10)).

### Name resolution

Clients must resolve the name of the DFS namespace and of any servers that are hosting the namespace. Review the output that was previously generated by the `dfsutil /pktinfo` and `dfsutil /spcinfo` commands. The server names that are listed must be resolved by the client to IP addresses.

You can use the following methods to verify proper name resolution functionality.

- WINS and NetBIOS names

    NetBIOS name resolution failures may occur because name records are missing or because you received the wrong IP address for the name. To test this, try to access the domain controller by using only its NetBIOS computer name (that is, by using the command `net view \\2003server1`). Then, verify that the shares that are listed are those that are expected to be hosted by the server. As an administrator, you can view the client's NetBIOS name cache by using the `nbtstat -c` command to review all resolved names and their IP addresses. Consider the following example.

    |Name| NetBIOS| Remote Type| Cache Name Table  Host Address| Life [sec]|
    |--|--|--|--|--|
    |2003server1| <00>| UNIQUE| 192.168.1.11| 462|

    Review the following documents to troubleshoot WINS failures:

  - [Troubleshooting WINS servers](/previous-versions/windows/it-pro/windows-server-2003/cc738288(v=ws.10))
  - [Troubleshooting WINS clients](/previous-versions/windows/it-pro/windows-server-2003/cc776185(v=ws.10))

- DNS names

    By default, DFSN stores NetBIOS names for root servers. DFSN can also be configured to use DNS names for environments without WINS servers. For more information, see [How to configure DFS to use fully qualified domain names in referrals](https://support.microsoft.com/help/244380).

    You can view the client's DNS resolver cache to verify resolved DNS names. To do this, open a command prompt, and type the `ipconfig /displaydns` command.

    Consider the following example.

    Windows IP Configuration

    2003server1

    Record Name . . . . . : 2003server1.contoso.com  
    Record Type . . . . . : 1  
    Time To Live . . . . : 882  
    Data Length . . . . . : 4  
    Section . . . . . . . : Answer  
    A (Host) Record . . . : 192.168.1.11  

    Review the following documents to troubleshoot DNS failures:

  - [Troubleshooting DNS clients](/previous-versions/windows/it-pro/windows-server-2003/cc736535(v=ws.10))
  - [Troubleshooting DNS servers](/previous-versions/windows/it-pro/windows-server-2003/cc787724(v=ws.10))

- Network capture

    A network capture may help you diagnose a name resolution failure. Before you perform a capture, flush cached naming information on the client. If you do this, you will not expose any problems that may exist in the capture because cached referral data or names will not be requested again over the network. To flush the name caches, run the following commands in this order:

  - `nbtstat -RR`
  - `ipconfig /flushdns`
  - `dfsutil /pktflush`
  - `dfsutil /spcflush`

For more information about the Microsoft Network Monitor 3, see [Information about Network Monitor 3](https://support.microsoft.com/help/933741).

For more information about the network traffic that is observed between a client and a domain-based DFS environment, see [How DFS Works](/previous-versions/windows/it-pro/windows-server-2003/cc782417(v=ws.10)).

For more information about DNS and WINS, see [Name Resolution Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc755374(v=ws.10)).

### DFS and system configuration

Even when connectivity and name resolution are functioning correctly, DFS configuration problems may cause the error to occur on a client. DFS relies on up-to-date DFS configuration data, correctly configured service settings, and Active Directory site configuration.

First, verify that the DFS service is started on all domain controllers and on DFS namespace/root servers. If the service is started in all locations, make sure that no DFS-related errors are reported in the system event logs of the servers.

When an administrator makes a change to the domain-based namespace, the change is made on the Primary Domain Controller (PDC) emulator master. Domain controllers and DFS root servers periodically poll PDC for configuration information. If the PDC is unavailable, or if "Root Scalability Mode" is enabled, Active Directory replication latencies and failures may prevent servers from issuing correct referrals. For more information about Root Scalability Mode, see [Reviewing DFS Size Recommendations](/previous-versions/windows/it-pro/windows-server-2003/cc776068(v=ws.10)).

One method to evaluate replication health is to interrogate the status of the last inbound replication attempt for each domain controller. To do this, run the repadmin.exe command. The required syntax for this command is as follows:

`repadmin /showrepl * DN_of_domain`

> [!NOTE]
> In this command, * represents all domain controllers that are to be queried, and **DN_of_domain** represents the distinguished name of the domain, such as dc=contoso,dc=com.

Review the status and time of the last successful replication to make sure that DFSN configuration changes have reached all domain controllers. You should investigate any failures that are reported for inbound replication to a DC.

DFSN configuration problems may also prevent access to the namespace. One common scenario in which this occurs is a client that belongs to a site that contains no namespace or folder targets. If the namespace is configured to issue referral targets only within the client's site (the *insite* option), DFSN will not provide a referral. To evaluate whether the insite option is configured on a namespace, open a command prompt, and then type the `dfsutil /path:\\contoso.com\dfs /insite /display` command.

Similarly, Active Directory site configuration problems may prevent DFSN servers from correctly determining the client site. Therefore, these problems may cause referral failures if insite is configured. The DFSN service maps the client to a site by analyzing the source IP address of the client's referral request. The DFS service also maps each root target server to a site by resolving the target server's name to an IP address. To evaluate whether a domain controller or a DFS root can determine the correct site of the system, run either of the following commands locally on the domain controllers and on the DFS namespace server:

- `dfsutil /sitename:root_target_name`
- `dfsutil /sitename:client_ip_address`

## References

- [Designing the Site Topology](/previous-versions/windows/it-pro/windows-server-2003/cc787284(v=ws.10))

- [How DFS Works](/previous-versions/windows/it-pro/windows-server-2003/cc782417(v=ws.10))

- [Updated namespace terminology](/previous-versions/windows/it-pro/windows-server-2003/cc786243(v=ws.10))
