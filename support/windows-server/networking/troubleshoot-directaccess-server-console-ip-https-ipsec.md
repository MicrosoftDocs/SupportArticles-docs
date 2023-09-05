---
title: Troubleshoot IP-HTTPS and IPSec for DirectAccess server troubleshooting
description: This article discusses how to troubleshoot IP-HTTPS and IPSec for DirectAccess server troubleshooting.
ms.date: 01/19/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DirectAccess Server console: IP-HTTPS and IPSec

This article discusses how to troubleshoot some IP-HTTPS and IPSec errors for DirectAccess Server console errors.

## IP-HTTPS: Route error

After you install and configure DirectAccess in Windows Server, you may receive an error message that indicates that IP-HTTPS is not working correctly. When you view the **Operations Status** overview in the Dashboard of the Remote Access Management console, the display shows that the IP-HTTPS interface is in error.

:::image type="content" source="media/troubleshoot-directaccess-server-console-ip-https-ipsec/ip-https-error.png" alt-text="Screenshot of the Operations Status." :::

The Operations Status details show the following error message:

> IP-HTTPS: Not working properly  
> Error:  
> The IP-HTTPS route does not have published property enabled.

### Cause

The publishing property of the IP-HTTPS route is not enabled. This is required for DirectAccess to work as expected.

### Resolution

To fix the missing route, check the routing table on the DirectAccess server. You should see no route to the client IPv6 prefix.

To get information about the ClientIPv6Prefix, run the following command in an elevated PowerShell instance:

```powershell
Get-RemoteAccess | Select-Object ClientIPv6Prefix.
```

To determine whether the route exists, run the following command:

```powershell
Get-NetRoute -AddressFamily IPv6
```

If you don't see an entry for the route, this indicates that the route is not present and must be added.

To resolve this error, add the client IPv6 route to the DirectAccess server’s routing table, and then publish the route. To do this, run the following PowerShell commands on the DirectAccess server:

```powershell
$IPv6prefix = (Get-RemoteAccess).ClientIPv6Prefix 
New-NetRoute -AddressFamily IPv6 -DestinationPrefix $IPv6prefix -InterfaceAlias “Microsoft IP-HTTPS Platform Interface” -Publish Yes 
```

Next, restart the Remote Access Management service (RaMgmtSvc) by using the following PowerShell command:

```powershell
Restart-Service RaMgmtSvc -PassThru 
```

## IP-HTTPS: Certificate error

In other situations, the issue can be related to the certificate itself. That would be true in this instance because the certificate is expired:

> IP-HTTPS: Not working properly  
> Error:  
> The IP-HTTPS certificate is not valid.

To resolve this issue, make sure that the certificate is not expired. If it is, renew the certificate.

## IP-HTTPS: Route advertisement error

Because the error message is clear, check whether the route advertisement is disabled. If it is, enable it.

> IP-HTTPS: Not working property  
> Error:  
> Route advertisement is disabled on the IP-HTTPS adapter.

### Cause

This issue occurs because route advertisement is disabled on the IP-HTTPS adapter. This feature is required for DirectAccess to work as expected.

### Resolution

Enable route advertisement on the IP-HTTPS adapter IPHTTPSInterface.

To check the information on the interfaces and their index, run the following command:

```console
netsh int ipv6 show int
```

See the **Idx - 17** line.

```output
Idx      Met           MTU         State                 Name 
---   ----------   ----------   ------------   --------------------------- 
1        50        4294967295      connected   Loopback Pseudo-Interface 1 
1        45              1280      connected                  6TO4 Adapter 
15        5              1280      connected       isatap.{Interface Guid} 
16        5              1280      connected       isatap.{Interface Guid}
17       50              1280      connected              IPHTTPSInterface 
12        5              1500      connected                      Internal 
13        5              1500      connected                      External 
```

The following command will show you the configuration for the IPHTTPSInterface adapter:

```console
netsh int ipv6 show int "int inx for IPHTTPSInterface"
```

See the second line:

```output
Interface IPHTTPSInterface  Parameters
Forwarding: disabled
Advertising: enabled
Neighbor Discovery: enabled
Neighbor Unreachability Detection: enabled
Router Discovery: enabled
```

After you have information about the index, run the following command to enable forwarding:

```console
netsh int ipv6 set int 17 forwarding=enabled
```

If you notice that advertising is disabled, issue the following command to enable advertising:

```console
netsh int ipv6 set int 17 forwarding=enabled
```

## IPSec error

To be able to connect to internal resources, two connection security tunnels are configured by the remote access wizard through a GPO and deployed on the DA clients and DA servers.

One of the typical errors is an invalid IP-HTTPS certificate that's installed on the DirectAccess server:

> IPsec: Not working properly  
> Error:  
> There is no valid certificate to be used by Ipsec which chains to the root/intermediate certificate configured to be used by Ipsec in the DirectAccess configuration.

### Cause

This issue occurs because the certificate wasn't installed or isn't valid.

### Resolution

To fix this error, make sure that the IP-HTTPS certificate or the machine certificate on the client is not expired and meets the following criteria:

- Should not be expired.
- Should have a private key.
- Should be configured to be used for client authentication.
- Should chain to the configured root or intermediate certificate.
