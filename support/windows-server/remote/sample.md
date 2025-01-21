---
title: 'RDS 2012: Which ports are used during deployment?'
TOCTitle: 'RDS 2012: Which ports are used during deployment?'
ms.date: 12/21/2023 2:12:22 AM
ms:mtpsurl: https://social.technet.microsoft.com/wiki/contents/articles/16164.rds-2012-which-ports-are-used-during-deployment.aspx
_tocRel: toc.json
author: Archiveddocs
ms.author: Archiveddocs
---
# RDS 2012: Which ports are used during deployment?

To configure Remote Desktop Services correctly for internet access or any time where firewalls are used, it is useful to know what ports are required.

The information / taxonomy is broken down by role service/component, and lists all inbound/outbound ports used.

## From Client to RD Resource

- If using RDWeb
  - TCP 443 (HTTPS)
- TCP|UDP 3389:  Standard RDP port. Can be configured on host and client to a different port number.

## Remote Desktop Connection Broker (RDCB)

- TCP 5504: connection to RD Web Access
- TCP 3389: connection to RD Session Host
- TCP 3389: connection to non-managed VM pools, managed machines use VMBus to open port.
- TCP 3389: client port for clients not using RD Gateway
- TCP 445|RPC: connection to RD Virtualization Host
- TCP 445|RPC: connection to RD Session Host
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Gateway

- For inbound external internet based traffic from RD Clients to the Gateway:
  - TCP 443:  HTTP (includes RPC over HTTP) over SSL - (configurable using RD Gateway Management console)
  - UDP 3391:  RDP/UDP (configurable using RD Gateway Management console) (NOTE: Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive"  configured)
- For internal traffic between the Gateway and the required User AD, Resource AD, DNS, NPS etc:
  - TCP 88: Kerberos for user authentication
  - TCP 135: RPC Endpoint Mapper
  - TCP: \<\>, Port on which NTDS RPC services listens on AD
  - TCP|UDP 389:  LDAP for user authentication
  - TCP|UDP 53: Internal resource name resolution, DNS
  - TCP|UDP 389: If using LDAP for Certificate Revocation List (CRL)  
  - TCP 80:  If using HTTP for Certificate Revocation List (CRL)  
  - TCP 21:  If using FTP for Certificate Revocation List (CRL)  
  - UDP 1812, 1813: If NPS Server is being used
  - TCP 5985: WMI and PowerShell Remoting for administration
- For internal traffic from the Gateway and the Internal Remote Desktop resources
  - TCP|UDP 3389: RDP (NOTE: Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive" configured in the UDP protocol)

## Remote Desktop Web Access

- If RD Web Access is on a perimeter network
  - TCP: \<WMI Fixed Port\>
  - TCP 5504: connection to RD Connection Broker for centralized publishing
  - TCP 5985: WMI and PowerShell Remoting for administration

<!-- -->

- If ISA is used, please refer to  <http://www.isaserver.org/articles/2004perimeterdomain.html>

## Remote Desktop Session Host

- RD License Server Port RPC
- TCP 389|636: Active Directory communication
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Virtualization Host

- RD License Server Port RPC
- TCP 389|636: Active Directory communication
- TCP 5985: WMI and PowerShell Remoting for administration

## Remote Desktop Licensing Server

Information for Terminal Server in Windows Server 2008 is at <http://support.microsoft.com/KB/832017#method26>  The ports used have not changed in Windows Server 2012 | R2.  The summary follows.

### TCP

- TCP 135 - RPC  for License Server communication and RDSH
- TCP 1024-65535 (randomly allocated)  Used for RPC For Windows Server pre-2008 (see next line).
- TCP 49152 - 65535 (randomly allocated) -  This is the range in Windows Server 2012,  Windows Server 2008 R2, Windows Server 2008
- TCP 445 - SMB
- TCP 443: Communication over the internet to the Microsoft Clearing House
- TCP 5985: WMI and PowerShell Remoting for administration
- TCP 139 - NetBIOS session service

How to configure which ports (if need to set to specifics) <http://support.microsoft.com/kb/154596/>

### NetBIOS

- UDP 137 - NetBIOS Name resolution
- UDP 138 - NetBIOS datagram
- UDP|TCP 389   LDAP - Used with per-user CALs against Active Directory

From a proxy standpoint, the regkey HKLM\Software\Microsoft\TermServLicensing\lrwiz\Params shows the Microsoft service that the RD LS communicates with.  e.g. clearinghouse.one.microsoft.com

 
