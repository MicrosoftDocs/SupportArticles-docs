---
title: L2TP VPN fails with error 787
description: L2TP VPN fails with 787 because of RRAS choosing the wrong certificate.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# L2TP VPN fails with error 787

This article provides help to fix the error 787 that occurs when a L2TP VPN connection to a Remote Access server fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2855053

## Symptoms

A L2TP VPN connection to a Windows Server 2012 Remote Access server fails with error 787 "The L2TP connection attempt failed because the security layer could not authenticate the remote computer."

The Server is configured for as well VPN connections as DirectAccess and has at least two valid certificates. One certificate for IPHTTPS and one for L2TP. Both certificates have at least the Server Authentication EKU, for example:
• Server Authentication (1.3.6.1.5.5.7.3.1)
• Client Authentication (1.3.6.1.5.5.7.3.2)
optionally also
• IP security IKE intermediate (1.3.6.1.5.5.8.2.2)

One of the certificates is a wildcard certificate.
The certificates might also be from different Certificate Authorities.

## Cause

The IPsec SA establishment for the L2TP connection fails because the server uses the wildcard certificate and/or a certificate from a different Certificate Authority as the computer certificate configured on the clients.
Routing and Remote Access (RRAS) is choosing the first certificate it can find in the computer certificate store.
For L2TP, different from SSTP or IPHTTPS or any other manual configured IPsec rule, you rely on the RRAS built in mechanism for choosing a certificate. There is no way to influence this.

## Resolution

There are two possible solutions:

1) Use a single certificate for IPHTTPS and L2TP.

2) Use a manually configured L2TP IPsec policy on the RRAS server (it is not needed on the clients) and disable the automatically configured IPsec policy.

- Path: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rasman\Parameters 
- Value Name: ProhibitIpSec 
- Data Type: REG_DWORD 
- Value: 1

Then add an IPsec policy manually - This is an L2TP Rule:

> Rule Name: L2TP Manual Rule  
Description: L2TP Manual Rule  
Enabled: Yes  
Profiles: Private, Public  
Type: Dynamic  
Mode: Transport  
InterfaceTypes: Any  
Endpoint1: Any  
Endpoint2: 131.107.0.2/32  
Port1: Any  
Port2: 1701  
Protocol: UDP  
Action: RequireInRequireOut  
Auth1: ComputerCert  
Auth1CAName: DC=com, DC=contoso, DC=corp, CN=corp-DC1-CA  
Auth1CertMapping: No  
Auth1ExcludeCAName: No  
Auth1CertType: Root  
Auth1HealthCert: No  
MainModeSecMethods: DHGroup2-AES128-SHA256, DHGroup2-AES128-SHA1, DHGroup2-3DES-SHA1  
MainModeKeyLifetime: 480min,0sess  
QuickModeSecMethods: ESP:SHA1-None+60min+100000kb,ESP:SHA1-AES128+60min+100000kb,ESP:SHA1-3DES+60min+100000kb,AH:SHA1+60min+100000kb  
QuickModePFS: None  
Rule source: Local Setting  
ApplyAuthorization: No
