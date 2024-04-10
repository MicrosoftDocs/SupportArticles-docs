---
title: Error message when you set an IP address
description: Provides a solution to an error that occurs when you try to set an IP address on a network adapter.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca, TERRYBA
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Error message when you try to set an IP address on a network adapter

This article provides a solution to an error that occurs when you try to set an IP address on a network adapter.

_Applies to:_ &nbsp; Windows Server 2012  
_Original KB number:_ &nbsp; 269155

## Symptoms  

When you try to set the IP address on a network adapter, you may receive the following error message:

> The IP address **XXX.XXX.XXX.XXX** you have entered for this network adapter is already assigned to another adapter **Name of adapter**. **Name of adapter** is hidden from the network and Dial-up Connections folder because it is not physically in the computer or is a legacy adapter that is not working. If the same address is assigned to both adapters and they become active, only one of them will use this address. This may result in incorrect system configuration. Do you want to enter a different IP address for this adapter in the list of IP addresses in the advanced dialog box?

> [!NOTE]
> In this error message, the placeholder **XXX.XXX.XXX.XXX** represents the IP address that you are trying to set, and the placeholder **Name of adapter** represents the name of the network adapter that is present in the registry but hidden in Device Manager.

If you select **Yes**, you see the TCP/IP properties. Then, you can change the IP address to something different for the currently displayed network adapter in Device Manager. If you select **No**, the IP address is assigned to the network adapter. Notice that if you select **No**, the selected network adapter in Device Manager and the ghosted network adapter have the same IP address. In most cases, this causes no problems, because the driver is disabled.

> [!NOTE]
> On a computer that is running Windows Server 2008, you receive the following error message:
>
> Cannot rename this connection. A connection with the name you specified already exists. Specify a different name.

## Cause

This issue occurs because a network adapter with the same IP address is in the registry but is hidden in Device Manager. It can occur when you move a network adapter from one PCI slot to another PCI slot.

## Resolution

To resolve this problem, uninstall the ghosted network adapter from the registry. To do it, use one of the following methods:

### Method 1

1. Use one of the following methods to go to a command prompt:
   - In Windows 8 or in Windows Server 2012, use the Search charm to search for cmd, and then tap or select **Command Prompt.**  
   - In earlier versions of Windows, select **Start**, select **Run**, type cmd.exe, and then press **Enter**.
2. Type `set devmgr_show_nonpresent_devices=1`, and then press Enter.
3. Type `start devmgmt.msc`, and then press Enter.
4. Select **View**, and then select **Show Hidden Devices**.
5. Expand the **Network Adapters** tree.
6. Right-click the dimmed network adapter, and then select **Uninstall**.

### Method 2

The DevCon utility is a command prompt utility that acts as an alternative to Device Manager. When you use DevCon, you can enable, disable, restart, update, remove, and query individual devices or groups of devices. To use DevCon, follow these steps:

1. Download the DevCon tool in [Windows Device Console (Devcon.exe)](/windows-hardware/drivers/devtest/devcon).
2. Unpack the 32-bit or 64-bit DevCon tool binary to a local folder.
3. Select **Start**, select **Run**, type cmd, and then press **Enter**. If you're running Windows 8 or Windows Server 2012, use the Search charm to search for cmd.
4. Type `cd <path_to_binaries>` to move to where devcon.exe is located.
5. Run the following command to list all network adapters that are present:

   ```console
   devcon listclass net
   ```

6. Run the following command to retrieve all network adapters:

   ```console
   devcon findall =net
   ```

7. For those network adapters that aren't listed in the result of the first command, note the instance ID of those items, and then run the following command for each instance ID:

   ```console
   devcon -r remove "@PCI\VEN_10B7&DEV_9200&SUBSYS_00D81028&REV_78\4&19FD8D60&0&58F0"
   ```

## More information

When you receive the error message that is mentioned in the [Symptoms](#symptoms) section, the hidden or ghosted network adapter doesn't appear in Device Manager unless you follow the steps in this article. Device Manager does show a network adapter, and the network adapter typically has #2 appended to its name.
