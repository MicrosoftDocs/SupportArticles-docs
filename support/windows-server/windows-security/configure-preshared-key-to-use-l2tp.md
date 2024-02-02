---
title: Configure preshared key to use L2TP
description: Discusses how to configure a preshared key for use with Layer 2 Tunneling Protocol (L2TP).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:secure-channel-issues, csstroubleshoot
ms.subservice: windows-security
---
# Configure a preshared key for use with Layer 2 Tunneling Protocol Connections in Windows Server 2003

This article discusses how to configure a preshared key for use with Layer 2 Tunneling Protocol (L2TP).

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324258

## Summary

To use L2TP in Microsoft Windows Server 2003, you must have a public key infrastructure (PKI) to issue computer certificates to the virtual private network (VPN) server and to clients so that the Internet Key Exchange (IKE) authentication process can occur.

With Windows Server 2003, you can use a preshared key for IKE authentication. This feature is useful in environments that do not currently have a PKI in place, or in situations where Windows Server 2003 L2TP servers are making connections to third-party VPN servers that only support the use of preshared keys.

> [!NOTE]
> Microsoft does not encourage the use of preshared keys, because it is a less secure method of authentication than certificates. Preshared keys are not meant to replace the use of certificates; instead, preshared keys are another method for testing and internal operations. Microsoft strongly recommends that you use certificates with L2TP whenever possible.

The following sections describe how to configure the preshared keys on both the L2TP client and the server. If you use a Windows Server 2003 operating system for both client and VPN-based server, complete the instructions in both of these sections so that the L2TP that uses a preshared key can work. If you use a Windows Server 2003 VPN client and a third-party VPN-based server, you must follow the steps in the [Configure a preshared key on a VPN client](#configure-a-preshared-key-on-a-vpn-client) section of this article, and you must configure preshared keys on the third-party device.

## Configure a preshared key on a VPN client

1. In Control Panel, double-click **Network Connections**.
2. Under the **Virtual Private Network** section, right-click the connection for which you want to use a preshared key, and then click **Properties**.
3. Click the **Security** tab.
4. Click **IPSec Settings**.

    > [!NOTE]
    > **IPSec Settings** may be shaded if on the **Networking** tab, **Type of VPN** is set to PPTP VPN. A preshared key can only be configured if this option is set to **L2TP IPSec VPN** or **Automatic**.
5. Click to select the **Use preshared key for authentication** check box.
6. In the **Key** box, type the preshared key value. This value must match the preshared key value that is entered on the VPN-based server.
7. Click **OK** two times.

## Configure a preshared key on a VPN server

1. Start the Routing and Remote Access snap-in. To do this, click **Start**, point to **Administrative Tools**, and then click **Routing and Remote Access**.
2. Right-click the server that you will configure with the preshared key, and then click **Properties**.
3. Click **Security**.
4. Click to select the **Allow Custom IPSec Policy for L2TP connection** check box.
5. In the **Preshared key** box, type the preshared key value. This value must match the preshared key value entered on the VPN-based client.
6. Click **OK**.
