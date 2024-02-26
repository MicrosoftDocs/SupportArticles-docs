---
title: DHCP clients are blocked and meet network issues
description: Discusses that DHCP clients are blocked when a DAI-enabled network device is used together with a DHCP failover on a Windows Server 2012 server. Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, saweng, greglin, arrenc, ajayps
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# DHCP clients are blocked when a DAI-enabled network device is used with a DHCP failover in Windows Server 2012 R2

This article provides a workaround for an issue where DHCP clients are blocked when a DAI-enabled network device is used together with a DHCP failover on a Windows Server 2012 server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2978225

## Symptoms

Consider the following scenario:

- You deploy a Dynamic Host Configuration Protocol (DHCP) failover by using a server that is running Windows Server 2012 R2.
- In this environment, you deploy a pair of active-active (duplicate) DHCP relay agents.
- DHCP snooping and Dynamic ARP Inspection (DAI) are enabled on network devices, such as switches.

In this scenario, DHCP clients are blocked and experience other network issues.

## Cause

This problem occurs because the duplicated DHCP relay agents cause the DHCP server to always receive duplicate DHCP messages for each client that connects to the network. For both DHCP requests, the DHCP failover-enabled server sends to the clients different ACK messages that have different lease duration values. This leads to a race condition in which the clients accept the first value that is received and ignore the second. However, DAI honors the second value. This creates a lease mismatch and causes DAI to block clients from accessing the network.

## Workaround

To work around this problem, use one of the following methods:

- Prevent duplicate DHCP requests. To do this, use one of the following options:

  - Remove the second DHCP relay agent.
  - Operate the DHCP relay agents in an active-passive mode. To do this, use virtual router groups if your router redundancy protocol is HSRP.

- Configure DAI so that it honors the first DHCP lease duration value (whenever possible).

- If DAI can't be configured to honor the first lease duration value, turn off or remove the DAI feature that is causing the conflict.

- Don't use DHCP failover in combination with two relay agents and DAI on the switches.

## More information

To provide redundancy, some organizations prefer to configure dual relays (two routers that each point to two DHCP servers). This configuration is common when Virtual Router Redundancy Protocol (VRRP) is used.

In a typical VRRP configuration that uses one IP address, one router is designated as the "active" device and the other one is set to "standby" mode. A heartbeat is exchanged between the routers. If the active router doesn't respond, the standby router takes over the shared IP address.

DHCP snooping enables a switch device to inspect DHCP traffic and to track which IP addresses are assigned to which host switch ports. This information can be useful to DAI. As soon as the DHCP lease duration expires, the traffic information is removed from the device database. A DAI-enabled switch will then block the ports.

A DHCP failover on a Windows Server 2012 server can't guarantee consistent lease duration for duplicated DHCP requests. This behavior is by design. This is because a DHCP server may issue either a Maximum Client Lead Time (MCLT) or Scope lease duration value, depending on the following circumstances:

- Upon receiving the first request, the DHCP server sends an ACK that includes an MCLT lease duration value before it tries to synchronize with its partner. This is also known as a Lazy Update.

- If the sync response arrives before the duplicated request, the DHCP server considers its partner to be up-to-date. It then sends an ACK that includes the Scope lease duration value. This is the desired behavior.

- If the duplicate request arrives before the sync response, the race condition that is described in the [Cause](#cause) section occurs. In this case, the DHCP server considers its partner to be out-of-sync. This causes the second ACK to use the MCLT lease duration value. You can't prevent the duplicate DHCP ACK messages from being sent. This is because a DHCP failover on a Windows Server 2012 server always responds by sending one DHCP ACK per DHCP request even though DHCP requests have the same transaction ID. This behavior is by design.

### Additional information

- The DHCP transaction ID is a way for the client to relate a sent message with a received message. The RFC does not imply that the server should be dropping messages based on transaction ID.

- At this time, we believe that a design change isn't warranted, based upon the following definition of a transaction ID that is provided in RFC 2131:

    > xid 4  
    Transaction ID, a random number chosen by the client, used by the client and server to associate messages and responses between a client and a server.
