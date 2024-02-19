---
title: Description of the Remote Desktop Connection 6.1 client update for Terminal Services
description: Describes the Remote Desktop Connection 6.1 client update and how it affects Terminal Services in Windows Vista SP1, in Windows XP SP3, and in Windows Server 2008.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: ayesham, kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Description of the Remote Desktop Connection 6.1 client update for Terminal Services

This article describes the Remote Desktop Connection 6.1 client update and how it affects Terminal Services in Windows Vista SP1, in Windows XP SP3, and in Windows Server 2008.

> [!NOTE]
> Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951616

## Introduction

This article discusses the Remote Desktop Connection (RDC) 6.1 client update that helps you use the new Terminal Services features. These features are introduced in Windows Vista and in Windows Server 2008 and are available from a computer that is running one of the following operating systems:

- Windows Vista with Service Pack 1 (SP1)

    [935791](https://support.microsoft.com/help/935791) How to obtain the latest Windows Vista service pack  

- Windows XP with Service Pack 3 (SP3)

    [322389](https://support.microsoft.com/help/322389) How to obtain the latest Windows XP service pack  

- Windows Server 2008

    The RDC 6.1 client can be used to connect to legacy terminal servers or to remote desktops as before. However, the new features that are mentioned in this article are available only when the client connects to a remote computer that is running Windows Vista or Windows Server 2008.

## More information

The RDC 6.1 client update contains the following features.

### Terminal Services Web Access

Terminal Services Web Access (TS Web Access) is a service in Terminal Services that lets you make Windows Server 2008 Terminal Services RemoteApp (TS RemoteApp) programs available to users from a Web browser. You can also use TS Web Access to make a link available to the terminal server desktop. Additionally, TS Web Access enables users to open a connection from a Web browser to the remote desktop of any server or client computer to which the users have the appropriate access.

### Remote Desktop Protocol (RDP) Signing

RDP signing lets users sign RDP files and connections that are opened from TS Web Access. This feature helps users make sure that they aren't using malicious RDP files to connect to potentially hostile terminal servers. You can also use Group Policy settings to specify that a user can only open signed files. This feature lets administrators make sure that users connect only to known resources.

### Terminal Services EasyPrint

Terminal Services Easy Print is the new printer redirection solution that was introduced in Windows Server 2008. Terminal Services Easy Print makes sure that client printers are always installed in remote sessions and that you don't have to install the printer drivers on the terminal server. Additionally, Terminal Services Easy Print addresses several other printer redirection issues that have been problematic in the past. Print queues are now enumerated per session, all printer properties are available in the remote session, and terminal server administrators can use a policy setting to redirect only the default printer. Terminal Services Easy Print is now the default printer redirection mechanism in Terminal Services. Therefore, no configuration is required to use this feature.

#### What is required to use Terminal Services Easy Print

To use Terminal Services Easy Print Windows, Windows Server 2008 must be installed on the Terminal Services server. No additional drivers have to be installed, and no additional configuration has to occur. On the Terminal Services client, the user must be running Terminal Services client 6.1 and the Microsoft .NET Framework 3.0 with SP1.

### Network Level Authentication

Network Level Authentication (NLA) is a new authentication method that finishes user authentication before you establish a full Remote Desktop connection and before the logon screen appears. Windows XP SP3 uses RDC 6.1 to support NLA. This feature improves the authentication method, and it can help protect the remote computer from malicious users and malicious software. NLA has the following benefits:

- It requires fewer remote computer resources. The remote computer uses a limited number of resources before it authenticates the user. Earlier authentication methods required the remote computer to start a full Remote Desktop connection.

- It can help provide better security by reducing the risk of malicious attacks that could limit or prevent access to the Internet.

- It uses remote computer authentication. This feature can help protect users from connecting to remote computers that are set up for malicious purposes.

> [!NOTE]
> By default, Network Level Authentication (NLA) is disabled in Windows XP Service Pack 3. To enable NLA, you have to turn on the Credential Security Service Provider (CredSSP).

### Server authentication

In RDC 6.1, server authentication verifies that you're connecting to the correct remote computer or remote server. This security feature helps prevent you from connecting to a computer or server to which you didn't intend to connect. This feature also prevents you from unintentionally exposing confidential information.

By default, server authentication is enabled for the connection. However, if you want to change server authentication settings, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, click **Communication**, and then click **Remote Desktop Connection**.

2. Click **Options**, and then click the **Advanced** tab.

The three available authentication options are as follows:

- **Always connect, even if authentication fails**  

    If you enable this option, you can connect even if RDC 6.1 can't verify the identity of the remote computer.

- **Warn me if authentication fails**  

    If you enable this option, RDC 6.1 tells you if it can't verify the identity of the remote computer. This option gives you the choice of whether to continue with the connection.

- **Do not connect if authentication fails**  

    If you enable this option, you can't connect if RDC 6.1 can't verify the identity of the remote computer.

### Resource redirection

The RDC 6.1 client helps you redirect Plug and Play devices that support redirection.

To redirect a Plug and Play device, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, click **Communication**, and then click **Remote Desktop Connection**.

2. Click **Options**, click the **Local Resources** tab, click **More**, and then select the **Supported Plug and Play devices** check box.

### Terminal Server Gateway servers

A Terminal Server Gateway (TS Gateway) server is a kind of gateway that enables authorized users to connect to remote computers on a corporate network. These authorized users can connect from any computer by using an Internet connection. TS Gateway uses the Remote Desktop Protocol (RDP) together with the HTTPS protocol to help create a more secure encrypted connection.

Earlier versions of RDC can't connect to remote computers across firewalls and across network address translators. This is because port 3389 is typically blocked to improve network security. Port 3389 is the port that is used for Remote Desktop connections. However, a TS Gateway server uses port 443. Port 443 transmits data through a Secure Sockets Layer (SSL) tunnel.

A TS Gateway server has the following benefits:

- It enables Remote Desktop connections to a corporate network from the Internet without requiring a virtual private network (VPN) connection.

- It enables connections to remote computers across firewalls.

- It helps you share a network connection with other programs that are running on the computer. This enables you to use the Internet service provider (ISP) connection instead of the corporate network to send and to receive data over the remote connection.

To specify a TS Gateway server, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, click **Communication**, and then click **Remote Desktop Connection**.

2. Click **Options**, click the **Advanced** tab, and then click **Settings**.

3. Click **Use these TS Gateway server settings**, type the server name in the **Server name** box, and then select one of the following logon methods from the **Logon methods** list:

    - **Allow me to select later**  
    This option lets you select a logon method when you connect.

    - **Ask for password**  
    This option prompts you for a password when you connect.

    - **Smart card**  
    This option prompts you to insert a smart card when you connect.

4. Select or clear the **Bypass TS Gateway server for local addresses** check box. By selecting this check box, you prevent the traffic that is moving to and from local network addresses from being routed through the TS Gateway server. This option makes the connection faster.

### Terminal Services RemoteApp

TS RemoteApp is a feature of Windows Server Terminal Services that lets users on client computers connect to a remote computer and run programs that are installed on the remote computer. For example, employees may be able to connect to a remote computer at a workplace, and they may be able to run Microsoft Word on that computer. An administrator must publish the programs for users to be able to access the programs. The experience is the same as running a program that is installed on the local computer.

TS RemoteApp makes system administration easier because there is only one copy of a program to upgrade and to maintain instead of many copies that are installed on individual computers.

### Monitor spanning

Remote Desktop Connection supports high-resolution displays that span multiple monitors. However, the total resolution on all monitors must be under 4096 x 2048 pixels. The monitors must have the same resolution. Additionally, the monitors must be aligned side by side.

To make the desktop of the remote computer span multiple monitors, type *Mstsc /span* at a command prompt.

### Visual improvements

Remote Desktop Connection now supports 32-bit color and font smoothing.

To enable 32-bit color, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, click **Communication**, and then click **Remote Desktop Connection**.

2. Click **Options**, click the **Display** tab, and then click **Highest Quality (32 bit)** in the **Colors** list.

To enable font smoothing, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, click **Communication**, and then click **Remote Desktop Connection**.

2. Click **Options**, click the **Experience** tab, and then select the **Font smoothing** check box.
