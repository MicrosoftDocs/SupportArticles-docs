---
title: Can't sign in or activate Outlook and Microsoft 365 applications
description: Provide two resolutions to an issue in which Microsoft 365 applications can't complete activation or connect to Microsoft 365 services.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: aruiz
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 124876
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 10/30/2023
---

# Can't sign in or activate Outlook and Microsoft 365 applications

## Symptoms

Microsoft Outlook or other office applications can't complete activation or can't connect to Exchange Online or other Microsoft 365 services.

The wired LAN network connection may display a yellow exclamation mark alert that indicates "No Internet Access".

> [!NOTE]
> This issue doesn't occur when you use Wi-Fi.

## Cause

This issue occurs because of either of the following reasons:

- The Network Interface Card (NIC) drivers are incompatible.
- The IPv4 Checksum functionality is active.

## Resolution

### Step 1: Update the network card drivers on your device

Network card manufacturers frequently release driver updates to improve performance and fix compatibility issues. If there is no update available through Windows Update, go to the support or download section of your network card manufacturer's website to learn how to download and install the latest driver.

If an updated driver doesn't fix this issue, go to Step 2.

### Step 2: Test by disabling the IPv4 Checksum Offload feature

> [!NOTE]
> This step may resolve the issue only temporarily. Work with the network device manufacturer and Microsoft Windows support to find a permanent solution.

Here's how to disable the IPv4 Checksum Offload feature:

1. In Windows Control Panel, open the **View network connections** item.
2. Right-click the network adapter, select **Properties** > **Configure**, and then select  the **Advanced** tab.
3. Select **IPv4 Checksum Offload**, and then select **Disable**.
4. Select **OK** to save the changes.

## More information

Address checksum offloads are a NIC feature that offloads the calculation of address checksums (IP, TCP, UDP) to the NIC hardware for both send (Tx) and receive (Rx).

On the receive path, the checksum offload calculates the checksums in the IP, TCP, and UDP headers and indicates to the operating system whether the checksums passed, failed, or weren't checked. If the NIC asserts that the checksums are valid, the system accepts the packet unchallenged. If the NIC asserts that the checksums are invalid or not checked, the IP/TCP/UDP stack internally calculates the checksums again. If the computed checksum fails, the packet is discarded.

For more information, see [Hardware Only (HO) features and technologies](/windows-server/networking/technologies/hpn/hpn-hardware-only-features).
