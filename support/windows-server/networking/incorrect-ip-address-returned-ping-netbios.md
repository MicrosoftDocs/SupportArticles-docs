---
title: An incorrect IP address is returned
description: Describes an issue in which an incorrect IP address is returned when you ping a server by using its NetBIOS name.
ms.date: 04/12/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, danma
ms.custom: sap:ip-address-management-ipam, csstroubleshoot
ms.subservice: networking
---
# An incorrect IP address is returned when you ping a server by using its NetBIOS name  

This article provides a resolution for the issue that an incorrect IP address is returned, when you ping a server by using its NetBIOS name.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 981953

## Symptoms

You have a computer that is running Windows Server 2008 or Windows Server 2008 R2. When a server that has multiple IP addresses tries to ping itself by using its NetBIOS name, an incorrect IP address is returned.

## Cause

When you perform a ping with a name instead of an IP address, the name has to be resolved to an IP address. If the name is that of the server, the IP address is returned as an address from the network adapter, which is at the top or bottom of the network bindings order. It usually will be the last network adapter that was installed, and may not be the interface that you expect to be used. Therefore, the ping command returns an incorrect IP address.

> [!NOTE]
> When there are multiple addresses on a network adapter, IPv6 addresses are preferred.

## Resolution

To work around this issue, you can change the adapter that the IP address is selected from by moving the preferred adapter to the top or bottom of the binding order. For a hidden adapter that does not appear in the list, you can create a Hosts file that uses the server name and the intended IP address. An example of a hidden adapter is the Microsoft Failover Cluster Virtual Adapter.

### How to change the binding order

To change the binding order, follow these steps:

1. Click **Start** :::image type="icon" source="media/incorrect-ip-address-returned-ping-netbios/vista-start-button.png" border="false":::, and then click **Control Panel**.
2. Click **Network and Internet**, and then click **Network and Sharing Center**.

3. Change the network adapter settings, depending on your operating system:
   - For Windows Server 2008, click **Manage adapter settings**.

   - For Windows Server 2008 R2, click **Change adapter settings**.

4. Click **Organize**, point to **Layout**, and then click **Menu bar**.

5. On the **Advanced** menu, click **Advanced Settings**.

6. In the **Connections** window, select the network adapter that you want.
7. Move this network adapter to the top of the list or to the bottom of the list. You can do it by using the UP ARROW and DOWN ARROW buttons.
8. Click **OK**.

### How to change the Hosts file

For a hidden adapter, you cannot change the binding order by using the steps in the "How to change the binding order" section. For hidden adapters, you must add an entry to the Hosts file that uses the intended host name and IP address.

To change the Hosts file, follow these steps:

1. Click **Start** :::image type="icon" source="media/incorrect-ip-address-returned-ping-netbios/vista-start-button.png" border="false":::, and then click **All Programs**.
2. Click **Accessories**, right-click **Notepad**, and then click **Run as administrator**.

3. :::image type="icon" source="media/incorrect-ip-address-returned-ping-netbios/security-shield-button.png" border="false"::: If you're prompted for an administrator password or for confirmation, type the password, or provide confirmation.
4. At a command prompt, type the following command, and then press ENTER:  

    ```console  
   cd %windir%\System32\Drivers\Etc  
   ```  

5. At a command prompt, type notepad hosts, and then press ENTER.
6. At the bottom of the file that you opened in step 5, add a new entry for the intended IP address by using the following format: **IP_Address** **Hostname**  
For example, for an IP address of 10.0.0.1 for Server01, type as:  
10.0.0.1Server01  

7. On the **File** menu, click **Save**, and then close Notepad.
8. At the command prompt, type ipconfig /flushdns, and then press ENTER. It will reload the Hosts file without restarting the computer or server.

> [!NOTE]
> If you want to ping a specific IPv4 address for the network adapter, you can use the -4 parameter. For example, you can use the following command:  
 ping -4 \<**host name**>  
>  
>If you want to use IPv4 addresses over a network, you can force Windows to use IPv4 addresses instead of IPv6 addresses. However, we do not recommend that you do this. We strongly recommend that you update the network to use IPv6 addresses. For more information about how to disable IPv6, click the following article number to view the article in the Microsoft Knowledge Base:  
>
>[929852](https://support.microsoft.com/help/929852) How to disable certain Internet Protocol version 6 (IPv6) components in Windows Vista, Windows 7 and Windows Server 2008  

## More information

For more information about the getaddrinfo function, visit the following MSDN Web site:  
[The getaddrinfo function](/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfo)  
