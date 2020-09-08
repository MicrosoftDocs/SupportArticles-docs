---
title: Cannot turn on Network Discovery
description: Describes an issue in which changes to the Advanced sharing settings in **Network and Sharing Center** are not saved. Therefore, you cannot turn on Network Discovery.
ms.data: 09/08/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika，ahamad, vipekkan
ms.prod-support-area-path: TCP/IP communications
ms.technology: Networking
---
# You cannot turn on Network Discovery in Network and Sharing Center

This article provides a resolution for the issue that you can't turn on Network Discovery in Network and Sharing Center.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2722035

## Symptoms

Assume that you try to turn on Network Discovery on a computer that is running Windows Server 2012. To do this, you change the Advanced sharing settings in **Network and Sharing Center**. However, the changes are not saved. Therefore, you cannot turn on Network Discovery, and you experience the following issues:

- You cannot browse or find any network share.
- You cannot view shared folders on a local network.

## Cause

This issue occurs for one of the following reasons:

- The dependency services for Network Discovery are not running.
- The Windows firewall or other firewalls do not allow Network Discovery.

## Resolution

To resolve the issue, follow these steps:

1. Make sure that the following dependency services are started:
   - DNS Client
   - Function Discovery Resource Publication
   - SSDP Discovery
   - UPnP Device Host

2. Configure the Windows firewall to allow Network Discovery. To do this, follow these steps:

      1. Open **Control Panel**, select **System and Security**, and then select **Windows Firewall**.
      2. In the left pane, select **Allow an app or feature through Windows Firewall**.
      3. Select **Change settings**. If you are prompted for an administrator password or confirmation, type the password or provide confirmation.
      4. Select **Network discovery**, and then select **OK**.

3. Configure other firewalls in the network to allow Network Discovery.
4. Turn on **Network Discovery** in **Network and Sharing Center**.
