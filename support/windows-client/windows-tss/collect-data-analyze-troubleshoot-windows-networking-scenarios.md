---
title: Collect Data to Analyze and Troubleshoot Windows Networking Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on Windows networking scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot Windows networking scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Domain Name System (DNS)

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario NET_DNSCli
```

Server:

```powershell
.\TSS.ps1 -Scenario NET_DNSSrv
```

### TSS cmdlet description

Use this scenario to troubleshoot DNS-related issues affecting name resolution and service availability.

Trigger this scenario when clients experience the following issues:

- Name resolution failures
- Slow DNS lookups
- Errors such as "DNS server not responding"

On the server side, use this scenario when:

- DNS services crash or fail to respond.
- There are suspected issues with DNS configuration or resolution flow.

This scenario helps identify problems such as:

- Misconfigured DNS settings
- Root hints issues
- Name Resolution Policy Table (NRPT) policy conflicts
- Forwarder or conditional forwarder misconfigurations

> [!NOTE]
> For a complete diagnostic view, collect logs from both the client and the server when reproducing the issue.

## Scenario: TCP/IP connectivity

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario NET_WinSock
```

### TSS cmdlet description

Use this scenario to troubleshoot general network connectivity issues.

Trigger this scenario when users report problems such as:

- Inability to reach websites
- Network timeouts
- Intermittent or unstable connectivity

This scenario helps diagnose issues related to:

- TCP/IP stack behavior
- Address Resolution Protocol (ARP) failures
- Routing misconfigurations

## Scenario: Access to file shares (Server Message Block (SMB))

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario NET_SMBCli
```

Server:

```powershell
.\TSS.ps1 -Scenario NET_SMBSrv
```

### TSS cmdlet description

Use this scenario to troubleshoot issues with accessing shared folders or file transfer.

Trigger this scenario when users encounter any of the following issues:

- Errors such as "network path not found" or "access denied"
- Inability to access shared folders
- Slow file transfer performance

> [!NOTE]
> For a complete analysis, collect logs from both the client and the server when reproducing the issue.

## Scenario: Dynamic Host Configuration Protocol (DHCP)

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario NET_DHCPCli
```

Server:

```powershell
.\TSS.ps1 -Scenario NET_DHCPSrv
```

### TSS cmdlet description

Use this scenario to troubleshoot DHCP-related connectivity issues.

Trigger this scenario when devices can't obtain an IP address, display a "limited connectivity" status, or fail to renew their DHCP leases.

The client-side trace captures the full DORA (Discover, Offer, Request, Acknowledge) sequence, while the server-side trace helps identify potential issues such as:

- DHCP scope exhaustion
- Relay agent misconfigurations
- Incorrect or missing DHCP options

> [!NOTE]
> For a complete diagnostic view, collect logs from both the client and the server when reproducing the issue.

## Scenario: Wired/wireless (802.1x, Bluetooth, Miracast, and mobile broadband)

### TSS cmdlet

Wired:

```powershell
.\TSS.ps1 -Scenario NET_802Dot1x
```

Wireless:

```powershell
.\TSS.ps1 -Scenario NET_WLAN
```  

### TSS cmdlet description

Use this scenario to troubleshoot 802.1x (dot1x) authentication issues on both wired and wireless networks.

This scenario is designed to help diagnose authentication failures that occur when clients attempt to connect to the network using Ethernet or Wi-Fi.

Common issues include:

- Authentication failures (for example, "authentication failed") on wired or wireless connections
- Dropped Wi-Fi connections
- Miracast pairing failures
- Mobile broadband not connecting
