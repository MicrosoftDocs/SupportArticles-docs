---
title: TCP/IP underlying network performance issues
description: Provides the troubleshooting process for TCP/IP performance issues about underlying network. The ctsTraffic tool is used to analyze the network trace.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, anupamk, rabhardw, v-lianna
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Troubleshooting TCP/IP performance issues about underlying network

> [!NOTE]
> This article is included in a 3-part series. You can review [Part 1: TCP/IP performance overview](overview-of-tcpip-performance.md) and [Part 3: TCP/IP performance known issues](tcpip-performance-known-issues.md).

When the throughput falls below a given [baseline](overview-of-tcpip-performance.md#how-to-create-a-baseline), use a packet capturing tool to take a network trace and detect network issues.

## Use the ctsTraffic tool to analyze the network trace

Here's an example of how you can use the [ctsTraffic](https://github.com/Microsoft/ctsTraffic) tool to analyze the network trace:

> [!NOTE]
> Taking a network trace may cause further slowdown of the throughput.

1. Run the ctsTraffic tool on both client and server sides.

    Run this command on the server:

    ```console
    CTStraffic -listen:*
    ```

    Run this command on the client:

    ```console
    CTSTraffic -target:<serverip> -consoleverbosity:3 -connections:4 -iterations:10 -connectionfilename:<filename>.csv
    ```

2. Stop network traces on both client and server sides.
3. Check the *\<filename>.csv* file:

    - If NetworkErrors or ProtocolErrors are displayed in the file, go to the next step.
    - If no error is displayed, stop and discard the network trace. Collect a new trace on the client and the server. Try with an increasing number of connections (`-connections:`) in step 1 until the error occurs.

4. Find the client socket number of the error in the *\<filename>.csv* file and apply this number as a filter to check for a packet loss, a packet retransmission, or a TCP reset that wasn't initiated from either endpoint. With this information in hand, contact the network team for help.

## Check Performance Monitor logs

Check Performance Monitor logs to find [Packet Received Discarded](/previous-versions/ms803962(v=msdn.10)) in these situations:

- There are errors, but no issues are found in the packet capture.
- The original packet reaches the destination, but the sender retransmits the same packet because there's no acknowledgment (ACK) by the receiver.

The packet discards might be caused by the network card driver or by the processor being unavailable to process incoming packets on the receiver. Make sure the Network card driver is up to date and that the [RSS](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh997036(v=ws.11))/[VMMQ](/windows-hardware/drivers/network/overview-of-virtual-machine-multiple-queues) is set up correctly. For example, to use more base processors on a server such as SQL server, customize RSS/VMMQ not to use the base processor and to start processing from the next physical core.

For more information, see [Network-Related Performance Counters](/windows-server/networking/technologies/network-subsystem/net-sub-performance-counters).

> [!NOTE]
> Customize RSS/VMMQ only for troubleshooting and with a full understanding of the operation.

## Next steps

> [!div class="nextstepaction"]
> [Learn more about known issues of TCP/IP performance](tcpip-performance-known-issues.md)
