---
title: Set up Internet Connection Sharing
description: Describes how to install Internet Connection Sharing (ICS) on a Microsoft Windows Server 2003-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, JAMIRC
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# Set Up Internet Connection Sharing in Windows Server 2003

This article describes how to install Internet Connection Sharing (ICS) on a Microsoft Windows Server 2003-based computer.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324286

## Summary

ICS permits you to use Windows Server 2003 to connect a small office network or home network over the Internet. ICS provides Network Address Translation (NAT), IP addressing, and name resolution services for all the computers on a small network.

The following hardware or software is required for this procedure:

- A digital subscriber line (DSL) or cable modem connected to an Internet service provider (ISP) and an activated DSL or cable account.
- Two installed network adapters. This article describes how to install a second network adapter.
- A network already configured with functioning TCP/IP.

Before proceeding with the procedures in this article, note the following points:

- Do not use ICS on a network that:

  - Uses static IP addresses
  - Has a Windows Server 2003 domain controller
  - Uses other DNS servers, gateways, or DHCP servers

    Because ICS creates a static IP address for your network adapter and allocates IP addresses to other computers on your network, you will lose your connection to the rest of the network if other network computers already provide those services. If one or more of these conditions exist in your network, you must use Windows Server 2003 NAT instead of ICS. For more information about NAT, see Windows Server 2003 Help.

- Do not create a virtual private network (VPN) connection to a corporate network from the ICS computer. If you do, by default all traffic from the ICS computer, including traffic from local area network clients, will be forwarded over the VPN connection to the corporate network. This means that Internet resources will no longer be reachable, and all the client computers will be sending data over the logical connection created with the credentials of the ICS computer user.

- Do not configure ICS on a computer that is a VPN server. If your Windows Server 2003-based computer is serving as a VPN server, you must use Windows Server 2003 NAT.

## Install a second ethernet network adapter to the ICS host computer

To install another Ethernet adapter to the ICS host computer, you must log on as a member of the Administrators group.

1. Shut down your computer properly, and then physically add the network adapter.
2. Restart your computer.
3. When the **Found New Hardware** dialog box is displayed that lists the name of the network adapter that you installed, click **Next**.
4. Click **Next** on the **Install Hardware Device Drivers** page.
5. On the **Locate Driver Files** page, click the media option that contains the drivers for the network adapter that you are installing. For example, click **CD-ROM drive**, **Floppy drive** or **Hard Drive Directory**.
6. On the **Driver Files Search Results** page, click **Finish**.

> [!NOTE]
> When you click **Finish**, the installation of the network adapter that you just installed is completed.

## Configure the ICS host computer

The ICS host computer provides a connection through the second network adapter to the existing TCP/IP network. Log on as member of the Administrators group to set up the ICS host computer.

1. Click **Start**, click **Control Panel**, and then click **Network Connections**.
2. Right-click **Local Area Connection** (the network card that you just installed), and then rename it *The Internet Connection*.

    In the **Network and Dial-up Connections** dialog box, two connections are displayed (for different network adapters): The Internet Connection and Local Area Connection.

3. Right-click **The Internet Connection**, and then click **Properties**.
4. Click the **General** tab, and then verify that **Client for Microsoft Networks** and **Internet Protocol (TCP/IP)** are displayed.
5. Click the **Advanced** tab, and then click to select the **Enable Internet Connection Sharing for this Connection** check box.

    > [!NOTE]
    > Make sure that firewall software or other Internet sharing software from any third-party manufacturer have been removed.
6. Click **OK**, and then return to the desktop.

## Configure the Windows client

> [!NOTE]
> Because there are several versions of Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

Log on as a member of the Administrators group to set up the Windows clients that will share the Internet connection.

1. Click **Start**, click **Control Panel**, and then double-click **Network Connections**.
2. Right-click **Local Area Connection**, and then click **Properties**.
3. Click the **General** tab, and then verify that **Client for Microsoft Networks** and **Internet Protocol (TCP/IP)** are displayed and selected.
4. Click **Internet Protocol (TCP/IP)**, and then click **Properties**.
5. Click the **General** tab, click **Obtain an IP address automatically**, and then click **Obtain DNS server address automatically** (if these options are not already selected).
6. Click **Advanced**, and then make sure that the various lists on the IP Settings, DNS, and WINS tabs are all empty.

    > [!NOTE]
    > ICS provides these settings.

7. Click **OK**, and then return to the desktop.

## ICS and Dial-up networking

You can use Dial-up Networking to connect to the Internet. However, Dial-up Networking typically has a lower bandwidth connection. This connection is not as useful when multiple computers share the connection. Additionally, Dial-up Networking is not persistent (you have to manually dial up to make a connection) and can cause initial delays when you connect to hosts on the Internet.

## Troubleshooting

Note the following items to prevent issues from occurring when you configure ICS:

- Do not connect a hub directly to your DSL or cable modem. If you do so, your internal network is vulnerable to other computers located on the Internet. If you do connect a computer directly to a DSL or cable modem, make sure that you turn off file and printer sharing to limit your vulnerability from the Internet. However, when you do so, your network is prevented from sharing files and printers, which may be your primary reason for networking in the first place.

- Verify that firewall software or other Internet sharing software from third-party manufacturers has been removed. Make sure that only the ICS-enabled computer is providing IP addresses, forwarding DNS names, or acting as a default gateway. If not, ICS may not work or you may experience unexpected behavior.

- You cannot modify the configuration of ICS. For example, you cannot prevent ICS from allocating IP addresses or modify the IP addresses that ICS has allocated. If these features are required, you must run NAT instead.

- The ICS computer automatically assigns IP addresses, forwards DNS names to the Internet for name resolution, and assigns itself as the default gateway for connections to the Internet. If the ICS-enabled computer is unavailable, the other client computers on your network cannot access the Internet.

- When you configure your network to use TCP/IP, remove instances of the NetBEUI protocol when you find them. NetBEUI is redundant and may slow down the network.
