---
title: Configure Distributed Transaction Coordinator (DTC) to work through a firewall
description: Describes how to configure DTC to work through firewalls.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jmeier
ms.prod-support-area-path: DTC startup, configuration, connectivity, and cluster
ms.technology: windows-server-application-compatibility
---
# Configure Microsoft Distributed Transaction Coordinator (DTC) to work through a firewall

This article describes how to configure Microsoft Distributed Transaction Coordinator (DTC) to work through firewalls.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 250367

## More information

You can configure DTC to communicate through firewalls, including network address translation firewalls.

DTC uses Remote Procedure Call (RPC) dynamic port allocation. By default, RPC dynamic port allocation randomly selects port numbers above 1024. By modifying the registry, you can control which ports RPC dynamically allocates for incoming communication. You can then configure your firewall to confine incoming external communication to only those ports and port 135 (the RPC Endpoint Mapper port).

You must provide one incoming dynamic port for DTC. You may need to provide more incoming dynamic ports for other subsystems that rely on RPC.

The registry keys and values described in this article don't appear in the registry by default; you must add them by using Registry Editor.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Window](https://support.microsoft.com/help/322756).

Follow these steps on both computers to control RPC dynamic port allocation. The firewall must be open in both directions for the specified ports:

1. To start Registry Editor, select **Start**, select **Run**, type *regedt32*, and then select **OK**.

   Use Regedt32.exe instead of Regedit.exe. Regedit.exe doesn't support the REG_MULTI_SZ data type that's required for the Ports value.

2. In Registry Editor, select **HKEY_LOCAL_MACHINE** in the **Local Machine** window.
3. Expand the tree by double-selecting the folders named in the `HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc` path.

4. Select the RPC folder, and then select **Add Key** on the **Edit** menu.
5. In the **Add Key** dialog box, in the **Key Name** box, type *Internet*, and then select **OK**.
6. Select the Internet folder, and then select **Add Value** on the **Edit** menu.
7. In the **Add Value** dialog box, in the **Value Name** box, type *Ports*.
8. In the **Data Type** box, select **REG_MULTI_SZ**, and then select **OK**.
9. In the **Multi-String Editor** dialog box, in the **Data** box, specify the port or ports you want RPC to use for dynamic port allocation, and then select **OK**.

   Each string value you type specifies either a single port or an inclusive range of ports. For example, to open port 5000, specify **5000** without the quotation marks. To open ports 5000 to 5020 inclusive, specify **5000-5020** without the quotation marks. You can specify multiple ports or ports ranges by specifying one port or port range per line. All ports must be in the range of 1024 to 65535. If any port is outside this range or if any string is invalid, RPC will treat the entire configuration as invalid.

   Microsoft recommends that you open up ports from 5000 and up, and that you open a minimum of 15 to 20 ports.

10. Follow steps 6 through 9 to add another key for Internet, by using these values:

    > Value: PortsInternetAvailable  
    Data Type: REG_SZ  
    Data: Y

    This value signifies that the ports listed under the Ports value are to be made Internet-available.

11. Follow steps 6 through 9 to add another key for Internet, by using these values:

    > Value: UseInternetPorts  
    Data Type: REG_SZ  
    Data: Y

    This signifies that RPC should dynamically assign ports from the list of Internet ports.

12. Configure your firewall to allow incoming access to the specified dynamic ports and to port 135 (the RPC Endpoint Mapper port).

13. Restart the computer. When RPC restarts, it will assign incoming ports dynamically, based on the registry values that you've specified. For example, to open ports 5000 through 5020 inclusive, create these named values:

    > Ports : REG_MULTI-SZ : 5000-5020  
    PortsInternetAvailable : REG_SZ : Y  
    UseInternetPorts : REG_SZ : Y

DTC also requires that you can resolve computer names by way of NetBIOS or DNS. Test if NetBIOS can resolve the names by using ping and the server name. The client computer must be able to resolve the name of the server, and the server must be able to resolve the name of the client. If NetBIOS can't resolve the names, add entries to the LMHOSTS files on the computers.
