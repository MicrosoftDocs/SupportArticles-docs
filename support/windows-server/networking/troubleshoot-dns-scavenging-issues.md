---
title: Troubleshoot DNS scavenging issues
description: Describes how to troubleshoot DNS scavenging issues.
ms.date: 09/03/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.localizationpriority: medium
ms.reviewer: aytarek, 5x5net
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshoot DNS scavenging issues

This article provides detailed information on how to troubleshoot issues related to DNS scavenging.

## Fundamental checks for DNS scavenging issues

There are various scenarios that may lead to DNS scavenging issues. The following common checks can be used to ensure that scavenging is configured correctly in all cases:

- For scavenging to take effect, it must be configured on three levels: Record, Zone and Server. See [DNS Scavenging Setup](dns-scavenging-setup.md) for more details. If any of those levels is missing, scavenging will not take place.

  The records that are prone to scavenging are the records that are registered with a timestamp in DNS, which could be either of the following ones:

  - Windows clients configured with dynamic IP addresses that are registered in DNS using DDNS.
  - Windows based machines that are configured with static IP addresses that are registered in DNS every 24 hours.
  
  Scavenging does not delete any records that are added manually to the server as static with no timestamp 
  
  > [!NOTE]
  > DDNS could lead to a static record deletion from DNS if that record was registered as dynamic then converted to static by removing its timestamp, in this case, we would need to review who has “delete” access on the record.

- Make sure that only one DNS server has scavenging configured to avoid conflict between servers.

  :::image type="content" source="media/troubleshoot-dns-scavenging-issues/option-to-enable-automatic-scavenging-of-stale-records.png" alt-text="Option to enable automatic scavenging of stale records.":::

- Check zone aging settings on whether there is a global aging set on all zones conflicting with a zone level aging.

  > [!NOTE]
  > The zone level aging will have higher precedence.

  Zone level:  
  :::image type="content" source="media/troubleshoot-dns-scavenging-issues/zone-level-aging-settings.png" alt-text="Zone level aging settings.":::

  All zones level:  
  :::image type="content" source="media/troubleshoot-dns-scavenging-issues/all-zone-level-aging-settings.png" alt-text="All zone level aging settings.":::

- There is no standard setting for what numbers to use when configuring **Refresh**, **No Refresh** and **Scavenging** cycle time, as this depends on each organization configuration and preferences. However, you must ensure the settings follow the following equation:

Refresh + No Refresh > = Biggest DHCP lease

The sum of **Refresh** and **No Refresh** intervals need to be greater than or equal the biggest Dynamic Host Configuration Protocol (DHCP) lease, highlighting the critical relationship between DHCP lease duration and scavenging. The Scenarios section in the article demonstrates the reason to consider this equation.

## Troubleshooting

1. Ensuring the correct configuration for scavenging is crucial for troubleshooting, as most issues are caused by configuration errors. See [DNS scavenging is misconfigured](troubleshoot-dns-guidance.md#dns-scavenging-is-misconfigured).

2. Based on the scenario, you might need to track the last occurrences of scavenging cycle by checking the signaling of event IDs [2501](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee783621(v=ws.10)) and [2502](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee783623(v=ws.10)):

   1. 2501 means scavenging cycle has passed and one or more records were deleted.
   2. 2502 means scavenging cycle has passed and no records were deleted.

   To identify the next scavenging cycle occurrence on a DNS server, you need to get the date and time of the last DNS scavenging cycle and add the scavenging period. See [How to identify when the next scavenging cycle will occur on a DNS server](/archive/technet-wiki/21724.how-dns-aging-and-scavenging-works#how-to-identify-when-the-next-scavenging-cycle-will-occur-on-a-dns-server).

3. Utilize DNS Server Audit logs for detailed information on:
   1. Which records are deleted by scavenging: event ID [521](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).
   2. Start of scavenging cycle: event ID [552](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).
   3. Termination of scavenging cycle: event ID [554](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).
   4. Scavenge servers: event ID [567](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29).

4. Consider manually initiating scavenging to test its functionality. This would result in instant deletion of records only if scavenging has run before automatically at least one time on this server. See [Automated and Manually Initiated Scavenging](/previous-versions/windows/it-pro/windows-server-2003/cc757041%28v=ws.10%29#automated-and-manually-initiated-scavenging).

   :::image type="content" source="media/troubleshoot-dns-scavenging-issues/click-the-scavenge-stale-resource-records-option.png" alt-text="Click the 'Scavenge Stale Resource Records' option.":::

## Scenarios

This section lists several common scenarios that might arise with DNS Scavenging:

### Statically configured IPs on servers that are dynamically registered in DNS may have their records deleted

Assume that you have the following configuration in an environment:

- SRV1 IP = 2.2.2.2, registered on DNS with timestamp 24/7/2024 6:00 PM
- Refresh Interval set to 2 hours.
- No-Refresh Interval set to 2 hours.
- Scavenging set to 7 days.
- Last scavenging cycle occurred on 17/7/2024 at 11:00 PM.

Statically configured IPs by default register themselves every 24 hours. With the above config, the record would become stale on 24/7/2024 at 10:00 PM. With the next scavenging cycle occurring on 24//7/2024 at 11:00 PM (seven days added to 17/7/2024), the DNS server will find that the record is stale and deletes it. In this scenario,you might encounter resolution issues for this server from 11:00 PM till the next working day when manual registration occurs or after 24 hours pass from the previous registration time for it to register itself again.

The cause here is that Refresh + No-Refresh interval is less than 24 hours. Therefore, the DNS records are lost.

### DNS Records get deleted unexpectedly

See [DNS: Scavenging: Records aren't deleted if scavenging manually disabled with DNSCMD](records-arent-deleted.md) for the full scenario.

### DNS Records not deleted if scavenging manually disabled with DNSCMD

See [Enable phase](dns-scavenging-setup.md#enable-phase) for the full scenario.

### DNS Scavenging is not occurring, events 2501 and 2502 are not generated

Issue: DNS Server fails to scavenge aging records, a DC being decommissioned is the server to which the original Domain Controller (DC) was replicating.

To troubleshoot the issue, verify if the zone is available for scavenging by ensuring that the partition (where the zone is stored) has replicated since the system boot.

The reason for verification is to prevent a DC that has been offline for a long time from scavenging data that appears old but has been updated on other DCs.

Replication Check:

- If the partition has not had a full sync with at least one replication partner in the last zone refresh interval, do not scavenge the zone.
- Examine the directory partition to determine if it has replicated with at least one other partner since the DNS service started and within the specified interval

If the decommissioned DC is no longer needed, removing the DC would solve the issue. To list all domain controllers in all domains, run the following command:

```console
nltest/ dclist:
```

### Records for Azure machines in DNS get deleted causing resolution issues

Azure machines have a lease of 136 years. Therefore, no matter what scavenging settings, it would never match with the rest of Windows On-Prem machines as the renewal time at 50% of lease time would be after 50 years. Hence, machines are not updating their timestamp and their records get deleted by scavenging.

Solution to this is to force Azure machines to register themselves every X interval of time to have their timestamp renewed in DNS during Refresh interval. To do this, apply RegistrationRefreshInterval policy:

`Computer Configuration\Administrative Templates\Network\DNS Client\Registration Refresh Interval`

The policy maps to registry key:

`HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\DNSClient`

The default value of the setting is 1800 seconds (30 minutes).

This specifies the time interval between DNS update registration updates. To make the changes to this value effective, you must restart Windows.

> [!NOTE]
> If you apply this policy on Windows Client machines, you will need to enable in advance Computer Configuration\Administrative Templates\Network\DNS Client\Dynamic Update for the Registration Refresh Interval to take effect.

### Duplicate Records are present in DNS server

See [How DNS Scavenging and the DHCP Lease Duration Relate](/archive/blogs/askpfe/how-dns-scavenging-and-the-dhcp-lease-duration-relate) for the full scenario.
