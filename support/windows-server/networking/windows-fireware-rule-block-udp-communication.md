---
title: UDP communication is blocked by the Windows Firewall rule in WSFC
description: Discusses that UDP communication is blocked by the Windows Firewall rule in WSFC when the network connection is interrupted and then restored. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
ms.subservice: networking
---
# UDP communication is blocked by the Windows Firewall rule in WSFC when the network connection is interrupted and then restored

This article provides resolutions for the issue where UDP communication is blocked by the Windows Firewall rule in WSFC when the network connection is interrupted and then restored.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2701206

## Symptoms

In Windows Server 2008 R2 environment, inbound UDP communication may be blocked when the connection to the network is interrupted and then restored. Inbound TCP and ICMP communications may also be blocked in this situation.

This problem occurs if the inbound UDP communication is enabled by Windows Firewall. One of the services that may be affected by this issue is Windows Server Failover Clustering (WSFC). Although Heartbeat Communication (UDP 3343) may be enabled by default, the communication may be blocked. When this issue occurs, the status of the communication in the Failover Cluster Manager is displayed as "Unreachable."

> [!NOTE]
> You can refer the inbound UDP communication settings of Windows Firewall from the following rule:  
> [Windows Firewall with Advanced Security] - [Inbound Rules]

## Cause

This problem occurs because of an issue in Windows Firewall. The connection to the network is interrupted and then restored when Windows Firewall reloads the profile. In this case, an unintended rule may block the communications port that's required in the cluster.

## Resolution 1: Use the netsh command

Run the following `netsh` commands at an elevated command prompt:

```console
netsh advfirewall firewall show rule "Failover Clusters (UDP-In)"
```  

```console
netsh advfirewall firewall set rule "Failover Clusters (UDP-In)" new enable=no
```  

```console
netsh advfirewall firewall show rule "Failover Clusters (UDP-In)"
```  

>[!NOTE]
>
> - When you use this method, the Cluster service may stop. Therefore, if it's possible, you should stop the Cluster service before you start this method, and then restart the Cluster service after you complete the other steps.
> - When you use this method, the "Failover Clusters (UDP-in)" rule is also disabled.
> - The Cluster service enables node communication by setting the firewall port of UDP at startup.

## Resolution 2: Use the Windows Firewall with Advanced Security add-in

Run the "Windows Firewall with Advanced Security" Microsoft Management Console add-in. To do this, follow these steps:

1. Click **Start**, type *wf.msc* in the **Search programs and files** box, and then click **wf.msc** under **Programs.**  
2. Click **Inbound Rules**.
3. Locate and then select the **Failover Clusters (UDP-In)** rule.
4. Disable or delete the **Failover Clusters (UDP-In)** rule.

> [!NOTE]
>
> - When you use this method, the Cluster service may stop. Therefore, if it's possible, you should stop the Cluster service before you start this method, and then restart the Cluster service after you complete the other steps.
> - When you use this method, the "Failover Clusters (UDP-in)" rule is also disabled.
> - The Cluster service enables node communication by setting the firewall port of UDP at startup.

## Resolution 3: Disable Network List Service

To disable the Network List Service service, follow these steps:

1. Click **Start**, type *services* in the **Search programs and files** box, and then press Enter.
2. In the **Name** column under **Services (Local)**, right-click **Network List Service**, and then click **Properties**.
3. On the **General** tab, set the **Startup type** box to **Disabled**.
4. Click **Apply** > **OK**.
5. Restart the computer.

> [!NOTE]
>
> Before you disable Network List Service, you should consider that this action makes the following changes:
>
> - By default, Windows Firewall will now select the Public profile. Therefore, rules that are set for the Domain or Private profiles must be added to the Public profile.
> - The Networking Sharing Center doesn't display profile types or the network connection status.
> - The network connection icon no longer appears on the Windows Taskbar.

The changes that occur after you disconnect Network List Service are limited to the display of network information. They don't affect system behavior.

## Status

Microsoft has confirmed that this is a known issue in Windows Firewall.
