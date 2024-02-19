---
title: DHCP client can't get a DHCP-assigned IP address
description: Discusses an issue where a DHCP client can't get a DHCP-assigned IP address.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# DHCP client may fail to obtain a DHCP-assigned IP address

This article helps fix an issue where a DHCP client can't get a DHCP-assigned IP address.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 167014

## Symptoms

When a DHCP client is moved from one subnet to another, it may fail to obtain a valid IP address on the new subnet.

## Resolution

To work around this problem, do one of the following methods:

- Don't use IP addressing schemes that overlap.

- Run the following commands after you move the client to a new segment:

    ```console
    Ipconfig /Release
    Ipconfig /Renew
    ```

## More information

When a DHCP client that has previously had a DHCP-assigned address is started again, the client goes into an INIT-REBOOT state. The client will attempt to verify that it can still use the same address by sending a DHCPRequest packet, populating the DHCP Option Field "DHCP Requested Address" with the previously assigned IP address.

If the DHCP server remains silent, the client assumes the previous address is still valid and keeps it. If a DHCP server sends a NACK packet in response to the DHCPRequest, the client goes into the Discover cycle; it also requests the previously assigned address in the DHCPDiscover packet.

When a DHCP server receives a DHCPRequest with a previously assigned address specified, it first checks to see if it came from the local segment by checking the GIADDR field. If it originated from the local segment, the DHCP server compares the requested address to the IP address and subnet mask belonging to the local interface that received the request.

If the address appears to be on the same subnet, the DHCP server will remain silent even if the address isn't in the range of its pool of addresses. The DHCP server assumes that the address was assigned by another DHCP server on the same segment if it's not from its own pool. If the address fails the subnet mask/IP address check, the DHCP server checks to see if it came from a Superscope, if one is defined. If not, the server responds to the DHCPRequest with a NACK packet.

If the client sending the DHCPRequest is requesting an address that appears to be on the same subnet but was actually assigned with a different subnet mask, the DHCP server will remain silent and the client will fail to obtain a valid IP address for the new subnet.

For example, assume the DHCP client obtains address 172.17.3.x with a subnet mask of 255.255.255.0, and the client is moved to a new segment where the address of the DHCP server is 172.17.1.x with a subnet mask of 255.255.0.0. When the subnet mask/IP address comparison is done on the DHCP server, the DHCP server will remain silent, assuming another DHCP server on the segment assigned the address. If the subnet masks were reversed, the client would obtain a valid address.
