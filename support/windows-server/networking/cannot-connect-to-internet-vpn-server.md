---
title: Can't connect to Internet on a VPN server
description: Provides a solution to fix an issue where you can't connect to the Internet after you log on to a server that's running Routing and Remote Access by using Virtual Private Network (VPN).
ms.date: 09/22/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, MASOUDH
ms.prod-support-area-path: Remote access
ms.technology: networking
---
# You can't connect to the Internet after you connect to a VPN server

This article provides help to fix an issue where you can't connect to the Internet after you log on to a server that's running Routing and Remote Access by using Virtual Private Network (VPN).

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 317025

## Symptoms

After you use a VPN connection to log on to a server that is running Routing and Remote Access, you may be unable to connect to the Internet.

## Cause

This issue may occur if you configure the VPN connection to use the default gateway on the remote network. This setting overrides the default gateway settings that you specify in your Transmission Control Protocol/Internet Protocol (TCP/IP) settings.

## Resolution

To resolve this issue, configure the client computers to use the default gateway setting on the local network for Internet traffic and a static route on the remote network for VPN-based traffic.

> [!NOTE]
> Because there are several versions of Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

### Step 1: Configure the server that's running Routing and Remote Access to use a static IP address pool

- Windows 2000 Server

    1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Routing and Remote Access**.
    2. Right-click the server that is running Routing and Remote Access, and then click **Properties**.
    3. Click the **IP** tab, click **Static address pool**, and then click **Add**.
    4. Type the start of the Internet Protocol (IP) address range in the **Start IP address** box, type the end of the IP address range in the **End IP address** box, and then click **OK**.

        > [!NOTE]
        > Configure a pool of static IP addresses on a different network segment than the network segment on which the internal local area network (LAN) exists.

    5. Click to select the **Enable IP routing** check box (if it is not already selected).
    6. Click **OK**.
    7. Enable TCP/IP forwarding.

- Windows NT Server 4.0

    1. Click **Start**, point to **Settings**, click **Control Panel**, and then double-click **Network**.
    2. Click the **Services** tab, click **Remote Access Service** in the **Network Services** list, and then click **Properties**.
    3. Click **Network**, click to select the TCP/IP check box (if it is not already selected), and then click **Configure** next to TCP/IP.
    4. Click **Use static address pool**.
    5. Type the start of the IP address range in the **Begin** box, type the end of the IP address range in the **End** box.

        > [!NOTE]
        > Configure a pool of static IP addresses on a different network segment than the network segment on which the internal LAN exists.
    6. If you want to exclude a range of IP addresses from the static address pool, type the starting IP address of the range that you want to exclude in the **From** box, type the ending IP address of the range that you want to exclude in the **To** box, and then click **Add**.
    7. Click **OK**, click **OK**, and then click **Continue**.
    8. Click the **Protocols** tab, click **TCP/IP Protocol**, click **Properties**, click the **Routing** tab, and then click to select the **Enable IP Forwarding** check box (if it is not already selected).
    9. Click **OK**, and then click **Close**.
    10. Click **Yes** to restart the computer.

### Step 2: Configure the VPN client TCP/IP properties

To disable the **Use Default Gateway on Remote Network** setting in the VPN dial-up connection item on the client computer:

1. Double-click **My Computer**, and then click the **Network and Dial-up Connections** link.
2. Right-click the VPN connection that you want to change, and then click **Properties**.
3. Click the **Networking** tab, click **Internet Protocol (TCP/IP)** in the **Components checked are used by this connection** list, and then click **Properties**.
4. Click **Advanced**, and then click to clear the **Use default gateway on remote network** check box.
5. Click **OK**, click **OK**, and then click **OK**.

### Step 3: Connect to the server that's running Routing and Remote Access

On the client computer, connect to the Internet, and then establish a VPN connection to the server that is running Routing and Remote Access.

> [!NOTE]
> You cannot connect to resources on the remote network because you have disabled the **Use Default Gateway on Remote Network** setting in the VPN TCP/IP configuration.

### Step 4: Add a static route on the client

Add a static route on the client computer that uses the following configuration:

- The remote network is the destination.
- The correct subnet mask is used for the remote network.
- The first IP address from the static IP address pool that you configured in the [Step 1: Configure the server that's running Routing and Remote Access to use a static IP address pool](#step-1-configure-the-server-thats-running-routing-and-remote-access-to-use-a-static-ip-address-pool) section of this article is the gateway.

> [!NOTE]
> The Routing and Remote Access server assigns this first IP address to its wide area network (WAN) Miniport driver.

For example, to add a static route to a network that has the IP address of 192.168.10.0, the subnet mask of 255.255.255.0, and the gateway (the first IP address of the range assigned to the static IP address pool) of 192.168.1.1, type the following command at the command prompt, and then press ENTER:

```console
route -p add 192.168.10.0 mask 255.255.255.0 192.168.1.1
```

> [!NOTE]
> If you use the -p switch with Windows 2000 or Windows NT 4.0, the route is made *persistent*. Use this switch to ensure that the routing entry is preserved when the computer is restarted.

> [!NOTE]
> The `-p` switch is not supported on either Microsoft Windows Millennium Edition-based, Microsoft Windows 98-based, or Microsoft Windows 95-based computers.

## Workaround

To work around this issue, create a batch file that contains the necessary route add command, and then configure it to run each time that a client connects to the VPN Server.
