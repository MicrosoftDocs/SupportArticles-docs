---
title: Avoid registering unwanted Network Interface Controllers (NICs) in Domain Name System (DNS)
description: This article provides a solution to an issue where unwanted NICs are registered in DNS on a multihomed domain controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Steps to avoid registering unwanted NICs in DNS on a multihomed domain controller

This article provides a solution to an issue where unwanted network interface controllers (NICs) are registered in Domain Name System (DNS) on a multihomed domain controller (DC).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2023004

## Symptoms

On Domain Controllers with more than one NIC where each NIC is connected to separate Network, there's a possibility that the Host A DNS registration can occur for unwanted NICs.

If one of the following conditions is true, the client will fail to contact the DC causing authentication and many other issues:

- The client queries for DC's DNS records, and gets an unwanted record.
- The client queries for DC's DNS records, and gets a record of a different network that isn't reachable to the client.

## Cause

The DNS server will respond to the query in a round robin fashion if the DC has multiple NICs registered in DNS. The DNS will serve the client with all the records available for that DC.

To prevent this issue, we need to make sure the unwanted NIC address isn't registered in DNS.

Below are the services that are responsible for Host A record registration on a DC:

1. `Netlogon` service
2. DNS server service (if the DC is running DNS server service)
3. DHCP client or DNS client (2003/2008)

If the NIC card is configured to register the connection address in DNS, then the DHCP/DNS client service will register the record in DNS. Unwanted NIC should be configured not to register the connection address in DNS.

If the DC is running DNS server service, then the DNS service will register the interface "Host A" record that it has set to listen on. The Zone properties, the **Name server** tab list out the IP addresses of interfaces present on the DC. If it has listed both the IPs, then DNS server will register "Host A" record for both the IP addresses.  

We need to make sure only the required interface listens for DNS and the zone properties, name server tab has required IP address information.

## Resolution

To avoid this problem, perform the following three steps (It's important that you follow all the steps to avoid the issue).

1. Under **Network Connections Properties**:

    On the unwanted NIC TCP/IP Properties, select **Advanced** > **DNS**, and then unselect **Register this connections Address** in DNS.

1. Open the DNS server console, highlight the server on the left pane, and then select **Action** > **Properties**. On the **Interfaces** tab, select **listen on only the following IP addresses**. Remove unwanted IP address from the list.

1. On the Zone properties, select **Name server** tab. Along with FQDN of the DC, you'll see the IP address associated with the DC. Remove unwanted IP address if it's listed.  

After doing it, delete the existing unwanted Host A record of the DC.

## More information

**Hardware details**: IBM servers with two NICs.

1. Ethernet NIC
1. USB NIC (it also can be considered for multiple Ethernet NICs)
