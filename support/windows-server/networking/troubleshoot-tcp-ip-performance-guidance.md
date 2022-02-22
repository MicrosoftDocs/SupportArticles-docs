---
title: Guidance of troubleshooting TCP/IP performance
description: Introduces general guidance of troubleshooting scenarios related to TCP/IP performance.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcpip-performance, csstroubleshoot
ms.technology: networking
---
# TCP/IP performance troubleshooting guidance

Transmission Control Protocol/Internet Protocol (TCP/IP) performance is a comparison. The comparison should be conducted with identical endpoints in terms of hardware, network path, and Operating System (OS). Real-life performance is different because multiple factors are involved and may cause a bottleneck. These factors are often the underlying network, the design of TCP and the actual transmit rate of storage IOs.

## Troubleshooting checklist

TCP settings are predefined in modern Windows operating systems. Use the [Get-NetTCPSettings](/powershell/module/nettcpip/get-nettcpsetting) cmdlet to get the TCP settings.

Tips to enhance the throughput:

- Make sure there are no underlying network issues (packet loss).
- Enable advanced properties of NIC for performance features (such as Jumbo frames, RSS/VMQ, offload features, and RSC), except if there's an underlying network compatibility issue or for troubleshooting purpose.
- Make sure the TCP is configured to use autotuning level to normal.
- Use Performance Monitor analysis to make sure there's no CPU or storage bottleneck.
- Select security features based on the actual organizations' requirements.
- Create a baseline.

See this page to learn more about [Bottlenecks for TCP throughput](/troubleshoot/windows-server/networking/overview-of-tcpip-performance#bottlenecks-for-tcp-throughput)

On how to create a baseline, visit the following URL: [How to create a baseline](/troubleshoot/windows-server/networking/overview-of-tcpip-performance#how-to-create-a-baseline)

When the throughput falls below a given baseline, use a packet capturing tool to take a network trace and detect network issues. [Use the ctsTraffic tool to analyze the network trace](/troubleshoot/windows-server/networking/troubleshooting-tcpip-performance-underlying-network#use-the-ctstraffic-tool-to-analyze-the-network-trace)

[Check Performance Monitor logs](/troubleshoot/windows-server/networking/troubleshooting-tcpip-performance-underlying-network#check-performance-monitor-logs)

## Common issues and solutions

- [Slow throughput on high latency and high bandwidth network](tcpip-performance-known-issues.md#slow-throughput-speed-on-a-high-latency-and-bandwidth-network)
- [Slow throughput on low latency and high bandwidth network](tcpip-performance-known-issues.md#use-command-prompt-to-enable-the-autotuning-level)
- [Use PowerShell to enable the autotuning level](tcpip-performance-known-issues.md#use-powershell-to-enable-the-autotuning-level)
- [Underlying network issues](tcpip-performance-known-issues.md#underlying-network-issues)

## Reference

- [Troubleshoot TCP/IP connectivity](/windows/client-management/troubleshoot-tcpip-connectivity)
- [Troubleshoot port exhaustion issues](/windows/client-management/troubleshoot-tcpip-port-exhaust)
- [Troubleshoot Remote Procedure Call (RPC) errors](/windows/client-management/troubleshoot-tcpip-rpc-errors)
- [Collect data using Network Monitor](/windows/client-management/troubleshoot-tcpip-netmon)
- [TCP traffic stops](tcp-traffic-stops.md)
