---
title: DirectAccess clients connection error 0x274d
description: Provides a solution to the error 0x274d that occurs when DirectAccess clients connect to DirectAccess Server by using Internet Protocol over Secure Hypertext Transfer Protocol (IP-HTTPS).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# DirectAccess clients are unable to connect over IP-HTTPS with error 0x274d or 0x2afc

This article provides a solution to the error 0x274d that occurs when DirectAccess clients connect to DirectAccess Server by using Internet Protocol over Secure Hypertext Transfer Protocol (IP-HTTPS).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3052855

## Symptoms

DirectAccess clients may not be able to connect to DirectAccess Server by using IP-HTTPS connections or resolve the DirectAccess public hostname.

When you run the `netsh interface http show interface` command, the output is as follows:

> **Error:** 0x274d or 0x2afc  
**Translates to** : The requested name is valid, but no data of the requested type was found

or

> No connection could be made because the target machine actively refused it.

Removing the DirectAccess GPO allows the client to resolve the DirectAccess public hostname.

Running the command `netsh namespace show policy` on a client will display a policy for the .contoso.com namespace.

In this policy the DirectAccess (DNS Servers) entry will be set to the internal IPv6 interface of the DirectAccess server, typically ending with 3333::1.

## Cause

> Error: 0x2AFC  
Role: Client  
URL: `https://da.contoso.com/IPHTTPS`  
Last Error Code: 0x2AFC  
Interface Status: Failed to connect to IPHTTPs server; Waiting to reconnect.  
0x2AFC translates to:  
WSANO_DATA  
\# The requested name is valid, but no data of the requested type was found.  
WSANO_DATA  
\# Successfully returned a NULL value.

There are several reasons this error may occur:

- A proxy server is blocking the connection.
- Inability to resolve the name of the IP-HTTPS server (DirectAccess server) mentioned in the IP-HTTPS interface URL.
- Client-side or server-side firewall may be blocking the connection to the IP-HTTPS Server (DirectAccess server).
- NAT device is configured incorrectly (if a behind-edge scenario is being used).
- All connectivity is fine, but the server does not have the IPv6 prefix published, or server-side IP-HTTPS is set to disabled.

> Error: 0x274D  
Role: Client  
URL: `https://da.contoso.com/IPHTTPS`  
Last Error Code: 0x274D  
Interface Status: Failed to connect to IPHTTPs server; Waiting to reconnect.  
0x274D translates to:  
WSAECONNREFUSED  
\# No connection could be made because the target machine actively refused it.

This error is caused by the following causes:

- Inability to resolve the name of the IP-HTTPS server (DirectAccess server) mentioned in the IP-HTTPS interface URL
- Incorrectly configured Name Resolution Policy Table (NRPT)
- Client-side Firewall may be blocking the IP-HTTPS connection
- The internal domain and external DNS entry used by DirectAccess are both in the same namespace (for example, *.contoso.com)

## Resolution

To resolve this issue, we must add an entry to the NRPT instructing the client to use its internet DNS to resolve the public hostname of the DirectAcess server. To do this, on the DirectAcess server, open the Remote Access Management Console, under Configuration select DirectAccess and VPN, find the Infrastructure Servers section under Step 3 and click Edit.

In the Infrastructure Server Setup window, select DNS on the left-hand side to view the NRPT settings of the DirectAccess deployment. The last row will show an asterisk (*) on the left-hand side, right-click this row and select new. In the DNS Server Addresses window, enter the public hostname of the DirectAccess server as the DNS suffix (for example, DA.contoso.com), don't attempt to detect or validate the suffix. Instead leave the rest of the information blank and click apply.

This will create an entry with a Name Suffix and no DNS Server Address, telling the clients to use their own internet DNS to resolve that name. Finish the Infrastructure setup process and update the GPO by clicking Finish in the Remote Access Setup window. Apply the new GPO to the clients and attempt to resolve the hostname of the DirectAccess server.

## More information

DirectAccess clients use multiple methods to connect to the DirectAccess server, which enables access to internal resources. Clients have the option to use either Teredo, 6to4, or IP-HTTPS to connect to DirectAccess. This also depends on how the DirectAccess server is configured.

When the DirectAccess client has a public IPv4 address, it will try to connect by using the 6to4 interface. However, some ISPs give the illusion of a public IP Address. What they provide to end users is a pseudo public IP address. What this means is that the IP address received by the DirectAccess client (a data card or SIM connection) might be an IP from the public address space, but in reality is behind one or more NATs.

When the client is behind a NAT device, it will try to use Teredo. Many businesses such as hotels, airports, and coffee shops do not allow Teredo traffic to traverse their firewall. In such scenarios, the client will fail over to IP-HTTPS. IP-HTTPS is built over an SSL (TLS) TCP 443-based connection. SSL outbound traffic will most likely be allowed on all networks.

Having this in mind, IP-HTTPS was built to provide a backup connection that is reliable and always reachable. A DirectAccess client will make use of this when other methods (such as Teredo or 6to4) fail.

More information about transition technologies can be found at [IPv6 Transition Technologies](/previous-versions//bb726951(v=technet.10)).
