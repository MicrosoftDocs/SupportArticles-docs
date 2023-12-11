---
title: Recommendations for Domain Name System (DNS) client settings
description: Describes recommendations for configuring DNS client settings.
ms.date: 12/11/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
ms.technology: networking
---
# Best practices for DNS client settings in Windows Server

This article describes best practices for the configuration of Domain Name System (DNS) client settings. The recommendations in this article are for the installation of supported Windows Server environments where there is no previously defined DNS infrastructure.

_Original KB number:_ &nbsp; 825036

## Domain controller with DNS installed

On a domain controller that also acts as a DNS server, Microsoft recommends that you configure the domain controller's DNS client settings according to these specifications:  

- If the server is the first and only domain controller that you install in the domain, and the server runs DNS, configure the DNS client settings to point to that first server's IP address. For example, you must configure the DNS client settings to point to itself. Do not list any other DNS servers until you have another domain controller hosting DNS in that domain.
- During the DCPromo process, you must configure additional domain controllers to point to another domain controller that is running DNS in their domain and site, and that hosts the namespace of the domain in which the new domain controller is installed. or if using a 3rd-party DNS to a DNS server that hosts the zone for that DC's Active Directory domain. Do not configure the domain controller to utilize its own DNS service for name resolution until you have verified that both inbound and outbound Active Directory replication is functioning and up to date. Failure to do so may result in DNS "Islands".  
 For more information about a related topic, click the following article number to view the article in the Microsoft Knowledge Base:

    [275278](https://support.microsoft.com/help/275278) DNS Server becomes an island when a domain controller points to itself for the `_msdcs.ForestDnsName` domain  

- After you've verified that replication has completed successfully, DNS may be configured on each Domain Controller in either of two ways, depending on the requirements of the environment. The configuration options are:
  - Configure the Preferred DNS server in TCP/IP properties on each Domain Controller to use itself as Primary DNS Server.
    - Advantages:
Ensures that DNS queries originating from the Domain Controller will be resolved locally if possible. Will minimize impact of Domain Controller's DNS queries on the network.
    - Disadvantages:
Dependent on Active Directory replication to ensure that DNS zone is up to date. Lengthy replication failures may result in an incomplete set of entries in the zone.
  - Configure all Domain Controllers to use a centralized DNS server as their Preferred DNS Server.
    - Advantages:
      - Minimizes the reliance on Active Directory replication for DNS zone updates of Domain Controller locator records. It includes faster discovery of new or updated Domain Controller locator records, as replication lag time isn't an issue.
      - Provides a single authoritative DNS server, which may be useful when troubleshooting Active Directory replication issues
    - Disadvantages:
      - Will more heavily use the network to resolve DNS queries originating from the Domain Controller
      - DNS name resolution may depend on network stability. Loss of connectivity to the Preferred DNS server will result in failure to resolve DNS queries from the Domain Controller. It may result in apparent loss of connectivity, even to locations that aren't across the lost network segment.
- A combination of the two strategies is possible, with the remote DNS server set as Preferred DNS server, and the local Domain Controller set as Alternate (or vice versa). While this strategy has many advantages, there are factors that should be considered before making this configuration change:
  - The DNS client does not utilize each of the DNS servers listed in TCP/IP configuration for each query. By default, on startup the DNS client will attempt to use the server in the Preferred DNS server entry. If this server fails to respond for any reason, the DNS client will switch to the server listed in the alternate DNS server entry. The DNS client will continue to use this alternate DNS server until:
    - It fails to respond to a DNS query, or:
    - The ServerPriorityTimeLimit value is reached (15 minutes by default).  

> [!Note]
> Only a failure to respond will cause the DNS client to switch Preferred DNS servers; receiving an authoritative but incorrect response does not cause the DNS client to try another server. As a result, configuring a Domain Controller with itself and another DNS server as Preferred and Alternate servers helps to ensure that a response is received, but it does not guarantee accuracy of that response. DNS record update failures on either of the servers may result in an inconsistent name resolution experience.  

- Don't configure the DNS client settings on the domain controllers to point to DNS servers of your Internet Service Provider (ISP). If you configure the DNS client settings to point to your ISP's DNS servers, the Netlogon service on the domain controllers doesn't register the correct records for the Active Directory directory service. With these records, other domain controllers and computers can find Active Directory-related information. The domain controller must register its records with its own DNS server.

To forward external DNS requests, add the ISP's DNS servers as DNS forwarders in the DNS management console. If you don't configure forwarders, use the default root hints servers. In both cases, if you want the internal DNS server to forward to an Internet DNS server, you also must delete the root "." (also known as "dot") zone in the DNS management console in the **Forward Lookup Zones** folder.

- If the domain controller that hosts DNS has several network adapters installed, you must disable one adapter for DNS name registration.

For more information about how to configure DNS correctly in this situation, click the following article number to view the article in the Microsoft Knowledge Base:

[292822](https://support.microsoft.com/help/292822) Name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS  

To verify your domain controller's DNS client settings, type the following command at a command prompt to view the details of your Internet Protocol (IP) configuration: `ipconfig /all`  
To modify the domain controller's DNS client configuration, follow these steps:  

1. Right-click **My Network Places**, and then select **Properties**.

2. Right-click **Local Area Connection**, and then select **Properties**.
3. Select **Internet Protocol (TCP/IP)**, and then select **Properties**.
4. Select **Advanced**, and then select the **DNS** tab. To configure the DNS information, follow these steps:  

      1. In the **DNS server addresses, in order of use** box, add the recommended DNS server addresses.
      2. If the **For resolution of unqualified names** setting is set to Append these DNS suffixes (in order), Microsoft recommends that you list the Active Directory DNS domain name first (at the top).
      3. Verify that the **DNS Suffix for this connection** setting is the same as the Active Directory domain name.
      4. Verify that the **Register this connection's addresses in DNS** check box is selected.
      5. Select **OK** three times.  

5. If you change any DNS client settings, you must clear the DNS resolver cache and register the DNS resource records. To clear the DNS resolver cache, type the following command at a command prompt: `ipconfig /flushdns`  
To register the DNS resource records, type the following command at a command prompt: `ipconfig /registerdns`  

6. To confirm that the DNS records are correct in the DNS database, start the DNS management console. There should be a host record for the computer name. (This host record is an "A" record in Advanced view.) There also should be a Start of Authority (SOA) record and a Name Server (NS) record that points to the domain controller.

## Domain controller without DNS installed

If you do not use Active Directory-integrated DNS, and you have domain controllers that do not have DNS installed, Microsoft recommends that you configure the DNS client settings according to these specifications:  

- Configure the DNS client settings on the domain controller to point to a DNS server that's authoritative for the zone that corresponds to the domain where the computer is a member. A local primary and secondary DNS server is preferred because of Wide Area Network (WAN) traffic considerations.
- If there's no local DNS server available, point to a DNS server that's reachable by a reliable WAN link. Up-time and bandwidth determine reliability.
- Don't configure the DNS client settings on the domain controllers to point to your ISP's DNS servers. Instead, the internal DNS server should forward to the ISP's DNS servers to resolve external names.

## Windows Server member servers

On Windows Server member servers, Microsoft recommends that you configure the DNS client settings according to these specifications:  

- Configure the primary and secondary DNS client settings to point to local primary and secondary DNS servers (if local DNS servers are available) that host the DNS zone for the computer's Active Directory domain.
- If there are no local DNS servers available, point to a DNS server for that computer's Active Directory domain that can be reached through a reliable WAN link. Up-time and bandwidth determine reliability.
- Don't configure the client DNS settings to point to your ISP's DNS servers. If you do so, you may experience issues when you try to join the Windows Server-based server to the domain, or when you try to log on to the domain from that computer. Instead, the internal DNS server should configure forwarding to the ISP's DNS servers to resolve external names.

## Windows Server non-member servers

- If you have servers that aren't configured to be part of the domain, you can still configure them to use Active Directory-integrated DNS servers as their primary and secondary DNS servers. If you have non-member servers in your environment that use Active Directory-integrated DNS, they don't dynamically register their DNS records to a zone that's configured to accept only secure updates.
- If you don't use Active Directory-integrated DNS, and you want to configure the non-member servers for both internal and external DNS resolution, configure the DNS client settings to point to an internal DNS server that forwards to the Internet.
- If only Internet DNS name resolution is required, you can configure the DNS client settings on the non-member servers to point to the ISP's DNS servers.  
