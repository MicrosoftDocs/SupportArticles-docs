---
title: Can't access shared folders from File Explorer
description: Provides troubleshooting for the issue that shared folders can't be accessed from File Explorer in Windows 10.
ms.date: 3/4/2021
author: xl989
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-wanyi
ms.prod-support-area-path: Access to remote file shares (SMB or DFS Namespace)
ms.technology: windows-client-networking
---
# Can't access shared folders from File Explorer in Windows 10

_Original product version:_ &nbsp;Windows 10

## General troubleshooting

- Instead of **File Explorer**, access the shared folder by **Command Prompt** using the below command:

    ```console
    net use <DeviceName>: \\<ServerName>\<ShareName>
    ```

    > [!NOTE]
    > For more information, see [Net use](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/gg651155(v=ws.11)).

- Turn on the SMB 1.0 support feature from **Control Panel** by following these steps:
    1. Open **Control Panel**.
    2. Select **Programs** > **Programs and Features** > **Turn Windows features on or off** > **SMB 1.0/CIFS File Sharing Support**.
    3. Check **SMB 1.0/CIFS Client**, and then press Enter.

        :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/smb-client-feature-on.png" alt-text="Turn on SMB 1.0/CIFS Client feature." border="false":::
- Turn on network discovery and file and printer sharing options by following these steps:
    1. Open **Control Panel**.
    2. Select **Network and Internet** > **Network and Sharing Center** > **Advanced sharing settings**.
    3. Select **Turn on network discovery**.
    4. Select **Turn on file and printer sharing** under **Private**.
    5. Select **Save changes**.

        :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/turn-on-network-discovery-share-settings.png" alt-text="Turn on network discovery and file and printer sharing options." border="true":::
- Set the startup type of specified services to **Automatic** to make the computer visible on the network. Here's how to proceed:
    1. Go to Start.
    2. Go to Search, enter the word *Services*, and press Enter.
    3. Change the **Startup type** property to **Automatic** for the following services.
       - **Function Discovery Provider Host**
       - **Function Discovery Resource Publication**
       - **SSDP Discovery**
       - **UPnP Device Host**
    4. Restart the system.

You may receive these error messages:

## You do not have permission to access \\\\\<IPAddress or Hostname>

:::image type="content" source="./media/cannot-access-shared-folder-file-explorer/error-1.png" alt-text="You do not have permission to access the shared folder." border="false":::

### Resolution

1. Here's how to share permission to **Everyone** for the folder you want to share:
    1. Press and hold (or right-click) the shared folder.
    2. Select **Properties**, and then select **Advanced Sharing** on the **Sharing** tab.
    3. Select **Permissions**, check **Allow** for **Full Control** of **Everyone**, and then press Enter.
    4. Select **OK** on the **Advanced Sharing** dialog box.

    :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/error-1-share-permission.png" alt-text="Share permission to Everyone." border="true":::
2. Here's how to allow the **Full Control** permission to **Everyone**:
    1. Select **Edit** on the **Security** tab.
    2. Select **Add**, enter *Everyone* in the **Enter the object names to select** field, and then press Enter.
    3. Check **Allow** for **Full control** of **Everyone**, and press Enter.
    4. Close the **Properties** dialog box.

    :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/error-1-allow-permission.png" alt-text="Allow the Full control permission to Everyone." border="true":::
3. Here's how to make sure TCP/IP NetBIOS is enabled:
    1. Go to Start.
    2. Go to Search, enter the word *Services*, and press Enter.
    3. Double-click **TCP/IP NetBIOS Helper** on the right pane, and make sure the **Startup type** property is set to **Automatic**.

       :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/configure-tcpip-netbios-service.png" alt-text="Configure TCP/IP NetBIOS service." border="true":::
    4. Go to **Control Panel** > **Network and Internet** > **Network and Sharing Center**, select **Change adapter settings** on the left pane, and then double-click **Ethernet**.
    5. Select **Properties** and double-click **Internet Protocol Version 4 (TCP/IPv4)** on the **Networking** tab.
    6. Select **Advanced**, select **Enable NetBIOS over TCP/IP** on the **WINS** tab, and then press Enter.
    7. Select **OK** twice to close the dialog box.

       :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/enable-netbios-over-tcpip.png" alt-text="Enable NetBIOS over TCP/IP." border="true":::

## You can't access this shared folder because your organization's security policies block unauthenticated guest access

:::image type="content" source="./media/cannot-access-shared-folder-file-explorer/error-2.png" alt-text="You can't access this shared folder because your organization's security policies block unauthenticated guest access." border="true":::

### Resolution

You can enable the guest access from your computer by using one of the following methods:

**Method 1**: Enable insecure guest logons with **Registry Editor**

1. Open **Registry Editor**.
2. Go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation`.
    > [!NOTE]
    > You must create the key if it doesn't exist. Press and hold (right-click) **Windows**, select **New** > **Key**, and then name the key *LanmanWorkstation*.

3. Press and hold (right-click) **LanmanWorkstation**, select **New** > **DWORD (32-bit) Value**, and then name it *AllowInsecureGuestAuth*. Double-click it, set the **Value data** to *1*, and then press Enter.

**Method 2**: Enable insecure guest logons with **Local Group Policy Editor**

1. Go to Start.
2. Go to Search, enter the word *gpedit.msc*, and then press Enter.
3. Go to **Computer Configuration** > **Administrative templates** > **Network** > **Lanman Workstation**.
4. From the right-side pane, double-click **Enable insecure guest logons**.
5. Select **Enabled**, and then press Enter.

    :::image type="content" source="./media/cannot-access-shared-folder-file-explorer/gpo-setting.png" alt-text="Enable insecure guest logons with Local Group Policy Editor." border="true":::

## Error code: 0x80004005. Unspecified error

:::image type="content" source="./media/cannot-access-shared-folder-file-explorer/error-3.png" alt-text="Error code: 0x80004005. Unspecified error." border="true":::

Instead of obtaining an IP address automatically, specify an IP address. Follow these instructions:

1. Select **Use the following IP address** if you want to specify the IP address for the network adapter.
2. In the **IP address** box, type the IP address that you want to assign to this network adapter. This IP address must be a unique address in the range of addresses that are available for your network. Contact the network administrator to obtain a list of valid IP addresses for your network.
3. In the **Subnet mask** box, type the subnet mask for your network.
4. In the **Default gateway** box, type the IP address of the computer or device on your network that connects your network to another network or to the Internet.
5. In the **Preferred DNS server** box, type the IP address of the computer that resolves host names to IP addresses.
6. In the **Alternate DNS server** box, type the IP address of the DNS computer that you want to use if the preferred DNS server becomes unavailable.
7. Select **OK**. In the **Local Area Connection Properties** dialog box, select **Close**.
8. In the **Local Area Connection Status** dialog box, select **Close**.
