---
title: Troubleshoot DNS scavenging issues
description: Describes how to troubleshoot DNS scavenging issues.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: aytarek, 5x5net
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshoot DNS scavenging issues

This article provides detailed information on how to troubleshoot issues related to Domain Name System (DNS) scavenging.

## Fundamental checks for DNS scavenging issues

There are various scenarios that might lead to DNS scavenging issues. The following common checks can be used to ensure that scavenging is configured correctly in all cases:

- For scavenging to take effect, it must be configured on three levels: record, zone, and server. For more information, see [DNS scavenging setup](dns-scavenging-setup.md). If any of those levels is missing, scavenging doesn't take place.

  The records that are prone to scavenging are the records that are registered with a timestamp in DNS, which can be either of the following ones:

  - Windows clients configured with dynamic IP addresses that are registered in DNS using dynamic DNS (DDNS).  
  - Windows-based machines configured with static IP addresses that are registered in DNS every 24 hours.
  
  Scavenging doesn't delete any records that are added manually to the server as static records with no timestamps. 
  
  > [!NOTE]
  > DDNS can cause a static record to be deleted from DNS if that record is registered as a dynamic record and then converted to a static record by removing its timestamp. In this case, you need to review who has "delete" access to the record.

- Make sure that only one DNS server has scavenging configured to avoid conflicts between servers.

  :::image type="content" source="media/troubleshoot-dns-scavenging-issues/option-to-enable-automatic-scavenging-of-stale-records.png" alt-text="Screenshot showing the 'Enable automatic scavenging of stale records' option.":::

- Check zone aging settings to see whether there's a global aging setting on all zones conflicting with zone-level aging.

  > [!NOTE]
  > The zone-level aging has higher precedence.

  Zone level:  

  :::image type="content" source="media/troubleshoot-dns-scavenging-issues/zone-level-aging-settings.png" alt-text="Screenshot showing the zone-level aging settings." lightbox="media/troubleshoot-dns-scavenging-issues/zone-level-aging-settings.png":::

  All zones level:  

  :::image type="content" source="media/troubleshoot-dns-scavenging-issues/all-zone-level-aging-settings.png" alt-text="Screenshot showing the all zones level aging settings." lightbox="media/troubleshoot-dns-scavenging-issues/all-zone-level-aging-settings.png":::

- There's no standard setting for which numbers to use when configuring the **Refresh**, **No-refresh**, and **Scavenging** cycle time, as this depends on each organization's configuration and preferences. However, you must ensure the settings follow this equation:

  > Refresh + No-refresh >= The maximum DHCP lease

The sum of the **Refresh** and **No-refresh** intervals needs to be greater than or equal to the maximum Dynamic Host Configuration Protocol (DHCP) lease, highlighting the critical relationship between DHCP lease duration and scavenging. The [Scenarios](#scenarios) section of the article demonstrates the reason for considering this equation.

## Troubleshooting steps

1. Ensuring the correct configuration for scavenging is crucial for troubleshooting, as most issues are caused by configuration errors. For more information, see [DNS scavenging is misconfigured](troubleshoot-dns-guidance.md#dns-scavenging-is-misconfigured).

2. Based on the scenario, you might need to track the last occurrence of the scavenging cycle by checking the signaling of event IDs [2501](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee783621(v=ws.10)) and [2502](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee783623(v=ws.10)):

   - Event 2501 means the scavenging cycle has passed and one or more records were deleted.
   - Event 2502 means the scavenging cycle has passed and no records were deleted.

   To identify when the next scavenging cycle will occur on a DNS server, you need to get the date and time of the last DNS scavenging cycle and add the scavenging period. For more information, see [How to identify when the next scavenging cycle will occur on a DNS server](/archive/technet-wiki/21724.how-dns-aging-and-scavenging-works#how-to-identify-when-the-next-scavenging-cycle-will-occur-on-a-dns-server).

3. Utilize DNS Server Audit logs to get the following details:

   - Which records are deleted by scavenging: event ID [521](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).
   - Start of the scavenging cycle: event ID [552](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).
   - Termination of the scavenging cycle: event ID [554](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).
   - Scavenge servers: event ID [567](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).

4. Consider manually initiating scavenging to test its functionality. This will result in the instant deletion of records only if scavenging has been run automatically at least once on this server. For more information, see [Automated and Manually Initiated Scavenging](/previous-versions/windows/it-pro/windows-server-2003/cc757041%28v=ws.10%29#automated-and-manually-initiated-scavenging).

   :::image type="content" source="media/troubleshoot-dns-scavenging-issues/scavenge-stale-resource-records-option.png" alt-text="Screenshot showing the 'Scavenge Stale Resource Records' option.":::

## Scenarios

This section lists several common scenarios that might arise with DNS scavenging.

### Statically configured IPs on servers that are dynamically registered in DNS might have their records deleted

Assume that you have the following configuration in an environment:

- SRV1 IP = 2.2.2.2, registered on DNS with a timestamp of 7/24/2024 6:00 PM.
- The **Refresh interval** is set to **2 hours**.
- The **No-refresh interval** set to **2 hours**.
- Scavenging is set to **7 days**.
- The last scavenging cycle occurred on July 17, 2024, at 11:00 PM.

By default, statically configured IPs register themselves every 24 hours. With the preceding configuration, the record will become stale on July 24, 2024, at 10:00 PM. With the next scavenging cycle occurring on July 24, 2024, at 11:00 PM (July 17, 2024, plus seven days), the DNS server will find that the record is stale and delete it. In this scenario, you might encounter resolution issues with this server from 11:00 PM to the next working day when you register manually, or after 24 hours have passed from the previous registration time when it registers itself again.

The cause is that the **Refresh** + **No-refresh** interval is less than 24 hours. Therefore, the DNS records are lost.

### DNS records are deleted unexpectedly

See [DNS: Scavenging: Records aren't deleted if scavenging is manually disabled with DNSCMD](records-arent-deleted.md) for the complete scenario.

### DNS records aren't deleted if scavenging is manually disabled with DNSCMD

See [Enable phase](dns-scavenging-setup.md#enable-phase) for the complete scenario.

### DNS scavenging doesn't occur, and events 2501 and 2502 aren't generated

The DNS server fails to scavenge aging records, and a domain controller (DC) being decommissioned is the server to which the original DC was replicating.

To troubleshoot the issue, verify that the zone is available for scavenging by ensuring that the partition (where the zone is stored) has replicated since the system boot.

The reason for the verification is to prevent a DC that has been offline for a long time from scavenging data that appears old but has been updated on other DCs.

Replication checks:

- If the partition hasn't fully synced with at least one replication partner in the last zone refresh interval, don't scavenge the zone.
- Examine the directory partition to determine if it has replicated with at least one other partner within the specified interval since the DNS service was started. 

If the decommissioned DC is no longer needed, removing the DC would solve the issue. To list all domain controllers in a specific domain, run the following command:

```console
nltest /dclist:<DomainName>
```

### Records for Azure machines in DNS are deleted, causing resolution issues

Azure machines have a lease of 136 years. Therefore, no matter what scavenging settings are used, it will never match the rest of the Windows on-premises machines as 50% of the lease renewal time us after 50 years. Hence, machines don't update their timestamps, and their records are deleted by scavenging.

The solution is to force the Azure machines to register themselves every *X* interval to have their timestamps renewed in DNS during the **Refresh** interval. To do so, apply the `RegistrationRefreshInterval` policy:

`Computer Configuration\Administrative Templates\Network\DNS Client\Registration Refresh Interval`

The policy maps to the registry key:

`HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\DNSClient`

The default value of the setting is 1800 seconds (30 minutes).

This specifies the time interval between DNS update registrations. To make the changes to this value effective, you must restart Windows.

> [!NOTE]
> If you apply this policy on Windows client machines, you need to enable `Computer Configuration\Administrative Templates\Network\DNS Client\Dynamic Update` in advance for the **Registration Refresh Interval** to take effect.

### Duplicate records are present in the DNS server

See [How DNS Scavenging and the DHCP Lease Duration Relate](/archive/blogs/askpfe/how-dns-scavenging-and-the-dhcp-lease-duration-relate) for the complete scenario.
