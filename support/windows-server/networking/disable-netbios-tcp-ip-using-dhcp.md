---
title: Disable NetBIOS over TCP/IP by using DHCP
description: Describes how to disable NetBIOS over TCP/IP on the DHCP client by using DHCP server options.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, SKHALELI, abpathak, v-jomcc, MASOUDH
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# How to disable NetBIOS over TCP/IP by using DHCP server options

This article describes how to disable NetBIOS over TCP/IP on the DHCP client by using DHCP server options.

_Original KB number:_ &nbsp; 313314

## Summary

The Windows Dynamic Host Configuration Protocol (DHCP) server provides a `Vendor class` option that you can use to disable NetBIOS over TCP/IP on the DHCP client.

## Disable NetBIOS on the DHCP server

To disable NetBIOS on the DHCP server, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **DHCP**.
2. In the navigation pane, expand the **server_name**, expand **Scope**, right-click **Scope Options**, and then select **Configure Options**.
    > [!NOTE]
    > In this step, the **server_name** placeholder specifies the name of the DHCP server.
3. Select the **Advanced** tab, and then select **Microsoft Windows 2000 Options** in the **Vendor class** list.
4. Make sure that **Default User Class** is selected in the **User class** list.
5. Select the **001 Microsoft Disable Netbios Option** check box, under the **Available Options** column.
6. In the **Data entry** area, type 0x2 in the **Long** box, and then select **OK**.

## Configure the DHCP client to enable the DHCP server to determine NetBIOS behavior

- For Windows 7

    1. Select **Start**, and then select **Control Panel**.
    2. Under **Network and Internet**, select **View network status and tasks**.
    3. Select **Change adapter settings**.
    4. Right-click **Local Area Connection**, and then select **Properties**.
    5. In the **This connection uses the following items** list, double-click **Internet Protocol Version 4 (TCP/IPv4)**, select **Advanced**, and then select the **WINS** tab.
    6. Select **Use NetBIOS setting from the DHCP server**, and then select **OK** three times.

- For Windows 10 and windows 11

    1. Select **Start**, and then input **View Network Connections**
    2. Right-click **Local Area Connection**, and then select **Properties**.
    3. In the **This connection uses the following items** list, double-click **Internet Protocol Version 4 (TCP/IPv4)**, select **Advanced**, and then select the **WINS** tab.
    4. Select **Use NetBIOS setting from the DHCP server**, and then select **OK** three times.
