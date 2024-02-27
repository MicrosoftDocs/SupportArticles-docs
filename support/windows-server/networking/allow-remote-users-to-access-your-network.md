---
title: How to allow remote users to access your network in Windows Server 2003
description: Describes how to configure a computer that is running Windows Server 2003 to allow remote users to establish an encrypted channel to a corporate network.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# How to allow remote users to access your network in Windows Server 2003  

This article describes how to configure a computer that is running Windows Server 2003 to allow remote users to establish an encrypted channel to a corporate network.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323381

## Summary

Users can connect to a remote access server through a dial-up connection or a virtual private network (VPN) connection.

A dial-up connection requires both the server and the client computer to have a correctly configured modem. The client and the server connect over analog public telephone networks. To enhance the security of a dial-up connection, use data encryption, Windows logon and domain security, remote access policies and callback security.

A VPN connection is made over a public network, for example the Internet, and uses Point-to-Point Tunneling Protocol (PPTP), logon and domain security, and remote access policies to help secure the transfer of data.

The scenarios that are described in this article assume the following configurations:

- For dial-up connection capability, the modems are configured on the server.
- For VPN capability, the server has two network adapters, with one of them connected directly to the Internet.
- For VPN capability, PPTP is used for the VPN tunnel.
- No routing protocols, such as Routing Information Protocol (RIP) or Open Shortest Path First (OSPF), are configured.

The following topics describes how to configure Routing and Remote Access Service in Windows Server 2003.

## Turn on Routing and Remote Access Service

The Routing and Remote Access service is automatically installed during the installation of Windows Server 2003. By default, however, this service is turned off.

## Turn on Windows Server 2003 Routing and Remote Access Service to allow dial-up connections or VPN connections

1. Click **Start**, point to **Administrative Tools**, and then click **Routing and Remote Access**.
2. In the console directory, click **Your_Server_Name**.
3. In the lower-right corner of the server icon next to **Your_Server_Name**, there is a circle that contains an arrow that indicates whether the Routing and Remote Access service is on or off:

   - If the circle contains a red arrow that points down, the Routing and Remote Access service is not turned on.
   - If the circle contains a green arrow that points up, the Routing and Remote Access service is turned on.
  
    If the Routing and Remote Access service is turned on and you want to reconfigure the server, you must turn off the Routing and Remote Access service. To do this, follow these steps:

    1. Right-click **Your_Server_Name**, and then click **Disable Routing and Remote Access**.
    2. In the dialog box, click **Yes**.

4. Right-click **Your_Server_Name**, and then click **Configure and Enable Routing and Remote Access** to start the Routing and Remote Access Server Setup Wizard.
5. Click **Next**, click **Remote access (dial-up or VPN)**, and then click **Next**.
6. Click either **VPN** or **Dial-up**, depending on the role that you want to assign to this server.
7. Under **How do you want IP addresses to be assigned to remote clients?**, click either **Automatically** or **From a specific range of addresses**, and then click **Next**.
8. If you clicked **Automatically**, go to step 9.

    If you clicked **From a specific range of addresses**, follow these steps:

    1. In the **Address Range Assignment** dialog box, click **New**.
    2. In the **Start IP address** box, type the first address of the range of IP addresses that you want to use.
    3. In the **End IP address** box, type the last address of the range of IP addresses that you want to use, click
    **OK**, and then click **Next**.

9. Click **No, use Routing and Remote Access to authenticate connection requests**, and then click **Next**.
10. Click **Finish** to turn on the Routing and Remote Access service and to configure the server as a Remote Access server.

## Allow access to all users or individual users

Before users can connect to the server, you must configure the server to either accept all remote access clients or you must grant dial-in access permissions to individual users.

To allow the server to accept all remote access clients, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Routing and Remote Access**.
2. Double-click **Your_Server_Name**, and then click **Remote Access Policies**.
3. Right-click **Connections to Microsoft Routing and Remote Access server**, and then click **Properties**.
4. Click **Grant remote access permission**, and then click **OK**.

To grant dial-up access permission to individual users, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. Right-click the user account that you want to allow remote access, and then click **Properties**.
3. Click the **Dial-in** tab, click **Allow access**, and then click **OK**.
4. Close the **UserAccountProperties** dialog box.

## Troubleshoot

The number of dial-up modem connections depends on the number of modems that are installed on the server. If you have only one modem installed on the server, you can only have one modem connection at a time.

The number of VPN connections depends on the number of users that you want to allow access at one time. By default, 128 connections are permitted. To change this number, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Routing and Remote Access**.
2. Double-click **Your_Server_Name**, right-click **Ports**, and then click **Properties**.
3. In the **Ports Properties** dialog box, click **WAN Miniport (PPTP)**, and then click **Configure**.
4. In the **Maximum ports** box, type the number of VPN connections that you want to allow.
5. Click **OK**, click **OK** again, and then quit Routing and Remote Access.
