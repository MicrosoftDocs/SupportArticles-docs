---
title: DirectAccess clients can't connect to server
description: Describes an issue in which DirectAccess clients encounter error code 0x103, 0x2AFC, or 0x2AF9 and cannot connect to Windows Server by using IP-HTTPS.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ajayps
ms.custom: sap:Network Connectivity and File Sharing\Remote access (DirectAccess), csstroubleshoot
---
# DirectAccess clients may not be able to connect to DirectAccess server with error code 0x103, 0x2AFC, or 0x2AF9 when using IP-HTTPS

This article provides help to fix error 0x103, 0x2AFC, or 0x2AF9 that occurs when you use IP-HTTPS to connect DirectAccess clients to the DirectAccess server.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2980635

## Symptoms

DirectAccess clients may not be able to connect to DirectAccess Server by using Internet Protocol over Secure Hypertext Transfer Protocol (IP-HTTPS) connections.

When you run the netsh interface http show interface command, the output is as follows:

> Error: 0x103 or 0x2AFC or 0x2AF9

Translates to:

> Failed to connect to IP-HTTPS interface.

## Cause

```output
Error: 0x103  
Role: Client  
URL: `https://da.contoso.com/IPHTTPS`  
Last Error Code: 0x103  
Interface Status: No usable certificate found  
0x103 translates to:  
ERROR_NO_MORE_ITEMS  
# No more data is available.  
(This means no matching certificates were found)
```

This error is seen in the following scenarios:  

- The IP-HTTPS URL does not match the certificate provided.
- The IP-HTTPS certificate has additional unwanted information in the Subject field.
- The IP-HTTPS certificate has the correct name in the Subject field, but incorrect values in the subject alternative name (SAN).

```output
Error: 0x2AFC  
Role: Client  
URL: `https://da.contoso.com/IPHTTPS`  
Last Error Code: 0x2AFC  
Interface Status: Failed to connect to IPHTTPs server; Waiting to reconnect.  
0x2AFC translates to:  
WSANO_DATA  
# The requested name is valid, but no data of the requested type was found.  
WSANO_DATA  
# Successfully returned a NULL value.  
```

There are several reasons this error may occur:  

- A proxy server is blocking the connection.
- Inability to resolve the name of the IP-HTTPS server (DirectAccess server) mentioned in the IP-HTTPS interface URL.
- Client-side or server-side firewall may be blocking the connection to the IP-HTTPS Server (DirectAccess server).
- NAT device is configured incorrectly (if a behind-edge scenario is being used).
- All connectivity is fine, but the server does not have the IPv6 prefix published, or server-side IP-HTTPS is set to disabled.

```output
Error: 0x2AF9  
Role: Client  
URL: `https://da.contoso.com/IPHTTPS`  
Last Error Code: 0x2AF9  
Interface Status: Failed to connect to the IPHTTPS server; waiting to reconnect  
0x2AF9 translates to:  
WSAHOST_NOT_FOUND  
# No such host is known.  
WSAHOST_NOT_FOUND  
# Non-NULL value successfully returned.  
```

There are several reasons this error may occur:  

- A proxy is blocking the connection.
- Inability to resolve the name of the IP-HTTPS server (DirectAccess server).
- Client-side or server-side firewall may be blocking the connection.
- NAT device in front of the DirectAccess server is configured incorrectly (if a behind-edge scenario is being used).
- All connectivity is fine, but the server does not have the IPv6 prefix published, or server-side IP-HTTPS is set to disabled.

## Resolution

Try to connect to the server through telnet by using the external IP address or name of the DirectAccess server on port 443. If it fails to connect, this may be because the packet is being dropped somewhere on the network, or the NAT rules are not created correctly on the external NAT device behind which DirectAccess is configured.

For more information, please see the "Plan firewall requirements" section of the following page at Microsoft Technet: [Plan the DirectAccess Infrastructure](https://technet.microsoft.com/library/jj574098.aspx)  
The external name should be resolvable from the client. Try to ping the name of the IP-HTTPS site name (the DirectAccess server public name), and check whether the name resolution is succeeding. If the name does not resolve, fix the name resolution.

> [!NOTE]
> We are just looking for success of name resolution of the DirectAccess server's public name to an IP address, and not the actual success of the Ping command.

If a telnet connection is successful, then look at a network trace. The SSL handshake should be successful.  

Reset the local system proxy settings. You can manipulate these settings by viewing the proxy settings in Internet Explorer. You must open Internet Explorer under the local system context rather than by using a normal account.  

DirectAccess clients may be configured to reach the HTTPS site through a proxy server (which may be blocking the connection). The latest proxy addresses are cached in the registry. To view them, open Registry Editor (regedit) on your DirectAccess client, and then navigate to the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iphlpsvc\Parameters\ProxyMgr`

Export the ProxyMgr registry subkey. If you no longer use the proxy server, remove all registry keys under this registry subkey, and then restart the DirectAccess client.

## More information

DirectAccess connectivity methods  

DirectAccess clients use multiple methods to connect to the DirectAccess server, which enables access to internal resources. Clients have the option to use either Teredo, 6to4, or IP-HTTPS to connect to DirectAccess. This also depends on how the DirectAccess server is configured.

When the DirectAccess client has a public IPv4 address, it will try to connect by using the 6to4 interface. However, some ISPs give the illusion of a public IP Address. What they provide to end users is a pseudo public IP address. What this means is that the IP address received by the DirectAccess client (a data card or SIM connection) might be an IP from the public address space, but in reality is behind one or more NATs.

When the client is behind a NAT device, it will try to use Teredo. Many businesses such as hotels, airports, and coffee shops do not allow Teredo traffic to traverse their firewall. In such scenarios, the client will fail over to IP-HTTPS. IP-HTTPS is built over an SSL (TLS) TCP 443-based connection. SSL outbound traffic will most likely be allowed on all networks.

Having this in mind, IP-HTTPS was built to provide a backup connection that is reliable and always reachable. A DirectAccess client will make use of this when other methods (such as Teredo or 6to4) fail.

More information about transition technologies can be found at [IPv6 transition technologies](https://technet.microsoft.com/library/bb726951.aspx).
