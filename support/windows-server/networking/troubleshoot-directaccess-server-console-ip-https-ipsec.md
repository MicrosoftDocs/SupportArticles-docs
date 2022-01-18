---
title: 'Troubleshoot IP-HTTPS and IPSec for DirectAccess server troubleshooting'
description: This article introduces how to troubleshoot IP-HTTPS and IPSec for DirectAccess server troubleshooting.
ms.date: 01/14/2022
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

This article introduces how to troubleshoot some IP-HTTPS and IPSec errors for DirectAccess Server console errors.

## IP-HTTPS: Route error

After installing and configuring DirectAccess in Windows Server, you may encounter an error message indicating that IP-HTTPS is not working properly. When you view the Operations Status overview in the Dashboard of the Remote Access Management console, it shows that the IP-HTTPS interface is in error.

:::image type="content" source="media/troubleshoot-directaccess-server-console-ip-https-ipsec/ip-https-error.png" alt-text="Screenshot of XXX" border="false":::

When you view the detailed Operations Status, the following error message is displayed.

> IP-HTTPS: Not working properly  
> Error:  
> The IP-HTTPS route does not have published property enabled.

### Cause

The publish property of the IP-HTTPS route has not been enabled. This is required for DirectAccess to work as expected.

### Resolution

To fix the Missing Route, check the routing table on the DirectAccess server. You will find that a route to the client IPv6 prefix is indeed missing.

To get information on the ClientIPv6Prefix, run the following command in the elevated version of the PowerShell:

```powershell
Get-RemoteAccess | Select-Object ClientIPv6Prefix.
```

To validate if the route is present, run the following command:

```powershell
Get-NetRoute -AddressFamily IPv6
```

If you don't see the entry for the route, it indicates that the route is not present and needs to be added.

To resolve this error message, add the client IPv6 route to the DirectAccess server’s routing table and publish it. This is accomplished by running the following PowerShell commands on the DirectAccess server.

```powershell
$IPv6prefix = (Get-RemoteAccess).ClientIPv6Prefix 
New-NetRoute -AddressFamily IPv6 -DestinationPrefix $IPv6prefix -InterfaceAlias “Microsoft IP-HTTPS Platform Interface” -Publish Yes 
```

Next, restart the Remote Access Management service (RaMgmtSvc) using the following PowerShell command.

```powershell
Restart-Service RaMgmtSvc -PassThru 
```

## IP-HTTPS: Certificate error

On other occasions, the issue can be related to the certificate itself and in this case since it has expired.

> IP-HTTPS: Not working properly  
> Error:  
> The IP-HTTPS certificate is not valid.

This issue occurs because the certificate has expired.

To resolve this issue, ensure that the certificate has not expired. Renew the certificate if it is.

## IP-HTTPS: Route Advertisement error

As the error is clear, we can double check if the route advertisement is disabled so we can enable it.

> IP-HTTPS: Not working property  
> Error:  
> Route advertisement is disabled on the IP-HTTPS adapter.

### Cause

This issue occurs because route advertisement is disabled on the IP-HTTPS. This feature is required for DirectAccess to work as expected.

### Resolution

Enable route advertisement on the ip-https adapter IPHTTPSInterface.

To check the information on the interfaces and their index, run the following command:

```console
netsh int ipv6 show int
```

See the line **Idx** 17.

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

The following command will show you the configuration for IPHTTPSInterface adapter:

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

Once we have the information on the index, we execute the following command to enable the forwarding.

```console
netsh int ipv6 set int 17 forwarding=enabled
```

If you see advertising disabled, then you can issue the following command to enable advertising.

```console
netsh int ipv6 set int 17 forwarding=enabled
```

## IPSec error

To be able to connect to internal resources, two connection security tunnels are configured by the remote access wizard, through GPO, and deployed on the DA clients & DA Servers.

One of the typical errors is the invalidity of the IP-HTTPS certificate installed on the DirectAccess Server.

> IPsec: Not working properly  
> Error:  
> There is no valid certificate to be used by Ipsec which chains to the root/intermediate certificate configured to be used by Ipsec in the DirectAccess configuration.

### Cause

This issue occurs because the certificate hasn't been installed or isn't valid.

### Resolution

To fix this error, we need to make sure that the iphttps certificate or the machine certificate on the client has not expired and its meets the criteria mentioned below:

- Should not be expired.
- Should have a private key.
- Should be configured to be used for client authentication.
- Should chain to the configured root/intermediate cert.
