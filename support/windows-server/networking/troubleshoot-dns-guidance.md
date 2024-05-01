---
title: Guidance for troubleshooting DNS
description: Introduces general guidance for troubleshooting scenarios related to DNS.
ms.date: 03/13/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# DNS troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806264" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common DNS issues.

This solution is designed to help you troubleshoot Domain Name System (DNS) scenarios. You can sort DNS troubleshooting issues into server-side and client-side categories.

## Troubleshooting checklist

### Server-side issues

- IP configuration
- DNS server
- Authoritative data
- Recursion
- Zone transfer

### Client-side issues

- IP configuration
- Network connectivity

## Common issues and solutions

### Support policy for DNS client-side caching on DNS clients

Windows contains a client-side DNS cache. We recommend that you don't disable DNS client-side caching on DNS clients. A configuration in which DNS client-side caching is disabled isn't supported.

Microsoft doesn't guarantee that a resolution will be found for issues that involve unsupported devices or configurations. If no resolution is found, the cost of an investigation into the incident isn't refunded. If it's not agreed that a solution isn't guaranteed, Microsoft Support won't fix the issue and will refund the cost of investigating the incident.

### DNS records are missing in a DNS zone

This issue can have any one of the following causes.

#### DNS scavenging is misconfigured

If DNS records go missing from DNS zones, scavenging is the most common cause. Even Windows-based computers that have statically-assigned DNS servers register their records every 24 hours. Check whether the no-refresh and refresh intervals are too low. For example, if these values are both less than 24 hours, you lose DNS records.

To troubleshoot this issue and to understand no-refresh and refresh intervals, see [Using DNS aging and scavenging](/previous-versions/windows/it-pro/windows-server-2003/cc757041%28v=ws.10%29).

#### Host "A" record is deleted when the IP address is changed

Sometimes, the host "A" record is deleted on the original DNS server after the host "A" record is registered on the newly configured DNS server IP address (Active Directory Integrated DNS). From a user perspective, anything that depends on name resolution is broken. When the DNS server IP address is changed on the client, the client sends a Start of Authority (SOA) update to delete its "A" record from the previous DNS server. Then, it sends another update to register its "A" record to the new DNS server.

The trouble occurs in Active Directory-integrated zones. Issues occur when the DNS Server IP address is changed on the client. When the IP address changes, the client sends a registration request to the new server, and sends a deletion request to the previous server. Because both servers are already synced, the records aren't registered. On the previous server, the DNS service deletes the "A" record, and then the deletion replicates to the new server. As a result, the record is deleted on both servers.

#### DHCP clients that use DHCP Option 81 unregister host "A" records during host "AAAA" registration

This issue occurs if DHCP client computers use ISATAP or 6to4 network adapters, and both the DNS clients and DNS servers are configured to dynamically update DNS records. Because of this configuration, DHCP Option 81 (also known as the *Client FQDN option*) is enabled on both the clients and the servers. In this situation, the DHCP server might create the client's DNS "A" record (IPv4). Then the client creates its "AAAA" (IPv6) record. However, as part of this operation, the client first sends an updated "A" record that has a time-to-live (TTL) of **0**. As a result, the DNS server deletes the client's "A" record while it registers the "AAAA" record.

To work around this behavior, avoid configuring DHCP clients that use these adapters to dynamically update DNS records when the DHCP servers are already configured to do so.

> [!NOTE]  
> For more information about DHCP Option 81, see [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md). That article describes a different issue, but explains more about DHCP Option 81.

#### The DNS Dynamic Update Protocol update to existing DNS records fails

The DNS Dynamic Update Protocol update to existing records fails. Because of this issue, the DNS scavenging process considers the records to be aged, and it deletes them.

In the case of a service that requires a SRV record, the local Netlogon service logs "event ID 577*X*" events when it can't register SRV records. For example, if the Netlogon service of a domain controller triggers a dynamic update for its LDAP SRV record, and that update fails, the Netlogon service logs an event on the domain controller. Other events are logged for registration failures of host "A" and PTR records. Check the System event logs on the DNS servers and any other affected computers for these failures. The client that registers these records might log such events, or the DHCP servers that register the records on the client's behalf might log them. These additional events can provide insight into the cause of the failure.

#### Converting an active dynamic lease to a reservation deletes the "A" and PTR records for that client

This behavior is by design. The DNS records ("A" or PTR) are automatically updated during the next DHCP renewal request from the client.

### Avoid registering unwanted network adapters in DNS

If a network adapter is configured to register the connection address in DNS, then the DHCP/DNS client services register the record in DNS. If a computer has a network adapter that you don't want to register, follow these steps:

1. In **Network Connections**, open the properties for the unwanted network adapter, open TCP/IP properties, select **Advanced** > **DNS**, and then clear the **Register this connections Address in DNS** checkbox.
2. In the left pane, open the DNS server console, highlight the server, and then select **Action** > **Properties**.
3. On the **Interfaces** tab, select **listen on only the following IP addresses**. Remove the unwanted IP address from the list.
4. On the **Zone** properties page, select the **Name server** tab. In addition to the FQDN of the domain controller, this tab lists the IP address that's associated with the domain controller. Remove the unwanted IP address if it's listed.
5. Delete the existing unwanted host "A" record of the domain controller.

### DNS query response delays

A DNS query request might time out if the DNS server forwards the query to unreachable forwarders or root hints. To troubleshoot this issue, follow these steps:

1. Open the DNS console on the DNS server, and check whether forwarders or conditional forwarders are reachable. If any of the forwarders are unreachable, remove them.
2. If the DNS server doesn't have to use forwarders and root hints, open the DNS console on the DNS server, open the server **Properties** window, select **Advanced**, and then turn on **Disable recursion**. (This setting also disables forwarders.)

### Event ID 4004 and event ID 4013

Event message:  
> DNS server was unable to open Active Directory. This DNS server is configured to use directory service information and cannot operate without access to the directory. The DNS server will wait for the directory to start. If the DNS server is started but the appropriate event has not been logged, then the DNS server is still waiting for the directory to start.

To troubleshoot this issue, see [Troubleshoot AD DS and restart the DNS Server service](troubleshoot-dns-event-id-4013.md#resolution).

### DNS Server geo-location policy doesn't work as expected

Consider the following scenario:

- You use an Active Directory-integrated zone (default zone scope) that's named "contoso.com."
- You use geo-location zone scopes that are associated with specific subnets.
- You use the Windows PowerShell `Add-DnsServerQueryResolutionPolicy` cmdlet to configure DNS resolution policies.

In this scenario, the desired outcome is that a client tries to locate a requested resource, first in the local zone scope and then in the default zone scope. However, after the organization configures these policies, clients from the defined subnets can't successfully resolve records that are hosted in the default zone scope (contoso.com). For example, clients can't resolve **hostA.contoso.com**. When the DNS server receives such requests, it returns a "Server Failure" message.

To troubleshoot this issue, see [DNS server geo-location policy doesn't work as expected](dns-server-geo-location-policy-doesnt-work-as-expected.md).

### Forwarded DNS name resolution fails for dual-stacked queries

You're using a third-party DNS server solution, and you can't consistently resolve names when you use conditional forwarding.

The local DNS server (10.100.100.70) can connect to the DNS server that's configured as a conditional forwarder (10.133.3.250). The first request from the DNS server to the conditional forwarder successfully resolves a name (for example, nbob1.contoso.com). After some time, name resolution stops working. An nslookup query to the conditional forwarder returns a "nonexistent domain" error message.

If you clear the DNS server cache on the forwarding computer (the local DNS server), name resolution resumes. However, this fix is temporary.

To troubleshoot this issue, see [Forwarded DNS name resolution fails for dual-stacked queries](forwarded-dns-name-resolution-fails-for-dual-stacked-queries.md).

### DNS Server loses its NIC Teaming configuration

Consider the following scenario:  

- The DNS server computer has multiple network adapters that you use in a NIC Teaming configuration.
- You configure the DNS server to listen on the IP address of the teaming network adapter. 
- On the **Interfaces** tab of the DNS server properties dialog box in DNS Manager, you can configure the IP address that you want to use.

After you restart the DNS server, Windows deletes the setting. The DNS server starts listening on all IP addresses again.

When this change occurs, Windows logs Event ID 410 in the DNS server event log:

> The DNS server list of restricted interfaces does not contain a valid IP address for the server computer. The DNS server will use all IP interfaces on the computer. Use the DNS manager server properties, interfaces dialog box, to verify and reset the IP addresses the DNS server should listen on. For more information, see "To restrict a DNS server to listen only on selected addresses" in the online Help.

To troubleshoot this issue, see [DNS server reverts to listening on all IP addresses instead of the configured NIC Teaming IP address](dns-server-loses-teaming-nic-configuration.md).

### DNS record registration behavior if the DHCP server manages dynamic DNS updates

You have an infrastructure that uses Windows Dynamic Host Configuration Protocol (DHCP) clients and Microsoft DHCP servers to assign and manage IP addresses. On the DHCP server, you select **Enable DNS dynamic updates according to the settings below** and **Always dynamically update DNS records**. In this configuration, you expect the DHCP server to manage dynamic DNS updates for "A" records and "PTR" records. However, you observe that both the client and the server create DNS records. Depending on your configuration, this behavior has the following effects:

- If you configure the DNS zones for **Nonsecure and secure** dynamic updates, you see that the DHCP server creates records, and then the DHCP client deletes and re-creates the same records.
- If you configure the DNS zones for **Secure only** dynamic updates, DNS records might become inconsistent. Both the DHCP server and the DHCP client create records. However, the DHCP server can't update records that the DHCP client creates, and the DHCP client can't update records that the DHCP server creates.

To troubleshoot this issue, see [DNS record registration behavior when the DHCP server is set to "Always dynamically update DNS records"](dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

## Data collection

Before you contact Microsoft Support, you can gather information about your issue.

### Prerequisites

- Run TSS in the security context of an account that has administrator privileges on the local system. The first time that you run TSS, accept the EULA. (After you accept the EULA, TSS won't prompt you again.)
- We recommend that you use the `RemoteSigned` PowerShell execution policy, at the `LocalMachine` scope.

> [!NOTE]  
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> 1. Set the `RemoteSigned` execution policy for the process level by running the cmdlet, `Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> 2. To verify that the change takes effect, run the `Get-ExecutionPolicy -List` cmdlet.  
>
> These process-level permissions apply to only the current PowerShell session. After you close the PowerShell window in which TSS runs, the assigned permission for the process level reverts to the previously-configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes, and expand the file into the *C:\\tss* folder.
2. Open the *C:\\tss* folder at an elevated PowerShell Command Prompt window.
3. Start the traces on the client and server by running the following cmdlets:

   - Client:  

     ```powershell
     TSS.ps1 -Scenario NET_DNScli
     ```

   - Server:  

     ```powershell
     TSS.ps1 -Scenario NET_DNSsrv
     ```

4. Accept the EULA if the traces are run for the first time on the server or the client.
5. Allow recording (PSR or video).

   > [!NOTE]
   > If you collect logs on both the client and the server, wait for this message to appear on both nodes before you reproduce the issue.

6. Reproduce the issue.

7. After you reproduce the issue, enter *Y* to finish logging data.

TSS stores the traces in a compressed file in the *C:\\MS_DATA* folder. You can upload the file to the workspace for analysis.

## References

- [Troubleshooting DNS clients](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-client)
- [Troubleshooting DNS servers](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server)
- [DNS logging and diagnostics](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29)
- [Understanding Aging and Scavenging](/previous-versions/windows/it-pro/windows-server-2003/cc759204%28v%3dws.10%29)
- [Enable DNS dynamic updates for clients](/previous-versions/windows/it-pro/windows-server-2003/cc757445%28v%3dws.10%29)
- [DNS Policies overview](/windows-server/networking/dns/deploy/dns-policies-overview)
- [DNS Active Directory-Integrated Zones](/windows-server/identity/ad-ds/plan/active-directory-integrated-dns-zones)
- [DNS zone replication in Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc779655%28v%3dws.10%29)
- [Verify that SRV DNS records have been created](verify-srv-dns-records-have-been-created.md)
- [Configure DNS dynamic updates](configure-dns-dynamic-updates-windows-server-2003.md)
- [Reviewing DNS concepts](/windows-server/identity/ad-ds/plan/reviewing-dns-concepts)
