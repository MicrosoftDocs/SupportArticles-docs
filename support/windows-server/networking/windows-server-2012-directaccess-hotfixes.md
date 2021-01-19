---
title: Recommended hotfixes and updates for Windows Server 2012 
description: Lists the recommended hotfixes and updates for Windows Server 2012 DirectAccess and Windows Server 2012 R2 DirectAccess.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Remote access
ms.technology: networking
---
# Recommended hotfixes and updates for Windows Server 2012 DirectAccess and Windows Server 2012 R2 DirectAccess

This article documents recommended hotfixes and product updates that are currently available for Windows Server 2012-based and Windows Server 2012 R2-based DirectAccess deployments. It also includes some known issues for Windows Server 2012 and Windows 2012 R2 DirectAccess that don't require a hotfix to resolve.

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 10  
_Original KB number:_ &nbsp; 2883952

## Summary

The updates are listed by the operating systems that they apply to. Some of the updates must be installed on DirectAccess servers and DirectAccess clients. The "Why we recommend this hotfix" column provides more information about each recommended update.

## Windows Server 2012 R2

| Date added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|May 12, 2015| [3047733](https://support.microsoft.com/help/3047733)|"No CA servers can be detected, and OTP cannot be configured." error when you enable OTP in Windows Server 2012 R2|DirectAccess components|Install this update on all Windows Server 2012 R2 Servers that have the DirectAccess role.|
|May 12, 2015| [3055343](https://support.microsoft.com/help/3055343)|Stop error code 0xD1, 0x139, or 0x3B and random crashes in Windows Server 2012 R2|DirectAccess components|Install this hotfix on all Windows Server 2012 R2 Servers that have the DirectAccess role.|
|May 12, 2015| [3047280](https://support.microsoft.com/help/3047280)|"The URL cannot be resolved" error during network location server setup for a DirectAccess server in Windows Server 2012 R2|DirectAccess components|Install this hotfix on all Windows Server 2012 R2 Servers that have the DirectAccess role.|
|March 10, 2015| [3035899](https://support.microsoft.com/help/3035899)|DirectAccess clients cannot establish connections when you use an authenticated web proxy from extranet in Windows|DirectAccess components|Install this hotfix on all Windows Server 2012 R2-based servers that act as DirectAccess clients for corporate connectivity.|
|March 6, 2015| [2895930](https://support.microsoft.com/help/2895930)|Remote Access Management leaks memory when a VPN or DirectAccess connection is used in Windows Server 2012 R2 or Windows Server 2012|Remote Access components|Install this hotfix on all Windows Server 2012 R2-based computers that have the Remote Access role installed.|
|September 3, 2014| [2975719](https://support.microsoft.com/help/2975719)|August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2<br/>|DirectAccess components|The August 2014 rollup for Windows Server 2012 R2 includes improvements to DirectAccess connectivity.|
|June 30, 2014| [2966087](https://support.microsoft.com/help/2966087)|You intermittently cannot connect to the DirectAccess server by using the IP-HTTPS adapter in Windows 8.1 or Windows Server 2012 R2|DirectAccess components|Install this hotfix on Windows Server 2012 R2 if your Windows Server 2012 R2 installation is a DirectAccess client.|
|April 1, 2014| [2929930](https://support.microsoft.com/help/2929930)|Host name cannot be resolved when you set up DirectAccess on a Windows Server 2012 R2-based computer in an IPv4-only environment|DirectAccess components|Install this recommended hotfix if you are configuring DirectAccess on a Windows Server 2012 R2 in an IPv4-only environment.|

## Windows Server 2012

| Date added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|September 3, 2014| [2973411](https://support.microsoft.com/help/2973411)|Client computer connects to an incorrect entry point when you start a Windows 8 or Windows Server 2012-based computer<br/>|DirectAccess components|Install this hotfix on Windows Server 2012 if you use it as a DirectAccess client.<br/>|
|April 1, 2014| [2895930](https://support.microsoft.com/help/2895930)|Remote Access Management leaks memory when a VPN or Direct Access connection is used in Windows Server 2012|Remote Access|Install this recommended hotfix if you are using DirectAccess or VPN on Windows Server 2012.|
|February 28, 2014| [2903938](https://support.microsoft.com/help/2903938)|Windows RT, Windows 8, and Windows Server 2012 update rollup: December 2013|DirectAccess-related drivers for 6 fixes|Apply this monthly rollup package to get 6 DirectAccess fixes.|
|September 6, 2013| [2859347](https://support.microsoft.com/help/2859347)|IPv6 address of a DirectAccess server binds to the wrong network interface in Windows Server 2012|DirectAccess administration components|We recommend this when you use an External Load Balancer with DirectAccess servers.|
|September 6, 2013| [2788525](https://support.microsoft.com/help/2788525)|You cannot enable external load balancing on a Windows Server 2012-based DirectAccess server|DirectAccess administration components|We recommend this when you use an External Load Balancer with DirectAccess servers.|
|September 6, 2013| [2782560](https://support.microsoft.com/help/2782560)|Clients cannot connect to IPv4-only resources when you use DirectAccess and external load balancing in Windows Server 2012|DirectAccess-related drivers|We recommend this when you use an External Load Balancer with DirectAccess servers.|
|September 6, 2013| [2836232](https://support.microsoft.com/help/2836232)|Subnet mask changes to an incorrect value and the server goes offline in DirectAccess in Windows Server 2012|DirectAccess administration components|You are using Network Load Balancing (NLB) with DirectAccess.|
|September 6, 2013| [2849568](https://support.microsoft.com/help/2849568)|MS13-064: Vulnerability in the Windows NAT driver could allow denial of service: August 13, 2013|Windows NAT driver used by DirectAccess|This is a recommended security update.|
|September 6, 2013| [2765809](https://support.microsoft.com/help/2765809)|MS12-083: Vulnerability in IP-HTTPS component could allow security feature bypass: December 11, 2012|DirectAccess-related drivers|This is a recommended security update.|
|September 6, 2013| [2855269](https://support.microsoft.com/help/2855269)|Error message when you use an account that contains a special character in its DN to connect to a Windows Server 2012-based Direct Access server|Credential provider|If you have one-time password (OTP) user authentication deployed, DirectAccess Clients may be unable to connect. This fix is required on DirectAccess Servers and Clients.|
|September 6, 2013| [2845152](https://support.microsoft.com/help/2845152)|DirectAccess server cannot ping a DNS server or a domain controller in Windows Server 2012|Windows NAT driver used by DirectAccess|DirectAccess clients may be unable to connect.|
|September 6, 2013| [2844033](https://support.microsoft.com/help/2844033)|Add an Entry Point Wizard fails on a Windows Server 2012-based server in a domain that has a disjoint namespace|DirectAccess administration components|If you have a disjoint DNS namespace.|
|September 6, 2013| [2796394](https://support.microsoft.com/help/2796394)|Error when you run the Get-RemoteAccess cmdlet during DirectAccess setup in Windows Server 2012 Essentials|DirectAccess administration components|You are deploying DirectAccess for Windows 7 clients, using Windows Server 2012 Essentials.|
|September 6, 2013| [2795944](https://support.microsoft.com/help/2795944)|Windows 8 and Windows Server 2012 update rollup: February 2013|DirectAccess-related drivers|This update includes fixes for DirectAccess Servers that provide stability under heavy load.|
|September 6, 2013| [2769240](https://support.microsoft.com/help/2769240)|You cannot connect a DirectAccess client to a corporate network in Windows 8 or Windows Server 2012|Kerberos|If you deployed DirectAccess to use a Kerberos Key Distribution Center (KDC) proxy service.|
|September 6, 2013| [2779768](https://support.microsoft.com/help/2779768)|Windows 8 and Windows Server 2012 update rollup: December 2012|IPSec|If you adjust the IPSec DSOP settings and experience a bugcheck.|

## Windows 8.1

| Date added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|March 10, 2015| [3035899](https://support.microsoft.com/help/3035899)|DirectAccess clients cannot establish connections when you use an authenticated web proxy from extranet in Windows|DirectAccess components|Install this hotfix on all Windows 8.1-based clients that act as DirectAccess clients for corporate connectivity.|
|September 3, 2014| [2975719](https://support.microsoft.com/help/2975719)|August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2<br/>|DirectAccess components|The August 2014 rollup for Windows 8.1 includes improvements to DirectAccess connectivity.|
|July 22, 2014| [2973071](https://support.microsoft.com/help/2973071)|"HTTP 403" or "0x80040001" error when a DirectAccess server requires OTP authentication in Windows RT 8.1 or Windows 8.1|DirectAccess components|Install this hotfix on Windows 8.1 computers if you connect to the DirectAccess server by using One-Time Password Certificate Enrollment (OTPCE) protocol authentication through an HTTPS connection.|
|June 30, 2014| [2966087](https://support.microsoft.com/help/2966087)|You intermittently cannot connect to the DirectAccess server by using the IP-HTTPS adapter in Windows 8.1 or Windows Server 2012 R2|DirectAccess components|Install this hotfix on all Windows 8.1 DirectAccess clients to ensure seamless connectivity.|
|June 30, 2014| [2964833](https://support.microsoft.com/help/2964833)|Windows 8.1 cannot connect over DirectAccess to a Remote Desktop Session Host server farm|RDP client-based components|Install this hotfix on all Windows 8.1 DirectAccess clients to ensure they can connect to their target endpoint in the RD Session Host server farm.|
|June 30, 2014| [2953212](https://support.microsoft.com/help/2953212)|You can't disable the NRPT in Windows 8 or Windows 8.1|DirectAccess components|Apply this hotfix if your users bring their Windows 8.1 computers inside the corporate network.|

## Windows 8

| Date added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|September 3, 2014| [2973411](https://support.microsoft.com/help/2973411)|Client computer connects to an incorrect entry point when you start a Windows 8 or Windows Server 2012-based computer|DirectAccess components|Install this hotfix on all Windows 8 Computers that use DirectAccess to connect to the corporate network.<br/>|
|June 30, 2014| [2953212](https://support.microsoft.com/help/2953212)|You can't disable the NRPT in Windows 8 or Windows 8.1|DirectAccess components|Apply this hotfix if your users bring their Windows 8 computers inside the corporate network.|
|February 28, 2014| [2893301](https://support.microsoft.com/help/2893301)|DirectAccess can't connect to a corporate network in Windows 8 or Windows Server 2012|DirectAccess|If you have Windows 8 or Window Server 2012 DirectAccess clients, apply this fix.|
|September 6, 2013| [2855269](https://support.microsoft.com/help/2855269)|Error message when you use an account that contains a special character in its DN to connect to a Windows Server 2012-based Direct Access server|Credential provider|If you have one-time password (OTP) user authentication deployed, DirectAccess Clients may be unable to connect. This fix is required on DirectAccess Servers and Clients.|
|September 6, 2013| [2769240](https://support.microsoft.com/help/2769240)|You cannot connect a DirectAccess client to a corporate network in Windows 8 or Windows Server 2012|Kerberos|If you deployed DirectAccess to use a Kerberos Key Distribution Center (KDC) proxy service.|

## Windows 7

| Date added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|March 6, 2015| [2615847](https://support.microsoft.com/help/2615847)|"ERROR_IPSEC_IKE_CERT_CHAIN_POLICY_MISMATCH" error when you try to start an IPsec connection between two computers that are running Windows 7 or Windows Server 2008 R2|Not applicable|Install this hotfix on all Windows 7-based computers that connect to a corporate network by using DirectAccess.|
|July 22, 2014| [2964833](https://support.microsoft.com/help/2964833)|Windows 8.1 cannot connect over DirectAccess to a Remote Desktop Session Host server farm|RDP client-based components|Install this hotfix on all Windows 7 DirectAccess clients to ensure they can connect to their target endpoint in the RD Session Host server farm.|
|June 30, 2014| [2951611](https://support.microsoft.com/help/2951611)|DirectAccess is used for internal network connections in Windows 7 SP1|DirectAccess components|Install this hotfix if you have Windows 7 SP1 DirectAccess clients.|
|June 6, 2014| [2939489](https://support.microsoft.com/help/2939489)|"HTTP 403" or "0x80040001" error when you connect to a DirectAccess server from a DCA tool in Windows 7 SP1||Install this hotfix if you use DirectAccess Connectivity Assistant 2.0 tool on Windows 7 SP1 machines and use the tool to connect to the DirectAccess server by using One-Time Password Certificate Enrollment (OTPCE) protocol authentication through an HTTPS connection.|
|February 28, 2014| [2912883](https://support.microsoft.com/help/2912883)|Remote Assistance connection to a Windows 7 SP1-based Direct Access client computer fails|Remote Assistance related|Apply this hotfix if you use Windows 7 SP1 and use Remote Assistance.|
|February 28, 2014| [2882659](https://support.microsoft.com/help/2882659)|FIX: "Corporate connectivity is not working" tooltip is displayed for the DirectAccess Assistant 2.0 tray icon in the French version of Windows 7 SP1|DirectAccess Assistance related|Apply this hotfix if you use a French version of Windows 7 SP1.|
|September 6, 2013| [2796313](https://support.microsoft.com/help/2796313)|Long reconnection time after a DirectAccess server disconnects a Windows 7-based DirectAccess client|DirectAccess-related drivers|DirectAccess clients may be unable to connect.|
|September 6, 2013| [2718654](https://support.microsoft.com/help/2718654)|You are prompted to enter credentials when you try to access a SharePoint server on a Windows 7 SP1-based or Windows Server 2008 R2 SP1-based computer|DNS Client|If you encounter this issue on DirectAccess clients.|
|September 6, 2013| [2680464](https://support.microsoft.com/help/2680464)|Location detection feature in DirectAccess is disabled intermittently in Windows 7 or in Windows Server 2008 R2|Network Location components|DirectAccess clients may be unable to connect.|
|September 6, 2013| [2535133](https://support.microsoft.com/help/2535133)|IP-HTTPS clients may disconnect from Windows Server 2008 R2-based web servers intermittently after two minutes of idle time|DirectAccess-related drivers|If you are using IP-HTTPS.|
|September 6, 2013| [2288297](https://support.microsoft.com/help/2288297)|You are unexpectedly prompted to enter your credentials when you try to access a WebDAV resource in a corporate network by using a DirectAccess connection in Windows 7 or in Windows Server 2008 R2|WebDAV client|If you encounter this issue on DirectAccess clients.|
|September 6, 2013| [979373](https://support.microsoft.com/help/979373)|The DirectAccess connection is lost on a computer that is running Windows 7 or Windows Server 2008 R2 that has an IPv6 address|DirectAccess-related drivers|DirectAccess clients may be unable to connect.|

## References

[DirectAccess clients may be unable to connect when a static proxy is configured](https://support.microsoft.com/help/3017472)

[Update adds BPA rules for DirectAccess in Windows Server 2012 R2 or Windows Server 2012](https://support.microsoft.com/help/2896496)

[Microsoft Windows DirectAccess Client Troubleshooting Tool](https://www.microsoft.com/download/details.aspx?id=41938)

[DirectAccess clients may not be able to connect to a DirectAccess server with error 0x800b0109 when using IP-HTTPS](https://support.microsoft.com/help/2980667)

[DirectAccess clients can connect over Teredo, but are unable to connect by using IP-HTTPS](https://support.microsoft.com/help/2980660)

[DirectAccess clients may not be able to connect to DirectAccess server with error code 0x103, 0x2AFC, or 0x2AF9 when using IP-HTTPS](https://support.microsoft.com/help/2980635)

[DirectAccess clients may not be able to connect with error 0x80092013](https://support.microsoft.com/help/2980672)

[Prerequisites for Deploying DirectAccess](https://technet.microsoft.com/library/dn464273.aspx)

[DirectAccess unsupported configurations](https://technet.microsoft.com/library/dn464274.aspx)

[Troubleshooting DirectAccess](https://technet.microsoft.com/library/dn467926.aspx)

[Deploy a single DirectAccess Server using the Getting Started Wizard](https://technet.microsoft.com/library/hh831520.aspx)

[Deploy a single DirectAccess Server with advanced settings](https://technet.microsoft.com/library/hh831436.aspx)