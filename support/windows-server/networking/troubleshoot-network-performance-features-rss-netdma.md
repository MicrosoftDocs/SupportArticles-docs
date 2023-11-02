---
title: How to troubleshoot advanced network performance features such as RSS and NetDMA
description: Some networking improvements that were first released in the Windows Server 2003 Scalable Networking Pack can cause slow or intermittent network performance if the network drivers that are being used are old or don't support the new features.
ms.date: 02/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: whall, kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# How to troubleshoot advanced network performance features such as RSS and NetDMA

This article troubleshoots some networking improvements that were first released in the Windows Server 2003 Scalable Networking Pack. Because they may cause slow or intermittent network performance if the network drivers that are being used are old or don't support the new features.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2643970

## Summary

This article describes how to troubleshoot network performance issues that involve the Windows improved networking features. These features include the following:

- TCP/IP Checksum offloading
- Receive side scaling (RSS)
- NetDMA
- TCP Chimney Offloading

## Network performance improvements

The Windows Scalable Networking Pack (SNP) was released as a stand-alone update for Windows Server 2003 SP1, but was later added to Windows Server 2003 Service Pack 2. This was a collection of improvements to network throughput and performance. When they were installed, they were enabled by default. There were issues with the features and some network drivers that caused network performance problems. So, the recommendation was to turn them off. Later many of the issues were fixed. However, it was still recommended for Windows Server 2003 to keep them off unless there was a specific need.

Windows Server 2008 and Windows Server 2008 R2, and also Windows Server 2012, have higher-performing TCP/IP stacks, and the SNP improvements are included. Additionally, most of the settings have been changed to automatically configure.

Recommendations for the settings are as follows.

### Windows Server 2008

- SP2 required
- Hotfix KB 979614
- Hotfix KB 967224
- Re-enable RSS in the OS and network adapters
- Update network adapter drivers to latest recommended manufacturer version
- Adjust RSS settings for network adapters based on manufacturer recommendations
- Update antivirus software to latest versions/engines and definitions

### Windows Server 2008 R2

- Service Pack 1
- Hotfix KB 2519736
- If you're using TCP Chimney Offload, you should install hotfix KB 2525390.
- Recommended install of hotfix KB 2511305
- Re-enable RSS in the OS and network adapters
- Update network adapter drivers to latest recommended manufacturer version
- Adjust RSS settings for network adapters based on manufacturer recommendations
- Update antivirus software to latest versions/engines and definitions

As an alternative to installing SP1 and hotfix KB 2519736 as recommended here, you can install the following on Windows Server 2008 R2 RTM:

- Hotfix KB 977977
- Hotfix KB 979612

Be aware that RSS requires checksum offloading to be enabled on the network adapter to work. Don't confuse TCP checksum offloading with TCP Chimney Offloading. If the adapters are teamed, then usually RSS will work as long as all adapters have it enabled (this is manufacture dependent). NetDMA should be automatically enabled if it's supported.

The network improvements in the operating system are intended to improve network throughput on servers by offloading some networking tasks to the network adapter's hardware. This mostly applies to adapters that are running at 1 Gbps and higher connection speeds and require that the network adapters and drivers that are being used implement the improvements. If the driver doesn't support the improvements, or if the driver has a problem that is related to them, you may have to disable them manually. If you've invested in equipment that supports TCP connection offloading/RSS/NetDMA, and if the adapter isn't working correctly, the first thing to check should be the driver version. A newer driver for the network adapter may resolve any networking issues that are being experienced. Use the following information to check the network adapter settings and the OS settings for SNP settings.

Determine d river information in Windows Server 2008 and Windows Server 2008 R2  

You can find the date and version of the network driver. To do this, follow these steps:

1. Click Start > right-click Computer, and then click **Manage**.
2. Expand the System Tools  group in the navigation pane if it's necessary.
3. Click Device Manager in the navigation pane. You should see something that resembles the following screenshot.
4. Expand Network adapters  in the right-side pane, and then double-click the adapter.

The **Driver**  tab has the following information:

:::image type="content" source="media/troubleshoot-network-performance-features-rss-netdma/driver-tab-info.png" alt-text="Screenshot of the Device Manager pane under Computer Management with a network adapter properties window opened, which shows the Driver information.":::

For Windows Server 2003, follow these steps to access Device Manager:

1. Open the Administrative Tools in Control Panel.
2. Within the Administrative Tools click Computer Management.
3. Click Device Manager. Next, go to the website of the Driver Provider (also on the Driver tab). Check for the latest version of the driver and see whether it's newer than the driver date that you found in the device properties. You may also find a solution in a FAQ or on a forum on the manufacture's site.

If updating the network drivers doesn't work, you might want to try disabling the improved features and see whether the issue resolves. Use this as a last resort or a troubleshooting step and not as the solution unless your network adapter was confirmed not to support the features in question. The improved networking features can be enabled or disabled in the operating system and also in the network adapter's advanced settings. Here you can see the **Advanced** tab in the network adapter properties that shows the TCP Connection Offload and Receive Side Scaling (RSS) settings.

:::image type="content" source="media/troubleshoot-network-performance-features-rss-netdma/tcp-connection-offload-rss-settings.png" alt-text="Screenshot of the Server Manager window with a network adapter properties window opened, which shows the TCP Connection Offload and Receive Side Scaling (RSS) settings in the Advanced tab." border="false":::

To see the settings for the operating system, use net shell command `netsh interface tcp show global` command as follows:

:::image type="content" source="media/troubleshoot-network-performance-features-rss-netdma/netsh-interface-tcp-show-global-cmd.png" alt-text="Screenshot of the output of the netsh interface tcp show global command." border="false":::

You can check the following two other settings that affect TCPchimney offloading:

- `netsh interface tcp show chimneyapplications`

- `netsh interface tcp show chimneyports`

These commands enable TCP offloading to be set up specifically for a certain application or port combination. Output from both netsh commands is as follows:

> [!NOTE]
> This operation requires elevated privileges (Run as administrator).

:::image type="content" source="media/troubleshoot-network-performance-features-rss-netdma/netsh-cmd-output.png" alt-text="Screenshot of the netsh command output which shows the chimney settings." border="false":::

If they're blank, no applications or ports were added to the chimney offload settings.

The most common improved networking features, together with links to more information about how to enable or disable them, are as follows:

[Information about the TCP Chimney Offload, Receive Side Scaling, and Network Direct Memory Access features in Windows Server 2008](https://support.microsoft.com/help/951037)

[TCP Chimney Resources](https://technet.microsoft.com/network/dd277645)

[Receive Side Scaling Resources (RSS)](https://technet.microsoft.com/network/dd277646)

[NetDMA](https://technet.microsoft.com/library/gg162716%28ws.10%29.aspx)

[Networking Deployment Guide: Deploying High-speed Networking Features](https://technet.microsoft.com/library/gg162681%28ws.10%29.aspx)
