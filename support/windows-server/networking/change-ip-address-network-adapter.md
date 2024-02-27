---
title: Change IP address of a network adapter
description: Provides some information about how to change the IP address of a network adapter.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# How to change the IP address of a network adapter  

This article provides some information about how to change the IP address of a network adapter.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 323444

## Summary

This article describes how to change the Internet Protocol (IP) address that is assigned to a network adapter. An IP address may be assigned automatically if your network has a Dynamic Host Configuration Protocol (DHCP) server, or you can specify an IP address.

## How to change the IP address assigned to a Network Adapter

1. Log on to the computer by using the Administrator account.
2. Click Start, point to Control Panel, and click Network Connections.
3. Right-click the local area connection that you want to modify and then click **Properties**.
4. In the `This connection uses the following items` box, click Internet Protocol (TCP/IP), and then click Properties. The **Internet Protocol (TCP/IP) Properties** dialog box appears.
5. Continue with the steps in one of the following two sections, depending on your circumstances.

## How to automatically obtain an IP Address

Follow these steps to configure the computer to obtain an IP address from a DHCP server. You must have a DHCP server.

1. Click **Obtain an IP address automatically**.
2. Click **Obtain DNS server address automatically** if you do not want to specify the IP address of the Domain Name System (DNS) server.
3. Click OK. In the **Local Area Connection Properties** dialog box, click Close.
4. In the **Local Area Connection Status** dialog box, click Close.
5. Click Start, and then click Run.
6. In the Open box, type cmd, and then click OK.
7. At the command prompt, type ipconfig /release, and then press ENTER.
8. Type ipconfig /renew, and then press ENTER.

   The network adapter is assigned an IP address by the DHCP server, and a message similar to the following appears:  
  
   ```output
   Windows Server IP Configuration  
   Ethernet adapter Local Area Connection:  
   Connection-specific DNS Suffix. :dns.microsoft.com  
   IP Address. . . . . . . . . . . . :192.168.0.201  
   Subnet Mask . . . . . . . . . . . :255.255.255.0  
   Default Gateway . . . . . . . . . :192.168.0.1
   ```

9. Type exit, and then press ENTER to quit the command prompt.

## How to Specify an IP Address

To assign an IP address to the network adapter, follow these steps:

1. Click **Use the following IP address** if you want to specify the IP address for the network adapter.
2. In the **IP address** box, type the IP address that you want to assign to this network adapter. This IP address must be a unique address in the range of addresses that are available for your network. Contact the network administrator to obtain a list of valid IP addresses for your network.
3. In the **Subnet mask** box, type the subnet mask for your network.
4. In the **Default gateway** box, type the IP address of the computer or device on your network that connects your network to another network or to the Internet.
5. In the **Preferred DNS server** box, type the IP address of the computer that resolves host names to IP addresses.
6. In the **Alternate DNS server** box, type the IP address of the DNS computer that you want to use if the preferred DNS server becomes unavailable.
7. Click OK. In the Local Area Connection Properties dialog box, click Close.
8. In the **Local Area Connection Status** dialog box, click Close.

## Troubleshooting

- There is an IP address conflict: If you try to assign an IP address that is already in use, you receive the following error message:  
  
  > The static IP address that was just configured is already in use on the network. Please reconfigure a different IP address.  

  In this case, assign an unused IP address to the network adapter.
- Your computer cannot connect to other computers on the network: If you assign an incorrect subnet mask address to the network adapter, the computer is effectively located on a different network. You cannot connect to other computers on the network.
- Your computer cannot connect to other computers by using host names: If you assign an incorrect DNS server IP address, or if you do not use a DNS server, you cannot connect to computers by using their host names. It prevents you from browsing the Internet. You can connect to other computers by using their IP addresses.

  To work around this issue in a local network, add host-name-to-IP-address mappings in a Hosts file.
