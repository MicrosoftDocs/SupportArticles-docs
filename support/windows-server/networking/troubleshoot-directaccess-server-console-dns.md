---
title: 
description: 
ms.date: 01/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, MASOUDH
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DirectAccess Server console: DNS

Name resolution and proper DNS server configuration are vital to the functionality of DirectAccess.

## "DNS: Not working properly" error

When performing initial configuration of DirectAccess or making any subsequent changes to the DNS server configuration after initial configuration, you may notice the operations status for DNS indicates critical and that the operations state shows Server responsiveness.

![to-be-change](to-be-added.jpg)

Details:  
> DNS: Not working properly

Error:  
> None of the enterprise DNS servers \<ipv6_address_of_the_DNS_server\> used by DirectAccess clients for name resolution are responding.

This might affect DirectAccess client connectivity to corporate resources. 

### Causes

This issue occurs because enterprise DNS servers \<ipv6_address_of_the_DNS_server\> are not responding.

### Resolution

1. Ensure the DNS server is online and responding to name resolution requests.
2. Verify DNS server settings.

> [!Note]
> Operations status is updated in accordance with the configured refresh interval. Clicking Refresh to manually update status does not update the status of the DNS resolution and ICMP reachability checks.

### More information

There are several things that can contribute to this problem, but a common cause is an error made when assigning a DNS server to a specific DNS suffix. An inexperienced DirectAccess administrator might specify the IPv4 address of an internal corporate DNS server, which is incorrect. The DNS server IPv4 address should be the address assigned to the DirectAccess server’s internal network interface. The best way to ensure that the DNS server is configured correctly for DirectAccess is to delete the existing entry and then click Detect.

An IPv6 address will be added automatically. This is the IPv6 address of the DNS64 service running on the DirectAccess server, which is how the DNS server should be configured for proper DirectAccess operation.

Once the changes have been saved and applied, the DNS server should once again respond, and the status should return to Working.

## DNS64

Direct Access is an IPv6 only technology. Direct Access clients talk to Direct Access Server using IPv6 technologies. (Don’t forget this communication happens using IPv6 transition technologies i.e., IPV6 encapsulation in IPv4 packets.). Communication between client to server happens using IPv6, Name lookup also happens using IPv6 & AAAA query. So, if an internal server has IPv6 address it is easy for the client to start communication. But if the internal server is only IPv4 configured, how will it communicate? This is where DNS64 and NAT64 come into the picture. So NAT64/DNS64 are needed when you want to have IPv6 communication over IPv4 network.

You can verify the DNS64 configuration on the server:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\RemoteAccess\Config\DefaultDnsServers`

Run the `netsh int ipv6` command to show addresses. We can see the bindings of these addresses to the interfaces. Normally in a behind NAT deployment with two interfaces the binding should be visible on the internal interface.
