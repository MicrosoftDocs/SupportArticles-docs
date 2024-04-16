---
title: Troubleshoot DNS server for DirectAccess server
description: This article discusses how to troubleshoot DNS server issues for DirectAccess server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Remote access (DirectAccess), csstroubleshoot
---
# Troubleshoot DirectAccess Server console: DNS

Name resolution and correct DNS server configuration are vital to the functionality of DirectAccess.

## "DNS not working properly" error

When you first configure of DirectAccess or make any later changes to the DNS server configuration, you might notice that the operations status for DNS is shown as **Critical** and the operations state is shown as **Server responsiveness**.

:::image type="content" source="media/troubleshoot-directaccess-server-console-dns/dns-server-error.png" alt-text="Screenshot of the DNS server responsiveness error." :::

> DNS: Not working properly  
> Error:  
> None of the enterprise DNS servers \<ipv6_address_of_the_DNS_server\> used by DirectAccess clients for name resolution are responding.

This issue can affect DirectAccess client connectivity to corporate resources.

### Cause

- An error occurs when you assign a DNS server to a specific DNS suffix. If the DirectAccess administrator specifies the IPv4 address of an internal corporate DNS server, this is incorrect. The DNS server IPv4 address should be the address that's assigned to the DirectAccess server’s internal network interface.
- Enterprise DNS servers \<ipv6_address_of_the_DNS_server\> aren't responding.

### Resolution

To resolve this issue, make sure that the DNS server is online and responding to name resolution requests. Then, verify the DNS server settings.

> [!Note]
> The operations status is updated according to the configured refresh interval. Clicking **Refresh** to manually update status does not update the status of the DNS resolution and the ICMP reachability checks.

The best way to make sure that the DNS server is configured correctly for DirectAccess is to delete the existing entry, and then select **Detect**.

:::image type="content" source="media/troubleshoot-directaccess-server-console-dns/detect-dns-server-correct-for-directaccess.png" alt-text="Screenshot of clicking detect in DNS Server Addresses." :::

An IPv6 address will be added automatically. This is the IPv6 address of the DNS64 service that is running on the DirectAccess server. This is how the DNS server should be configured for correct DirectAccess operation.

:::image type="content" source="media/troubleshoot-directaccess-server-console-dns/ipv6-address-of-dns64-service.png" alt-text="Screenshot of IPv6 that is added automatically." :::

After the changes are saved and applied, the DNS server should respond again, and the status should return to **Working**.

## DNS64 error

DirectAccess is an IPv6 only technology. DirectAccess clients talk to the DirectAccess server by using IPv6 technologies. This communication uses IPv6 transition technologies. For example, it uses IPV6 encapsulation in IPv4 packets.

Communication between client to server occur by using IPv6. Name lookup also occurs by using IPv6 and a AAAA query. Therefore, if an internal server has an IPv6 address, the client can easily start communication.

However, if the internal server has only IPv4 configured, NAT64 or DNS64 are required to have IPv6 communication over an IPv4-based network connhection.

You can verify the DNS64 configuration on the server by checking the following registry key:  

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\RemoteAccess\Config\DefaultDnsServers`

Run the `netsh int ipv6` command to show addresses. You can see the bindings of these addresses to the interfaces. In a behind-NAT deployment that has two interfaces, the binding would typically be visible on the internal interface.
