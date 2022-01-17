---
title: 
description: 
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
NAT64 
When a client receives the DNS AAAA record it will try to establish a TCP connection against that IPv6. It will talk with the NAT64 service and that will be the responsible to make the connection against the internal IPv4 address. NAT64 is always used by DirectAccess when you have your DA server running in an IPv4 internal network 
 NAT64: Not working properly 
Error: 
NAT64 translation failures might be preventing remote clients from accessing IPv4•onty severs in the corporate network. Causes: 
l. NAT64 is not enabled on the server. 
2. The NAT64 server cannot be reached. 
3. NAT 64 translation has failed. 
Resolution: 
Ensure that the NAT64 server can be reached on the corporate network.
Ensure that NAT64 is enabled on server. 
If you have native ipv6 connectivity, ensure that the NAT64/DNS64 prefix is configured in the DirectAccess settings. 
In the Remote Server Setup Wizard, ensure that the default NRPT entry points to internal address of the NAT64/DNS64 server. 
NAT64 not working properly is normally the behavior when we have too many connections for one single server. An over provisioned server cannot support every client communication and the NAT64 engine has a hard-stop limit of simultaneous sessions/transactions. If it hits a warning threshold against that limit it might be normal to see this warning regularly. 
Be sure to watch the CPU/memory utilization numbers and if you think your server is getting close to tapping out, start making plans to add an additional DirectAccess server node. 
Restarting remote access should also correct it momentarily. 
Also verify the “Remote Access Server administrative channel “event log. You should find messages related to the NAT64 passing from WARNING to HEALTHY. 
Alternative on the limit of NAT64 connection 
·Add more (double) ports for NAT64 without lowering the number of ephemeral ports for the DA server itself (the ports can be either used by NAT or the server for its own tasks, but not both) is to add a second IP on the internal IF and then configure NAT64 for both Ips 
Set-NetNatTransitionConfiguration –IPv4AddressPortPool @("xxx.xxxx.xxxx.xxxx, 10000-47000", "xxx.xxx.xxx.xxx, 10000-47000") 
 
Network Adapters 
Network Adapters error messages are referred to the local NICs of the selected DA Server. 
 Network adapters: Not working properly 
Error: 
The network adapters are either disconnected or disabled. 
Causes: 
1. The specified network adapters are not enabled. 
2. The specified network adapters are not connected. 
Resolution: 
1. Enable the network adapters using ncpa.cpl. 
2. Verify network connectivity on the network adapters. 
  
Be sure to also verify the “Remote Access Server administrative channel “event log. You should find messages related to the monitor of the network interfaces passing from UNHEALTHY to HEALTHY. 
 Network Location Server 
After configuring a Windows Server DirectAccess server to use an intranet-based Network Location Server (NLS), you may notice that the operations status in the remote access management console indicates a critical problem with NLS, when in fact you can browse the NLS server from the DirectAccess server. 
 
 
 
The issue here is that the DirectAccess server, in addition to being able to successfully connect to the NLS using an HTTP GET, must also be able to ping the NLS server. However, inbound ICMP is often blocked on web servers which results in the DirectAccess server marking the service as failed. The issue can be quickly resolved by modifying the host firewall policy to allow inbound ICMPv4 echo requests. 
 
Network Security 
The reason this warning appears is written in the Details section of the RA Monitor. 
It says that "…a large number of packets with a bad SPI…." have been received in a short amount of time and you will see that this warning is sporadic not showing all the time. 
 Details
Network security: Not working properly
Error:
A network security component is under a spoofing attack.
Causes:
A large number of packets with bad SPIs within a short amount of time might indicate a packet spoofing attack.
Resolution 
Monitor the server for signs of a spoofing attack. If an attack is detected, apply mitigation measures to stop it. 

This could be a spoofing attack, some clients sending ESP packets with wrong SPIs (outdated SAs) or the Load Balancer forwarding ESP packets with a wrong SPI. Only a WFPDIAG trace will show what happens. 
You can start a trace on it the server and stop it based on event 10039 - Microsoft-Windows-RemoteAccess-RemoteAccessServer. 
Adding more servers is also helpful.

High Availability 
This will show up in Operation Status only if we are setting up a high availability solution using Microsoft NLB or an external Load Balancer to load the traffic across two or more Direct Access Servers. 
If the default NLB deployment method is chosen and the DirectAccess server is deployed on a virtual machine running in Microsoft Hyper-V, make sure to Enable MAC address spoofing: 
  
