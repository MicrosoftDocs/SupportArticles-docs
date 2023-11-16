---
title: Configure TCP/IP Filtering
description: Describes how to configure TCP/IP filtering on Microsoft Windows 2003-based computers.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# How to configure TCP/IP Filtering in Windows Server 2003

This article describes how to configure TCP/IP filtering on Microsoft Windows 2003-based computers.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816792

## Summary

Windows 2003-based computers support several methods of controlling inbound access. One of the most simple and most powerful methods of controlling inbound access is to use the TCP/IP filtering feature. TCP/IP filtering is available on all Windows 2003-based computers.

TCP/IP filtering helps with security because it works in kernel mode. In contrast, other methods of controlling inbound access to Windows 2003-based computers, such as by using the IPSec Policy filter and the Routing and Remote Access server, depend on user-mode processes or the Workstation and Server services.

You can layer your TCP/IP inbound access control scheme by using TCP/IP filtering with IPSec filters and Routing and Remote Access packet filtering. This approach is especially useful if you want to control both inbound and outbound TCP/IP access, because TCP/IP security alone controls only inbound access.

> [!NOTE]
> TCP/IP filtering can filter only inbound traffic and can't block ICMP (Internet Control Message Protocol) messages, regardless of the settings that are configured in the **Permit Only IP Protocols** column or whether you don't permit Internet Protocol 1. Use IPSec Policies or packet filtering if you need more control over outbound access.

> [!NOTE]
> We recommend that you use the Configure E-mail and Internet Connection Wizard on SBS 2003-based computers with two network adaptors, and that you turn on the Firewall option and then open the required ports on the external network adaptor. For more information about the Configure E-mail and Internet Connection Wizard, select **Start**, and then select **Help and Support**. In the **Search** box, type Configure E-mail and Internet Connection Wizard, and then select **Start Searching**. You can find information about the Configure E-mail and Internet Connection Wizard in the Small Business Server Topics result set list.

## Configuring TCP/IP security in Windows Server 2003

To configure TCP/IP security:

1. Select **Start**, point to **Control Panel**, point to **Network Connections**, and then select the local area connection that you want to configure.
2. In the **Connection Status** dialog box, select **Properties**.
3. Select **Internet Protocol (TCP/IP)**, and then select **Properties**.
4. In the **Internet Protocol (TCP/IP) Properties** dialog box, select **Advanced**.
5. Select **Options**.
6. Under **Optional settings**, select **TCP/IP filtering**, and then select **Properties**.
7. Click to select the **Enable TCP/IP Filtering (All adaptors)** check box.

    > [!NOTE]
    > When you select this check box, you enable filtering for all adaptors, but you configure the filters individually for each adaptor. The same filters don't apply to all adaptors.
8. In the **TCP/IP Filtering** dialog box, there are three sections where you can configure filtering for TCP ports, User Datagram Protocol (UDP) ports, and Internet protocols. For each section, configure the security settings that are appropriate for your computer.

    > [!NOTE]
    > When **Permit All** is activated, you permit all packets for TCP or UDP traffic. **Permit Only** lets you to permit only selected TCP or UDP traffic by adding the allowed ports. To specify the ports, you use the **Add** button. To block all UDP or TCP traffic, select **Permit Only** but don't add any port numbers in the **UDP Ports** column or **TCP Ports** column. You can't block UDP or TCP traffic by selecting **Permit Only for IP Protocols** and excluding IP protocols 6 and 17.

## Configuring TCP/IP security in Windows Small Business Server 2003

To configure TCP/IP Filtering, follow these steps.

> [!NOTE]
> To perform this procedure, you must be a member of the Administrators group or the Network Configuration Operators group on the local computer.

1. Select **Start**, point to **Control Panel**, right-click **Network Connections**, and then select **Open**.

2. Right-click the network connection where you want to configure inbound access control, and then select **Properties**.
3. Under **adaptorName Connection Properties** on the **General** tab, select **Internet Protocol (TCP/IP)**, and then select **Properties**.
4. In the **Internet Protocol (TCP/IP) Properties** dialog box, select **Advanced**.
5. Select the **Options** tab.
6. Select **TCP/IP Filtering**, and then select **Properties**.
7. Click to select the **Enable TCP/IP Filtering (All adaptors)** check box.

    > [!NOTE]
    > When you select this check box, you enable filtering for all adaptors. However, filter configuration must be completed on each adaptor. When TCP/IP Filtering is enabled, you can configure each adaptor by selecting the **Permit All** option, or you could allow for only specific IP protocols, TCP ports, and UDP (User Datagram Protocol) ports to accept inbound connections. For example, if you enable TCP/IP Filtering and you configure the external network adaptor to permit only port 80, this lets the external network adaptor to accept Web traffic only. If the internal network adaptor also has TCP/IP Filtering enabled but is configured with the **Permit All** option selected, this enables unrestricted communication on the internal network adaptor.

8. Under **TCP/IP Filtering**, there are three columns with the following labels:

    - TCP Ports
    - UDP Ports
    - IP Protocols

    In each column, you must select one of the following options:

      - **Permit All**. Select this option if you want to permit all packets for TCP or UDP traffic.
      - **Permit Only**. Select this option if you want to permit only selected TCP or UDP traffic, select **Add**, and then type the appropriate port or protocol number in the **Add Filter** dialog box. You can't block UDP or TCP traffic by selecting **Permit Only** in the IP Protocols column and then adding IP protocols 6 and 17.
    > [!NOTE]
    > You can't block ICMP messages, even if you select **Permit Only** in the **IP Protocols** column and then you don't include IP protocol 1.

TCP/IP Filtering can filter only inbound traffic. This feature doesn't affect outbound traffic or TCP response ports that are created to accept responses from outbound requests. Use IPSec Policies or Routing and Remote Access packet filtering if you require more control over outbound access.

> [!NOTE]
> If you select **Permit Only** in UDP Ports, TCP Ports, or the IP Protocols column and the lists are left blank, the network adaptor will not be able to communicate with anything over a network, either locally or to the Internet.

## References

For more information about TCP and UDP port numbers, see [Service Name and Transport Protocol Port Number Registry](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml).
