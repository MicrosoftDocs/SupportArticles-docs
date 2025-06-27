---
title: Outlook shows Disconnected if IPv6 is enabled
description: Describes a problem that blocks Outlook from accessing your Exchange Server mailbox. The connection status is shown as Disconnected.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Network disconnects, password or credentials prompt
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook displays a Disconnected status when IPv6 is enabled

_Original KB number:_ &nbsp; 3134780

## Symptoms

Microsoft Outlook cannot connect to your Microsoft Exchange mailbox, and the connection status is displayed as Disconnected.

## Cause

This issue may occur if you have IPv6 enabled on your network adapter and there are network connectivity issues on your IPv6 network.

## Resolution

To resolve this issue, fix the connectivity issues related to your IPv6 network.

## Workaround

If you are unable to resolve the issues on your IPv6 network, you can work around this issue by using one of the following methods.

Method 1: Disable IPv6 on your network adapter

1. Select **Start**, and then select **Control Panel**.
2. Select **Network and Sharing Center**.
3. In the **View your active networks** area, select **Local Area Connection**, and then select **Properties**.
4. On the **Networking** tab, clear the **Internet Protocol Version 6 (TCP/IPv6)** check box, and then select **OK**.

Method 2: Download the fix that's associated with the Prefer IPv4 over IPv6 in prefix policies part in [Guidance for configuring IPv6 in Windows for advanced users](https://support.microsoft.com/help/929852).
