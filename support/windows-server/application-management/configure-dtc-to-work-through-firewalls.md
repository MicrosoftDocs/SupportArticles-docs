---
title: Configure Distributed Transaction Coordinator (DTC) to work through a firewall
description: Describes how to configure DTC to work through firewalls.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jmeier, niklase, shaheera, jpierauc
ms.custom: sap:dtc-startup-configuration-connectivity-and-cluster, csstroubleshoot
---
# Configure Microsoft Distributed Transaction Coordinator (DTC) to work through a firewall

This article describes how to configure Microsoft Distributed Transaction Coordinator (DTC) to work through firewalls.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 250367

## More information

You can configure DTC to communicate through firewalls, including network address translation firewalls.

DTC uses Remote Procedure Call (RPC) dynamic port allocation by default. RPC dynamic port allocation randomly selects port numbers in the 49152-65535 range. By modifying the registry, you can control which ports RPC dynamically allocates for incoming communication. You can then configure your firewall to confine incoming external communication to only those ports and port 135 (the RPC Endpoint Mapper port). It is recommended to use either fixed port for DTC services or the default dynamic 49152-65535 range in firewalls to avoid port exhaustion and only change to custom RPC ports if firewalls cannot filter on computer or IPs.

You can have one local DTC instance and multiple clustered DTC instances. You may need to provide more incoming dynamic ports for other subsystems that rely on RPC so it is recommended to keep default RPC range even if using fixed port for DTC services.

The registry keys and values described in this article don't appear in the registry by default; you must add them by using Registry Editor.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Window](https://support.microsoft.com/help/322756).

### Configure DTC to use single fixed port

Follow these steps on computers involved in DTC transactions to set fixed port for DTC. The firewall must be open in both directions for the fixed port and port 135 (the RPC Endpoint Mapper port):

1. To start Registry Editor, select **Start**, select **Run**, type *regedt32*, and then select **OK**.
2. In Registry Editor, select **HKEY_LOCAL_MACHINE** in the **Local Machine** window.
3. Expand the tree by double-selecting the folders named in the `HKEY_LOCAL_MACHINE\Software\Microsoft\MSDTC` path.
4. Select the MSDTC folder, and then select **New > DWORD (32-bit) Value** on the **Edit** menu.
5. Change the **Name** to *ServerTcpPort*.
6. Right-click and choose **Modify** on the new value.
7. In the **Value Editor** dialog box, select **Decimal** and then put your fixed port number, e g 40001, in the **Value data** field, and then select **OK**.

To configure fixed port for clustered DTC instances, you need to find the cluster resource GUID and add the **ServerTcpPort** value under this location. Use different port number for each DTC instance. For example, if your DTC resource GUID is 012345678-9abc-def0-1234-56789abcdef0, then it would be in this path: `HKEY_LOCAL_MACHINE\Cluster\Resources\012345678-9abc-def0-1234-56789abcdef0\MSDTCPRIVATE\MSDTC`. Repeat the steps for additional DTC clustered resources.

Alternative, you can use the `reg add` commands in scripts with administrator privileges to do this operation. Adjust the following example to your specific cluster GUID if clustered DTC instance is used:

```console
reg add HKLM\SOFTWARE\Microsoft\MSDTC /v ServerTcpPort /t REG_DWORD /d 40001 /f
reg add HKLM\Cluster\Resources\012345678-9abc-def0-1234-56789abcdef0\MSDTCPRIVATE\MSDTC /v ServerTcpPort /t REG_DWORD /d 40002 /f
```

### Configure RPC to use customer port range

Follow these steps on computers involved in DTC transactions where firewalls prevent full communication to control RPC dynamic port allocation. The firewall must be open in both directions for the specified ports and port 135 (the RPC Endpoint Mapper port):

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

   Each string value you type specifies either a single port or an inclusive range of ports. For example, to open port 40000, specify **40000** without the quotation marks. To open ports 40000 to 42000 inclusive, specify **40000-42000** without the quotation marks. You can specify multiple ports or ports ranges by specifying one port or port range per line. All ports must be in the range of 1024 to 65535. If any port is outside this range or if any string is invalid, RPC will treat the entire configuration as invalid.

   Microsoft recommends that you open up ports from 20000 and up, as lower ports may often be in use by other applications, and that you open a minimum of 1000 ports to avoid port exhaustion. On high load systems you may need more ports. The default range of 1024-5000 was moved in Windows 2008 and above to 49152-65535 range to avoid port exhaustion.

10. Follow steps 6 through 9 to add another key for Internet, by using these values:

    > Value: PortsInternetAvailable  
    Data Type: REG_SZ  
    Data: Y

    This value signifies that the ports listed under the Ports value are to be made Internet-available.

11. Follow steps 6 through 9 to add another key for Internet, by using these values:

    > Value: UseInternetPorts  
    Data Type: REG_SZ  
    Data: Y

    This value signifies that RPC should dynamically assign ports from the list of Internet ports.

12. Configure your firewall to allow incoming access to the specified dynamic ports and to port 135 (the RPC Endpoint Mapper port).

13. Restart the computer. When RPC restarts, it will assign incoming ports dynamically, based on the registry values that you've specified. For example, to open ports 40000 through 42000 inclusive, create these named values:

    > Ports : REG_MULTI-SZ : 40000-42000  
    PortsInternetAvailable : REG_SZ : Y  
    UseInternetPorts : REG_SZ : Y

DTC also requires you can resolve computer names by way of NetBIOS or DNS. Check that NetBIOS is enabled in the NIC properties and test if NetBIOS can resolve the names by using ping and the server name. The client computer must be able to resolve the name of the server. And the server must be able to resolve the name of the client. If NetBIOS can't resolve the names, add entries to the LMHOSTS files on the computers.
