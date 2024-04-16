---
title: Records aren't deleted
description: Provides a solution to an issue where you enable Scavenging on the Windows DNS Server to get rid of some old and stale records on the zone.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# DNS: Scavenging: Records aren't deleted if scavenging manually disabled with DNSCMD

This article provides a solution to an issue where you enable Scavenging on the Windows DNS Server to get rid of some old and stale records on the zone.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2791165

## Symptoms

You may find yourself in a scenario where you enable Scavenging on the Windows DNS Server to get rid of some old and stale records on the zone.

You configure the Scavenging Cycle and Aging (No Refresh and Refresh interval) appropriate to your environment and wait for the Scavenging cycle to delete your records.

You notice that the Scavenging cycle runs but doesn't delete the records with old time stamps.  
You decide to wait for another scavenging cycle to run, but still the records don't get deleted.

## Cause

You may get into this scenario where the DNS Zone was previously configured manually for scavenging by a different server (using dnscmd), then scavenging was disabled in the environment and then enabled again on another server.

## Resolution

For the zone in question, run the following command:

```console
dnscmd /zoneinfo contoso.com
```

(I'll use the zone as contoso.com for example)
You'll get the result like this:

```console
Zone query result:

Zone info:

                ptr                   = 0000000000327C90
                zone name             = ocntoso.com
                zone type             = 1
                shutdown              = 0
                paused                = 0
                update                = 2
                DS integrated         = 1
                read only zone        = 0
                in DS loading queue   = 0
                currently DS loading  = 0
                data file             = (null)
                using WINS            = 0
                using Nbstat          = 0
                aging                 = 1
                 refresh interval    = 168
                  no refresh          = 168
                  scavenge available  = 3606130
                Zone Masters          NULL IP Array.
                Zone Secondaries   NULL IP Array.
                secure secs           = 3
                directory partition   = AD-Domain     flags 00000015

                zone DN               = DC=contoso.com,cn=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com          Scavenge Servers

                 Ptr          = 000000000031D480
               MaxCount     = 1

                AddrCount    = 1
                                Server[0] => af=2, salen=16, [sub=0, flag=00000000] p=13568, addr=192.168.1.1
```

Here you notice the IP address 192.168.1.1.
It's the IP address of the server that has the permission to scavenge the zone (Most likely this could be a server that is no longer existing)
If it isn't the IP address of the server that on which you have configured Scavenging then we need to change that.
To change the Scavenging server for a zone, run the command:

```console
dnscmd /zoneresetscavengeservers contoso.com <Ip of the current DNS Server>
```

where \<IP of the current DNS Server> is the IP address of the DNS Server where Scavenging is configured.

## More information

The following command resets all scavenging server settings and removes manually specified servers.

```console
dnscmd /zoneresetscavengeservers contoso.com (without ip address).
```

> [!NOTE]
> The maximum time that an stale record may take to be deleted through Scavenging is (No Refresh interval + Refresh interval + Scavenging cycle interval).
