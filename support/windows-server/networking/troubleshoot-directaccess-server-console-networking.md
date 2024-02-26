---
title: Troubleshoot networking issues for DirectAccess server troubleshooting
description: This article discusses how to troubleshoot networking issues for DirectAccess server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# Troubleshoot DirectAccess Server console: Network and high availability

This article discusses how to troubleshoot network and high availability issues for DirectAccess Server console.

## Network address translation (NAT) 64 issue

When a client receives the DNS AAAA record, it tries to establish a TCP connection to that IPv6-based network. The client talks to the NAT64 service that will be responsible for making the connection to the internal IPv4 address. NAT64 is always used by DirectAccess your DA server is running in an IPv4-based internal network.

> NAT64: Not working properly  
> Error:  
> NAT64 translation failures might be preventing remote clients from accessing IPv4 only severs in the corporate network.

### Cause

This issue can be caused by one of the following factors:

- NAT64 is not enabled on the server.
- The NAT64 server cannot be accessed.
- NAT64 translation has failed.

### Resolution

If you have a native ipv6 connection, make sure that the NAT64 or DNS64 prefix is configured in the DirectAccess settings.

In the **Remote Server Setup** Wizard, make sure that the default Name Resolution Policy Table（NRPT）entry points to the internal address of the NAT64 or DNS64 server.

The "NAT64 not working properly" error is the usual behavior if there are too many connections to a single server. An over-provisioned server cannot support every client communication, and the NAT64 engine has a hard-stop limit on simultaneous sessions or transactions. If the engine hits a warning threshold against that limit, this warning is displayed regularly.

Be sure to watch the CPU and memory usage numbers. If you believe that your server is getting close to tapping out, start making plans to add another DirectAccess server node.

You can also fix the issue momentarily by restarting the Remote Access server.

Also, check the **Remote Access Server administrative channel** event log. You should find messages that are related to the NAT64 moving from a **WARNING** to a **HEALTHY** state.

Alternatively, regarding the limit on the NAT64 connection, add double ports for NAT64 without lowering the number of ephemeral ports for the DirectAccess server itself. The ports can be used by either NAT or the server for its own tasks, but not by both. 

The following command adds a second IP on the internal interface, and then configures NAT64 for both IPs:

```powershell
Set-NetNatTransitionConfiguration –IPv4AddressPortPool @("xxx.xxxx.xxxx.xxxx, 10000-47000", "xxx.xxx.xxx.xxx, 10000-47000")
```

## Network adapters issue

Network adapters-related error messages refer to the local network interfaces of the selected DirectAccess server:

> Network adapters: Not working properly  
> Error:  
> The network adapters are either disconnected or disabled.

### Cause

The specified network adapters are not enabled or not connected.

### Resolution

To resolve this issue, follow these steps:

1. Enable the network adapters by using the Network and Sharing Center in Control Panel (ncpa.cpl).
2. Verify network connectivity on the network adapters.
  
Make sure that you also verify the **Remote Access Server administrative channel** event log. You should find messages related to the monitoring of network interfaces moving from an **UNHEALTHY** status to a **HEALTHY** status.

## Network location server issue

You configure a Windows Server DirectAccess server to use an intranet-based Network Location Server (NLS). In this situation, you might notice that the operations status in the remote access management console indicates a critical problem that affects NLS. However, you can browse the NLS server from the DirectAccess server.

The DirectAccess server must be able to ping the NLS server in addition to being able to successfully connect to the NLS by using an HTTP GET. However, inbound Internet Control Message Protocol (ICMP) is often blocked on web servers. Therefore, the DirectAccess server tags the service as failed. The issue can be resolved by modifying the host firewall policy to allow inbound ICMPv4 echo requests.

## Network security error

The reason for this warning is written in the **Details** section of the **RA Monitor**:

> Network security: Not working properly  
> Error:  
> A network security component is under a spoofing attack.

You may see that many packets that have a bad security parameters index (SPI) have been received in a short amount of time. Also, you will see that this warning is intermittent.

### Cause

Many packets that have bad SPIs within a short amount of time might indicate a packet spoofing attack.

### Resolution

Monitor the server for signs of a spoofing attack. If an attack is detected, apply mitigation measures to stop it.

Some clients send ESP packets that have incorrect SPIs (outdated SAs) or the Load Balancer-forwarding Encapsulating Security Payload (ESP) packets that have an incorrect SPI. Run a wfpdiag trace to show what is occurring, and stop the attack based on event 10039 - Microsoft-Windows-RemoteAccess-RemoteAccessServer.

Adding more servers is also helpful.

## High availability error

This error appears as the operation status only if you're setting up a high-availability solution by using Microsoft NLB or an external Load Balancer to load the traffic across two or more Direct Access servers.

If the default NLB deployment method is selected, and the DirectAccess server is deployed on a virtual machine that's running in Microsoft Hyper-V, make sure that you select the **Enable MAC address spoofing** option.

:::image type="content" source="media/troubleshoot-directaccess-server-console-networking/hyper-v-enable-mac-spoofing.png" alt-text="Screenshot of Hyper-V settings." :::
