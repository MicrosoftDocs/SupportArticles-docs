---
title: 'Troubleshoot DNS server for DirectAccess server troubleshooting'
description: This article introduces how to troubleshoot DNS server issues for DirectAccess server troubleshooting.
ms.date: 01/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: asvaidya, anupamk
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DirectAccess Server console: DNS

Name resolution and proper DNS server configuration are vital to the functionality of DirectAccess.

## "DNS: Not working properly" error

When performing initial configuration of DirectAccess or making any subsequent changes to the DNS server configuration after initial configuration, you may notice the operations status for DNS indicates critical and that the operations state shows Server responsiveness.

:::image type="content" source="media/troubleshoot-directaccess-server-console-dns/dns-server-error.png" alt-text="Screenshot of the DNS server responsiveness error." border="false":::

Details:  
> DNS: Not working properly

Error:  
> None of the enterprise DNS servers \<ipv6_address_of_the_DNS_server\> used by DirectAccess clients for name resolution are responding.

This may affect DirectAccess client connectivity to corporate resources.

### Causes

This issue occurs because enterprise DNS servers \<ipv6_address_of_the_DNS_server\> are not responding.

### Resolution

To resolve this issue, ensure the DNS server is online and responding to name resolution requests. Then, verify DNS server settings.

> [!Note]
> Operations status is updated in accordance with the configured refresh interval. Clicking Refresh to manually update status does not update the status of the DNS resolution and ICMP reachability checks.

There are several things that can contribute to this problem. A common cause is an error occurred when you assign a DNS server to a specific DNS suffix. An inexperienced DirectAccess administrator may specify the IPv4 address of an internal corporate DNS server, which is incorrect. The DNS server IPv4 address should be the address assigned to the DirectAccess server’s internal network interface.

The best way to ensure that the DNS server is configured correctly for DirectAccess is to delete the existing entry and then select **Detect**.

:::image type="content" source="media/troubleshoot-directaccess-server-console-dns/detect-dns-server-correct-for-directaccess.png" alt-text="Screenshot of XXXXXX." border="false":::

An IPv6 address will be added automatically. This is the IPv6 address of the DNS64 service that is running on the DirectAccess server, which is how the DNS server should be configured for proper DirectAccess operation.

:::image type="content" source="media/troubleshoot-directaccess-server-console-dns/ipv6-address-of-dns64-service.png" alt-text="Screenshot of XXXXXX." border="false":::

After the changes have been saved and applied, the DNS server should once again respond, and the status should return to **Working**.

## DNS64

Direct Access is an IPv6 only technology. Direct Access clients talk to DirectAccess server by using IPv6 technologies. This communication happens by using IPv6 transition technologies, for example, IPV6 encapsulation in IPv4 packets.

Communication between client to server happens by using IPv6. Name lookup also happens using IPv6 and AAAA query. So, if an internal server has IPv6 address, it is easy for the client to start communication. 

However, if the internal server is only IPv4 configured, NAT64 or DNS64 are needed when you want to have IPv6 communication over IPv4 network.

You can verify the DNS64 configuration on the server by checking the following registry key:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\RemoteAccess\Config\DefaultDnsServers`

Run the `netsh int ipv6` command to show addresses. We can see the bindings of these addresses to the interfaces. Normally in a behind NAT deployment with two interfaces the binding should be visible on the internal interface.
