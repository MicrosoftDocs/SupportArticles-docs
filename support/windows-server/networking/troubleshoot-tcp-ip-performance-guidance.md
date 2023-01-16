---
title: Guidance for troubleshooting TCP/IP performance
description: Introduces general guidance for troubleshooting scenarios related to TCP/IP performance.
ms.date: 03/16/2022
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

- Make sure there are no underlying network issues, such as packet loss.
- Enable advanced properties of network interface for performance features (such as Jumbo frames, RSS/VMQ, offload features, and RSC), except if there's an underlying network compatibility issue or for troubleshooting purpose.
- Make sure the TCP is configured to use autotuning level to normal.
- Use Performance Monitor analysis to make sure there's no CPU or storage bottleneck.
- Select security features based on the actual organizations' requirements.
- Create a baseline.

For more information, see [Bottlenecks for TCP throughput](/troubleshoot/windows-server/networking/overview-of-tcpip-performance#bottlenecks-for-tcp-throughput).

For more information on how to create a baseline, see [How to create a baseline](/troubleshoot/windows-server/networking/overview-of-tcpip-performance#how-to-create-a-baseline).

When the throughput falls below a given baseline, use a packet capturing tool to take a network trace and detect network issues. [Use the ctsTraffic tool to analyze the network trace](/troubleshoot/windows-server/networking/troubleshooting-tcpip-performance-underlying-network#use-the-ctstraffic-tool-to-analyze-the-network-trace)

[Check Performance Monitor logs](/troubleshoot/windows-server/networking/troubleshooting-tcpip-performance-underlying-network#check-performance-monitor-logs)

## Common issues and solutions

- [Slow throughput on high latency and high bandwidth network](tcpip-performance-known-issues.md#slow-throughput-speed-on-a-high-latency-and-bandwidth-network)
- [Slow throughput on low latency and high bandwidth network](tcpip-performance-known-issues.md#use-command-prompt-to-enable-the-autotuning-level)
- [Use PowerShell to enable the autotuning level](tcpip-performance-known-issues.md#use-powershell-to-enable-the-autotuning-level)
- [Underlying network issues](tcpip-performance-known-issues.md#underlying-network-issues)

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSSv2 must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSSv2 won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSSv2, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSSv2 runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) on all nodes and unzip it in the *C:\\tss_tool* folder.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
3. Start the traces by using the following cmdlets:

    ```powershell
    TSSv2.ps1 -Start -Scenario NET_Winsock
    ```

    For NCSI related issues:  

    ```powershell
    TSSv2.ps1 -Start -Scenario NET_NCSI
    ```

4. Accept the EULA if the traces are run for the first time on the computer.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MSDATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Troubleshoot TCP/IP connectivity](/windows/client-management/troubleshoot-tcpip-connectivity)
- [Troubleshoot port exhaustion issues](/windows/client-management/troubleshoot-tcpip-port-exhaust)
- [Troubleshoot Remote Procedure Call (RPC) errors](/windows/client-management/troubleshoot-tcpip-rpc-errors)
- [Collect data using Network Monitor](/windows/client-management/troubleshoot-tcpip-netmon)
- [TCP traffic stops](tcp-traffic-stops.md)
