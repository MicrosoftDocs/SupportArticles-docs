---
title: Configure a subnetted reverse lookup zone
description: Describes how to configure a subnetted reverse lookup zone.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, drewba
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# How to configure a subnetted reverse lookup zone

This article describes how to configure a subnetted reverse lookup zone.

_Original KB number:_ &nbsp; 174419

## Summary

>[!NOTE]
>Creating delegated subnetted reverse lookup zones is not a trivial task. It is important to understand how Domain Name System (DNS) zones work before attempting to create subnetted reverse lookup zones. There are numerous notes throughout this document to which you should pay close attention. It is recommended that you first attempt these procedures in a test environment before deploying them on a live network because of the ease with which mistakes can occur during configuration.

The rapid growth of the Internet community created the need to subnetwork full IP networks into smaller portions. In a subnetted environment, DNS servers can easily delegate authority of forward lookup zones because they are independent of the underlying subnetted infrastructure. However, because of the inverse structure of reverse lookup zones and their strict reliance on the specific subnet structure, delegation of these zones requires special considerations. The Internet Engineering Task Force (IETF) has created RFC 2317, "Classless IN-ADDR.ARPA Delegation," which discusses these considerations.

Delegating subnetted reverse lookup zones complements the ability to delegate forward lookup zones. This flexibility in zone ownership allows you, as the administrator of a parent domain, to delegate control of both a child subdomain and a corresponding subnet of addresses to another administrator. Conversely, as the administrator of a child domain, you now have the control necessary to make changes to both DNS host (A) records or IP address (PTR) records without having to make a request for change through the parent domain.

This article discusses how to configure delegated subnetted reverse lookup zones for a Microsoft Windows DNS server.

>[!NOTE]
>Simply because your network environment is subnetted does not imply that your DNS server must be configured in the manner described in this article. Creating delegated subnetted reverse lookup zones is an administrative choice only; it is not solely dictated by the underlying subnetted infrastructure.

## More information

A "classful" IP addressing scheme is one that does not break down an IP network into smaller segments. For example, a class C address of 192.168.1.0 with a subnet mask of 255.255.255.0 is a classful IP addressing scheme.

A "classless" IP addressing scheme is one that uses a subnet mask to divide an IP address into smaller segments. For example, a class C address of 192.168.1.0 with a subnet mask of 255.255.255.192 is a classless IP addressing scheme. Along with this network, you would also have the following IP network addresses: 192.168.1.64, 192.168.1.128, and 192.168.1.192.

When subnetting IP networks, additional bits are taken from the host portion of the IP address and given to the network portion. This is defined by adding additional bits to the subnet mask. The value 11111111.11111111.11111111.00000000 shows us a classful subnet mask for a Class C network of 255.255.255.0, while the value 11111111.11111111.11111111.11000000 illustrates the classless subnet mask of 255.255.255.192. Therefore, from the example above, we know that:

|If the subnet mask is| The subnet mask bit-count is  
| --------------------- |---------------------------- |  
 255.255.255.128 |25  
 255.255.255.192 |26  
 255.255.255.224 |27  
 255.255.255.240 |28  
 255.255.255.248 |29  
 255.255.255.252 |30  
 255.255.255.254 |31  

### The syntax

Delegated subnetted reverse lookup zones can be used to transfer administrative control between any parent and child IN-ADDR.ARPA zone in the DNS. Common configurations involve an ISP (Parent) delegating to a Customer Site (Child) or a Corporate Headquarters (Parent) delegating to a Corporate Remote Site (Child). Because the ISP scenario is most typical, it will be used in the following example.

When creating classless reverse lookup zones, you may use notation such as the following ones:  

\<subnet>-\<subnet mask bit count>.100.168.192.in-addr.arpa or

\<subnet>/\<subnet mask bit count>.100.168.192.in-addr.arpa or

\<subnet>.\<subnet mask bit count>.100.168.192.in-addr.arpa or

SubnetX\<subnet>.100.168.192.in-addr.arpa (where X is the subnet number assigned by parent) or

\<subnet>.100.168.192.in-addr.arpa
For example:64-26.100.168.192.in-addr.arpa or

64/26.100.168.192.in-addr.arpa or

64.26.100.168.192.in-addr.arpa or

Subnet3.100.168.192.in-addr.arpa or

64.100.168.192.in-addr.arpa  
This indicates that the subnetted reverse lookup zone is the 64 subnetwork that is using 26 bits for its subnet mask.

>[!NOTE]
>If you will be performing any Zone Transfers, between parent and child you need to check the syntax of the files that will be transferred between DNS servers. Not all versions of DNS servers will support the various syntax methods defined in the RFC (the hyphen, the slash, etc.). Microsoft DNS will support any of these methods.

>[!NOTE]
>Whichever syntax is chosen in the Parent domain MUST be identical to the syntax used in the Child domain.

### The checklist

Filling out the following checklist will make walking through this document easier.

|Parent Checklist| Child Checklist|  
|---------------- |---------------|  
|\<Parent DNS server name>|\<Child DNS server name>|  
|\<Parent DNS server IP> |\<Child DNS server IP>|  
|\<subnet mask> |\<subnet mask>|  
|\<subnet>\<syntax>\<subnet mask bit count> |\<subnet>\<syntax>\<subnet mask bit count>|

Here is the example we will use of an ISP who has taken a Class C range and subnetted it into four subnets by using the 255.255.255.192 subnet mask. The four subnets are 192.168.100.0, 192.168.100.64, 192.168.100.128 and 192.168.100.192. The subnet being delegated to the Customer Site is the second range, that is the 64 network using 65-126 for the host IP addresses.

|Parent Checklist |Child Checklist|
|---------------- |---------------|
| `NS.microsoft.com` |`NS1.msn.com`|
 |192.168.43.8 |192.168.100.126|
 |255.255.255.192 |255.255.255.192|
 |0-26 |64-26|
 |64-26
 |128-26
 |192-26

### The parent walkthrough for Windows DNS Server environments

1. Launch the DNS snap-in in Microsoft Management Console (MMC).
2. Under **View**, change from standard view to **Advanced**.
3. Right-click **Reverse Lookup Zones**, and select **New Zone**.
4. Select **Zone Type** of Active Directory Integrated or Standard Primary, click **Next**.
5. Type in either the non-subnetted network ID (for example, 192.168.100) or the reverse lookup zone name (for example, 100.168.192.in-addr.arpa) for the non-subnetted class C address, select **Next**.
6. If you selected standard primary, you can either create a new zone file or if there is an existing zone file, you can place it in the %systemroot%\system32\dns directory and the server will read it from that directory.
7. Once the primary parent zone is created, right-click the newly created zone, and select **New delegation**. Add the naming convention you choose as the parent for the delegated child zone, for example, 64-26. Be sure to communicate that naming convention to the administrator of the child domain. See examples.
8. Add the CNAME (ALIAS) RR (resource records) for the devices within each of the subnets. For example:

   `65 CNAME 65.64-26.100.168.192.in-addr.arpa.`

   > [!NOTE]
   > Dynamic updates for subnetted reverse lookups do not work. The records will need to be added manually. Using "Create Associated PTR record" checkbox will not work for the subnetted reverse lookup zone when "A" (host) record is created through GUI.

### The child walkthrough for Windows DNS Server environments

1. Launch the DNS snap-in in Microsoft Management Console (MMC).
2. Under **View**, change from standard view to **Advanced**.
3. Right-click **Reverse Lookup Zones**, and select **New Zone**.
4. Select the **Zone Type**: either **Active Directory-Integrated** or **Standard Primary**, and select **Next**.
5. Select the option for the **Reverse Lookup Zone Name**. Enter the name of the reverse lookup zone, for example, `64-26.100.168.192.in-addr.arpa` for the subnetted Class C address. Make sure to follow the naming convention supplied by the administrator of the parent domain. Select **Next**.
6. If you selected **Standard Primary**, you can either:
   - Create a new zone file, or
   - Use an existing zone file by placing it in the `%systemroot%\system32\dns` directory, where the server reads it from.
7. Manually add your PTR (pointer) records to the reverse lookup zone. For example:  
   `65 PTR host65.msn.com`
8. If needed, configure the child DNS server (hosting the delegated zone) to forward requests to the parent DNS servers. This allows the child DNS servers to resolve records in zones hosted by the parent DNS servers.

### Reverse Lookup Zone Configuration

If the Reverse Lookup Zone isn't an Active Directory-integrated zone (file-based zone), you can open the zone file located at %systemroot%\system32\dns\*Zonename.in-addr.arpa*. The file appears as shown in the following example:

#### Sample zone files

#### Parent subnetted reverse lookup zone file

>;  
; Database file 100.168.192.in-addr.arpa.dns for 100.168.192.in-addr.arpa zone.  
; Zone version: 4  
;  
>
>@ IN SOA `NS.microsoft.com`. `administrator.microsoft.com`. (  
 4 ; serial number  
 3600 ; refresh  
 600 ; retry  
 86400 ; expire  
 3600 ); minimum TTL  
>
>;  
; Zone NS records  
;  
>
>@ `NSNS.microsoft.com`.  
>
>;  
; Zone records  
;  
>
>;  
; Delegated sub-zone: 64-26.100.168.192.in-addr.arpa.  
;  
64-26 `NSNS1.msn.com`.  
; End delegation  
>
>65 CNAME65.64-26.100.168.192.in-addr.arpa.  
66 CNAME66.64-26.100.168.192.in-addr.arpa.  
67 CNAME67.64-26.100.168.192.in-addr.arpa.  
...  
126 CNAME67.64-26.100.168.192.in-addr.arpa.  

> [!NOTE]
> The ellipse, "...", indicates the unique IP addresses and hosts between 67 and 126. Ellipses are not valid in the file.

#### Child subnetted reverse lookup zone file

>;  
; Database file 64-26.100.168.192.in-addr.arpa.dns for 64-26.100.168.192.in-addr.arpa zone.  
; Zone version: 1  
;  
>
>@ IN SOA `NS1.msn.com`. `administrator.msn.com`. (  
 1 ; serial number  
 3600 ; refresh  
 600 ; retry  
 86400 ; expire  
 3600 ); minimum TTL  
>
>;  
; Zone NS records  
;  
>
>@ `NSNS1.msn.com`.  
>
>;  
; Zone records  
;  
>
>65 PTR `host65.msn.com`.  
66 PTR `host66.msn.com`.  
67 PTR `host67.msn.com`.  
...  
126 PTR `host126.msn.com`.  

> [!NOTE]
> Again, in the above examples, the ellipses indicate the omitted IP addresses between 67 and 126. Ellipses are not valid in the file.
