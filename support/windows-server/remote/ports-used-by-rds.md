---
title: Ports That Are Used by RDS
description: Introduces the ports that are required to open on firewalls to configure Remote Desktop Services (RDS) correctly.
ms.date: 02/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# Ports that are used by Remote Desktop Services

This article introduces the ports that need to be open on firewalls to configure Remote Desktop Services (RDS) correctly.

The information and taxonomy are broken down by role, service, and component, and all inbound and outbound ports used are listed.

## From client to RD resource

- TCP 443 (HTTPS): Required if RDWeb is deployed.
- TCP and UDP 3389: Standard Remote Desktop Protocol (RDP) port. It can be configured to a different port number on the host and client.

## Remote Desktop Connection Broker (RDCB)

- TCP 5504: Used for connections to RD Web Access.
- TCP 3389: Used for connections to RD Session Host.
- TCP 3389: Used for connections to non-managed VM pools. Managed machines use Virtual Machine Bus (VMBus) to open ports.
- TCP 3389: Client port for clients not using RD Gateway.
- TCP 445 and RPC: Used for connections to RD Virtualization Host.
- TCP 445 and RPC: Used for connections to RD Session Host.
- TCP 5985: Used by Windows Management Instrumentation (WMI) and PowerShell Remoting for administration.

## Remote Desktop Gateway

### Inbound external internet-based traffic from RD clients to the Gateway

- TCP 443: Used for HTTP (including RPC over HTTP) over SSL. This port can be configured using the RD Gateway Management console.
- UDP 3391: Used for RDP over UDP. This port can be configured using the RD Gateway Management console.

  > [!NOTE]
  > Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive" to be configured.

### Internal traffic between the Gateway and the required user AD, resource AD, DNS, NPS, and so on

- TCP 88: Used by Kerberos for user authentication.
- TCP 135: Used by the Remote Procedure Call (RPC) Endpoint Mapper. It's the port on which the NTDS RPC services listen on Active Directory (AD).
- TCP and UDP 389: Used by the Lightweight Directory Access Protocol (LDAP) for user authentication. It's required when using LDAP for Certificate Revocation Lists (CRLs).
- TCP and UDP 53: Used by the Domain Name System (DNS) for internal resource name resolution.
- TCP 80: Required when using HTTP for CRLs.
- TCP 21: Required when using FTP for CRLs.
- UDP 1812 and 1813: Required when Network Policy Server (NPS) is used.
- TCP 5985: Used by WMI and PowerShell Remoting for administration.

### Internal traffic from the Gateway and the internal RD resources

- TCP and UDP 3389: Used by RDP.

  > [!Note]
  > Firewalls that have directional UDP analysis, such as TMG, require UDP "Send Receive" to be configured in the UDP protocol.

## Remote Desktop Web Access

If RD Web Access is on a perimeter network, configure the following ports:

- TCP: \<WMI Fixed Port\>
- TCP 5504: Used for connections to RDCB for centralized publishing.
- TCP 5985: Used by WMI and PowerShell Remoting for administration.

## Remote Desktop Session Host

- RD License Server: RPC ports.
- TCP 389 and 636: Used for AD communication.
- TCP 5985: Used by WMI and PowerShell Remoting for administration.

## Remote Desktop Virtualization Host

- RD License Server: RPC ports.
- TCP 389 and 636: Used for AD communication.
- TCP 5985: Used by WMI and PowerShell Remoting for administration.

## Remote Desktop Licensing Server

For more information, see [RDS Licensing (RDSL)](../networking/service-overview-and-network-port-requirements.md#rds-licensing-rdsl).

### TCP

- TCP 135: Used for RPC for License Server communication and Remote Desktop Session Host.
- TCP 1024-65535 (randomly allocated): Used for RPC in Windows Server versions that are earlier than Windows Server 2008.
- TCP 49152-65535 (randomly allocated): Used for RPC in Windows Server 2008 and later versions.
- TCP 445: Used by the  Server Message Block (SMB) protocol.
- TCP 443: Used for communication over the internet to the Microsoft Clearing House.
- TCP 5985: Used by WMI and PowerShell Remoting for administration.
- TCP 139: Used by the NetBIOS session service.

For more information, see [How to configure RPC dynamic port allocation to work with firewalls](../networking/configure-rpc-dynamic-port-allocation-with-firewalls.md).

### NetBIOS

- UDP 137: Used for NetBIOS name resolution.
- UDP 138: Used by the NetBIOS Datagram Service.
- UDP and TCP 389: Used by LDAP with per-user Client Access Licenses (CALs) in AD.

From a proxy standpoint, the registry key `HKLM\Software\Microsoft\TermServLicensing\lrwiz\Params` shows the Microsoft service that the RD License Server communicates with.
