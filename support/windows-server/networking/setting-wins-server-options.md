---
title: Setting WINS server options
description: Provides a solution to an error that occurs when you try to specify the same WINS address in the Secondary WINS address.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, timball
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Setting primary and secondary WINS server options

This article provides a solution to an error that occurs when you try to specify the same WINS address in the Secondary WINS address.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 150737

## Symptoms

If a Windows NT server is running the Windows Internet Naming Service (WINS) and is participating in WINS database replication on the network, special consideration must be taken configuring where the WINS server points to for its own name resolution (this parameter is set in the Network section of Control Panel, in the Configuration section of TCP/IP Protocol).

We recommend that a WINS server point to itself as Primary WINS in the TCP/IP configuration. If you try to specify the same WINS address in the Secondary WINS address, you receive an error message:  
> The WINS server is already in the list.

The configuration can be set by using the registry. However, because the address is already entered, you don't have to add it again.

## Workaround

We recommend that a WINS server always point to itself as Primary WINS only. This configuration avoids split registrations and other problems.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed at the beginning of this article.

## More information

When any WINS enabled computer is booted, it must register different kinds of services with WINS. Commonly a computer has a Primary and Secondary WINS address configured in the TCP/IP setup. If the Primary WINS doesn't respond to the registrations, the computer tries the Secondary WINS.

Generally, most clients and servers should be configured with a Primary and Secondary WINS address, however caution must be taken with how a WINS server is itself configured. A WINS server eventually registers its services in its own local WINS database, regardless of whether it points to itself or not (either Primary, Secondary, or none). Registering with itself and another WINS server can cause problems when it comes to replication and renewal of these entries.

For example, if you have a WINS server (Srv1) that points to itself as Primary and points to another WINS as Secondary (Wins2). When Srv1 is booted, it usually tries to register its services before its own WINS Service is started. Since those registrations fail, it tries to register them at Wins2. If Wins2 is available, it accepts the registration requests. However, not all the services are registered at Wins2, because as these registration requests are made, Srv1 continues to check its local WINS service. Once the service is running, it switches back to it and continues registering locally.

After replication has occurred between Srv1 and Wins2, both databases show this ownership:

Srv1: Owns his Srv1<20>, and Domain<1c> (if it is a domain controller)  
Wins2: Owns all other Srv1 registrations, and also owns Domain<1c> from Srv1

It potentially problematic condition is referred to as split registration.

At this point, Srv1 has reverted to re-registering locally, however it takes a while before you can see it. Meanwhile, Srv1 and Wins2 are replicating the split registration mappings to other WINS servers. Eventually these replicas should be reconciled at the remote WINS (that is, the Wins2 replicas are replaced by the newer Srv1 replicas). However, before reconciliation is finished, client connection problems may have occurred, including the inability to connect to a WINS server that split its registration (in this example, Srv1), or the inability to resolve the domain<1c> name that Srv1 registered.

The exact conditions that lead to failure are varied. If your WINS servers are running Windows NT version 3.51 with Service Pack 4 (or greater), these conditions should only be temporary. However, the problem may be more severe depending on your replication scheme or if you're running pre- Service Pack 4 WINS servers.

Another faulty configuration is setting a remote IP address (in this example, Wins2) as Primary while setting the local WINS (Srv1) as Secondary. In this case, Srv1 will eventually stop refreshing its NetBIOS lease at Wins2, and will begin registering locally. Depending on your WINS replication scheme, which may cause connection problems.
