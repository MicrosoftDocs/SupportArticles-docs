---
title: 'Troubleshoot networking issues for DirectAccess server troubleshooting'
description: This article introduces how to troubleshoot networking issues for DirectAccess server troubleshooting.
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
# Troubleshoot DirectAccess Server console: Network and high availability

This article introduce how to troubleshoot network and high availability issues for DirectAccess Server console troubleshooting.

## Network address translation (NAT) 64 issue

When a client receives the DNS AAAA record, it will try to establish a TCP connection against that IPv6. It will talk with the NAT64 service and that will be the responsible to make the connection against the internal IPv4 address. NAT64 is always used by DirectAccess when you have your DA server running in an IPv4 internal network.

> NAT64: Not working properly  
> Error:  
> NAT64 translation failures might be preventing remote clients from accessing IPv4 only severs in the corporate network.

### Causes

This issue can be caused by one of the following factors.

- NAT64 is not enabled on the server.
- The NAT64 server cannot be reached.
- NAT64 translation has failed.

### Resolution

If you have a native ipv6 connectivity, ensure that the NAT64 or DNS64 prefix is configured in the DirectAccess settings.

In the **Remote Server Setup** Wizard, ensure that the default Name Resolution Policy Table （NRPT） entry points to internal address of the NAT64/DNS64 server.

NAT64 not working properly error is normally the behavior when there are too many connections to one single server. An over provisioned server cannot support every client communication and the NAT64 engine has a hard-stop limit of simultaneous sessions or transactions. If it hits a warning threshold against that limit, this warning is displayed regularly.

Be sure to watch the CPU and memory utilization numbers. If you think your server is getting close to tapping out, start making plans to add an additional DirectAccess server node.

Restarting the Remote Access server should also fix the issue momentarily.

Also verify the **Remote Access Server administrative channel** event log. You should find messages related to the NAT64 passing from **WARNING** to **HEALTHY**.

Alternative, on the limit of NAT64 connection, add double ports for NAT64 without lowering the number of ephemeral ports for the DirectAccess server itself. The ports can be either used by NAT or the server for its own tasks, but not both. 

The following command is to add a second IP on the internal interface and then configure NAT64 for both IPs.

```powershell
Set-NetNatTransitionConfiguration –IPv4AddressPortPool @("xxx.xxxx.xxxx.xxxx, 10000-47000", "xxx.xxx.xxx.xxx, 10000-47000")
```

## Network adapters issue

Network Adapters error messages are referred to the local network interfaces of the selected DirectAccess server.

> Network adapters: Not working properly  
> Error:  
> The network adapters are either disconnected or disabled.

### Causes

This issue can be caused when the specified network adapters are not enabled or not connected.

### Resolution

To resolve this issue, follow these steps:

1. Enable the network adapters by using ncpa.cpl.
2. Verify network connectivity on the network adapters.
  
Be sure to also verify the **Remote Access Server administrative channel** event log. You should find messages related to the monitor of the network interfaces passing from **UNHEALTHY** to **HEALTHY**.

## Network location server issue

You configure a Windows Server DirectAccess server to use an intranet-based Network Location Server (NLS). Then, you may notice that the operations status in the remote access management console indicates a critical problem with NLS. However, you can browse the NLS server from the DirectAccess server.

The issue is that the DirectAccess server, in addition to being able to successfully connect to the NLS using an HTTP GET, must also be able to ping the NLS server. However, inbound Internet Control Message Protocol (ICMP) is often blocked on web servers. Therefore, the DirectAccess server marking the service as failed. The issue can be resolved by modifying the host firewall policy to allow inbound ICMPv4 echo requests.

## Network security error

The reason of this warning is written in the **Details** section of the **RA Monitor**.

You may see a large number of packets with a bad security parameters index (SPI) have been received in a short amount of time. Also, you will see that this warning is sporadic not showing all the time.

> Network security: Not working properly  
> Error:  
> A network security component is under a spoofing attack.

### Causes

A large number of packets with bad SPIs within a short amount of time might indicate a packet spoofing attack.

### Resolution

Monitor the server for signs of a spoofing attack. If an attack is detected, apply mitigation measures to stop it.

This could be a spoofing attack. Some clients send ESP packets with wrong SPIs (outdated SAs) or the Load Balancer forwarding Encapsulating Security Payload (ESP) packets with a wrong SPI. Only a wfpdiag trace will show what happens.

You can start a trace on it the server and stop it based on event 10039 - Microsoft-Windows-RemoteAccess-RemoteAccessServer.

Adding more servers is also helpful.

## High availability error

This error will show up in **Operation Status** only if we are setting up a high availability solution using Microsoft NLB or an external Load Balancer to load the traffic across two or more Direct Access Servers.

If the default NLB deployment method is chosen and the DirectAccess server is deployed on a virtual machine running in Microsoft Hyper-V, make sure to select the **Enable MAC address spoofing** option.

:::image type="content" source="media/troubleshoot-directaccess-server-console-networking/hyper-v-enable-mac-spoofing.png" alt-text="Screenshot of Hyper-V settings." border="false":::
