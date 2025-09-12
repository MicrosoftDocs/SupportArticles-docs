---
title: Troubleshoot Azure Virtual Desktop connection quality
description: Helps troubleshoot connection quality issues in Azure Virtual Desktop.
ms.topic: troubleshooting
ms.date: 01/21/2025
ms.reviewer: daknappe
ms.custom: docs_inherited, pcy:wincomm-user-experience
---
# Troubleshoot connection quality in Azure Virtual Desktop

This article helps troubleshoot connection quality issues in Azure Virtual Desktop.

If you experience issues with graphical quality in your Azure Virtual Desktop connection, you can use the Network Data diagnostic table to figure out what's going on. Graphical quality during a connection is affected by many factors, such as network configuration, network load, or virtual machine (VM) load. The Connection Network Data table can help you figure out which factor is causing the issue.

## Addressing round trip time

In Azure Virtual Desktop, latency up to 150 ms shouldn't affect user experience that doesn't involve rendering or video. Latencies between 150 ms and 200 ms should be fine for text processing. Latency above 200 ms might affect user experience.

In addition, the Azure Virtual Desktop connection depends on the internet connection of the machine the user is using the service from. Users might lose connection or experience input delay in one of the following situations:

- The user doesn't have a stable local internet connection, and the latency is over 200 ms.
- The network is saturated or rate-limited.

To reduce round trip time:

- Reduce the physical distance between end-users and the server. When possible, your end-users should connect to VMs in the Azure region closest to them.
- Check your network configuration. Firewalls, ExpressRoutes, and other network configuration features can affect round trip time.
- Check if something is interfering with your network bandwidth. If your network's available bandwidth is too low, you might need to change your network settings to improve connection quality. Make sure your configured settings follow our [network guidelines](/windows-server/remote/remote-desktop-services/network-guidance).
- Check your compute resources by looking at CPU utilization and available memory on your VM. You can view your compute resources by following the instructions in [Configuring performance counters](/azure/azure-monitor/agents/data-sources-performance-counters#configure-performance-counters) to set up a performance counter to track certain information. For example, you can use the **Processor Information(_Total)\\% Processor Time** counter to track CPU utilization, or the **Memory(\*)\\Available Mbytes** counter for available memory. Both of these counters are enabled by default in Azure Virtual Desktop Insights. If both counters show that CPU usage is too high or available memory is too low, your VM size or storage might be too small to support your users' workloads, and you need to upgrade to a larger size.

## Optimize VM latency by reviewing Azure network round-trip latency statistics

Round-trip time (RTT) latency from the client's network to the Azure region that contains the host pools should be less than 150 ms. To see which locations have the best latency, look up your desired location in [Azure network round-trip latency statistics](/azure/virtual-desktop/../networking/azure-network-latency). To optimize for network performance, we recommend you create session hosts in the Azure region closest to your users. We also recommend you review the statistics every two to three months to make sure the optimal location hasn't changed as Azure Virtual Desktop rolls out to new areas.

## My connection data isn't going to Azure Log Analytics

If your **Connection Network Data Logs** aren't going to Azure Log Analytics every two minutes, you need to check the following things:

- Make sure you've [configured the diagnostic settings correctly](/azure/virtual-desktop/diagnostics-log-analytics).
- Make sure you've configured the VM correctly.
- Make sure you're actively using the session. Sessions that aren't actively used won't send data to Azure Log Analytics as frequently.

## Next steps

For more information about how to diagnose connection quality, see [Analyze connection quality in Azure Virtual Desktop](/azure/virtual-desktop/connection-latency).
