---
title: How to configure DNS dynamic updates in Windows Server
description: Describes that  how to configure DNS dynamic updates in Windows Server and how to integrate DNS updates with DHCP.
ms.date: 01/18/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:dns, csstroubleshoot
ms.subservice: networking
---
# How to configure DNS dynamic updates in Windows

This article describes how to configure the DNS update functionality in Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows 10  
_Original KB number:_ &nbsp; 816592

## Summary

The DNS update functionality enables DNS client computers to register and to dynamically update their resource records with a DNS server whenever changes occur. If you use this functionality, you can reduce the requirement for manual administration of zone records, especially for clients that frequently move and use Dynamic Host Configuration Protocol (DHCP) to obtain an IP address.

Windows provides support for the dynamic update functionality as described in Request for Comments (RFC) 2136. For DNS servers, the DNS service permits you to enable or to disable the DNS update functionality on a per-zone basis at each server that is configured to load either a standard primary or directory-integrated zone.

### Windows DNS update features

The DNS service lets client computers dynamically update their resource records in DNS. When you use this functionality, you improve DNS administration by reducing the time that it requires to manually manage zone records. You can use the DNS update functionality with DHCP to update resource records when a computer's IP address is changed.

Windows provides the following features that are related to the DNS dynamic update protocol:

- Use of Active Directory directory service as a locator service for domain controllers.
- Integration with Active Directory.

    You can integrate DNS zones into Active Directory to provide increased fault tolerance and security. Every Active Directory-integrated zone is replicated among all domain controllers in the Active Directory domain. All DNS servers that are running on these domain controllers can act as primary servers for the zone and accept dynamic updates. Active Directory replicates on a per-property basis and propagates only relevant changes.
- Aging and scavenging of records.

    The DNS Server service can scan and remove records that are no longer required. When you enable this feature, you can prevent outdated records from remaining in DNS.
- Secure dynamic updates in Active Directory-integrated zones.

    You can configure Active Directory-integrated zones for secure dynamic updates so that only authorized clients can make changes to a zone or to a record.
- Administration from a command prompt.
- Enhanced name resolution.
- Enhanced caching and negative caching.
- Interoperability with other DNS server implementations.
- Integration with other network services.
- Incremental zone transfer.

### How Windows-based computers update their DNS names

By default, Windows computers that are statically configured for TCP/IP try to dynamically register host address (A) and pointer (PTR) resource records for IP addresses that are configured and used by their installed network connections. By default, all computer register records are based on the full computer name.

The primary full computer name is a fully qualified domain name (FQDN). Additionally, the primary full computer name is the primary DNS suffix of the computer that is appended to the computer name. To determine the primary DNS suffix of the computer and the computer name, right-click **My Computer**, click **Properties**, and then click **Computer Name**.

DNS updates can be sent for any one of the following reasons or events:

- An IP address is added, removed, or modified in the TCP/IP properties configuration for any one of the installed network connections.
- An IP address lease changes or renews any one of the installed network connections with the DHCP server. For example, this update occurs when the computer is started or when you use the `ipconfig /renew` command.
- You use the `ipconfig /registerdns` command to manually force an update of the client name registration in DNS.
- The computer is turned on.
- A member server is promoted to a domain controller.

When one of these events triggers a DNS update, the DHCP Client service, not the DNS Client service, sends updates. If a change to the IP address information occurs because of DHCP, corresponding updates in DNS are performed to synchronize name-to-address mappings for the computer. The DHCP Client service performs this function for all network connections on the system. This includes connections that are not configured to use DHCP.

> [!Note]
>
> - The update process for Windows-based computers that use DHCP to obtain their IP address is different from the process that is described in this section. For more information, see the "Integration of DHCP with DNS" section and the "Windows DHCP clients and DNS dynamic update protocol" section.
> - The update process that is described in this section assumes that Windows installation defaults are in effect. Specific names and update behavior is tunable when advanced TCP/IP properties are configured to use non-default DNS settings.
> - Besides the full computer name, or the primary name, of the computer, you can configure additional connection-specific DNS names and optionally register or update them in DNS.

By default, Windows registers A and PTR resource records every 24 hours regardless of the computer's role. To change this time, add the DefaultRegistrationRefreshInterval registry entry under the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TcpIp\Parameters`

The interval is set in seconds.

#### An example of how DNS updates work

Dynamic updates are typically requested when either a DNS name or an IP address changes on the computer. For example, a client named "oldhost" is first configured in system properties to have the following names:  
Computer name: oldhost  
DNS domain name of computer: `example.microsoft.com`  
Full computer name: `oldhost.example.microsoft.com`  

In this example, no connection-specific DNS domain names are configured for the computer. If you rename the computer from "oldhost" to "newhost", the following name changes occur:  
Computer name: newhost  
DNS domain name of computer: `example.microsoft.com`  
Full computer name: `newhost.example.microsoft.com`

After the name change is applied in **System Properties**, Windows prompts you to restart the computer. After the computer restarts Windows, the DHCP Client service performs the following sequence to update DNS:

1. The DHCP Client service sends a start of authority (SOA) type query by using the DNS domain name of the computer.

    The client computer uses the currently configured FQDN of the computer, such as "`newhost.example.microsoft.com`", as the name specified in this query.
2. The authoritative DNS server for the zone that contains the client FQDN responds to the SOA-type query.

    For standard primary zones, the primary server, or owner, that is returned in the SOA query response is fixed and static. The primary server name always matches the exact DNS name as that name is displayed in the SOA resource record that is stored with the zone. However, if the zone that is being updated is directory-integrated, any DNS server that is loading the zone can respond and dynamically insert its own name as the primary server of the zone in the SOA query response.
3. The DHCP Client service tries to contact the primary DNS server.

    The client processes the SOA query response for its name to determine the IP address of the DNS server that is authorized as the primary server for accepting its name. If it is required, the client performs the following steps to contact and dynamically update its primary server:

    1. The client sends a dynamic update request to the primary server that is determined in the SOA query response.

        If the update succeeds, no additional action is taken.
    2. If this update fails, the client next sends an NS-type query for the zone name that is specified in the SOA record.
    3. When the client receives a response to this query, the client sends an SOA query to the first DNS server that is listed in the response.
    4. After the SOA query is resolved, the client sends a dynamic update to the server that is specified in the returned SOA record.

        If the update succeeds, no additional action is taken.
    5. If this update fails, the client repeats the SOA query process by sending to the next DNS server that is listed in the response.

4. After the primary server that can perform the update is contacted, the client sends the update request, and the server processes it.

    The contents of the update request include instructions to add A, and possibly PTR, resource records for "`newhost.example.microsoft.com`" and to remove these same record types for "`oldhost.example.microsoft.com`". ("`oldhost.example.microsoft.com`" is the name that was previously registered.)

    The server also checks to make sure that updates are permitted for the client request. For standard primary zones, dynamic updates are not secured. Any client attempt to update succeeds. For Active Directory-integrated zones, updates are secured and performed using directory-based security settings.

Dynamic updates are sent or refreshed periodically. By default, computers send an update every twenty-four hours. If the update causes no changes to zone data, the zone remains at its current version, and no changes are written. Updates that cause actual zone changes or increased zone transfers occur only if names or addresses actually change.

> [!NOTE]
> Names are not removed from DNS zones if they become inactive or if they are not updated within the update interval of twenty-four hours. DNS does not use a mechanism to release or to tombstone names, although DNS clients do try to delete or to update old name records when a new name or address change is applied

When the DHCP Client service registers A and PTR resource records for a Windows-based computer, the client uses a default caching time-to-live (TTL) value of 15 minutes for host records. This value determines how long other DNS servers and clients cache a computer's records when they are included in a query response.

### Integration of DHCP with DNS

A Windows DHCP server can enable dynamic updates in the DNS namespace for any one of its clients that support these updates. Scope clients can use the DNS dynamic update protocol to update their host name-to-address mapping information whenever changes occur to their DHCP-assigned address. This mapping information is stored in zones on the DNS server. A Windows-based DHCP server can perform updates on behalf of its DHCP clients to any DNS server.

#### How DHCP/DNS update interaction works

You can use the DHCP server to register and update the PTR and A resource records on behalf of the server's DHCP-enabled clients. When you do this, you must use an additional DHCP option, the Client FQDN option (option 81). This option lets the client send its FQDN to the DHCP server in the DHCPREQUEST packet. This enables the client to notify the DHCP server as to the service level it requires.

The FQDN option includes the following six fields:

- Code  
Specifies the code for this option (81).
- Len  
Specifies the length of this option. (This must be a minimum of 4.)
- Flags  
Specifies the type of service.
- 0  
Client will register the "A" (Host) record.
- 1  
Client wants DHCP to register the "A" (Host) record.
- 3  
DHCP will register the "A" (Host) record regardless of the client's request.
- RCODE1  
Specifies a response code the server is sending to the client.
- RCODE2  
Specifies an additional delineation of RCODE1.
- Domain Name  
Specifies the FQDN of the client.

If the client requests to register its resource records with DNS, the client is responsible for generating the dynamic UPDATE request per Request for Comments (RFC) 2136. Then, the DHCP server registers its PTR (pointer) record.

Assume that this option is issued by a qualified DHCP client, such as a DHCP-enabled computer that is running Windows. In this case, the option is processed and interpreted by Windows Server-based DHCP servers to determine how the server initiates updates on behalf of the client.

For example, you can use any one of the following configurations to process client requests:

- The DHCP server registers and updates client information with its configured DNS servers according to the client request.

    This is the default configuration for Windows. In this mode, any one of these Windows DHCP clients can specify the way that the DHCP server updates its host A and PTR resource records. If it is possible, the DHCP server handles the client request for handling updates to its name and IP address information in DNS.

    To configure the DHCP server to register client information according to the client's request, follow these steps:
    1. Open the DHCP properties for the server or the individual scope.
    2. Click the **DNS** tab, click **Properties**, and then click to select the **Dynamically update DNS A and PTR records only if requested by the DHCP clients** check box.
- The DHCP server always registers and updates client information with its configured DNS servers.

    This is a modified configuration supported for Windows Server DHCP servers and clients that are running Windows. In this mode, the DHCP server always performs updates of the client's FQDN and leased IP address information regardless of whether the client has requested to perform its own updates.

    To configure a DHCP server to register and to update client information with its configured DNS servers, follow these steps:
    1. Open the DHCP properties for the server
    2. Click **DNS**, click **Properties**, click to select the **Enable DNS dynamic updates according to the settings below** check box, and then click **Always dynamically update DNS A and PTR records**.
- The DHCP server never registers and updates client information with its configured DNS servers.

    To use this configuration, the DHCP server must be configured to disable performance of DHCP/DNS proxied updates. When you use this configuration, no client host A or PTR resource records are updated in DNS for DHCP clients.

    To configure the server to never update client information, follow these steps:
    1. Open the DHCP properties for the DHCP server or one of its scopes on the Windows Server-based DHCP server.
    2. Click **DNS**, click **Properties**, and then clear the **Enable DNS dynamic updates according to the settings below** check box.

    By default, updates are always performed for newly installed Windows Server-based DHCP servers and any new scopes that you create for them.

### Windows DHCP clients and DNS dynamic update protocol

DHCP clients that are running Windows can interact differently when they perform the DHCP/DNS interactions. The following examples show how this process varies in different cases.

#### An example of a DHCP/DNS update interaction for Windows-based DHCP clients

Clients interact with DNS dynamic update protocol in the following manner:

1. The client initiates a DHCP request message (DHCPREQUEST) to the server. The request includes option 81.
2. The server returns a DHCP acknowledgment message (DHCPACK) to the client. The client grants an IP address lease and includes option 81. If the DHCP server is configured with the default settings, option 81 tells the client that the DHCP server will register the DNS PTR record and that the client will register the DNS A record.
3. Asynchronously, the client sends a DNS update request to the DNS server for its own forward lookup record, a host A resource record.
4. The DHCP server registers the PTR record of the client.

#### An example of a DHCP/DNS update interaction for DHCP clients that do not support DNS dynamic updates

DHCP clients that do not support the DNS dynamic update process directly cannot directly interact with the DNS server. For these DHCP clients, updates are typically handled in the following manner:

1. The client initiates a DHCP request message (DHCPREQUEST) to the server. This request does not include option 81.
2. The server returns a DHCP acknowledgment message (DHCPACK) to the client. The client grants an IP address lease, without option 81.
3. The server sends updates to the DNS server for the client's forward lookup record, the host A resource record, and sends an update for the client's PTR reverse lookup record.

### Secure dynamic updates

For Windows Server, DNS update security is available only for zones that are integrated into Active Directory. After you integrate a zone, you can use the access control list (ACL) editing features that are available in the DNS snap-in to add or to remove users or groups from the ACL for a specific zone or for a resource record.

For more information, search for the "To modify security for a resource record" topic or the "To modify security for a directory integrated zone" topic in Windows Server Help.

By default, dynamic update security for Windows Server DNS servers and clients is handled in the following manner:

1. Windows Server-based DNS clients try to use nonsecure dynamic updates first. If the nonsecure update is refused, clients try to use a secure update.

    Also, clients use a default update policy that lets them to try to overwrite a previously registered resource record, unless they are specifically blocked by update security.
2. By default, after a zone becomes Active Directory-integrated, Windows Server-based DNS servers enable only secure dynamic updates.

By default, when you use standard zone storage, the DNS Server service does not enable dynamic updates on its zones. For zones that are either directory-integrated or use standard file-based storage, you can change the zone to enable all dynamic updates. This enables all updates to be accepted by passing the use of secure updates.

> [!IMPORTANT]
> The DHCP Server service can perform proxy registration and update of DNS records for legacy clients that do not support dynamic updates. For more information, see the "Using DNS servers with DHCP" topic in Windows Server Help.

#### Enable only secure dynamic updates

1. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
2. Under **DNS**, double-click the applicable DNS server, double-click **Forward Lookup Zones** or **Reverse Lookup Zones**, and then right-click the applicable zone.
3. Click **Properties**.
4. On the **General** tab, verify that the zone type is **Active Directory-integrated**.
5. In the **Dynamic updates** box, click **Secure only**.
6. Click **OK**.

> [!NOTE]
> The secure dynamic update functionality is supported only for Active Directory-integrated zones. If you configure a different zone type, change the zone type, and then integrate the zone before you secure it for DNS updates. Dynamic update is an RFC-compliant extension to the DNS standard. The DNS update process is defined in RFC 2136, "Dynamic Updates in the Domain Name System (DNS UPDATE)".

#### Security considerations when the DHCP server does the dynamic update on behalf of the clients

You can configure a Windows Server-based DHCP server so that it dynamically registers host A and PTR resource records on behalf of DHCP clients. If you use secure dynamic updates in this configuration with Windows Server-based DNS servers, resource records may become stale.

For example, consider the following scenario:

1. A Windows Server DHCP server (DHCP1) performs a secure dynamic update on behalf of one of its clients for a specific DNS domain name.
2. Because the DHCP server successfully created the name, it becomes the owner of the name.
3. After the DHCP server becomes the owner of the client name, only that DHCP server can update the name.

In some circumstances, this scenario may cause problems. For example, if DHCP1 fails and a second backup DHCP server comes online, the backup server cannot update the client name because the server is not the owner of the name.

In another example, you may have configured multiple DHCP server or use the DHCP Failover functionality where different DHCP servers are responsible for the dynamic update of a single client. 

To help protect against nonsecure or stale records, follow these steps:

1. Create a dedicated user account in the Active Directory Users and Computers snap-in.
2. Configure every DHCP server to perform DNS dynamic updates with the user account credentials of the created dedicated account. (These credentials are the user name, the password, and the domain.)

The credentials of one dedicated user account can be used by multiple DHCP servers.

A dedicated user account is a user account whose sole purpose is to supply DHCP servers with credentials for DNS dynamic update registrations. Assume that you have created a dedicated user account and configured DHCP servers with the account credentials. Each DHCP server will supply these credentials when it registers names on behalf of DHCP clients that are using DNS dynamic update. The dedicated user account should be created in the forest where the primary DNS server for the zone to be updated resides. The dedicated user account can also be located in another forest. However, the forest that the account resides in must have a forest trust established with the forest that contains the primary DNS server for the zone to be updated.

When the DHCP Server service is installed on a domain controller, you can configure the DHCP server by using the credentials of the dedicated user account to prevent the server from inheriting, and possibly misusing, the power of the domain controller. When the DHCP Server service is installed on a domain controller, it inherits the security permissions of the domain controller. The service also has the authority to update or delete any DNS record that is registered in a secure Active Directory-integrated zone. (This includes records that were securely registered by other Windows-based computers, and by domain controllers.)

### Configure DNS dynamic updates

The dynamic update functionality that is included in Windows follows RFC 2136. Dynamic update enables clients and servers to register DNS domain names (PTR resource records) and IP address mappings (A resource records) to an RFC 2136-compliant DNS server.

#### Configure DNS dynamic updates for DHCP clients

By default, Windows-based DHCP clients are configured to request that the client register the A resource record and that the server register the PTR resource record. By default, the name that is used in the DNS registration is a concatenation of the computer name and the primary DNS suffix. To change this default name, open the TCP/IP properties of your network connection.

To change the dynamic update defaults on the dynamic update client, follow these steps:

1. In **Control Panel**, double-click **Network Connections**.
2. Right-click the connection that you want to configure, and then click **Properties**.
3. Click **Internet Protocol (TCP/IP)**, click **Properties**, and then click **Advanced**.
4. Click **DNS**.

    By default, **Register this connection's address in DNS** is selected and **Use this connection's DNS suffix in DNS registration** is not selected. This default configuration causes the client to request that the client register the A resource record and the server register the PTR resource record.
5. Click to select the **Use this connection's DNS suffix in DNS registration** check box.

    The client will then request that the server update the PTR record by using the FQDN. If the DHCP server is configured to register DNS records according to the client's request, the client registers the following records:

    - The PTR record.
    - The A record that uses the name that is a concatenation of the computer name and the primary DNS suffix.
    - The A record that uses the name that is a concatenation of the computer name and the connection-specific DNS suffix.
6. To configure the client to make no requests for DNS registration, click to clear the **Register this connection's address in DNS** check box.

#### Configure DNS dynamic updates on multihomed client computers

If a dynamic update client is multihomed, it registers all its IP addresses with DNS by default. A client is multihomed if it has more than one adapter and an associated IP address. If you do not want the client to register all its IP addresses, you can configure it not to register one or more IP addresses in the network connection properties.

To prevent the computer from registering all its IP addresses, follow these steps:

1. In **Control Panel**, double-click **Network Connections**.
2. Right-click the connection that you want to configure, and then click **Properties**.
3. Click **Internet Protocol (TCP/IP)**, click **Properties**, and then click **Advanced**.
4. Click **DNS**.
5. Click to clear the **Register this connection's address in DNS** check box.

You can also configure the computer to register its domain name in DNS. For example, if you have a client that is connected to two different networks, you can configure the client to have a different domain name on each network.

#### Configure DNS dynamic updates on a Windows Server-based DHCP server

To configure DNS dynamic update for a Windows Server-based DHCP server, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **DHCP**.
2. Right-click the appropriate DHCP server or scope, and then click **Properties**.
3. Click **DNS**.
4. Click to select the **Enable DNS dynamic updates according to the settings below** check box to enable DNS dynamic update for clients that support dynamic update.

    > [!NOTE]
    > By default, this check box is selected.
5. To enable DNS dynamic update for DHCP clients that do not support it, click to select the **Dynamically update DNS A and PTR records for DHCP clients that do not request for updates (for example, clients that are running Windows NT 4.0)** check box.
6. Click **OK**.

To configure the DHCP server to use a dedicated user account for the dynamic update, follow the steps below:

1. Click **Start**, point to **Administrative Tools**, and then click **DHCP**.
2. Right-click the appropriate DHCP server, IPv4 or IPv6 and then click **Properties**.
3. Click **Advanced** and **Credentials** .
4. Add the **User name**, **Domain** and **Password** of the created dedicated user account
5. Click **OK**.

#### Enable DNS dynamic updates to a DNS server

On a Windows Server-based DHCP server, you can dynamically update the DNS records for pre-Windows Server-based clients that cannot do it for themselves.

To enable a DHCP server to dynamically update the DNS records of its clients, follow these steps:

1. In the DHCP management console, select the scope or the DHCP server that you want to enable DNS updates for.
2. On the **Action** menu, click **Properties**, and then click **DNS**.
3. Click to select the **Enable DNS dynamic updates according to the settings below** check box.
4. To update a client's DNS records based on the type of DHCP request that the client makes, click to select **Dynamically update DNS A and PTR records only if requested by the DHCP clients**. (This update will only occur only when the client makes a request.)
5. To always update a client's forward and reverse lookup records, click to select **Always dynamically update DNS A and PTR records**.
6. Click to select the **Discard A and PTR records when lease is deleted** check box to have the DHCP server delete the record for a client when its DHCP lease expires and is not renewed.

### Disable DNS dynamic updates

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

By default, dynamic updates are configured on Windows Server-based clients. To disable dynamic updates for all network interfaces, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

3. On the **Edit** menu, point to **New**, and then click **DWORD value**.
4. Type *DisableDynamicUpdate*, and then press ENTER two times.
5. In **Edit DWORD Value**, type *1* in the **Value data** box, and then click **OK**.
6. Quit **Registry Editor**.

To disable dynamic updates for a specific interface, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\interface`
    > [!NOTE]
    > **interface** is the device ID of the network adapter for the interface that you want to disable dynamic update for.
3. On the **Edit** menu, point to **New**, and then click **DWORD value**.
4. Type *DisableDynamicUpdate*, and then press ENTER two times.
5. In **Edit DWORD Value**, type *1* in the **Value data** box, and then click **OK**.
6. Quit **Registry Editor**.
