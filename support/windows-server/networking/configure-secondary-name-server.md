---
title: Configure a secondary name server
description: Describes how to configure a secondary DNS server.
ms.date: 12/02/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
ms.technology: networking
---
# Configure a secondary name server in Windows Server 2003  

This step-by-step article describes how to configure a secondary DNS server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816518

## Identify the secondary name server

On the primary DNS server, identify an additional name server. To do this, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
2. In the console tree, expand **Host name** (where **Host name** is the host name of the DNS server).
3. In the console tree, expand **Forward Lookup Zones**.
4. Right-click the zone that you want (for example, `example.com`), and then click **Properties**.
5. Click the **Name Servers** tab, and then click **Add**.
6. In the **Server fully qualified domain name (FQDN)** box, type the host name of the server that you want to add.

    For example, type `namesvr2.example.com`.

7. In the **IP address** box, type the IP address of the name server that you want to add (for example, 192.168.0.22), and then click **Add**.

8. Click **OK**, and then click **OK**.
9. In the console tree, click **Reverse Lookup Zones**, right-click the zone that you want, and then click **Properties**.
10. Click the **Name Servers** tab, and then click **Add**.
11. In the **Server name** box, type the host name of the server that you want to add.

    For example, `namesvr2.example.com`.

12. In the **IP address** box, type the IP address of the name server that you want to add (for example, 192.168.0.22), and then click **Add**.

13. Click **OK** two times.

### Install DNS on the secondary name server

To install the DNS service, follow these steps:

1. Log on to the computer as an administrator.
2. Click **Start**, point to **Control Panel**, and then click **Add or Remove Programs**.
3. Click **Add\Remove Windows Components**.
4. In the **Components** list, click **Networking Services** (do not click to select or click to clear the check box), and then click **Details**.
5. Click to select the **Domain Name System (DNS)** check box, and then click **OK**.
6. On the **Windows Components** page, click **Next**.
7. Insert the Windows 2003 Server CD when you are prompted, and then click **OK**.
8. On the **Completing the Windows Components Wizard** page, click **Finish**.
9. Click **Close**.

    DNS is now installed. To start the DNS snap-in, click **Start**, point to **Administrative Tools**, and then click **DNS**.

## Configure the forward lookup zone

To configure the forward lookup zone on the secondary name server, follow these steps:

1. Log on to the secondary name server as an administrator.
2. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
3. In the console tree, under **DNS**, click **Host name** (where **Host name** is the host name of the DNS server).
4. In the console tree, click **Forward Lookup Zones**.
5. Right-click **Forward Lookup Zones**, and then click **New Zone**.
6. When the New Zone Wizard starts, click **Next** to continue.
7. Click **Secondary Zone**, and then click **Next**.
8. In the **Name** box, type the name of the zone (for example, `example.com`), and then click **Next**.
9. On the **Master DNS Servers** page, type the IP address of the primary name server for this zone, click **Add**, click **Next**, and then click **Finish**.

## Configure the reverse lookup zone

To configure the reverse lookup zone on the secondary name server, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
2. In the console tree, click **Host name** (where **Host name** is the host name of the DNS server).
3. In the console tree, click **Reverse Lookup Zones**.
4. Right-click **Reverse Lookup Zones**, and then click **New Zone**.
5. When the New Zone Wizard starts, click **Next** to continue.
6. Click **Secondary zone**, and then click **Next**.
7. In the **Network ID** box, type the network ID (for example, type 192.168.0), and then click **Next**.

    > [!NOTE]
    > The network ID is that portion of the TCP/IP address that pertains to the network.

    For more information about TCP/IP networks, see [Understand TCP/IP Addressing and Subnetting Basics](../../windows-client/networking/tcpip-addressing-and-subnetting.md).

8. On the **Zone File** page, click **Next**, and then click **Finish**.

## Troubleshoot an error: The zone is not loaded by the DNS server

When you select a zone on the secondary name server, you may receive the following error message in the right pane of the DNS window:

> Zone not loaded by DNS Server
>
> The DNS server encountered an error while attempting to load the zone.  
> The transfer of zone data from the main server failed.

This issue may occur if zone transfers are disabled. To resolve this issue, follow these steps:

1. Log on to the primary name server computer as an administrator.
2. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
3. In the console tree, click **Host name** (where **Host name** is the host name of the DNS server).
4. In the console tree, click **Forward Lookup Zones**.
5. Under **Forward Lookup Zones**, right-click the zone that you want (for example, **example**.com), and then click **Properties**.
6. Click the **Zone Transfers** tab.
7. Click to select the **Allow zone transfers** check box, and then click one of the following options:

    - **To any server**  
    - **Only to servers listed on the Name Servers tab**  
    - **Only to the following servers**.

    > [!NOTE]
    > If you click **Only to the following servers**, type the IP address of the secondary name server in the **IP address** box, and then click **Add**.
8. Click **Apply**, and then click **OK**.
9. Quit the DNS snap-in.

## Troubleshoot DNS

To troubleshoot and obtain information about the DNS configuration, use the [Nslookup](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc725991(v=ws.11)) utility.

For more information about how to install and configure DNS, see [How To Install and Configure DNS Server in Windows Server 2003](https://support.microsoft.com/help/814591).
