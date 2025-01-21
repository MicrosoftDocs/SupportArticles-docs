---
title: Ports that are used by RDS
description: Introduces the ports that are required to open on firewalls in order to configure Remote Desktop (RD) Services correctly.
ms.date: 02/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Session connectivity, csstroubleshoot
---
# Ports that are used by RDS

This article introduces the ports that are required to open on firewalls in order to configure Remote Desktop (RD) Services correctly.

The information and taxonomy is broken down by role service and component, and lists all inbound and outbound ports used.

## From Client to RD Resource

- TCP 443 (HTTPS) Required if RDWeb is deployed.
- TCP and UDP 3389: Standard RDP port. Can be configured on host and client to a different port number.

## Remote Desktop Connection Broker (RDCB)

- TCP 5504: Connection to RD Web Access
- TCP 3389: Connection to RD Session Host
- TCP 3389: Connection to non-managed VM pools, managed machines use VMBus to open port.
- TCP 3389: Client port for clients not using RD Gateway
- TCP 445 and RPC: Connection to RD Virtualization Host
- TCP 445 and RPC: Connection to RD Session Host
- TCP 5985: WMI and PowerShell Remoting for administration.

## Remote Desktop Gateway

### Inbound external internet based traffic from RD Clients to the Gateway

- TCP 443: HTTP (includes RPC over HTTP) over SSL. The port is configurable using RD Gateway Management console.
- UDP 3391: RDP over UDP. The port is configurable using RD Gateway Management console.

  > [!NOTE]
  > Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive" configured.

### Internal traffic between the Gateway and the required User AD, Resource AD, DNS, NPS and so on

- TCP 88: Kerberos for user authentication
- TCP 135: RPC Endpoint Mapper
- TCP 135: Port that NTDS RPC services listens on AD
- TCP and UDP 389: LDAP for user authentication
- TCP and UDP 53: Internal resource name resolution, DNS
- TCP and UDP 389: If using LDAP for Certificate Revocation List (CRL)  
- TCP 80: If using HTTP for CRL
- TCP 21: If using FTP for CRL
- UDP 1812 and 1813: If NPS Server is being used.
- TCP 5985: WMI and PowerShell Remoting for administration

### Internal traffic from the Gateway and the Internal Remote Desktop resources

- TCP and UDP 3389: RDP

  > [!Note]
  > Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive" configured in the UDP protocol

## Remote Desktop Web Access

If RD Web Access is on a perimeter network, configure the following ports.

- TCP: \<WMI Fixed Port\>
- TCP 5504: connection to RD Connection Broker for centralized publishing
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Session Host

- RD License Server Port RPC
- TCP 389 and 636: Active Directory communication
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Virtualization Host

- RD License Server Port RPC
- TCP 389 and 636: Active Directory communication
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Licensing Server

For more information, see [RDS Licensing (RDSL)](../networking/service-overview-and-network-port-requirements.md#rds-licensing-rdsl).

### TCP

- TCP 135: RPC for License Server communication and RDSH
- TCP 1024-65535 (randomly allocated): Used for RPC in Windows Server versions that is earlier than Windows Server 2008 (see next line).
- TCP 49152-65535 (randomly allocated): Used for RPC in Windows Server 2008 and later versions.
- TCP 445: SMB
- TCP 443: Communication over the internet to the Microsoft Clearing House.
- TCP 5985: WMI and PowerShell Remoting for administration
- TCP 139: NetBIOS session service

For more information, see [How to configure RPC dynamic port allocation to work with firewalls](../networking/configure-rpc-dynamic-port-allocation-with-firewalls.md).

### NetBIOS

- UDP 137: NetBIOS Name resolution
- UDP 138: NetBIOS Datagram Service
- UDP and TCP 389: LDAP that is used with per-user CALs against Active Directory

From a proxy standpoint, the registry key `HKLM\Software\Microsoft\TermServLicensing\lrwiz\Params` shows the Microsoft service that the RD LS communicates with.
