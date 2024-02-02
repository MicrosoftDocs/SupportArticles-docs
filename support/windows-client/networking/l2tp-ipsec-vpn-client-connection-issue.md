---
title: Troubleshoot L2TP/IPSec VPN client connection
description: Describes how to troubleshoot L2TP/IPSec virtual private network (VPN) connection issues.
ms.date: 09/22/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, MASOUDH
ms.custom: sap:remote-access, csstroubleshoot
ms.subservice: networking
---
# How to troubleshoot a Microsoft L2TP/IPSec virtual private network client connection

This article describes how to troubleshoot L2TP/IPSec virtual private network (VPN) connection issues.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 325034

## Summary

You must have an Internet connection before you can make an L2TP/IPSec VPN connection. If you try to make a VPN connection before you have an Internet connection, you may experience a long delay, typically 60 seconds, and then you may receive an error message that says there was no response or something is wrong with the modem or other communication device.

When you troubleshoot L2TP/IPSec connections, it's useful to understand how an L2TP/IPSec connection proceeds. When you start the connection, an initial L2TP packet is sent to the server, requesting a connection. This packet causes the IPSec layer on your computer to negotiate with the VPN server to set up an IPSec protected session (a security association). Depending on many factors including link speed, the IPSec negotiations may take from a few seconds to around two minutes. When an IPSec security association (SA) has been established, the L2TP session starts. When it starts, you receive a prompt for your name and password (unless the connection has been set up to connect automatically in Windows Millennium Edition.) If the VPN server accepts your name and password, the session setup completes.

A common configuration failure in an L2TP/IPSec connection is a misconfigured or missing certificate, or a misconfigured or missing preshared key. If the IPSec layer can't establish an encrypted session with the VPN server, it will fail silently. As a result, the L2TP layer doesn't see a response to its connection request. There will be a long delay, typically 60 seconds, and then you may receive an error message that says there was no response from the server or there was no response from the modem or communication device. If you receive this error message before you receive the prompt for your name and password, IPSec didn't establish its session. If that occurs, examine your certificate or preshared key configuration, or send the isakmp log to your network administrator.

A second common problem that prevents a successful IPSec session is using a Network Address Translation (NAT). Many small networks use a router with NAT functionality to share a single Internet address among all the computers on the network. The original version of IPSec drops a connection that goes through a NAT because it detects the NAT's address-mapping as packet tampering. Home networks frequently use a NAT. This blocks using L2TP/IPSec unless the client and the VPN gateway both support the emerging IPSec NAT-Traversal (NAT-T) standard. For more information, see the "NAT Traversal" section.

If the connection fails after you receive the prompt for your name and password, the IPSec session has been established and there's probably something wrong with your name and password. Other server settings may also be preventing a successful L2TP connection. In this case, send the PPP log to your administrator.

## NAT Traversal

With the IPSec NAT-T support in the Microsoft L2TP/IPSec VPN client, IPSec sessions can go through a NAT when the VPN server also supports IPSec NAT-T. IPSec NAT-T is supported by Windows Server 2003. IPSec NAT-T is also supported by Windows 2000 Server with the L2TP/IPSec NAT-T update for Windows XP and Windows 2000.

For third-party VPN servers and gateways, contact your administrator or VPN gateway vendor to verify that IPSec NAT-T is supported.

## More information

The configuration utility also provides a check box that enables IPSec logging. If you can't connect, and your network administrator or support personnel have asked you to provide them a connection log, you can enable IPSec logging here. When you do so, the log (Isakmp.log) is created in the `C:\Program Files\Microsoft IPSec VPN` folder. When you create a connection, also enable logging for the PPP processing in L2TP. To do so:

1. Right-click the **Dialup Networking** folder, and then click **Properties**.
2. Click the **Networking** tab, and then click to select the **Record a log file for this connection** check box.

The PPP log file is `C:\Windows\Ppplog.txt`. It's located in the `C:\Program Files\Microsoft IPSec VPN` folder.

For more information, see [Default Encryption Settings for the Microsoft L2TP/IPSec Virtual Private Network Client](https://support.microsoft.com/help/325158).
