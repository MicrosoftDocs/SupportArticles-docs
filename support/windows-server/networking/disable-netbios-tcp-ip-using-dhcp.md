---
title: Disable NetBIOS over TCP/IP by using DHCP
description: Describes how to disable NetBIOS over TCP/IP on the DHCP client by using DHCP server options.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, SKHALELI, abpathak, v-jomcc, MASOUDH
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# How to disable NetBIOS over TCP/IP by using DHCP server options

This article describes how to disable NetBIOS over TCP/IP on the DHCP client by using DHCP server options.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 313314

## Summary

The Windows Dynamic Host Configuration Protocol (DHCP) server provides a `Vendor class` option that you can use to disable NetBIOS over TCP/IP on the DHCP client.

## Disable NetBIOS on the DHCP server

To disable NetBIOS on the DHCP server, follow these steps:

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **DHCP**.
2. In the navigation pane, expand the **server_name**, expand **Scope**, right-click **Scope Options**, and then select **Configure Options**.
    > [!NOTE]
    > In this step, the **server_name** placeholder specifies the name of the DHCP server.
3. Select the **Advanced** tab, and then select **Microsoft Windows 2000 Options** in the **Vendor class** list.
4. Make sure that **Default User Class** is selected in the **User class** list.
5. Select the **001 Microsoft Disable Netbios Option** check box, under the **Available Options** column.
6. In the **Data entry** area, type 0x2 in the **Long** box, and then select **OK**.

## Configure the DHCP client to enable the DHCP server to determine NetBIOS behavior

- For Windows XP, Windows Server 2003, and Windows 2000

    1. On the desktop, right-click **My Network Places**, and then select **Properties**.
    2. Right-click **Local Area Connection**, and then select **Properties**.
    3. In the **Components checked are used by this connection** list, double-click **Internet Protocol (TCP/IP)**, select **Advanced**, and then select the **WINS** tab.

        > [!NOTE]
        > In Windows XP and in Windows Server 2003, you must double-click **Internet Protocol (TCP/IP)** in the **This connection uses the following items** list.
    4. Select **Use NetBIOS setting from the DHCP server**, and then select **OK** three times.

- For Windows Vista

    1. On the desktop, right-click **Network**, and then select **Properties**.
    2. Under **Tasks**, select **Manage network connections**.
    3. Right-click **Local Area Connection**, and then select **Properties**.
    4. In the **This connection uses the following items** list, double-click **Internet Protocol Version 4 (TCP/IPv4)**, select **Advanced**, and then select the **WINS** tab.
    5. Select **Use NetBIOS setting from the DHCP server**, and then select **OK** three times.

- For Windows 7

    1. Select **Start**, and then select **Control Panel**.
    2. Under **Network and Internet**, select **View network status and tasks**.

    3. Select **Change adapter settings**.
    4. Right-click **Local Area Connection**, and then select **Properties**.
    5. In the **This connection uses the following items** list, double-click **Internet Protocol Version 4 (TCP/IPv4)**, select **Advanced**, and then select the **WINS** tab.
    6. Select **Use NetBIOS setting from the DHCP server**, and then select **OK** three times.
