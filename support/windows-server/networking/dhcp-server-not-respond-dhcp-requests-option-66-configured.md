---
title: DHCP server doesn't respond to DHCP requests after option 66 Boot Server Host Name is configured
description: Helps to resolve the issue in which the Dynamic Host Configuration Protocol (DHCP) server doesn't respond to DHCP requests, even though the request number won't cause DHCP performance issues.
ms.date: 01/18/2023
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
ms.technology: networking
---
# The DHCP server doesn't respond to DHCP requests after option 66 Boot Server Host Name is configured

This article helps to resolve the issue in which the Dynamic Host Configuration Protocol (DHCP) server doesn't respond to DHCP requests, even though the request number won't cause DHCP performance issues.

After a DHCP server has the DHCP scope option (**066 Boot Server Host Name**) configured to a server name, the DHCP clients can't get an IP address from the DHCP server.

:::image type="content" source="media/dhcp-server-not-respond-dhcp-requests-option-66-configured/scope-option-66-boot-server-host-name.png" alt-text="Screenshot of the Scope Options 066 Boot Server Host Name with a server name as the String value.":::

When you check the DHCP packets on the DHCP server side, only a part of the DHCP requests gets replies. These replies are normally sent out together. In many short time windows, the DHCP requests are received, but no DHCP reply goes out.

When you filter on the NetBIOS or LLMNR requests, you see lots of the name resolution requests are sent to a particular host name, but the IP address can't be resolved.

## Unresolvable boot server host name

When the DHCP server responds to a DHCP Discover packet under a certain type of request, the DHCP server needs to check BOOTP (Bootstrap Protocol) information. The information includes the BOOTP server IP address and the boot filename.

If option 66 is configured as a server name, the DHCP server will perform name resolution over broadcast protocols (NetBIOS and LLMNR). In this period, the DHCP server ProcessingLoop thread hangs until the name resolution completes. This is by design.

When the server name is unresolvable, the name resolution takes time to fail. This action blocks the DHCP server from processing new messages because all DHCP ProcessingLoop threads are synchronized by one critical section.

## Check the server side DHCP option 66

You can delete the option if it isn't necessary. If the option is needed, make sure the name resolution can succeed. To fix the name resolution, edit the host file or replace the server name with the IP address for the option value.
