---
title: Troubleshoot DNS name resolution failures related to DNS forwarders
description: Provides troubleshooting guides for DNS name resolution failures related to DNS forwarders.
ms.date: 01/15/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: aytarek,5x5net
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshoot DNS name resolution failures related to DNS forwarders

You have forwarders, conditional forwarders, or root hints configured to perform name lookups for external names. However, you can't resolve external names from clients by using `nslookup` or `Resolve-DnsName`. This article introduces how to troubleshoot Domain Name System (DNS) forwarder-related name resolution failures.

## Analysis of the symptoms

1. Check whether the clients that can't resolve the names are external or internal.  
   If the issue is specific to an internal domain or external names, this information helps you look at the domain specific configuration on the DNS server.
2. Check whether all clients are facing the issue or only specific ones are.  
   By doing so, you can help isolate whether the issue is specific to a DNS forwarding server.
3. Check the DNS server.  
   - If the name resolution fails from the clients, check whether the name resolution also fails from your preferred DNS server configured.
   - Check whether the resolution fails from the DNS server itself. If so, you can rule out any issue with the client or the network between the client and the DNS server.

   :::image type="content" source="media/troubleshoot-dns-forwarders-related-failures/sample-of-how-dns-forwarder-works.png" alt-text="Screenshot showing a sample of how DNS forwarder works." border="true":::

## Troubleshooting flowchart

:::image type="content" source="media/troubleshoot-dns-forwarders-related-failures/visual-diagram-of-troubleshooting-flowchart.png" alt-text="Visual diagram of the troubleshooting flowchart." border="true":::

## Troubleshooting steps

### Step 1: Check network connectivity between the client and the DNS server

1. Verify the DNS configuration. Run `ipconfig /all` on the client and confirm the correct DNS server IP is configured. If it's incorrect, configure it using the following command:

   ```powershell
   Set-DnsClientServerAddress -InterfaceAlias "Interface-Name" -ServerAddresses ("IP1")
   ```

2. Check the UDP port 53 communication. Ensure that UDP port 53 communication between the client and the DNS server is allowed.
3. Perform a ping test from the client to the DNS server and vice versa to ensure basic network connectivity.

### Step 2: Check the DNS server configuration

Follow these steps to validate if this DNS server is configured correctly to be able to resolve the names that aren't local to itself.

1. Check whether a conditional forwarder is configured for the domain in question:

    ```powershell
    Get-DnsServerZone -Name <domainname>
    ```

2. If no conditional forwarder is found, check whether there are general forwarders configured:

   ```powershell
   Get-DnsServerForwarder
   ```

   Verify that **Useroothints** is set to TRUE.

3. If no forwarders are configured, check for root hints:

   ```powershell
   Get-DnsServerRootHint
   ```

If none of them are configured, the name resolution is expected to fail. You need to proceed to create a conditional forwarder if it's an internal domain or a forwarder if it's for external domains (preferably).

> [!NOTE]
> The conditional forwarder or the forwarders, which are DNS servers, need to have the records for the name or need to be configured to resolve the name.

### Step 3: Check the DNS service status and connectivity

1. Ensure the DNS server service is running on both the forwarding and forwarder DNS servers:

   ```powershell
   Get-Service -Name DNS
   ```

   Start the service if it isn't running:

   ```powershell
   Start-Service -Name DNS
   ```

2. Ensure UDP port 53 communication between the DNS forwarding server and the forwarder servers is allowed.

### Step 4: Collect network captures to track DNS packets

Before you take a network capture on the client machine, it's always recommended to clear the DNS client-side cache:

```console
ipconfig /flushdns
```

Then collect a network capture using these steps:

1. Start a network capture tool (for example, Wireshark) on the client, DNS server, and forwarder.
2. Perform `nslookup <name>` on the client to reproduce the failure.
3. Stop the capture and review the traces. Filter for UDP port 53 to view the relevant DNS traffic.

Analyze the scenarios.

The following sections list several scenarios that you might encounter. These scenarios involve a conditional forwarder configuration, but the troubleshooting steps are the same if you deal with a standard forwarder.

#### Scenario 1: Network latency or time-out

DNS name server 192.168.10.10 forwards the query to the first forwarder 192.168.5.5. Due to network latency or intermediate network issues, the response doesn't reach the DNS server within the **ForwarderTimeout** period. Hence, the DNS server forwards the query to the next forwarder configured out of it, which is 192.168.5.6. Again, due to latency or intermediate network issues, the response doesn't reach the DNS server. Since the DNS server can't fetch the response for the query `nodeA.contoso.com`, it sends a "Server failure" response to the client.

:::image type="content" source="media/troubleshoot-dns-forwarders-related-failures/network-flow-when-network-latency-or-timeout-with-dns-forwarder.png" alt-text="Screenshot of a network flow when network latency or time-out happens with the DNS forwarder." border="true":::

**Resolution**: Collaborate with the network team to address the latency. If the latency is expected, make sure the DNS server is given enough time to wait for the response from the conditional forwarder before timing out by increasing the **ForwarderTimeout** and **RecursionTimeout** periods.

To do so, see [NET: DNS: Forwarders and conditional forwarders resolution timeouts](forwarders-resolution-timeouts.md).

#### Scenario 2: Query refused by the forwarder

DNS name server 192.168.10.10 forwards the query to the conditional forwarder 192.168.5.5. On this server, if there's any policy configured to refuse or deny queries for a particular record or zone, the conditional forwarder responds to the forwarding DNS name server with a "Refused" response. Now, the DNS server will in turn forward this error to the client as a server failure. The DNS server won't contact the second conditional forwarder as we already got a response from the first one (even though it's an error response)

**Resolution**: If the forwarder is a Microsoft Windows DNS server, check for any DNS query resolution policies configured on the conditional forwarder to "deny" the queries for the zone `fab.com` or certain records such as `NodeA.fab.com`. You can get the list of configured policies with the command `get-dnsserverqueryresolutionpolicy`. To do so, see [Get-DnsServerQueryResolutionPolicy](/powershell/module/dnsserver/get-dnsserverqueryresolutionpolicy).

If any such policies shouldn't be placed, remove them to resolve the issue.

If it's a third-party DNS server, contact the respective vendor.

#### Scenario 3: Missing records on the forwarder

DNS name server 192.168.10.10 forwards the query to the first conditional forwarder 192.168.5.5. On the conditional forwarder, there's no host A record present for the name `NodeA` under the `fab.com` zone. In this case, the conditional forwarder responds to the DNS server with a "Name error" response. The DNS server will then forward the same response to the client. The DNS server won't contact the second conditional forwarder here as we already got a response from the first one. Usually, if this scenario occurs, you see the symptom that the resolution fails for certain names, not necessarily all the names of the `fab.com` domain.

:::image type="content" source="media/troubleshoot-dns-forwarders-related-failures/network-flow-when-missing-records-on-forwarder.png" alt-text="Screenshot of a network flow when there are missing records on the forwarder." border="true":::

**Resolution**: Register the missing records on the forwarder for the zone in question, either statically or dynamically.

## Data collection

If you need help from Microsoft support, we recommend that you collect information about your issue before contacting Microsoft support.

1. Follow the steps provided in [Introduction to TroubleShootingScript toolset (TSS)](../../windows-client/windows-tss/introduction-to-troubleshootingscript-toolset-tss.md) to download and collect logs using the TSS tool.
2. Run this command to enable log collection on the impacted machine:
   - On DNS servers:

     ```console
     .\TSS.ps1 -Scenario NET_DNSsrv
     ```

   - On DNS clients:

     ```console
     .\TSS.ps1 -Scenario NET_DNScli
     ```
