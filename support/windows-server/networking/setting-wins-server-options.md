---
title: Setting WINS server options
description: Provides a solution to an error that occurs when you try to specify the same WINS address in the Secondary WINS address.
ms.date: 03/08/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, timball
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Setting primary and secondary WINS server options

This article provides a solution to an error that occurs when you try to specify the same WINS address in the Secondary WINS address.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 150737

## Symptoms

When a Windows Server computer runs the Windows Internet Naming Service (WINS) and participates in WINS database replication on the network, you have to carefully configure the destination that the WINS server uses for its own name resolution.

You can configure this setting in the Network control panel, in **TCP/IP Protocol** > **Configuration**. You can also configure this setting by using the registry (although if the address is already added, you don't have to add it again).

We recommend that a WINS server point to its own address as the Primary WINS address in the TCP/IP configuration. However, if you try to specify the same WINS address as the Secondary WINS address, you receive an error message:  
> The WINS server is already in the list.

## Workaround

We recommend that a WINS server always point to itself as only the Primary WINS address, and not the Secondary WINS address. This configuration avoids split registrations and other problems.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed at the beginning of this article.

## More information

When any WINS-enabled computer starts, it must register different kinds of services with WINS. Typically, the computer has a Primary and Secondary WINS address configured in the TCP/IP setup. If the Primary WINS address doesn't respond to the registrations, the computer tries the Secondary WINS address.

Most clients and servers should be configured with a Primary and Secondary WINS address, however caution must be taken with how a WINS server is itself configured. A WINS server eventually registers its services in its own local WINS database, regardless of whether it points to itself or not (either Primary, Secondary, or none). Registering with itself and another WINS server can cause problems when it comes to replication and renewal of these entries.

### Example

Consider a WINS server (Srv1) that points to itself as Primary and points to another WINS as Secondary (Wins2). When Srv1 starts, it tries to register its services before its own WINS service starts. Because those registrations fail, it tries to register them at Wins2. If Wins2 is available, it accepts the registration requests. During this process, Srv1 continues to check its local WINS service. When Srv1 detects that its WINS service is running, it stops sending registration requests to WINS2 and handles them locally instead.



After replication has occurred between Srv1 and Wins2, both databases show this ownership:

Srv1: Owns his Srv1<20>, and Domain<1c> (if it is a domain controller)  
Wins2: Owns all other Srv1 registrations, and also owns Domain<1c> from Srv1

It potentially problematic condition is referred to as split registration.

At this point, Srv1 has reverted to re-registering locally, however it takes a while before you can see it. Meanwhile, Srv1 and Wins2 are replicating the split registration mappings to other WINS servers. Eventually these replicas should be reconciled at the remote WINS (that is, the Wins2 replicas are replaced by the newer Srv1 replicas). However, before reconciliation is finished, client connection problems may have occurred, including the inability to connect to a WINS server that split its registration (in this example, Srv1), or the inability to resolve the domain<1c> name that Srv1 registered.

The exact conditions that lead to failure vary. These conditions should only be temporary. However, the problem may be more severe depending on your replication scheme.

Another faulty configuration is setting a remote IP address (in this example, Wins2) as Primary while setting the local WINS (Srv1) as Secondary. In this case, Srv1 will eventually stop refreshing its NetBIOS lease at Wins2, and will begin registering locally. Depending on your WINS replication scheme, which may cause connection problems.
