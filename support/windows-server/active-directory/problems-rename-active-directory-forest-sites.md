---
title: You may experience problems when you rename sites in the Active Directory forest
description: Describes the problems that you may experience when you rename sites in the Active Directory forest.
ms.date: 06/18/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# You may experience problems when you rename sites in the Active Directory forest

This article describes the problems that you may experience when you rename sites in the Active Directory forest.

_Original KB number:_ &nbsp; 920718  
_Applies to:_ &nbsp; All supported versions of Windows Server

## More information

When you rename a site in the Active Directory forest, the following events occur in the background:

1. The site name change is replicated in the configuration naming context (NC) throughout the forest.
2. When the site name change is replicated on a local domain controller, the Net Logon service looks up its subnet-to-site mapping table. Thereafter, the Net Logon service informs the client computers about the new site name.
3. The Net Logon service on the domain controller then registers its new site-specific domain controller Service location (SRV) records with its authoritative Domain Name System (DNS) server.
4. The DNS server writes the new domain controller records to the zone. This new information is then replicated to other DNS servers based on the DNS or Active Directory replication schedule.
5. The client computers receive the new site name from the domain controller. The client computers then use this new site name in the DNS queries to look for domain controllers.
6. The Distributed File System (DFS) server service keeps caches of client-to-site and server-to-site mappings. These caches are named "client site cache" and "target site cache." These caches are refreshed every 12 hours, but the caches are only reliably present after 24 hours.

Because of the different time intervals that are used to update site-related information, you may experience the following problems:

- When the client computers are informed about the new site name in step 2, their DNS server may not yet have the new record registrations and will therefore return an error. The client computers will then query for records that aren't site-specific. The domain controllers that are returned from this query may only have a weak network link to the client computer. Therefore, the client computer experiences poor performance. The effect of this problem depends on the following:  

  - The replication delay of the site information in the Configuration NC
  - The delay that you experience in obtaining the new DNS records that are propagated to all DNS servers

    To force the Net Logon service to immediately register its DNS records, you can run the `nltest /dsregdns` command at the command prompt.

    > [!NOTE]
    > The Nltest tool can be obtained from the Microsoft Windows Server 2003 support tools.

    To speed up adoption of new sites especially for System Volume (SYSVOL) access, you can use the logon server as the preferred DFS server.

- When client computers search for domain-based DFS volumes, the DFS namespace servers or domain controllers examine the IP address of the client computers and their local site information. When the DFS namespace servers or domain controllers examine the IP address, they can determine the site that the client computers are in. You can also perform this mapping from the client site cache. DFS may run a query for the best alternative site by using the Windows Server 2003 closest site selection mode. The DFS server then examines the target site cache to find the servers for the site that the client computer is in, and the next best sites. Because of the delay to update the caches, the DFS server may not find the new site names in the target site cache. The DFS server then returns an incorrectly ordered list of servers to the client computer. Therefore, the client computer may contact slow servers for files. This causes poor performance.

    If the site information is completely replicated in Active Directory and DNS, you may restart all DFS namespace servers or domain controllers so that they obtain the latest server-to-site mapping.

    For more information about DFS, visit the following Microsoft Web site:

    [Distributed File System](/windows/win32/dfs/distributed-file-system)
