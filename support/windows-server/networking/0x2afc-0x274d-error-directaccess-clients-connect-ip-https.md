---
title: 0x2AFC or 0x274D error when DirectAccess clients try to connect over IP-HTTPS
description: Describes an issue that blocks DirectAccess clients from connecting to a DirectAccess server in Windows Server 2012. Error 0x2AFC or 0x274D is triggered in this situation. A resolution is provided.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# 0x2AFC or 0x274D error when DirectAccess clients try to connect over IP-HTTPS

This article provides a resolution to the error 0x2AFC or 0x274D that occurs when DirectAccess clients try to connect over IP-HTTPS.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3056560

## Symptoms

DirectAccess clients may be unable to connect to a DirectAccess server through an Internet Protocol over Secure Hypertext Transfer Protocol (IP-HTTPS) connection. Or, these clients may be unable to resolve the DirectAccess public host name.

When you run the `netsh interface http show interface` command in this situation, one of the following errors is returned:

> Error: 0x2AFC  
 Role: Client  
 URL: `https://da.contoso.com/iphttps`  
 Last Error Code: 0x2AFC  
 Interface Status: Failed to connect to IPHTTPs server; Waiting to reconnect.  
 0x2AFC translates to:  
 WSANO_DATA  
 \# The requested name is valid, but no data of the requested type was found.  
 WSANO_DATA  
 \# Successfully returned a NULL value.

> Error: 0x274D  
 Role: Client  
 URL: `https://da.contoso.com/iphttps`  
 Last Error Code: 0x274D  
 Interface Status: Failed to connect to IPHTTPs server; Waiting to reconnect.  
 0x274D translates to:  
 WSAECONNREFUSED  
 \# No connection could be made because the target machine actively refused it.

These errors mean that the requested name is valid, but no data of the requested type was found. Or, no connection could be made because the target computer actively refused it. If you remove the DirectAccess GPO, the client can resolve the DirectAccess public host name.

If you run the netsh namespace show policy command on a client, this displays a policy for the .contoso.com namespace. In this policy, the DirectAccess (DNS servers) entry is set to the internal IPv6 interface of the DirectAccess server. This entry typically ends with **3333::1**.

## Cause

- Error 0x2AFC

    This error may occur if one of the following conditions is true:

  - A proxy server is blocking the connection.
  - The name of the IP-HTTPS server (DirectAccess server) that's mentioned in the IP-HTTPS interface URL can't be resolved.
  - The client-side or server-side firewall is blocking the connection to the IP-HTTPS Server (DirectAccess server).
  - NAT device is configured incorrectly (if a behind-edge scenario is being used). NAT device is configured incorrectly (if a behind-edge scenario is being used).
  - All connectivity is fine, but the server does not have the IPv6 prefix published, or the server-side IP-HTTPS is set to disabled.

- Error 0x274D

    This error may occur if one of the following conditions is true:

  - The name of the IP-HTTPS server (DirectAccess server) that's mentioned in the IP-HTTPS interface URL can't be resolved.
  - A Name Resolution Policy Table (NRPT) is configured incorrectly.
  - The client-side firewall is blocking the IP-HTTPS connection.
  - The internal domain and external DNS entry that are used by DirectAccess are both in the same namespace (for example, *.contoso.com).

## Resolution

To resolve this issue, you have to add an entry to the NRPT that instructs the client to use its Internet DNS to resolve the public host name of the DirectAccess server. To do this, follow these steps:

1. On the DirectAccess server, open the Remote Access Management Console.
2. Under **Configuration**, select **DirectAccess** and **VPN**.
3. Locate the "Infrastructure Servers" section (under step 3 in that UI), and then click **Edit**.
4. In the Infrastructure Server Setup window, select **DNS**  on the left side to view the NRPT settings of the DirectAccess deployment. The last row displays an asterisk (*) on the left side. Right-click this row, and then click **New**.
5. In the DNS Server Addresses window, enter the public host name of the DirectAccess server as the DNS suffix (for example, `DA.contoso.com`). Do not try to detect or validate the suffix. Instead, leave the rest of the information blank, and then click **Apply**.  

    This creates an entry that has a name suffix and no DNS server address. This tells clients to use their own Internet DNS to resolve that name.
6. Finish the infrastructure setup process, and then update the GPO by clicking **Finish** in the Remote Access Setup window. Apply the new GPO to the clients, and then try to resolve the host name of the DirectAccess server.

## More information

DirectAccess clients use multiple methods to connect to the DirectAccess server, and this enables access to internal resources. Clients have the option to use Teredo, 6to4, or IP-HTTPS to connect to DirectAccess. These available options depend on how the DirectAccess server is configured.

When the DirectAccess client has a public IPv4 address, it tries to connect by using the 6to4 interface. Although some ISPs give the illusion of a public IP address, what they actually provide to end users is a pseudo-public IP address. This means that the IP address that's received by the DirectAccess client (a data card or SIM connection) might be an IP from the public address space, but in reality it's behind one or more NATs.

When the client is behind a NAT device, it tries to use Teredo. Many businesses such as hotels, airports, and coffee shops do not allow Teredo traffic to traverse their firewalls. In such scenarios, the client fails over to IP-HTTPS. IP-HTTPS is built over an SSL (TLS) TCP 443-based connection. SSL outbound traffic will most likely be permitted on all networks.

Having this in mind, IP-HTTPS was built to provide a backup connection that is reliable and always reachable. A DirectAccess client will use IP-HTTPS failover when other methods (such as Teredo or 6to4) fail.

For more information about transition technologies, see [IPv6 transition technologies](/previous-versions//bb726951(v=technet.10)).
