---
title: Error when you configure Primary and Secondary WINS addresses for a WINS server
description: Provides a solution to an error that occurs when you try to specify the same WINS address in the Secondary WINS address or when you set the Primary WINS address of a WINS server to another WINS server.
ms.date: 03/08/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, timball
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Error when you configure Primary and Secondary WINS addresses for a WINS server

This article provides a solution to an error that occurs when you try to specify the same Windows Internet Naming Service (WINS) address in the Secondary WINS address for a WINS server.

> [!IMPORTANT]  
> WINS is deprecated, and should no longer be used as a name resolution system.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 150737

## Symptoms

When a Windows Server computer runs the WINS service and participates in WINS database replication on the network, you have to carefully configure the destination that the WINS server uses for its own name resolution.

You can configure this setting in the Network control panel, in **TCP/IP Protocol** > **Configuration**. You can also configure this setting by using the registry (although if the address is already added, you don't have to add it again).

We recommend that a WINS server point to its own address as the Primary WINS address in the TCP/IP configuration. However, if you also try to specify the same WINS address as the Secondary WINS address, you receive an error message:  
> The WINS server is already in the list.

If you set the WINS server as its own Secondary WINS address (instead of the Primary WINS address), the WINS clients experience connection issues.

## Workaround

We recommend that a WINS server always point to itself as only the Primary WINS address, and not the Secondary WINS address. This configuration avoids split registrations and other problems.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed at the beginning of this article.

## More information

When any WINS-enabled computer starts, it registers different kinds of services with WINS. Typically, the computer has a Primary and Secondary WINS address configured in the TCP/IP setup. If the Primary WINS address doesn't respond to the registration attempts, the computer tries the Secondary WINS address.

However, when a WINS server starts, it should ideally register its own services in its own local WINS database before it connects to other WINS servers. However, the WINS server might try to register services before its own WINS service starts. If the Primary WINS address is set to a remote WINS server, or if both of the WINS addresses are set to remote WINS servers, the newly started WINS server might register its own services in a remote WINS server's database. After the local WINS service starts, the WINS server registers its services locally. However, this doesn't immediately remove the remote registrations.

This situation is a potentially problematic condition that's referred to as "split registration." Split registration can cause connection issues. Clients might not be able to connect to the newly started WINS server or its services. As the split registration replicates to other WINS servers, the likelihood of connection problems for clients increases. The exact conditions that lead to failure vary, and the severity of the issue depends on your replication scheme.

Split registration is a temporary condition. After the newly started WINS server stops registering its services remotely, the remote WINS server stops renewing the incorrect registrations. Eventually, the corrected registrations replicate throughout the system and resolve the connection issues.

### Example

Consider a WINS server (SRV1), a domain controller that runs in the `contoso.com` domain. SRV1 points to itself as the Primary WINS server and points to another WINS server (WINS2) as the Secondary WINS server. When SRV1 starts, it tries to register its services before its own WINS service starts. Because those registrations fail, it tries to register them at WINS2. If WINS2 is available, it accepts the registration requests. During this process, SRV1 continues to check its local WINS service. When SRV1 detects that its WINS service is running, it stops sending registration requests to WINS2 and handles them locally instead.

After the WINS records have replicated between SRV1 and WINS2, the databases on both servers show the following record ownership:

| Records that SRV1 owns | Records that WINS2 owns |
| --- | --- |
| `SRV1<20>` | Other registrations from SRV1 |
| `CONTOSO<1C>` | `CONTOSO<1C>` |

Because of the split registration, clients might not be able to connect to SRV1 or might not resolve the `contoso.com` domain. As the split registration replicates to other WINS servers, the likelihood of connection problems for clients increases.

Eventually, SRV1 correctly registers all of its service records locally, and WINS2 determines that it no longer owns the SRV1 registrations. The corrected registrations from both SRV1 and WINS2 replicate to the remaining WINS servers, removing the risk of connection issues.
