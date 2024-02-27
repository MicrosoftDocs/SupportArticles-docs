---
title: Boot from a PXE server on a different network
description: This article describes how to boot from a PXE server on a different network.
ms.date: 12/05/2023
ms.custom: sap:PXE
ms.reviewer: kaushika
---
# How to boot from a PXE server that's on a different network

This article describes how to boot from a PXE server on a different network.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4471003

## PXE boot process

Generally, a client computer boots from the network by using the PXE protocol according to the following process. It involves three parties, the DHCP server, the PXE server, and the client:

1. The client computer broadcasts a DHCP packet that asks for the address of the DHCP and PXE servers.
2. The DHCP server responds, sending a broadcast packet that tells the client it's an address server.
3. The PXE server responds to the client and reports that it's a boot server.
4. The client sends a request to the DHCP server to ask for the IP address.
5. The DHCP server sends the IP address to the client.
6. The client sends a request to the PXE server to ask for the path to the Network Boot Program (NBP).
7. The PXE server responds, sending the NBP path.
8. The client downloads and runs the NBP.

After this process, the basic PXE boot is completed, but there will be more interaction between the client and the PXE server. It's controlled by the NBP implementation. For example, the Windows Deployment Services (WDS) NBP implementation will require the path of a custom boot file (`pxeboot.com` or `bootmgfw.efi`). The implementation will download and run the custom boot file. Then, the Windows Imaging Format (WIM) file and other files that Windows PE needs will be downloaded.

The eight steps mentioned earlier usually work if the client and the servers are on the same network. When the client and servers are on different networks, the recommended method to make sure the client can boot from the network without using DHCP options is to configure the routers.

## Recommended method - IP helper

The routers must be able to route the client requests from the network of the client to the network of the DHCP server. One such simple router rule is the **IP helper**. The helper just tells the router to forward the DHCP requests to the known IP address of the DHP server.

For PXE requests, you just need to configure the routers to forward the client request to the PXE server, just like you do with the DHCP server. Locate your router, find the DHCP IP helper entry, and add another entry that looks exactly like the first one but uses the IP address of the PXE server. For more information, see the blog post [You want to PXE Boot? Don't use DHCP options](https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/You-want-to-PXE-Boot-Don-t-use-DHCP-Options/ba-p/275562).

Besides, you can add an IP helper entry for each PXE server. In a load-balancing scenario (multiple PXE servers), PXE servers can be up or down in a group, and you don't have to do any extra configuration. In diverse environments (Windows, Linux, and Router PXE servers all coexisting), the different PXE servers can selectively respond to the clients that they recognize.

## Problematic scenarios

To configure the DHCP server to respond to PXE requests, you might try to add PXE options to the DHCP replies. It results in the client always downloading the network boot file (as specified in the DHCP reply) and running it.

It's problematic in some UEFI setting scenarios. The client may not try to boot from the hard drive after the client was configured to start from a network boot. But the network boot failed, for example, there's no task sequence deployment for the client. It's also problematic for mixed-OS environments. Your Linux computer would be instructed by the DHCP server to download and run the Windows network boot program.

So, letting the DHCP server masquerade as a PXE server doesn't work as expected in some scenarios. The true PXE server decides whether it will respond and serve a network boot file. In the Configuration Manager case, the server will only respond if there's a task sequence deployed to the client.
