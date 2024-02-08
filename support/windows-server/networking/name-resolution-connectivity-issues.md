---
title: Name resolution and connectivity issues
description: Provides a solution to name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, JOELSCH
ms.custom: sap:dns, csstroubleshoot
ms.subservice: networking
---
# Name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS

This article provides a solution to name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 292822

## Symptoms

A computer that is running Microsoft Windows 2000 Server or Microsoft Windows Server 2003 may exhibit connectivity issues if the server is configured in the following manner:

- The Routing and Remote Access service is configured to permit incoming connections.
- The Domain Name System (DNS) or Windows Internet Name Server (WINS) service is installed and configured on the server that is running Routing and Remote Access.

After a remote computer connects to the Routing and Remote Access server by using a dial-up or a Virtual Private Networking (VPN) connection, one or more of the following symptoms may occur intermittently:

- If the Routing and Remote Access server is also running Microsoft Internet Security and Acceleration (ISA) Server 2000, you can't browse the Web from client computers on the local network, regardless of whether the computers are configured to use Web Proxy or the Microsoft Firewall Client. For example, "The page cannot be displayed" may appear in the Web browser with a "cannot find server or DNS" error message.

- If the Routing and Remote Access server is running ISA Server 2000, and a user on a client computer selects **Update Now** in the **Firewall Client Options** dialog box, the user receives the following error message:

    > The server is not responding when client requests an update.  
    Possible causes:  
    -The server is not an ISA Server.  
    -The server is down.

- When you try to ping the Routing and Remote Access server from a local computer by using the server's NetBIOS name or fully qualified domain name (FQDN), the computer tries to ping the wrong IP address.
- If the Routing and Remote Access server is the master browser for the network, you can't browse the list of computers in Network Neighborhood or My Network Places.
- You can't connect to the http://**server_name**/myconsole  
site on a Small Business Server 2000 computer.
- On the Routing and Remote Access server, you receive an event message that is similar to the following:

    ```output
    Event ID: 4319
    Source: Netbt
    Description: A duplicate name has been detected on the tcp network. The IP address of the machine that sent the message is in the data. Use NBTSTAT with a switch of N in a command window to see which name is in a conflict state.
    ```

- You receive error messages when you try to open file shares or map network drives to the Routing and Remote Access server.
- If the Routing and Remote Access server is also a domain controller, you receive error messages when you try to sign in the network.
- If the Routing and Remote Access server is a domain controller, you receive error messages when you try to open file shares or map network drives to any shared resource on the network. For example, computers that are running Microsoft Windows 2000 Professional or Microsoft Windows XP Professional receive an error message that is similar to the following:
    > No Logon Servers Available to Service your Logon Request

This issue typically affects computers that are running Small Business Server because this version of Windows Server is frequently the only server on the network. However, the issue can affect any Windows 2000-based server or any Windows Server 2003-based Routing and Remote Access server that is running the DNS or the WINS service.

## Cause

When a remote computer connects to the Routing and Remote Access server by using a dial-up or a VPN connection, the server creates a Point-to-Point Protocol (PPP) adapter to communicate with the remote computer. The server may then register the IP address of this PPP adapter in the DNS or the WINS database.

When the Routing and Remote Access server registers the IP address of its PPP adapter in DNS or WINS, you may receive errors on the local computers when you try to connect to the server. You receive these errors because the DNS or WINS servers may return the IP address of the PPP adapter to computers that query DNS or WINS for the server's IP address. The computers then try to connect to the IP address of the PPP adapter. Because the local computers can't reach the PPP adapter, the connections fail.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)

To resolve this issue, configure the Routing and Remote Access server to prevent it from registering the IP address of its PPP adapter in the DNS or the WINS database. To do it, follow these steps:

### Configure the Routing and Remote Access server to publish only the IP address of the local network adapter in DNS

Complete the steps in this section only if the Routing and Remote Access server is running the DNS service. If the server isn't running the DNS service, go to the [Configure the Routing and Remote Access server to register only the IP address of the local network adapter in WINS](#configure-the-routing-and-remote-access-server-to-register-only-the-ip-address-of-the-local-network-adapter-in-wins) section.

### Add the PublishAddresses and RegisterDnsARecords registry values for the DNS and Netlogon services

1. Select **Start**, select **Run**, type regedit, and then select **OK**.
2. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters`

3. On the **Edit** menu, point to **New**, and then select **String Value** to add the following registry value:
    > Value name: PublishAddresses  
    Data type: REG_SZ  
    Value data: IP address of the server's local network adapter. If you have to specify more than one IP address, separate the addresses with spaces.

4. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

5. On the **Edit** menu, point to **New**, and then select **DWORD Value** to add the following registry value:

    > Value name: RegisterDnsARecords  
    Data type: REG_DWORD  
    Value data: 0

6. Close Registry Editor, and then restart the DNS and Netlogon services. To restart a service, select **Start**, point to **Programs** or **All Programs**, point to **Administrative Tools**, and then select **Services**. In the Services console, right-click the service, and then select **Restart**.

### Add the A Records in DNS

Complete these steps only if the Routing and Remote Access server is a domain controller.

1. Select **Start**, point to **Programs** or **All Programs**, point to **Administrative Tools**, and then select **DNS**.
2. In the DNS console, expand the server object, expand the **Forward Lookup Zones** folder, and then select the folder for the local domain.
3. On the **Action** menu, select **New Host**.
4. In the **IP address** text box, type the IP address of the server's local network adapter.
5. Leave the **Name** box empty, select **Create Associated PTR Record**, and then select **Add Host**.
6. When you receive the "(same as parent folder) is not a valid host name. Are you sure you want to add this record?" message, select **Yes**.

    > [!NOTE]
    > If the server is a global catalog server, go to step 7. If the server isn't a global catalog server, you don't have to complete steps 7 through 11. To determine if the server is a global catalog server, follow these steps:
      1. Select **Start**, point to **Programs** or **All Programs**, point to **Administrative Tools**, and then select **Active Directory Sites and Services**.
      2. In the Active Directory Sites and Services console, expand the **Sites** folder, expand the site that contains the server, and then expand the server object.
      3. Right-click **NTDS Settings**, and then select **Properties**.
      4. On the **General** tab, locate the **Global Catalog** check box. If this check box is checked, the server is a global catalog server.
7. Under the **Forward Lookup Zones** folder in the DNS console, expand the folder for the local domain, expand the **MSDCS** folder, and then select the **GC** folder.
8. On the **Action** menu, select **New Host**.
9. In the **IP address** box, type the IP address of the server's local network adapter.
10. Leave the **Name** box empty, select **Create Associated PTR Record**, and then select **Add Host**.
11. When you receive the "(same as parent folder) is not a valid host name. Are you sure you want to add this record?" message, select **Yes**.

### Configure the Routing and Remote Access Server to register only the IP address of the local network adapter in WINS

Complete the steps in this section only if the Routing and Remote Access server is running the WINS service. Additionally, if the server is running Small Business Server 2000 SP1, Small Business Server 2000 SP1a, or Windows Small Business Server 2003, you don't have to complete the steps in this section. By default, these versions of the Windows server are configured to prevent the server from registering the PPP adapter's IP address in the WINS database.

### Add the DisableNetbiosOverTcpip registry value for the Routing and Remote Access service

The DisableNetbiosOverTcpip registry value disables the NetBIOS over TCP/IP (NetBT) protocol for remote access connections. So the server won't register the PPP adaptor in the WINS database. Know that by adding this value, you'll prevent remote access clients from browsing the local network through My Network Places or Network Neighborhood. Sometimes, it may also cause remote access connections to be unsuccessful on computers that are running older versions of Windows. For example, remote access connections may be unsuccessful on Microsoft Windows 98 computers and on Microsoft Windows NT 4.0 Workstation computers. For an alternative to using the DisableNetbiosOverTcpip registry, see the [Workaround](#workaround) section.

> [!IMPORTANT]
> If the server is running Windows 2000 Server SP2 or an earlier version, you must update the server with SP3 or SP4 for the DisableNetbiosOverTcpip registry value to work. If you don't update the server, the Routing and Remote Access service won't use this registry value, and the issue won't be resolved.

1. Select **Start**, select **Run**, type regedit, and then select **OK**.
2. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\RemoteAccess\Parameters\IP`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value** to add the following registry value:
    > Value name: DisableNetbiosOverTcpip  
    Data type: REG_DWORD  
    Value data: 1

4. Close Registry Editor, and then restart the Routing and Remote Access service. To restart a service, select **Start**, point to **Programs** or **All Programs**, point to **Administrative Tools**, and then select **Services**. In the Services console, right-click the service, and then select **Restart**.

### Clear the WINS database

1. Select **Start**, point to **Programs** or **All Programs**, point to **Administrative Tools**, and then select **WINS**.
2. Expand the server object, right-click **Active Registrations**, and then select **Delete Owner**.
3. In the **Delete Owner** dialog box, select the IP address of the server.
4. If the WINS server doesn't have any replication partners, select **Delete from this server only**, and then select **OK**. If the WINS server has one or more replication partners, select **Replicate deletion to other servers (tombstone)**, and then select **OK**.

The WINS server will rebuild the database automatically as computers on the network register their NetBIOS names. You can force Windows-based computers on the network to register their NetBIOS names immediately by running the `nbtstat -RR` command.

## Workaround

As a workaround for this issue, you can configure the remote access connections to use a static pool of IP addresses that is on a different IP subnet than the local computers. In this case, local computers won't try to connect to the PPP adapter if it registers in DNS or WINS because the PPP adapter is on a different IP subnet.

To specify a static address pool in the Routing and Remote Access console, right-click **ServerName**, select **Properties**, select the **IP** tab, select **Static address pool**, and then select **Add**. Add a range that doesn't use the same IP subnet as the local computers. For example, if the local computers are using the 10.0.0.0 subnet, add a static pool that uses the 172.168.0.0 subnet. If the Routing and Remote Access server is running ISA Server 2000, you must add this subnet to the Local Address Table. This scenario is most common on Small Business Server 2000.
