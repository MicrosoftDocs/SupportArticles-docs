---
title: 'RDS 2012: Which ports are used during deployment?'
TOCTitle: 'RDS 2012: Which ports are used during deployment?'
ms.date: 12/21/2023 2:12:22 AM
ms:mtpsurl: https://social.technet.microsoft.com/wiki/contents/articles/16164.rds-2012-which-ports-are-used-during-deployment.aspx
_tocRel: toc.json
author: Archiveddocs
ms.author: Archiveddocs
---
# Ports that are used by RDS

This article introduces the ports that are required to open on firewalls in order to configure Remote Desktop Services correctly.

The information and taxonomy is broken down by role service and component, and lists all inbound and outbound ports used.

## From Client to Remote Desktop Resource

- TCP 443 (HTTPS) needs to be open if RDWeb is deployed.
- TCP and UDP 3389:  Standard RDP port. Can be configured on host and client to a different port number.

## Remote Desktop Connection Broker (RDCB)

- TCP 5504: connection to RD Web Access
- TCP 3389: connection to RD Session Host
- TCP 3389: connection to non-managed VM pools, managed machines use VMBus to open port.
- TCP 3389: client port for clients not using RD Gateway
- TCP 445 and RPC: connection to RD Virtualization Host
- TCP 445 and RPC: connection to RD Session Host
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Gateway

For inbound external internet based traffic from RD Clients to the Gateway:

- TCP 443:  HTTP (includes RPC over HTTP) over SSL - (configurable using RD Gateway Management console)
- UDP 3391:  RDP/UDP (configurable using RD Gateway Management console) (NOTE: Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive"  configured)

For internal traffic between the Gateway and the required User AD, Resource AD, DNS, NPS etc:

- TCP 88: Kerberos for user authentication
- TCP 135: RPC Endpoint Mapper
- TCP: 135, Port on which NTDS RPC services listens on AD
- TCP and UDP 389:  LDAP for user authentication
- TCP and UDP 53: Internal resource name resolution, DNS
- TCP and UDP 389: If using LDAP for Certificate Revocation List (CRL)  
- TCP 80:  If using HTTP for Certificate Revocation List (CRL)  
- TCP 21:  If using FTP for Certificate Revocation List (CRL)  
- UDP 1812, 1813: If NPS Server is being used
- TCP 5985: WMI and PowerShell Remoting for administration

For internal traffic from the Gateway and the Internal Remote Desktop resources:

- TCP and UDP 3389: RDP
  > [!Note]
  > Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive" configured in the UDP protocol

## Remote Desktop Web Access

- If RD Web Access is on a perimeter network
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

- TCP 135 - RPC  for License Server communication and RDSH
- TCP 1024-65535 (randomly allocated)  Used for RPC For Windows Server pre-2008 (see next line).
- TCP 49152 - 65535 (randomly allocated) -  This is the range in Windows Server 2012,  Windows Server 2008 R2, Windows Server 2008
- TCP 445 - SMB
- TCP 443: Communication over the internet to the Microsoft Clearing House
- TCP 5985: WMI and PowerShell Remoting for administration
- TCP 139 - NetBIOS session service

For more information, see [How to configure RPC dynamic port allocation to work with firewalls](../networking/configure-rpc-dynamic-port-allocation-with-firewalls.md).

### NetBIOS

- UDP 137 - NetBIOS Name resolution
- UDP 138 - NetBIOS datagram
- UDP|TCP 389   LDAP - Used with per-user CALs against Active Directory

From a proxy standpoint, the registry key `HKLM\Software\Microsoft\TermServLicensing\lrwiz\Params` shows the Microsoft service that the RD LS communicates with.
