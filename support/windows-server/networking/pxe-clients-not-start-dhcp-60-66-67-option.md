---
title: PXE clients don't start
description: Describes problem when PXE clients do not start when you use Dynamic Host Configuration Protocol options 60, 66, 67 on the DHCP server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# PXE clients computers do not start when you configure the Dynamic Host Configuration Protocol server to use options 60, 66, 67

This article helps fix an issue where Pre-Boot Execution Environment (PXE) clients computers don't start when you configure the Dynamic Host Configuration Protocol server to use options 60, 66, 67.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 259670

## Symptoms

When you try to start a PXE client computer, you may receive one of the following error messages:  
>No reply from Server  
TFTP download failed  
No boot Filename Received  
PXE-E55 Proxy DHCP Service did not reply to request on port 4011  

## Cause

This issue can occur when the DHCP server has the following Dynamic Host Configuration Protocol (DHCP) options set:

- #60 = Client Identifier (set to "PXEClient")
- #66 = Boot Server Host Name
- #67 = BootFile NameWhen the initial DHCP offer from the DHCP server contains these boot options, an attempt is made to connect to port 4011 on the DHCP server. This offer fails if the PXE server is on another computer.

> [!IMPORTANT]
> Microsoft does not support the use of these options on a DHCP server to redirect PXE clients

To resolve this issue, you must remove these options from the DHCP server and configure the routers IP helper table to contain the IP address of the RIS server.

## More information

This issue can affect any kind of PXE server including Automated Deployment Services (ADS).

For a PXE server to respond to a PXE request, the request must be able to transverse routers to communicate with PXE servers on other subnets. PXE uses the DHCP option fields to pass information. Therefore having the PXE server in the routers IP helper table helps make sure that the DHCP packets are forwarded to the PXE server so the PXE server can respond correctly.

PXE uses the following to determine which offer to use:

- DHCP/Bootp in same offer
- DHCP with IP only Proxy Boot Servers, such as Remote installation services (RIS) and ADS.
