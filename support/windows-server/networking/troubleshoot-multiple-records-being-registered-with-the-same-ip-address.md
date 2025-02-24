---
title: Troubleshoot multiple records being registered with the same IP address
description: Describes how to configure DNS scavenging and the DHCP lease duration to prevent multiple records with the same IP address.
ms.date: 01/15/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: ahmorsy, 5x5net
ms.custom:
- sap:network connectivity and file sharing\dns
- pcy:WinComm Networking
---
# Multiple records with the same IP address due to DNS scavenging and the DHCP lease duration configurations

This article helps you troubleshoot the issue in which multiple records are registered with the same IP address. The issue is caused by the configurations of Domain Name System (DNS) scavenging and the Dynamic Host Configuration Protocol (DHCP) lease duration.

## Scenario

Consider the following scenario.

On a DHCP server, you have the following configurations:

- A DHCP scope has its lease duration set to the default eight days.
- The DHCP scope is low on available IP addresses.
- Client A doesn't renew its IP address lease in eight days and expires.
- Client B requests a new IP address.
- The DHCP server assigns client B the address that is leased to client A.

This scenario is typical and everything works correctly.

On a DNS server, you have the following configurations:

- An Active Directory (AD) integrated DNS zone is set to scavenge stale resource records.
- The DNS record scavenging uses default settings: **No-refresh interval = 7 days**, **Refresh interval = 7 days**, and **Scavenging period = 7 days**.
- Client A renewed its DNS record eight days ago when the client's DHCP lease was last updated.
- By default, client A is the owner of its DNS record, so the record can't be deleted by the DHCP server.
- Client B registers its DNS record with the new IP address received from the DHCP server, which is the same as the record registered to client A.

In this scenario, the DNS server can't scavenge client A's DNS record for another six days. Now, client A and client B have the same IP address registered in DNS.

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/client-a-client-b-same-records.png" alt-text="Screenshot that shows client A and client B have the same DNS records.":::

## Issue analysis

Several issues occur because of the same DNS record for different names. For example, installation issue with Microsoft System Center Configuration Manager (SCCM) clients.

Here's another example. When you access a share on client A, you receive the following error message, even when client A isn't turned on.

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/logon-failure.png" alt-text="Screenshot of an error message received when you access a share folder on client A.":::

This error is caused because a Kerberos ticket intended for one computer is sent to another computer. The following section walks through the whole process.

### Network flows during the logon failure

The computer (Infra-App1) does a DNS query for `client-a.corp.contoso.com`. DNS responses back with the IP address 10.0.0.100.

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/network-trace.png" alt-text="Screenshot of network trace during the DNS query.":::

As far as DNS is concerned, the result is correct. Client A has 10.0.0.100 listed as its IP address, so does client B.

Then, the computer Infra-App1 requests a Kerberos ticket. The DNS query is for client A, so the Ticket Granting Service (TGS) request is also for client A.

The TGS request:

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/tgs-request-client-a.png" alt-text="Screenshot that shows TGS request is sent for client A.":::

The domain controller's response:

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/response-tgs-request.png" alt-text="Screenshot that shows domain concoller's response for the TGS request." :::

After the computer Infra-App1 receives the ticket, the computer tries to connect to client A. The Kerberos ticket is included in this frame.

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/infra-app1-connect-client-a.png" alt-text="Screenshot shows that Infrra-App1 tries to connect to client A." :::

Finally, the remote client returns an error because the computer Infra-App1 connects to client B.

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/error-packet-client-b.png" alt-text="Screenshot that shows error packet returned from client B." :::

The error is expected because you must present the right ticket to the right account to make Kerberos work.

> [!NOTE]
> For more information about Kerberos, see [Kerberos for the Busy Admin](/archive/blogs/askds/kerberos-for-the-busy-admin).

This issue doesn't occur if you use IP address instead of the fully qualified domain name (FQDN), because the New Technology LAN Manager (NTLM) authentication is used instead of the Kerberos authentication. When you use the IP address to connect to the client, there's no assumption about which client is being connected to. Therefore, the computer must negotiate NTLM first. For the example in the [scenario](#scenario) section, the Kerberos returns a valid response, so the computer doesn't fail over to use NTLM.

## Resolutions

Because this issue is related to stale DNS records, you can use different resolutions to prevent the issue from occurring.

> [!NOTE]
> For each resolution, we recommend lowering the scavenging interval to one to three days. The seven-day default extends the period that invalid records remain in DNS.

### Resolution 1

Increase the DHCP lease duration to match the **No-refresh + Refresh** intervals. For the example in the [scenario](#scenario) section, you can increase the DHCP lease to 14 days.

Advantage:

DHCP leases remain until the DNS record is scavenged. No other client receives and registers the address in DNS.

Disadvantage:

If the DHCP scope is already low on addresses, the IP addresses could run out.

A small percentage of records might not be scavenged before the lease expires because of small time differences. Setting the scavenging interval to one day ensures the stale records are removed the next day.

### Resolution 2

Decrease the **No-refresh + Refresh** intervals to match the DHCP lease. For the example in the [scenario](#scenario) section, you can decrease both **No-refresh** and **Refresh** to four days.

Advantage:

The existing DNS record is scavenged sooner affectively achieving the same results as in the first solution.

Disadvantage:

If these are AD integrated DNS zones, AD replication frequency increases. This is because the DNS records will be refreshed by the clients more frequently. For example, every four days instead of every seven days.

A small percentage of records might not be scavenged before the lease expires because of small time differences. Setting the scavenging interval to one day ensures the stale records are removed the next day.

### Resolution 3

Allow the DHCP server to register the addresses on behalf of the clients.

Advantage:

The DHCP server can remove the DNS record as soon as the lease expires. If setup is correct, no duplicate records should exist.

Disadvantage:

The setup is more involved.

A service account needs to be set up to run the DHCP service, or all the DHCP servers need to be joined to the DNSUpdateProxy group (less secure). The configuration adds complexity.

To do so, see [How to configure DNS dynamic updates in Windows](configure-dns-dynamic-updates-windows-server-2003.md).

Experiment with the DHCP lease duration, **No-refresh** interval, and **Refresh** interval. You may find a need to depart completely from the defaults. Low DHCP lease durations (in the hours) are sometimes used for wireless subnets. Be mindful of the performance of your servers though, especially if you have a DNS server set to scavenge every few hours on large DNS zones.

## Identify records with duplicate IPs

This section introduces how to use PowerShell to identify the duplicate records. The script aims at finding records in DNS that contain duplicate IP addresses.

```powershell
#Import the Active Directory Module
import-module activedirectory

#Define an empty array to store computers with duplicate IP address registrations in DNS
$duplicate_comp = @()

#Get all computers in the current Active Directory domain along with the IPv4 address
#The IPv4 address is not a property on the computer account so a DNS lookup is performed
#The list of computers is sorted based on IPv4 address and assigned to the variable $comp
$comp = get-adcomputer -filter * -properties ipv4address | sort-object -property ipv4address

#For each computer object returned, assign just a sorted list of all
#of the IPv4 addresses for each computer to $sorted_ipv4
$sorted_ipv4 = $comp | foreach {$_.ipv4address} | sort-object

#For each computer object returned, assign just a sorted, unique list
#of all of the IPv4 addresses for each computer to $unique_ipv4
$unique_ipv4 = $comp | foreach {$_.ipv4address} | sort-object | get-unique

#compare $unique_ipv4 to $sorted_ipv4 and assign just the additional
#IPv4 addresses in $sorted_ipv4 to $duplicate_ipv4
$duplicate_ipv4 = Compare-object -referenceobject $unique_ipv4 -differenceobject $sorted_ipv4 | foreach {$_.inputobject}

#For each instance in $duplicate_ipv4 and for each instance
#in $comp, compare $duplicate_ipv4 to $comp If they are equal, assign
#the computer object to array $duplicate_comp
foreach ($duplicate_inst in $duplicate_ipv4)
{
    foreach ($comp_inst in $comp)
    {
        if (!($duplicate_inst.compareto($comp_inst.ipv4address)))
        {
            $duplicate_comp = $duplicate_comp + $comp_inst
        }
    }
}

#Pipe all of the duplicate computers to a formatted table
$duplicate_comp | ft name,ipv4address -a
```

Here’s a sample of the output:

:::image type="content" source="media/troubleshoot-multiple-records-being-registered-with-the-same-ip-address/output-powershell-script.png" alt-text="Screenshot that shows output of the PowerShell script." :::

This PowerShell script is straightforward. Consider the script as a sample. This script only returns duplicate IP addresses registered to actual computer accounts in AD. Keep in mind that the script queries every computer in an AD domain. Then, it does a DNS query to get the IP address. If you have many computers, use the `-searchbase` switch with `get-adcomputer` to limit the number of computers returned each time. If the computer isn't joined to AD, the computer isn't returned from the `get-adcomputer` command.
