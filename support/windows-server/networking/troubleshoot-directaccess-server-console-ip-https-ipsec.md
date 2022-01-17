---
title: 
description: 
ms.date: 01/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, MASOUDH
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
IP-HTTPS 
For this we may see different errors and some of them are mentioned below.
1.Route Issue 
After installing and configuring DirectAccess in Windows Server you may encounter an error message indicating that IP-HTTPS is not working properly. Looking at the Operations Status overview in the Dashboard of the Remote Access Management console shows that the IP-HTTPS interface is in error. 
 
 
 



Viewing the detailed Operations Status shows the following error message. 
Details 
IP-HTTPS: Not working properly 
Error: 
The IP-HTTPS route does not have published property enabled. 
Causes: 
The Publish property of the IP-HTTPS route has not been enabled. This is required for DirectAccess to work as expected.
Resolution: 
Set the property on the route. 
 
To fix the Missing Route 
Looking at the routing table on the DirectAccess server reveals that a route to the client IPv6 prefix is indeed missing. 
To get information on the ClientIPv6Prefix run the following command in the elevated version of the PowerShell: -
Get-RemoteAccess | Select-Object ClientIPv6Prefix.
To validate if the route is present then issue the following command: -
Get-NetRoute -AddressFamily IPv6
If you don’t see the entry for the route then that is not present and needs to be added.
To resolve this error message, add the client IPv6 route to the DirectAccess server’s routing table and publish it. This is accomplished by running the following PowerShell commands on the DirectAccess server. 
$IPv6prefix = (Get-RemoteAccess).ClientIPv6Prefix 
New-NetRoute -AddressFamily IPv6 -DestinationPrefix $IPv6prefix -InterfaceAlias “Microsoft IP-HTTPS Platform Interface” -Publish Yes 
Next, restart the Remote Access Management service (RaMgmtSvc) using the following PowerShell command. 
Restart-Service RaMgmtSvc -PassThru 

2.	Certificate Issue 
On other occasions the issue can be related to the certificate itself and in this case since it has expired
Error: 
The IP-HTTPS certificate is not valid.
Causes:
The certificate has expired
Resolution: 
Ensure that the certificate has not expired
Renew the certificate.

To fix the issue we will need to see if the cert has not expired and if it has expired then we need to renew it.
 
3.Route Advertisement 
As the error is clear we can double check if the route advertisement is disabled so we can enable it 
 IP-HTTPS: Not working property 
Error: 
Route advertisement is disabled on the IP-HTTPS adapter. 
Causes: 
Route advertisement is disabled on the IP-HTTPS. This is required for DirectAccess to work as expected. 
Resolution: 
Enable route advertisement on the ip-https adapter IPHTTPSInterface.
 netsh int ipv6 show int will give you information on the interfaces and their index.
 Idx     Met         MTU                         State                 Name 
---     ----------  ----------                       ------------        --------------------------- 
1        50        4294967295                connected      Loopback Pseudo-Interface 1 
1        45                      1280               connected      6TO4 Adapter 
15        5                      1280               connected      isatap.{Interface Guid} 
16        5                      1280               connected      isatap.{{Interface Guid}
17      50                      1280               connected     IPHTTPSInterface 
12        5                      1500               connected     Internal 
13        5                      1500               connected     External 
 
netsh int ipv6 show int “int inx for IPHTTPSInterface" will show you the configuration for IPHTTPSInterface adapter.
 Interface IPHTTPSInterface  Parameters 
Forwarding: disabled 
Advertising: enabled 
Neighbor Discovery: enabled 
Neighbor Unreachability Detection: enabled 
Router Discovery: enabled 
Once we have the information on the index, we execute the following command to enable the forwarding.
Netsh int ipv6 set int 17 forwarding=enabled 
If you see advertising disabled, then you can issue the following command to enable advertising
Netsh int ipv6 set int 17 forwarding=enabled

IPSec 
To be able to connect to internal resources, two connection security tunnels are configured by the remote access wizard, thru GPO, and deployed on the DA clients & DA Servers. 
One of the typical errors is the invalidity of the IP-HTTPS certificate installed on the Direct Access Server. 
 IPsec: Not working properly
Error: 
There is no valid certificate to be used by Ipsec which chains to the root/intermediate certificate configured to be used by Ipsec in the DirectAccess configuration.
Causes:
The certificate has not been installed or is not valid. 
Resolution: 
Please ensure that a valid certificate is present in the machine store and DA server is configured to use the corresponding root certificate.
The valid certificate must satisfy the following:
Should not be expired.
Should have a private key.
Should be configured to be used for client authentication.
Should chain to the configured root/intermediate cert.

To fix this error we need to make sure that the iphttps certificate (Or machine certificate) on the client has not expired and its meets the criteria mentioned below: -
Should not be expired.
Should have a private key.
Should be configured to be used for client authentication.
Should chain to the configured root/intermediate cert.
