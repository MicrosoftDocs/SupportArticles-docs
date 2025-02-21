---
title: Can't turn on Network Discovery
description: Describes an issue that changes to the Advanced sharing settings in **Network and Sharing Center** aren't saved. So you can't turn on Network Discovery.
ms.date: 01/15/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, ahamad, vipekkan
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
---
# You can't turn on Network Discovery in Network and Sharing Center

This article provides a resolution for the issue that you can't turn on Network Discovery in Network and Sharing Center.

_Original KB number:_ &nbsp; 2722035

## Symptoms

You try to turn on Network Discovery on a computer that's running Windows Server 2012. To do it, you change the Advanced sharing settings in **Network and Sharing Center**. However, the changes aren't saved. So you can't turn on Network Discovery. And you experience the following issues:

- You can't browse or find any network share.
- You can't view shared folders on a local network.

## Cause

This issue occurs for one of the following reasons:

- The dependency services for Network Discovery aren't running.
- The Windows firewall or other firewalls don't allow Network Discovery.

## Resolution

To resolve the issue, follow these steps:

1. Make sure that the following dependency services are started:
   - DNS Client
   - Function Discovery Resource Publication
   - SSDP Discovery
   - UPnP Device Host

2. Configure the Windows firewall to allow Network Discovery by following these steps:

      1. Open **Control Panel**, select **System and Security**, and then select **Windows Firewall**.
      2. In the left pane, select **Allow an app or feature through Windows Firewall**.
      3. Select **Change settings**. If you're prompted for an administrator password or confirmation, enter the password or provide confirmation.
      4. Select **Network discovery**, and then select **OK**.

3. Configure other firewalls in the network to allow Network Discovery.
4. Turn on **Network Discovery** in **Network and Sharing Center**.
