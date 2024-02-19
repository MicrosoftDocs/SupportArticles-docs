---
title: DirectAccess clients connection error 0x800b0109
description: Provides a solution to an issue in which DirectAccess clients encounter error code 0x800b0109 and cannot connect to Windows Server by using IP-HTTPS.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, AJAYPS
ms.custom: sap:remote-access, csstroubleshoot
---
# DirectAccess clients may not be able to connect to a DirectAccess server with error 0x800b0109 when using IP-HTTPS

This article provides a solution to an issue where DirectAccess clients fail to connect to a server by using IP-HTTPS.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2980667

## Symptoms

DirectAccess clients may not be able to connect to a DirectAccess server by using IP-HTTPS. When you run the `netsh interface http show interface` command, the output is as follows:

> URL: `https://da.contoso.com:443/IPHTTPS`
Error: 0x800b0109  
Interface Status: Failed to connect to the IPHTTPS server. Waiting to reconnect
>
> The error 0x800b0109 translates to:  
CERT_E_UNTRUSTEDROOT  
\# A certificate chain processed, but terminated in a root  
\# certificate which is not trusted by the trust provider.

By default, the Trusted Root Certification Authorities certificate store is configured with a set of public certification authorities that are trusted by a Windows client. Some organizations may want to manage certificate trust and prevent users in the domain from configuring their own set of trusted root certificates. In addition, some organizations may want to issue certificates for the IP-HTTPS server from their own certification authority server. They need to distribute that specific trusted root certificate to enable the trust relationships. When configuring certificates for DirectAccess, the Root Certificate Authority must be trusted by the clients, and it should have the Root CA certificate in the Trusted Root Certification Authorities store.

For more information about certificates, see [How certificate revocation works](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee619754(v=ws.10)).

## Cause

The issuing certificate authority for the IP-HTTPS certificate is not present in the clients Trusted and Intermediate stores. Make sure that you add the Root certificate to the Root store and the Intermediate certificates to the Intermediate stores.

## Resolution

To solve this issue, follow these steps:

1. Obtain the certificate for the certification authority that issued the IP-HTTPS certificate.
2. Import this certificate into the computer store of the DirectAccess client.
3. To apply this change to all clients, [use Group Policy to deploy the imported certificate](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772491(v=ws.11)).

## DirectAccess connectivity methods

DirectAccess clients use multiple methods to connect to the DirectAccess server, which enables access to internal resources. Clients have the option to use either Teredo, 6to4, or IP-HTTPS to connect to DirectAccess. This also depends on how the DirectAccess server is configured.

When the DirectAccess client has a public IPv4 address, it will try to connect by using the 6to4 interface. However, some ISPs give the illusion of a public IP Address. What they provide to end users is a pseudo public IP address. What this means is that the IP address received by the DirectAccess client (a data card or SIM connection) might be an IP from the public address space, but in reality is behind one or more NATs.

When the client is behind a NAT device, it will try to use Teredo. Many businesses such as hotels, airports, and coffee shops do not allow Teredo traffic to traverse their firewall. In such scenarios, the client will fail over to IP-HTTPS. IP-HTTPS is built over an SSL (TLS) TCP 443-based connection. SSL outbound traffic will most likely be allowed on all networks.

Having this in mind, IP-HTTPS was built to provide a backup connection that is reliable and always reachable. A DirectAccess client will make use of this when other methods (such as Teredo or 6to4) fail.

More information about transition technologies can be found at [IPv6 transition technologies](/previous-versions//bb726951(v=technet.10)).
